package controller;

import dao.InquiryDAO;
import model.Inquiry;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * InquiryServlet.java
 * Handles contact form submissions (public) and admin inquiry management.
 *
 * URLs:
 *   POST /inquiry            → save new inquiry from contact form
 *   GET  /admin/inquiries    → list all inquiries in admin panel
 *   POST /admin/inquiries    → update inquiry status
 */
@WebServlet({"/inquiry", "/admin/inquiries"})
public class InquiryServlet extends HttpServlet {

    private InquiryDAO inquiryDAO = new InquiryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Only admin list view uses GET
        if (!AdminServlet.isLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/admin/login"); return;
        }
        req.setAttribute("inquiries", inquiryDAO.getAllInquiries());
        req.getRequestDispatcher("/jsp/admin/inquiries.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        if (uri.contains("/admin/inquiries")) {
            // Admin updating inquiry status
            if (!AdminServlet.isLoggedIn(req)) {
                resp.sendRedirect(req.getContextPath() + "/admin/login"); return;
            }
            // FIX: id null/empty check — crash avoid karo
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/admin/inquiries");
                return;
            }
            int    id     = Integer.parseInt(idParam.trim());
            String status = req.getParameter("status");
            if (status == null || status.isEmpty()) status = "read";
            inquiryDAO.updateStatus(id, status);
            resp.sendRedirect(req.getContextPath() + "/admin/inquiries");

        } else {
            // Public contact form submission
            String name  = req.getParameter("name");
            String phone = req.getParameter("phone");

            // Basic server-side validation
            if (name == null || name.trim().isEmpty() || phone == null || phone.trim().isEmpty()) {
                req.setAttribute("error", "Name and Phone are required.");
                req.getRequestDispatcher("/jsp/public/contact.jsp").forward(req, resp);
                return;
            }

            Inquiry inq = new Inquiry();
            inq.setName(name.trim());
            inq.setPhone(phone.trim());
            inq.setEmail(req.getParameter("email"));
            inq.setMessage(req.getParameter("message"));

            boolean saved = inquiryDAO.addInquiry(inq);

            if (saved) {
                req.setAttribute("success", "Thank you! We will contact you soon.");
            } else {
                req.setAttribute("error", "Something went wrong. Please try again.");
            }
            req.getRequestDispatcher("/jsp/public/contact.jsp").forward(req, resp);
        }
    }
}
