package controller;

import dao.SiteDAO;
import model.WorkSite;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * SiteServlet.java
 * Admin-only. Manages work sites: list, add, edit, delete.
 *
 * URL: /admin/sites
 */
@WebServlet("/admin/sites")
public class SiteServlet extends HttpServlet {

    private SiteDAO siteDAO = new SiteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (!AdminServlet.isLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/admin/login"); return;
        }
        req.setAttribute("sites", siteDAO.getAllSites());
        req.getRequestDispatcher("/jsp/admin/sites.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (!AdminServlet.isLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/admin/login"); return;
        }

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            siteDAO.addSite(buildFromRequest(req));

        } else if ("edit".equals(action)) {
            WorkSite s = buildFromRequest(req);
            s.setId(Integer.parseInt(req.getParameter("id")));
            s.setActualEndDate(req.getParameter("actualEndDate"));
            siteDAO.updateSite(s);

        } else if ("delete".equals(action)) {
            siteDAO.deleteSite(Integer.parseInt(req.getParameter("id")));
        }

        resp.sendRedirect(req.getContextPath() + "/admin/sites");
    }

    private WorkSite buildFromRequest(HttpServletRequest req) {
        WorkSite s = new WorkSite();
        s.setSiteName(req.getParameter("siteName"));
        s.setClientName(req.getParameter("clientName"));
        s.setClientPhone(req.getParameter("clientPhone"));
        s.setAddress(req.getParameter("address"));
        s.setStartDate(req.getParameter("startDate"));
        s.setExpectedEndDate(req.getParameter("expectedEndDate"));
        s.setStatus(req.getParameter("status"));

        String budget = req.getParameter("budget");
        s.setBudget(budget != null && !budget.isEmpty() ? Double.parseDouble(budget) : 0);

        s.setNotes(req.getParameter("notes"));
        return s;
    }
}