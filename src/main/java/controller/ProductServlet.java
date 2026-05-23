package controller;

import dao.ProductDAO;
import dao.InquiryDAO;
import model.Product;
import model.Inquiry;
import util.FileUpload;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * ProductServlet.java
 * --------------------------------------------------
 * Handles product listing (public) and admin CRUD.
 *
 * URL mappings:
 *   GET  /products            → public product list
 *   GET  /products?id=X       → product detail page
 *   GET  /products?search=X   → search products
 *   GET  /admin/products      → admin product list
 *   POST /admin/products      → add/edit/delete product
 * --------------------------------------------------
 *
 * @MultipartConfig is required to handle file uploads (images).
 */
@WebServlet({"/products", "/admin/products"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,     // 1 MB in memory before writing to disk
    maxFileSize       = 5 * 1024 * 1024, // max 5 MB per file
    maxRequestSize    = 10 * 1024 * 1024 // max 10 MB total request
)
public class ProductServlet extends HttpServlet {

    private ProductDAO  productDAO  = new ProductDAO();
    private InquiryDAO  inquiryDAO  = new InquiryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        // ---- ADMIN PANEL ----
        if (uri.contains("/admin/products")) {
            if (!AdminServlet.isLoggedIn(req)) {
                resp.sendRedirect(req.getContextPath() + "/admin/login");
                return;
            }
            List<Product> products = productDAO.getAllProductsAdmin();
            req.setAttribute("products", products);
            req.getRequestDispatcher("/jsp/admin/products.jsp").forward(req, resp);
            return;
        }

        // ---- PUBLIC PAGE ----
        String idParam     = req.getParameter("id");
        String searchParam = req.getParameter("search");

        if (idParam != null) {
            // Show single product detail
            int id = Integer.parseInt(idParam);
            Product product = productDAO.getProductById(id);
            req.setAttribute("product", product);
            req.getRequestDispatcher("/jsp/public/productDetail.jsp").forward(req, resp);

        } else if (searchParam != null && !searchParam.trim().isEmpty()) {
            // Search results
            List<Product> results = productDAO.searchProducts(searchParam.trim());
            req.setAttribute("products", results);
            req.setAttribute("searchQuery", searchParam);
            req.getRequestDispatcher("/jsp/public/products.jsp").forward(req, resp);

        } else {
            // Show all products
            List<Product> products = productDAO.getAllProducts();
            req.setAttribute("products", products);
            req.getRequestDispatcher("/jsp/public/products.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // All POST actions require admin login
        if (!AdminServlet.isLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }

        String action = req.getParameter("action");
        // Upload directory — absolute path on server
        String uploadDir = getServletContext().getRealPath("/uploads");

        if ("add".equals(action)) {
            // --- ADD NEW PRODUCT ---
            Product p = new Product();
            p.setName(req.getParameter("name"));
            p.setDescription(req.getParameter("description"));
            p.setPrice(Double.parseDouble(req.getParameter("price")));
            p.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
            p.setStockStatus(req.getParameter("stockStatus"));

            // Handle image upload
            Part imagePart = req.getPart("image");
            String fileName = FileUpload.saveFile(imagePart, uploadDir);
            p.setImageFilename(fileName != null ? fileName : "default-product.jpg");

            boolean success = productDAO.addProduct(p);
            req.getSession().setAttribute("flashMsg",
                success ? "Product added successfully!" : "Failed to add product.");
            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } else if ("edit".equals(action)) {
            // --- EDIT EXISTING PRODUCT ---
            Product p = new Product();
            p.setId(Integer.parseInt(req.getParameter("id")));
            p.setName(req.getParameter("name"));
            p.setDescription(req.getParameter("description"));
            p.setPrice(Double.parseDouble(req.getParameter("price")));
            p.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
            p.setStockStatus(req.getParameter("stockStatus"));
            p.setActive("1".equals(req.getParameter("isActive")));

            // Only update image if a new one was uploaded
            Part imagePart = req.getPart("image");
            String fileName = FileUpload.saveFile(imagePart, uploadDir);
            p.setImageFilename(fileName); // null if no new image → DAO keeps old one

            productDAO.updateProduct(p);
            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } else if ("delete".equals(action)) {
            // --- SOFT DELETE: is_active = 0 (Inactive ho jata hai) ---
            int id = Integer.parseInt(req.getParameter("id"));
            productDAO.deleteProduct(id);
            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } else if ("permanentDelete".equals(action)) {
            // --- PERMANENT DELETE: DB se bhi hata do ---
            int id = Integer.parseInt(req.getParameter("id"));
            // Image bhi delete karo
            dao.ProductDAO pdao = new dao.ProductDAO();
            model.Product prod = pdao.getProductById(id);
            if (prod != null && prod.getImageFilename() != null) {
                String uploadDir1 = getServletContext().getRealPath("/uploads");
                util.FileUpload.deleteFile(prod.getImageFilename(), uploadDir1);
            }
            productDAO.permanentDelete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } else if ("inquiry".equals(action)) {
            // --- CUSTOMER INQUIRY about a product (from public page) ---
            Inquiry inq = new Inquiry();
            inq.setName(req.getParameter("name"));
            inq.setPhone(req.getParameter("phone"));
            inq.setEmail(req.getParameter("email"));
            inq.setMessage(req.getParameter("message"));
            String pid = req.getParameter("productId");
            if (pid != null && !pid.isEmpty()) inq.setProductId(Integer.parseInt(pid));

            boolean saved = inquiryDAO.addInquiry(inq);
            req.setAttribute("inquirySuccess", saved);
            req.getRequestDispatcher("/jsp/public/products.jsp").forward(req, resp);
        }
    }
}
