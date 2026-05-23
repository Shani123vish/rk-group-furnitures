package dao;

import model.Inquiry;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * InquiryDAO.java
 * Handles customer contact form submissions.
 */
public class InquiryDAO {

    /** Save a new inquiry from the contact form. */
    public boolean addInquiry(Inquiry inq) {
        String sql = "INSERT INTO inquiries (name, phone, email, message, product_id) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, inq.getName());
            ps.setString(2, inq.getPhone());
            ps.setString(3, inq.getEmail());
            ps.setString(4, inq.getMessage());
            // product_id may be 0 if not a product inquiry
            if (inq.getProductId() > 0) ps.setInt(5, inq.getProductId());
            else ps.setNull(5, Types.INTEGER);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("InquiryDAO.addInquiry(): " + e.getMessage());
            return false;
        }
    }

    /** Returns all inquiries for admin panel, newest first. */
    public List<Inquiry> getAllInquiries() {
        List<Inquiry> list = new ArrayList<>();
        String sql = "SELECT i.*, p.name AS product_name FROM inquiries i " +
                     "LEFT JOIN products p ON i.product_id = p.id " +
                     "ORDER BY i.created_at DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Inquiry inq = new Inquiry();
                inq.setId(rs.getInt("id"));
                inq.setName(rs.getString("name"));
                inq.setPhone(rs.getString("phone"));
                inq.setEmail(rs.getString("email"));
                inq.setMessage(rs.getString("message"));
                inq.setProductId(rs.getInt("product_id"));
                inq.setProductName(rs.getString("product_name"));
                inq.setStatus(rs.getString("status"));
                inq.setCreatedAt(rs.getString("created_at"));
                list.add(inq);
            }
        } catch (SQLException e) {
            System.err.println("InquiryDAO.getAllInquiries(): " + e.getMessage());
        }
        return list;
    }

    /** Update inquiry status (new → read → replied). */
    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE inquiries SET status = ? WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("InquiryDAO.updateStatus(): " + e.getMessage());
            return false;
        }
    }
}