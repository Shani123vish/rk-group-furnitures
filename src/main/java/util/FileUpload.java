package util;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;

/**
 * FileUpload.java
 * --------------------------------------------------
 * Helper class to save uploaded image files to the
 * server's "uploads" folder.
 *
 * HOW TO USE (in a Servlet):
 *   Part filePart = request.getPart("image");
 *   String uploadDir = getServletContext().getRealPath("/uploads");
 *   String fileName = FileUpload.saveFile(filePart, uploadDir);
 *   // fileName is what you store in the database
 * --------------------------------------------------
 */
public class FileUpload {

    // Allowed image file extensions
    private static final String[] ALLOWED = {".jpg", ".jpeg", ".png", ".gif", ".webp"};

    /**
     * Saves an uploaded file to the given directory.
     * Returns the generated filename (UUID-based) to store in DB.
     * Returns null if no file was uploaded or file type is invalid.
     *
     * @param filePart  - The file Part from request.getPart("fieldName")
     * @param uploadDir - Absolute path on server e.g. /uploads/
     */
    public static String saveFile(Part filePart, String uploadDir) throws IOException {

        // Get original filename from the browser
        String originalName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // If no file selected, return null
        if (originalName == null || originalName.isEmpty()) {
            return null;
        }

        // Get file extension (.jpg, .png, etc.)
        String ext = "";
        int dotIndex = originalName.lastIndexOf('.');
        if (dotIndex > 0) {
            ext = originalName.substring(dotIndex).toLowerCase();
        }

        // Check if extension is allowed
        if (!isAllowedExtension(ext)) {
            return null; // Invalid file type
        }

        // Generate a unique name using UUID to avoid filename conflicts
        String newFileName = UUID.randomUUID().toString() + ext;

        // Make sure the upload directory exists
        File uploadFolder = new File(uploadDir);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs(); // Create folders if they don't exist
        }

        // Save the file
        String filePath = uploadDir + File.separator + newFileName;
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, Paths.get(filePath));
        }

        return newFileName; // Store this in the database
    }

    /**
     * Checks if a file extension is in our allowed list.
     */
    private static boolean isAllowedExtension(String ext) {
        for (String allowed : ALLOWED) {
            if (allowed.equals(ext)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Deletes an old file from uploads folder (used when updating images).
     * @param fileName  - just the filename, e.g. "abc123.jpg"
     * @param uploadDir - full path to uploads folder
     */
    public static void deleteFile(String fileName, String uploadDir) {
        if (fileName != null && !fileName.isEmpty()) {
            File file = new File(uploadDir + File.separator + fileName);
            if (file.exists()) {
                file.delete();
            }
        }
    }
}