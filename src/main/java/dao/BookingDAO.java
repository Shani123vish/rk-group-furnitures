package dao;

import model.Booking;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * BookingDAO.java
 * Handles site visit / consultation booking operations.
 */
public class BookingDAO {

    /** Save a new booking request from the public form. */
    public boolean addBooking(Booking b) {
        String sql = "INSERT INTO bookings (customer_name, phone, email, address, visit_date, message) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, b.getCustomerName());
            ps.setString(2, b.getPhone());
            ps.setString(3, b.getEmail());
            ps.setString(4, b.getAddress());
            ps.setString(5, b.getVisitDate());
            ps.setString(6, b.getMessage());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("BookingDAO.addBooking(): " + e.getMessage());
            return false;
        }
    }

    /** Returns all bookings for admin panel. */
    public List<Booking> getAllBookings() {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM bookings ORDER BY created_at DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Booking b = new Booking();
                b.setId(rs.getInt("id"));
                b.setCustomerName(rs.getString("customer_name"));
                b.setPhone(rs.getString("phone"));
                b.setEmail(rs.getString("email"));
                b.setAddress(rs.getString("address"));
                b.setVisitDate(rs.getString("visit_date"));
                b.setMessage(rs.getString("message"));
                b.setStatus(rs.getString("status"));
                b.setAdminNotes(rs.getString("admin_notes"));
                b.setCreatedAt(rs.getString("created_at"));
                list.add(b);
            }
        } catch (SQLException e) {
            System.err.println("BookingDAO.getAllBookings(): " + e.getMessage());
        }
        return list;
    }

    /** Admin approves, rejects, or marks booking complete. */
    public boolean updateStatus(int id, String status, String adminNotes) {
        String sql = "UPDATE bookings SET status = ?, admin_notes = ? WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, adminNotes);
            ps.setInt(3, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("BookingDAO.updateStatus(): " + e.getMessage());
            return false;
        }
    }
}