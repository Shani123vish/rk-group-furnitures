package dao;

import model.Feedback;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * FeedbackDAO.java
 * Handles all database operations for customer feedback.
 */
public class FeedbackDAO {

    /** Save new feedback from public form */
    public boolean addFeedback(Feedback f) {
        String sql = "INSERT INTO feedback (name, phone, location, rating, message) VALUES (?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, f.getName());
            ps.setString(2, f.getPhone());
            ps.setString(3, f.getLocation());
            ps.setInt(4, f.getRating());
            ps.setString(5, f.getMessage());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("FeedbackDAO.addFeedback(): " + e.getMessage());
            return false;
        }
    }

    /** Get all active feedback for public page — newest first */
    public List<Feedback> getAllFeedback() {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM feedback WHERE is_active = 1 ORDER BY created_at DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("FeedbackDAO.getAllFeedback(): " + e.getMessage());
        }
        return list;
    }

    /** Get all feedback for admin panel */
    public List<Feedback> getAllFeedbackAdmin() {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM feedback ORDER BY created_at DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("FeedbackDAO.getAllFeedbackAdmin(): " + e.getMessage());
        }
        return list;
    }

    /** Delete feedback */
    public boolean deleteFeedback(int id) {
        String sql = "DELETE FROM feedback WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("FeedbackDAO.deleteFeedback(): " + e.getMessage());
            return false;
        }
    }

    /** Get average rating */
    public double getAverageRating() {
        String sql = "SELECT AVG(rating) FROM feedback WHERE is_active = 1";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) {
            System.err.println("FeedbackDAO.getAverageRating(): " + e.getMessage());
        }
        return 0;
    }

    private Feedback mapRow(ResultSet rs) throws SQLException {
        Feedback f = new Feedback();
        f.setId(rs.getInt("id"));
        f.setName(rs.getString("name"));
        f.setPhone(rs.getString("phone"));
        f.setLocation(rs.getString("location"));
        f.setRating(rs.getInt("rating"));
        f.setMessage(rs.getString("message"));
        f.setActive(rs.getInt("is_active") == 1);
        f.setCreatedAt(rs.getString("created_at"));
        return f;
    }
}
