package controller;

import java.io.IOException;
import java.util.Base64;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.AIDesignService;

@WebServlet("/phonepe-callback")
public class PhonePeCallbackServlet extends HttpServlet {

    private AIDesignService aiService = new AIDesignService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String code = req.getParameter("code");

        // Payment success check
        if (!"PAYMENT_SUCCESS".equals(code)) {
            resp.sendRedirect("ai-design.jsp?error=payment_failed");
            return;
        }

        HttpSession session = req.getSession();
        byte[] photoBytes  = (byte[]) session.getAttribute("pending_photo");
        String roomType    = (String) session.getAttribute("pending_room_type");
        String demands     = (String) session.getAttribute("pending_demands");
        String budget      = (String) session.getAttribute("pending_budget");
        String txnId       = (String) session.getAttribute("pending_txn_id");

        String imageBase64 = Base64.getEncoder().encodeToString(photoBytes);

        try {
            // Claude AI se suggestions
            String suggestions = aiService.getDesignSuggestions(
                imageBase64, roomType, demands, budget
            );

            // HuggingFace se generated image
            byte[] genImg = aiService.generateRoomImage(
                roomType, demands, budget
            );
            String genImgBase64 = Base64.getEncoder()
                                        .encodeToString(genImg);

            // Session mein store
            session.setAttribute("ai_suggestions", suggestions);
            session.setAttribute("generated_image", genImgBase64);
            session.setAttribute("room_type", roomType);
            session.setAttribute("budget", budget);
            session.setAttribute("transaction_id", txnId);

            resp.sendRedirect("ai-result.jsp");

        } catch (Exception e) {
            resp.sendRedirect("ai-design.jsp?error=ai_failed");
        }
    }
}