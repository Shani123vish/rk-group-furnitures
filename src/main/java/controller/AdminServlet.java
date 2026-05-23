package controller;

import java.io.IOException;

import dao.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Admin;

/**
 * AdminServlet.java
 * --------------------------------------------------
 * Handles admin login, logout and dashboard.
 *
 * URL mappings:
 *   GET  /admin/login     → show login page
 *   POST /admin/login     → process login form
 *   GET  /admin/logout    → clear session, redirect to login
 *   GET  /admin/dashboard → show dashboard (protected)
 * --------------------------------------------------
 */
@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    private AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Get the path after /admin/  e.g. "login", "dashboard"
        String path = req.getPathInfo();
        if (path == null) path = "/dashboard";

        switch (path) {

            case "/login":
                // Show the login page
                req.getRequestDispatcher("/jsp/admin/login.jsp").forward(req, resp);
                break;

            case "/logout":
                // Invalidate (destroy) the session
                HttpSession session = req.getSession(false);
                if (session != null) session.invalidate();
                resp.sendRedirect(req.getContextPath() + "/admin/login");
                break;

            case "/dashboard":
                // Only allow if admin is logged in
                if (!isLoggedIn(req)) {
                    resp.sendRedirect(req.getContextPath() + "/admin/login");
                    return;
                }
                // Get dashboard counts and pass to JSP
                int[] counts = adminDAO.getDashboardCounts();
                req.setAttribute("newInquiries",  counts[0]);
                req.setAttribute("totalProducts", counts[1]);
                req.setAttribute("totalGallery",  counts[2]);
                req.setAttribute("activeSites",   counts[3]);
                req.setAttribute("totalWorkers",  counts[4]);
                req.setAttribute("pendingBookings", counts[5]);
                req.getRequestDispatcher("/jsp/admin/dashboard.jsp").forward(req, resp);
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getPathInfo();
        if (path == null) path = "";

        if ("/login".equals(path)) {
            // Read form fields
            String username = req.getParameter("username");
            String password = req.getParameter("password");

            // Validate with database
            Admin admin = adminDAO.login(username, password);

            if (admin != null) {
                // Login successful — create session and store admin object
                HttpSession session = req.getSession(true); // true = create new session
                session.setAttribute("loggedAdmin", admin);
                session.setMaxInactiveInterval(60 * 60); // 1 hour timeout
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else {
                // Login failed — go back to login with error message
                req.setAttribute("error", "Invalid username or password!");
                req.getRequestDispatcher("/jsp/admin/login.jsp").forward(req, resp);
            }
        }
    }

    /**
     * Helper method: checks if an admin session exists.
     * Call this at the top of every protected admin action.
     */
    public static boolean isLoggedIn(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return session != null && session.getAttribute("loggedAdmin") != null;
    }
}