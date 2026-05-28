package controller;

import dao.FeedbackDAO;
import model.Feedback;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * FeedbackServlet.java
 *
 * URLs:
 *   GET  /feedback          → public feedback page (form + all reviews)
 *   POST /feedback          → save new feedback
 *   GET  /admin/feedback    → admin manage feedback
 *   POST /admin/feedback    → delete feedback
 */
@WebServlet({"/feedback", "/admin/feedback"})
public class FeedbackServlet extends HttpServlet {

    private FeedbackDAO feedbackDAO = new FeedbackDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        if (uri.contains("/admin/feedback")) {
            if (!AdminServlet.isLoggedIn(req)) {
                resp.sendRedirect(req.getContextPath() + "/admin/login"); return;
            }
            req.setAttribute("feedbackList", feedbackDAO.getAllFeedbackAdmin());
            req.setAttribute("avgRating", feedbackDAO.getAverageRating());
            req.getRequestDispatcher("/jsp/admin/feedback.jsp").forward(req, resp);
        } else {
            // Public feedback page
            req.setAttribute("feedbackList", feedbackDAO.getAllFeedback());
            req.setAttribute("avgRating",    feedbackDAO.getAverageRating());
            req.getRequestDispatcher("/jsp/public/feedback.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        if (uri.contains("/admin/feedback")) {
            // Admin delete
            if (!AdminServlet.isLoggedIn(req)) {
                resp.sendRedirect(req.getContextPath() + "/admin/login"); return;
            }
            String idParam = req.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                feedbackDAO.deleteFeedback(Integer.parseInt(idParam.trim()));
            }
            resp.sendRedirect(req.getContextPath() + "/admin/feedback");

        } else {
            // Public form submit
            String name    = req.getParameter("name");
            String phone   = req.getParameter("phone");
            String message = req.getParameter("message");

            // Basic validation
            if (name == null || name.trim().isEmpty() ||
                message == null || message.trim().isEmpty()) {
                req.setAttribute("error", "Name and message are required.");
                req.setAttribute("feedbackList", feedbackDAO.getAllFeedback());
                req.setAttribute("avgRating", feedbackDAO.getAverageRating());
                req.getRequestDispatcher("/jsp/public/feedback.jsp").forward(req, resp);
                return;
            }

            Feedback f = new Feedback();
            f.setName(name.trim());
            f.setPhone(phone != null ? phone.trim() : "");
            f.setLocation(req.getParameter("location") != null ? req.getParameter("location").trim() : "");
            f.setMessage(message.trim());

            // Rating — default 5 if not given
            String ratingParam = req.getParameter("rating");
            int rating = 5;
            try {
                if (ratingParam != null && !ratingParam.isEmpty()) {
                    rating = Integer.parseInt(ratingParam);
                    if (rating < 1) rating = 1;
                    if (rating > 5) rating = 5;
                }
            } catch (NumberFormatException e) { rating = 5; }
            f.setRating(rating);

            boolean saved = feedbackDAO.addFeedback(f);

            if (saved) {
                req.setAttribute("success", "Thank you for your feedback! It has been published.");
            } else {
                req.setAttribute("error", "Something went wrong. Please try again.");
            }

            req.setAttribute("feedbackList", feedbackDAO.getAllFeedback());
            req.setAttribute("avgRating", feedbackDAO.getAverageRating());
            req.getRequestDispatcher("/jsp/public/feedback.jsp").forward(req, resp);
        }
    }
}
