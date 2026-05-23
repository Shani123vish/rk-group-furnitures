package dao;

import model.Product;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ProductDAO.java
 * --------------------------------------------------
 * Handles all database operations for products:
 *   - getAllProducts()       → list all active products
 *   - getProductById(id)    → get one product
 *   - addProduct(product)   → insert new product
 *   - updateProduct(product)→ edit existing product
 *   - deleteProduct(id)     → soft delete (set is_active=0)
 *   - searchProducts(query) → search by name/category
 * --------------------------------------------------
 */
public class ProductDAO {

    /**
     * Returns all active products, with category name via JOIN.
     * Used on the public products page.
     */
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();

        // JOIN with categories to get the category name
        String sql = "SELECT p.*, c.name AS category_name " +
                     "FROM products p " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.is_active = 1 " +
                     "ORDER BY p.created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs)); // convert row to Product object
            }

        } catch (SQLException e) {
            System.err.println("ProductDAO.getAllProducts() error: " + e.getMessage());
        }

        return list;
    }

    /**
     * Returns all products (including inactive) for admin panel.
     */
    public List<Product> getAllProductsAdmin() {
        List<Product> list = new ArrayList<>();

        String sql = "SELECT p.*, c.name AS category_name " +
                     "FROM products p " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "ORDER BY p.created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (SQLException e) {
            System.err.println("ProductDAO.getAllProductsAdmin() error: " + e.getMessage());
        }

        return list;
    }

    /**
     * Returns a single product by its ID.
     */
    public Product getProductById(int id) {
        Product product = null;

        String sql = "SELECT p.*, c.name AS category_name " +
                     "FROM products p " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                product = mapRow(rs);
            }

        } catch (SQLException e) {
            System.err.println("ProductDAO.getProductById() error: " + e.getMessage());
        }

        return product;
    }

    /**
     * Inserts a new product into the database.
     * Returns true if insert succeeded, false if it failed.
     */
    public boolean addProduct(Product p) {
        String sql = "INSERT INTO products (name, description, price, category_id, image_filename, stock_status, is_active) " +
                     "VALUES (?, ?, ?, ?, ?, ?, 1)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getCategoryId());
            ps.setString(5, p.getImageFilename());
            ps.setString(6, p.getStockStatus());

            int rows = ps.executeUpdate(); // returns number of rows affected
            return rows > 0;

        } catch (SQLException e) {
            System.err.println("ProductDAO.addProduct() error: " + e.getMessage());
            return false;
        }
    }

    /**
     * Updates an existing product in the database.
     */
    public boolean updateProduct(Product p) {
        // If a new image was uploaded, update it; otherwise keep old one
        String sql;
        if (p.getImageFilename() != null && !p.getImageFilename().isEmpty()) {
            sql = "UPDATE products SET name=?, description=?, price=?, category_id=?, " +
                  "image_filename=?, stock_status=?, is_active=? WHERE id=?";
        } else {
            sql = "UPDATE products SET name=?, description=?, price=?, category_id=?, " +
                  "stock_status=?, is_active=? WHERE id=?";
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getCategoryId());

            if (p.getImageFilename() != null && !p.getImageFilename().isEmpty()) {
                ps.setString(5, p.getImageFilename());
                ps.setString(6, p.getStockStatus());
                ps.setInt(7, p.isActive() ? 1 : 0);
                ps.setInt(8, p.getId());
            } else {
                ps.setString(5, p.getStockStatus());
                ps.setInt(6, p.isActive() ? 1 : 0);
                ps.setInt(7, p.getId());
            }

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("ProductDAO.updateProduct() error: " + e.getMessage());
            return false;
        }
    }

    /**
     * Soft-deletes a product (sets is_active = 0).
     * We don't actually DELETE rows to preserve history.
     */
    public boolean deleteProduct(int id) {
        String sql = "UPDATE products SET is_active = 0 WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("ProductDAO.deleteProduct() error: " + e.getMessage());
            return false;
        }
    }

    /**
     * Searches products by name or category name.
     * Used for the search bar on the products page.
     */
    public List<Product> searchProducts(String query) {
        List<Product> list = new ArrayList<>();

        // LIKE with % wildcards matches partial words
        String sql = "SELECT p.*, c.name AS category_name " +
                     "FROM products p " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.is_active = 1 AND (p.name LIKE ? OR c.name LIKE ?) " +
                     "ORDER BY p.name";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String wildcard = "%" + query + "%";
            ps.setString(1, wildcard);
            ps.setString(2, wildcard);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (SQLException e) {
            System.err.println("ProductDAO.searchProducts() error: " + e.getMessage());
        }

        return list;
    }

    /**
     * Private helper: converts a ResultSet row into a Product object.
     * Called by all methods above to avoid repeating code.
     */
    private Product mapRow(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getDouble("price"));
        p.setCategoryId(rs.getInt("category_id"));
        p.setCategoryName(rs.getString("category_name"));
        p.setImageFilename(rs.getString("image_filename"));
        p.setStockStatus(rs.getString("stock_status"));
        p.setActive(rs.getInt("is_active") == 1);
        p.setCreatedAt(rs.getString("created_at"));
        return p;
    }


    // --------------------------------------------------------
    // ADD KIYA: Permanent delete - DB se row hata deta hai
    // Sirf Inactive products pe use karo
    // --------------------------------------------------------
    public boolean permanentDelete(int id) {
        String sql = "DELETE FROM products WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("ProductDAO.permanentDelete(): " + e.getMessage());
            return false;
        }
    }}
