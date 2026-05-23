package controller;

import dao.GalleryDAO;
import model.Gallery;
import util.FileUpload;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * GalleryServlet.java
 * Public gallery view + admin upload/edit/delete.
 *
 * URLs:
 *   GET  /gallery             → public gallery grid
 *   GET  /gallery?catId=X     → filter by category
 *   GET  /admin/gallery       → admin gallery management
 *   POST /admin/gallery       → add / edit / delete gallery item
 */
@WebServlet({"/gallery", "/admin/gallery"})
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024)
public class GalleryServlet extends HttpServlet {

    private GalleryDAO galleryDAO = new GalleryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        if (uri.contains("/admin/gallery")) {
            if (!AdminServlet.isLoggedIn(req)) {
                resp.sendRedirect(req.getContextPath() + "/admin/login"); return;
            }
            req.setAttribute("galleryList", galleryDAO.getAllGalleryAdmin());
            req.getRequestDispatcher("/jsp/admin/gallery.jsp").forward(req, resp);
            return;
        }

        // Public gallery — optional category filter
        String catId = req.getParameter("catId");
        List<Gallery> items;
        if (catId != null && !catId.isEmpty()) {
            items = galleryDAO.getByCategory(Integer.parseInt(catId));
            req.setAttribute("activeCat", catId);
        } else {
            items = galleryDAO.getAllGallery();
        }
        req.setAttribute("galleryList", items);
        req.getRequestDispatcher("/jsp/public/gallery.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (!AdminServlet.isLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/admin/login"); return;
        }

        String action    = req.getParameter("action");
        String uploadDir = getServletContext().getRealPath("/uploads");

        if ("add".equals(action)) {
            Gallery g = new Gallery();
            g.setTitle(req.getParameter("title"));
            g.setDescription(req.getParameter("description"));
            g.setLocation(req.getParameter("location"));
            g.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
            g.setCompletionDate(req.getParameter("completionDate"));

            Part img = req.getPart("image");
            String fn = FileUpload.saveFile(img, uploadDir);
            g.setImageFilename(fn != null ? fn : "default-gallery.jpg");

            galleryDAO.addGallery(g);

        } else if ("edit".equals(action)) {
            Gallery g = new Gallery();
            g.setId(Integer.parseInt(req.getParameter("id")));
            g.setTitle(req.getParameter("title"));
            g.setDescription(req.getParameter("description"));
            g.setLocation(req.getParameter("location"));
            g.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
            g.setCompletionDate(req.getParameter("completionDate"));
            g.setActive("1".equals(req.getParameter("isActive")));

            Part img = req.getPart("image");
            g.setImageFilename(FileUpload.saveFile(img, uploadDir));
            galleryDAO.updateGallery(g);

        } else if ("delete".equals(action)) {
            // Soft delete - sirf is_active = 0 karta hai (Hidden)
            galleryDAO.deleteGallery(Integer.parseInt(req.getParameter("id")));

        } else if ("permanentDelete".equals(action)) {
            // Permanently delete - DB se bhi hata do + image file bhi
            int id = Integer.parseInt(req.getParameter("id"));
            // Pehle image filename lo
            model.Gallery g = galleryDAO.getById(id);
            if (g != null && g.getImageFilename() != null) {
                String uploadDir1 = getServletContext().getRealPath("/uploads");
                util.FileUpload.deleteFile(g.getImageFilename(), uploadDir1);
            }
            // DB se permanently delete karo
            galleryDAO.permanentDelete(id);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/gallery");
    }
}
