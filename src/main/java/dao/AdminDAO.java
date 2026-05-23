package dao;

import model.Admin;
import util.DBConnection;

import java.sql.*;

/**
 * AdminDAO.java
 * --------------------------------------------------
 * Data Access Object for admin authentication.
 * All database queries related to admins go here.
 *
 * IMPORTANT: Always use PreparedStatement (never
 * concatenate user input into SQL — that causes
 * SQL Injection attacks!).
 * --------------------------------------------------
 */
public class AdminDAO {

    /**
     * Checks if the given username + password exist in the DB.
     * Returns the Admin object if login is valid, else returns null.
     *
     * @param username - from login form
     * @param password - from login form (plain text for now)
     */
    public Admin login(String username, String password) {
        Admin admin = null;

        // SQL query using ? placeholders (PreparedStatement is safe)
        String sql = "SELECT * FROM admins WHERE username = ? AND password = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Set the ? values
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            // If a row is found, login is successful
            if (rs.next()) {
                admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setUsername(rs.getString("username"));
                admin.setEmail(rs.getString("email"));
                admin.setFullName(rs.getString("full_name"));
                admin.setCreatedAt(rs.getString("created_at"));
            }

        } catch (SQLException e) {
            System.err.println("AdminDAO.login() error: " + e.getMessage());
            e.printStackTrace();
        }

        return admin; // null means login failed
    }

    /**
     * Returns dashboard summary counts for the admin dashboard cards.
     * Returns an int array: [inquiries, products, gallery, sites, workers, bookings]
     */
    public int[] getDashboardCounts() {
        int[] counts = new int[6]; // 6 count values

        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement()) {

            // Count new inquiries
            ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM inquiries WHERE status='new'");
            if (rs.next()) counts[0] = rs.getInt(1);

            // Count active products
            rs = st.executeQuery("SELECT COUNT(*) FROM products WHERE is_active=1");
            if (rs.next()) counts[1] = rs.getInt(1);

            // Count gallery items
            rs = st.executeQuery("SELECT COUNT(*) FROM gallery WHERE is_active=1");
            if (rs.next()) counts[2] = rs.getInt(1);

            // Count active work sites
            rs = st.executeQuery("SELECT COUNT(*) FROM work_sites WHERE status='active'");
            if (rs.next()) counts[3] = rs.getInt(1);

            // Count active workers
            rs = st.executeQuery("SELECT COUNT(*) FROM workers WHERE is_active=1");
            if (rs.next()) counts[4] = rs.getInt(1);

            // Count pending bookings
            rs = st.executeQuery("SELECT COUNT(*) FROM bookings WHERE status='pending'");
            if (rs.next()) counts[5] = rs.getInt(1);

        } catch (SQLException e) {
            System.err.println("AdminDAO.getDashboardCounts() error: " + e.getMessage());
        }

        return counts;
    }
}