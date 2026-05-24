package util;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import jakarta.servlet.http.Part;

/**
 * CloudinaryUpload.java
 * --------------------------------------------------
 * Cloudinary pe image aur video upload karta hai.
 * Free plan: 25GB storage, unlimited uploads.
 *
 * Environment Variables se credentials read karta hai:
 *   CLOUDINARY_CLOUD_NAME = dvnqvczfn
 *   CLOUDINARY_API_KEY    = 652258933391184
 *   CLOUDINARY_API_SECRET = (Railway Variables mein daalo)
 * --------------------------------------------------
 */
public class CloudinaryUpload {

    // Cloudinary credentials — environment variables se aate hain
    private static final String CLOUD_NAME  = System.getenv("CLOUDINARY_CLOUD_NAME") != null
            ? System.getenv("CLOUDINARY_CLOUD_NAME") : "dvnqvczfn";

    private static final String API_KEY     = System.getenv("CLOUDINARY_API_KEY") != null
            ? System.getenv("CLOUDINARY_API_KEY") : "652258933391184";

    private static final String API_SECRET  = System.getenv("CLOUDINARY_API_SECRET") != null
            ? System.getenv("CLOUDINARY_API_SECRET") : "";

    // Upload URL
    private static final String UPLOAD_URL_IMAGE = "https://api.cloudinary.com/v1_1/" + CLOUD_NAME + "/image/upload";
    private static final String UPLOAD_URL_VIDEO = "https://api.cloudinary.com/v1_1/" + CLOUD_NAME + "/video/upload";

    // Allowed file types
    private static final String[] IMAGE_TYPES = {".jpg", ".jpeg", ".png", ".gif", ".webp"};
    private static final String[] VIDEO_TYPES = {".mp4", ".mov", ".avi", ".mkv", ".webm"};

    /**
     * File type check karo — image hai ya video
     */
    public static boolean isImage(String filename) {
        if (filename == null) return false;
        String lower = filename.toLowerCase();
        for (String ext : IMAGE_TYPES) {
            if (lower.endsWith(ext)) return true;
        }
        return false;
    }

    public static boolean isVideo(String filename) {
        if (filename == null) return false;
        String lower = filename.toLowerCase();
        for (String ext : VIDEO_TYPES) {
            if (lower.endsWith(ext)) return true;
        }
        return false;
    }

    /**
     * Main upload method — Cloudinary pe file upload karo.
     * Returns Cloudinary URL (permanent) ya null if failed.
     *
     * @param filePart  - HttpServletRequest ka Part
     * @param folder    - Cloudinary folder: "gallery" ya "products"
     */
    public static String uploadFile(Part filePart, String folder) throws IOException {

        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        // Original filename
        String originalName = getFileName(filePart);
        if (originalName == null || originalName.isEmpty()) return null;

        // Image ya Video?
        boolean isImg = isImage(originalName);
        boolean isVid = isVideo(originalName);

        if (!isImg && !isVid) {
            System.err.println("Invalid file type: " + originalName);
            return null;
        }

        String uploadUrl = isImg ? UPLOAD_URL_IMAGE : UPLOAD_URL_VIDEO;

        // File bytes read karo
        byte[] fileBytes;
        try (InputStream is = filePart.getInputStream();
             ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            byte[] buffer = new byte[8192];
            int bytesRead;
            while ((bytesRead = is.read(buffer)) != -1) {
                baos.write(buffer, 0, bytesRead);
            }
            fileBytes = baos.toByteArray();
        }

        // Base64 encode karo
        String base64File = Base64.getEncoder().encodeToString(fileBytes);
        String ext = originalName.substring(originalName.lastIndexOf('.'));
        String mimeType = getMimeType(ext);
        String dataUri = "data:" + mimeType + ";base64," + base64File;

        // Timestamp aur signature generate karo
        long timestamp = System.currentTimeMillis() / 1000L;
        String folderPath = "rk_group/" + folder;
        String signature = generateSignature(timestamp, folderPath);

        // POST request body banao
        String boundary = "----CloudinaryBoundary" + System.currentTimeMillis();
        ByteArrayOutputStream requestBody = new ByteArrayOutputStream();

        // file field
        writeMultipartField(requestBody, boundary, "file", dataUri);
        // api_key field
        writeMultipartField(requestBody, boundary, "api_key", API_KEY);
        // timestamp field
        writeMultipartField(requestBody, boundary, "timestamp", String.valueOf(timestamp));
        // folder field
        writeMultipartField(requestBody, boundary, "folder", folderPath);
        // signature field
        writeMultipartField(requestBody, boundary, "signature", signature);
        // Close boundary
        requestBody.write(("--" + boundary + "--\r\n").getBytes());

        // HTTP POST to Cloudinary
        URL url = new URL(uploadUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
        conn.setConnectTimeout(30000);
        conn.setReadTimeout(60000);

        try (OutputStream os = conn.getOutputStream()) {
            os.write(requestBody.toByteArray());
        }

        // Response read karo
        int responseCode = conn.getResponseCode();
        InputStream responseStream = (responseCode == 200)
                ? conn.getInputStream()
                : conn.getErrorStream();

        StringBuilder response = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(responseStream, StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
        }

        if (responseCode == 200) {
            // JSON se secure_url extract karo
            String json = response.toString();
            String secureUrl = extractJsonValue(json, "secure_url");
            System.out.println("Cloudinary upload success: " + secureUrl);
            return secureUrl;
        } else {
            System.err.println("Cloudinary upload failed (" + responseCode + "): " + response);
            return null;
        }
    }

    /**
     * Signature generate karo (Cloudinary authentication ke liye)
     */
    private static String generateSignature(long timestamp, String folder) {
        try {
            String toSign = "folder=" + folder + "&timestamp=" + timestamp + API_SECRET;
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("SHA-1");
            byte[] hash = md.digest(toSign.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            System.err.println("Signature error: " + e.getMessage());
            return "";
        }
    }

    /**
     * Multipart form field likhta hai
     */
    private static void writeMultipartField(ByteArrayOutputStream out,
            String boundary, String name, String value) throws IOException {
        out.write(("--" + boundary + "\r\n").getBytes());
        out.write(("Content-Disposition: form-data; name=\"" + name + "\"\r\n").getBytes());
        out.write("\r\n".getBytes());
        out.write(value.getBytes(StandardCharsets.UTF_8));
        out.write("\r\n".getBytes());
    }

    /**
     * Part se filename nikalta hai
     */
    private static String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition == null) return null;
        for (String token : contentDisposition.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    /**
     * Extension se MIME type
     */
    private static String getMimeType(String ext) {
        switch (ext.toLowerCase()) {
            case ".jpg": case ".jpeg": return "image/jpeg";
            case ".png":  return "image/png";
            case ".gif":  return "image/gif";
            case ".webp": return "image/webp";
            case ".mp4":  return "video/mp4";
            case ".mov":  return "video/quicktime";
            case ".avi":  return "video/x-msvideo";
            case ".mkv":  return "video/x-matroska";
            case ".webm": return "video/webm";
            default:      return "application/octet-stream";
        }
    }

    /**
     * Simple JSON value extractor
     */
    private static String extractJsonValue(String json, String key) {
        String searchKey = "\"" + key + "\"";
        int keyIndex = json.indexOf(searchKey);
        if (keyIndex == -1) return null;
        int colonIndex = json.indexOf(":", keyIndex);
        if (colonIndex == -1) return null;
        int startQuote = json.indexOf("\"", colonIndex);
        if (startQuote == -1) return null;
        int endQuote = json.indexOf("\"", startQuote + 1);
        if (endQuote == -1) return null;
        return json.substring(startQuote + 1, endQuote);
    }
}
