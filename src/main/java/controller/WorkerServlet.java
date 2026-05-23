package controller;

import dao.WorkerDAO;
import dao.SiteDAO;
import model.Worker;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * WorkerServlet.java
 * Admin-only. Manages workers: list, add, edit, delete.
 *
 * URL: /admin/workers
 */
@WebServlet("/admin/workers")
public class WorkerServlet extends HttpServlet {

    private WorkerDAO workerDAO = new WorkerDAO();
    private SiteDAO   siteDAO   = new SiteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (!AdminServlet.isLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/admin/login"); return;
        }
        // Pass workers list AND all sites (for the "assign to site" dropdown)
        req.setAttribute("workers",   workerDAO.getAllWorkers());
        req.setAttribute("allSites",  siteDAO.getAllSites());
        req.getRequestDispatcher("/jsp/admin/workers.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (!AdminServlet.isLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/admin/login"); return;
        }

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            Worker w = buildFromRequest(req);
            workerDAO.addWorker(w);

        } else if ("edit".equals(action)) {
            Worker w = buildFromRequest(req);
            w.setId(Integer.parseInt(req.getParameter("id")));
            w.setActive("1".equals(req.getParameter("isActive")));
            workerDAO.updateWorker(w);

        } else if ("delete".equals(action)) {
            workerDAO.deleteWorker(Integer.parseInt(req.getParameter("id")));
        }

        resp.sendRedirect(req.getContextPath() + "/admin/workers");
    }

    /** Builds a Worker object from form parameters. */
    private Worker buildFromRequest(HttpServletRequest req) {
        Worker w = new Worker();
        w.setName(req.getParameter("name"));
        w.setPhone(req.getParameter("phone"));
        w.setSkill(req.getParameter("skill"));

        String sal = req.getParameter("dailySalary");
        w.setDailySalary(sal != null && !sal.isEmpty() ? Double.parseDouble(sal) : 0);

        String siteId = req.getParameter("siteId");
        w.setSiteId(siteId != null && !siteId.isEmpty() ? Integer.parseInt(siteId) : 0);

        w.setAttendanceNote(req.getParameter("attendanceNote"));
        w.setJoinedDate(req.getParameter("joinedDate"));
        return w;
    }
}