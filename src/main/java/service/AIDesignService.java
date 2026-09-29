package service; 
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONArray;
import org.json.JSONObject;

public class AIDesignService {

    private static final String CLAUDE_URL =
        "https://api.anthropic.com/v1/messages";
    private static final String CLAUDE_KEY =
        "YOUR_ANTHROPIC_API_KEY"; // anthropic.com pe free signup

    private static final String HF_URL =
        "https://api-inference.huggingface.co/models/runwayml/stable-diffusion-v1-5";
    private static final String HF_KEY =
        "YOUR_HUGGINGFACE_KEY"; // huggingface.co pe free signup

    public String getDesignSuggestions(String imageBase64,
                                        String roomType,
                                        String demands,
                                        String budget) throws Exception {

        String prompt = "Tum ek experienced luxury interior designer ho India mein.\n\n" +
            "Room type: " + roomType + "\n" +
            "Customer budget: " + budget + "\n" +
            "Customer demands: " + demands + "\n\n" +
            "Is room ki photo dekho aur detailed interior design report banao.\n" +
            "Report Hinglish mein likhna (Hindi + English mix).\n\n" +
            "Yeh sections include karo:\n" +
            "1. 🎨 Overall Style & Theme\n" +
            "2. 🖌 Wall Colors & Finishes\n" +
            "3. 🏠 Flooring Recommendations\n" +
            "4. 🛋 Furniture Suggestions (budget ke hisaab se price range INR mein)\n" +
            "5. 💡 Lighting Plan\n" +
            "6. ✨ Decor & Accessories\n" +
            "7. 📦 RK Group Furnitures ke products kaise help karenge\n\n" +
            "Budget " + budget + " hai toh usi ke hisaab se practical suggestions do.\n" +
            "Har section mein 3-4 bullet points rakhna. Premium aur luxury feel do.";

        JSONObject payload = new JSONObject();
        payload.put("model", "claude-opus-4-5");
        payload.put("max_tokens", 2000);

        JSONArray messages = new JSONArray();
        JSONObject msg = new JSONObject();
        msg.put("role", "user");

        JSONArray content = new JSONArray();

        // Image
        JSONObject imgBlock = new JSONObject();
        imgBlock.put("type", "image");
        JSONObject src = new JSONObject();
        src.put("type", "base64");
        src.put("media_type", "image/jpeg");
        src.put("data", imageBase64);
        imgBlock.put("source", src);
        content.put(imgBlock);

        // Text
        JSONObject txtBlock = new JSONObject();
        txtBlock.put("type", "text");
        txtBlock.put("text", prompt);
        content.put(txtBlock);

        msg.put("content", content);
        messages.put(msg);
        payload.put("messages", messages);

        URL url = new URL(CLAUDE_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("x-api-key", CLAUDE_KEY);
        conn.setRequestProperty("anthropic-version", "2023-06-01");
        conn.setDoOutput(true);
        conn.getOutputStream().write(payload.toString().getBytes("UTF-8"));

        BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getInputStream(), "UTF-8"));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) sb.append(line);

        return new JSONObject(sb.toString())
                   .getJSONArray("content")
                   .getJSONObject(0)
                   .getString("text");
    }

    public byte[] generateRoomImage(String roomType,
                                     String demands,
                                     String budget) throws Exception {

        String prompt = "Luxury " + roomType + " interior, " +
            demands + ", Indian luxury style, white and gold color scheme, " +
            "photorealistic, 4k quality, professional interior photography, " +
            "elegant premium furniture, warm ambient lighting";

        JSONObject payload = new JSONObject();
        payload.put("inputs", prompt);
        JSONObject params = new JSONObject();
        params.put("width", 768);
        params.put("height", 512);
        params.put("num_inference_steps", 30);
        payload.put("parameters", params);

        URL url = new URL(HF_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Authorization", "Bearer " + HF_KEY);
        conn.setDoOutput(true);
        conn.setReadTimeout(120000);
        conn.getOutputStream().write(payload.toString().getBytes("UTF-8"));

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        InputStream is = conn.getInputStream();
        byte[] buf = new byte[4096];
        int n;
        while ((n = is.read(buf)) != -1) baos.write(buf, 0, n);
        return baos.toByteArray();
    }
}