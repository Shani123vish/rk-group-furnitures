package controller;

import service.AIDesignService;
import util.CloudinaryUpload;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.util.Base64;

@WebServlet("/ai-design")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize       = 10 * 1024 * 1024,
    maxRequestSize    = 15 * 1024 * 1024
)
public class AIDesignServlet extends HttpServlet {

    private AIDesignService aiService = new AIDesignService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        // Form fields
        String roomType    = req.getParameter("room_type");
        String demands     = req.getParameter("demands");
        String budgetRange = req.getParameter("budget_range");
        String customBudget= req.getParameter("custom_budget");
        String finalBudget = (customBudget != null && !customBudget.isEmpty())
                             ? "₹" + customBudget : budgetRange;

        // Photo part lena
        Part photoPart = req.getPart("room_photo");

        // ✅ Tumhara apna CloudinaryUpload use karo — koi dependency nahi chahiye
        String cloudinaryUrl = CloudinaryUpload.uploadFile(photoPart, "ai-designs");

        // Image bytes Base64 mein convert karo (Claude API ke liye)
        byte[] imageBytes = photoPart.getInputStream().readAllBytes();
        String imageBase64 = Base64.getEncoder().encodeToString(imageBytes);

        try {
            // Claude AI se suggestions
            String suggestions = aiService.getDesignSuggestions(
                imageBase64, roomType, demands, finalBudget
            );

            // HuggingFace se generated room image
            byte[] genImg = aiService.generateRoomImage(
                roomType, demands, finalBudget
            );
            String genImgBase64 = Base64.getEncoder().encodeToString(genImg);

            // Session mein store karo
            HttpSession session = req.getSession();
            session.setAttribute("ai_suggestions",  suggestions);
            session.setAttribute("generated_image", genImgBase64);
            session.setAttribute("room_type",        roomType);
            session.setAttribute("budget",           finalBudget);
            session.setAttribute("original_img_url", cloudinaryUrl);

            resp.sendRedirect("jsp/public/ai-result.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "AI processing failed: " + e.getMessage());
            req.getRequestDispatcher("jsp/public/ai-design.jsp").forward(req, resp);
        }
    }
}