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

@WebServlet({"/products", "/admin/products"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize       = 5 * 1024 * 1024,
    maxRequestSize    = 10 * 1024 * 1024
)
public class ProductServlet extends HttpServlet {

    private ProductDAO  productDAO  = new ProductDAO();
    private InquiryDAO  inquiryDAO  = new InquiryDAO();

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

        // ✅ Public inquiry — admin check nahi chahiye
        if ("inquiry".equals(action)) {
            Inquiry inq = new Inquiry();
            inq.setName(req.getParameter("name"));
            inq.setPhone(req.getParameter("phone"));
            inq.setEmail(req.getParameter("email"));
            inq.setMessage(req.getParameter("message"));
            String pid = req.getParameter("productId");
            if (pid != null && !pid.isEmpty()) inq.setProductId(Integer.parseInt(pid));

            boolean saved = inquiryDAO.addInquiry(inq);
            
            // ❌ Purana — forward karta tha bina products ke
            // req.setAttribute("inquirySuccess", saved);
            // req.getRequestDispatcher("/jsp/public/products.jsp").forward(req, resp);
            
            // ✅ Fix — redirect karo, products automatically load honge
            if (saved) {
                resp.sendRedirect(req.getContextPath() + "/products?success=1");
            } else {
                resp.sendRedirect(req.getContextPath() + "/products?error=1");
            }
            return;
        }

        // ✅ Baaki sab admin ke liye
        if (!AdminServlet.isLoggedIn(req)) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }

        String uploadDir = getServletContext().getRealPath("/uploads");

        if ("add".equals(action)) {
            Product p = new Product();
            p.setName(req.getParameter("name"));
            p.setDescription(req.getParameter("description"));
            p.setPrice(Double.parseDouble(req.getParameter("price")));
            p.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
            p.setStockStatus(req.getParameter("stockStatus"));

            Part imagePart = req.getPart("image");
            String fileName = FileUpload.saveFile(imagePart, uploadDir);
            p.setImageFilename(fileName != null ? fileName : "default-product.jpg");

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

            Part imagePart = req.getPart("image");
            String fileName = FileUpload.saveFile(imagePart, uploadDir);
            p.setImageFilename(fileName);

            productDAO.updateProduct(p);
            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            productDAO.deleteProduct(id);
            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } else if ("permanentDelete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.ProductDAO pdao = new dao.ProductDAO();
            model.Product prod = pdao.getProductById(id);
            if (prod != null && prod.getImageFilename() != null) {
                String uploadDir1 = getServletContext().getRealPath("/uploads");
                util.FileUpload.deleteFile(prod.getImageFilename(), uploadDir1);
            }
            productDAO.permanentDelete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }
}