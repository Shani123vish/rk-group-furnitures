package controller;

import dao.ProductDAO;
import dao.InquiryDAO;
import model.Product;
import model.Inquiry;
import util.CloudinaryUpload;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet({"/products", "/admin/products"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize       = 5 * 1024 * 1024,
    maxRequestSize    = 10 * 1024 * 1024
)
public class ProductServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();
    private InquiryDAO inquiryDAO = new InquiryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

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

        String idParam     = req.getParameter("id");
        String searchParam = req.getParameter("search");

        if (idParam != null) {
            int id = Integer.parseInt(idParam);
            Product product = productDAO.getProductById(id);
            req.setAttribute("product", product);
            req.getRequestDispatcher("/jsp/public/productDetail.jsp").forward(req, resp);

        } else if (searchParam != null && !searchParam.trim().isEmpty()) {
            List<Product> results = productDAO.searchProducts(searchParam.trim());
            req.setAttribute("products", results);
            req.setAttribute("searchQuery", searchParam);
            req.getRequestDispatcher("/jsp/public/products.jsp").forward(req, resp);

        } else {
            List<Product> products = productDAO.getAllProducts();
            req.setAttribute("products", products);
            req.getRequestDispatcher("/jsp/public/products.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        // Public inquiry
        if ("inquiry".equals(action)) {
            Inquiry inq = new Inquiry();
            inq.setName(req.getParameter("name"));
            inq.setPhone(req.getParameter("phone"));
            inq.setEmail(req.getParameter("email"));
            inq.setMessage(req.getParameter("message"));
            String pid = req.getParameter("productId");
            if (pid != null && !pid.isEmpty()) inq.setProductId(Integer.parseInt(pid));

            boolean saved = inquiryDAO.addInquiry(inq);
            if (saved) {
                resp.sendRedirect(req.getContextPath() + "/products?success=1");
            } else {
                resp.sendRedirect(req.getContextPath() + "/products?error=1");
            }
            return;
        }

        // Admin only
        if (!AdminServlet.isLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }

        if ("add".equals(action)) {
            Product p = new Product();
            p.setName(req.getParameter("name"));
            p.setDescription(req.getParameter("description"));
            p.setPrice(Double.parseDouble(req.getParameter("price")));
            p.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
            p.setStockStatus(req.getParameter("stockStatus"));

            // ✅ Cloudinary upload
            Part imagePart = req.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                String cloudUrl = CloudinaryUpload.uploadFile(imagePart, "products");
                p.setImageFilename(cloudUrl != null ? cloudUrl : "");
            } else {
                p.setImageFilename("");
            }

            boolean success = productDAO.addProduct(p);
            req.getSession().setAttribute("flashMsg",
                success ? "Product added successfully!" : "Failed to add product.");
            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } else if ("edit".equals(action)) {
            Product p = new Product();
            p.setId(Integer.parseInt(req.getParameter("id")));
            p.setName(req.getParameter("name"));
            p.setDescription(req.getParameter("description"));
            p.setPrice(Double.parseDouble(req.getParameter("price")));
            p.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
            p.setStockStatus(req.getParameter("stockStatus"));
            p.setActive("1".equals(req.getParameter("isActive")));

            // ✅ Cloudinary upload — sirf tab jab nai image upload ho
            Part imagePart = req.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                String cloudUrl = CloudinaryUpload.uploadFile(imagePart, "products");
                p.setImageFilename(cloudUrl);
            }
            // agar nai image nahi — purani DB wali rahegi (null set nahi hogi)

            productDAO.updateProduct(p);
            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            productDAO.deleteProduct(id);
            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } else if ("permanentDelete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            productDAO.permanentDelete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }
}