package dao;

import model.Gallery;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * GalleryDAO.java
 * Cloudinary support ke saath — image_url aur media_type columns use karta hai.
 */
public class GalleryDAO {

    public List<Gallery> getAllGallery() {
        List<Gallery> list = new ArrayList<>();
        String sql = "SELECT g.*, c.name AS category_name FROM gallery g " +
                     "LEFT JOIN categories c ON g.category_id = c.id " +
                     "WHERE g.is_active = 1 ORDER BY g.created_at DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("GalleryDAO.getAllGallery(): " + e.getMessage());
        }
        return list;
    }

    public List<Gallery> getAllGalleryAdmin() {
        List<Gallery> list = new ArrayList<>();
        String sql = "SELECT g.*, c.name AS category_name FROM gallery g " +
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

    public List<Gallery> getByCategory(int categoryId) {
        List<Gallery> list = new ArrayList<>();
        String sql = "SELECT g.*, c.name AS category_name FROM gallery g " +
                     "LEFT JOIN categories c ON g.category_id = c.id " +
                     "WHERE g.is_active = 1 AND g.category_id = ? ORDER BY g.created_at DESC";
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

    /** Add new gallery item with Cloudinary URL */
    public boolean addGallery(Gallery g) {
        String sql = "INSERT INTO gallery (title, description, location, category_id, " +
                     "image_filename, image_url, media_type, completion_date, is_active) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 1)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, g.getTitle());
            ps.setString(2, g.getDescription());
            ps.setString(3, g.getLocation());
            ps.setInt(4, g.getCategoryId());
            ps.setString(5, g.getImageFilename());     // old local filename (backup)
            ps.setString(6, g.getImageUrl());          // Cloudinary URL
            ps.setString(7, g.getMediaType() != null ? g.getMediaType() : "image");
            ps.setString(8, g.getCompletionDate());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("GalleryDAO.addGallery(): " + e.getMessage());
            return false;
        }
    }

    public boolean updateGallery(Gallery g) {
        boolean hasNewMedia = g.getImageUrl() != null && !g.getImageUrl().isEmpty();
        String sql = hasNewMedia
            ? "UPDATE gallery SET title=?, description=?, location=?, category_id=?, " +
              "image_url=?, media_type=?, completion_date=?, is_active=? WHERE id=?"
            : "UPDATE gallery SET title=?, description=?, location=?, category_id=?, " +
              "completion_date=?, is_active=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, g.getTitle());
            ps.setString(2, g.getDescription());
            ps.setString(3, g.getLocation());
            ps.setInt(4, g.getCategoryId());
            if (hasNewMedia) {
                ps.setString(5, g.getImageUrl());
                ps.setString(6, g.getMediaType() != null ? g.getMediaType() : "image");
                ps.setString(7, g.getCompletionDate());
                ps.setInt(8, g.isActive() ? 1 : 0);
                ps.setInt(9, g.getId());
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

    private Gallery mapRow(ResultSet rs) throws SQLException {
        Gallery g = new Gallery();
        g.setId(rs.getInt("id"));
        g.setTitle(rs.getString("title"));
        g.setDescription(rs.getString("description"));
        g.setLocation(rs.getString("location"));
        g.setCategoryId(rs.getInt("category_id"));
        g.setCategoryName(rs.getString("category_name"));
        g.setImageFilename(rs.getString("image_filename"));
        g.setImageUrl(rs.getString("image_url"));           // Cloudinary URL
        g.setMediaType(rs.getString("media_type"));         // image/video
        g.setCompletionDate(rs.getString("completion_date"));
        g.setActive(rs.getInt("is_active") == 1);
        g.setCreatedAt(rs.getString("created_at"));
        return g;
    }
}
