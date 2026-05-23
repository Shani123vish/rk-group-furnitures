package dao;

import model.Gallery;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * GalleryDAO.java
 * Handles all database operations for the gallery/portfolio section.
 */
public class GalleryDAO {

    /** Returns all active gallery items for public view. */
    public List<Gallery> getAllGallery() {
        List<Gallery> list = new ArrayList<>();
        String sql = "SELECT g.*, c.name AS category_name " +
                     "FROM gallery g " +
                     "LEFT JOIN categories c ON g.category_id = c.id " +
                     "WHERE g.is_active = 1 " +
                     "ORDER BY g.created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("GalleryDAO.getAllGallery(): " + e.getMessage());
        }
        return list;
    }

    /** Returns all gallery items (for admin panel). */
    public List<Gallery> getAllGalleryAdmin() {
        List<Gallery> list = new ArrayList<>();
        String sql = "SELECT g.*, c.name AS category_name " +
                     "FROM gallery g " +
                     "LEFT JOIN categories c ON g.category_id = c.id " +
                     "ORDER BY g.created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("GalleryDAO.getAllGalleryAdmin(): " + e.getMessage());
        }
        return list;
    }

    /** Returns gallery items filtered by category (for filter buttons on gallery page). */
    public List<Gallery> getByCategory(int categoryId) {
        List<Gallery> list = new ArrayList<>();
        String sql = "SELECT g.*, c.name AS category_name " +
                     "FROM gallery g " +
                     "LEFT JOIN categories c ON g.category_id = c.id " +
                     "WHERE g.is_active = 1 AND g.category_id = ? " +
                     "ORDER BY g.created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("GalleryDAO.getByCategory(): " + e.getMessage());
        }
        return list;
    }

    /** Get a single gallery item by ID. */
    public Gallery getById(int id) {
        Gallery g = null;
        String sql = "SELECT g.*, c.name AS category_name FROM gallery g " +
                     "LEFT JOIN categories c ON g.category_id = c.id WHERE g.id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) g = mapRow(rs);
        } catch (SQLException e) {
            System.err.println("GalleryDAO.getById(): " + e.getMessage());
        }
        return g;
    }

    /** Insert a new gallery project. Returns true on success. */
    public boolean addGallery(Gallery g) {
        String sql = "INSERT INTO gallery (title, description, location, category_id, image_filename, completion_date, is_active) " +
                     "VALUES (?, ?, ?, ?, ?, ?, 1)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, g.getTitle());
            ps.setString(2, g.getDescription());
            ps.setString(3, g.getLocation());
            ps.setInt(4, g.getCategoryId());
            ps.setString(5, g.getImageFilename());
            ps.setString(6, g.getCompletionDate());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("GalleryDAO.addGallery(): " + e.getMessage());
            return false;
        }
    }

    /** Update an existing gallery item. */
    public boolean updateGallery(Gallery g) {
        boolean hasNewImage = g.getImageFilename() != null && !g.getImageFilename().isEmpty();
        String sql = hasNewImage
            ? "UPDATE gallery SET title=?, description=?, location=?, category_id=?, image_filename=?, completion_date=?, is_active=? WHERE id=?"
            : "UPDATE gallery SET title=?, description=?, location=?, category_id=?, completion_date=?, is_active=? WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, g.getTitle());
            ps.setString(2, g.getDescription());
            ps.setString(3, g.getLocation());
            ps.setInt(4, g.getCategoryId());
            if (hasNewImage) {
                ps.setString(5, g.getImageFilename());
                ps.setString(6, g.getCompletionDate());
                ps.setInt(7, g.isActive() ? 1 : 0);
                ps.setInt(8, g.getId());
            } else {
                ps.setString(5, g.getCompletionDate());
                ps.setInt(6, g.isActive() ? 1 : 0);
                ps.setInt(7, g.getId());
            }
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("GalleryDAO.updateGallery(): " + e.getMessage());
            return false;
        }
    }

    /** Soft-delete: sirf is_active = 0 karta hai (Hidden ho jata hai) */
    public boolean deleteGallery(int id) {
        String sql = "UPDATE gallery SET is_active = 0 WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("GalleryDAO.deleteGallery(): " + e.getMessage());
            return false;
        }
    }

    /**
     * Permanent delete: DB se bhi row hata deta hai.
     * Sirf Hidden items pe use karo.
     */
    public boolean permanentDelete(int id) {
        String sql = "DELETE FROM gallery WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("GalleryDAO.permanentDelete(): " + e.getMessage());
            return false;
        }
    }

    /** Map ResultSet row → Gallery object. */
    private Gallery mapRow(ResultSet rs) throws SQLException {
        Gallery g = new Gallery();
        g.setId(rs.getInt("id"));
        g.setTitle(rs.getString("title"));
        g.setDescription(rs.getString("description"));
        g.setLocation(rs.getString("location"));
        g.setCategoryId(rs.getInt("category_id"));
        g.setCategoryName(rs.getString("category_name"));
        g.setImageFilename(rs.getString("image_filename"));
        g.setCompletionDate(rs.getString("completion_date"));
        g.setActive(rs.getInt("is_active") == 1);
        g.setCreatedAt(rs.getString("created_at"));
        return g;
    }
}
