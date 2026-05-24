package controller;

import java.io.IOException;
import java.util.List;

import dao.GalleryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Gallery;
import util.CloudinaryUpload;

/**
 * GalleryServlet.java
 * Cloudinary ke saath — images aur videos dono upload ho sakti hain.
 */
@WebServlet({"/gallery", "/admin/gallery"})
@MultipartConfig(maxFileSize = 50 * 1024 * 1024,   // 50MB (videos ke liye)
                 maxRequestSize = 60 * 1024 * 1024)
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

        // Public gallery
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

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            Gallery g = new Gallery();
            g.setTitle(req.getParameter("title"));
            g.setDescription(req.getParameter("description"));
            g.setLocation(req.getParameter("location"));
            g.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
            g.setCompletionDate(req.getParameter("completionDate"));

            // Cloudinary pe upload karo (image ya video dono)
            Part mediaPart = req.getPart("image");
            if (mediaPart != null && mediaPart.getSize() > 0) {
                String cloudUrl = CloudinaryUpload.uploadFile(mediaPart, "gallery");
                g.setImageUrl(cloudUrl);
                // media type detect karo
                String filename = mediaPart.getSubmittedFileName();
                g.setMediaType(CloudinaryUpload.isVideo(filename) ? "video" : "image");
                g.setImageFilename(filename); // backup
            }

            boolean success = galleryDAO.addGallery(g);
            if (!success) {
                req.getSession().setAttribute("flashMsg", "Upload failed. Please try again.");
            }

        } else if ("edit".equals(action)) {
            Gallery g = new Gallery();
            g.setId(Integer.parseInt(req.getParameter("id")));
            g.setTitle(req.getParameter("title"));
            g.setDescription(req.getParameter("description"));
            g.setLocation(req.getParameter("location"));
            g.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
            g.setCompletionDate(req.getParameter("completionDate"));
            g.setActive("1".equals(req.getParameter("isActive")));

            Part mediaPart = req.getPart("image");
            if (mediaPart != null && mediaPart.getSize() > 0) {
                String cloudUrl = CloudinaryUpload.uploadFile(mediaPart, "gallery");
                g.setImageUrl(cloudUrl);
                String filename = mediaPart.getSubmittedFileName();
                g.setMediaType(CloudinaryUpload.isVideo(filename) ? "video" : "image");
            }
            galleryDAO.updateGallery(g);

        } else if ("delete".equals(action)) {
            galleryDAO.deleteGallery(Integer.parseInt(req.getParameter("id")));

        } else if ("permanentDelete".equals(action)) {
            galleryDAO.permanentDelete(Integer.parseInt(req.getParameter("id")));
        }

        resp.sendRedirect(req.getContextPath() + "/admin/gallery");
    }
}
