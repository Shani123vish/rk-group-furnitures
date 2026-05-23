package dao;

import model.WorkSite;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * SiteDAO.java
 * Handles all database operations for work sites.
 */
public class SiteDAO {

    /** Returns all work sites for admin panel. */
    public List<WorkSite> getAllSites() {
        List<WorkSite> list = new ArrayList<>();
        String sql = "SELECT * FROM work_sites ORDER BY created_at DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("SiteDAO.getAllSites(): " + e.getMessage());
        }
        return list;
    }

    /** Returns only active sites. */
    public List<WorkSite> getActiveSites() {
        List<WorkSite> list = new ArrayList<>();
        String sql = "SELECT * FROM work_sites WHERE status = 'active' ORDER BY start_date DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("SiteDAO.getActiveSites(): " + e.getMessage());
        }
        return list;
    }

    /** Get a single site by ID. */
    public WorkSite getById(int id) {
        WorkSite site = null;
        String sql = "SELECT * FROM work_sites WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) site = mapRow(rs);
        } catch (SQLException e) {
            System.err.println("SiteDAO.getById(): " + e.getMessage());
        }
        return site;
    }

    /** Add a new work site. */
    public boolean addSite(WorkSite s) {
        String sql = "INSERT INTO work_sites (site_name, client_name, client_phone, address, " +
                     "start_date, expected_end_date, status, budget, notes) VALUES (?,?,?,?,?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, s.getSiteName());
            ps.setString(2, s.getClientName());
            ps.setString(3, s.getClientPhone());
            ps.setString(4, s.getAddress());
            ps.setString(5, s.getStartDate());
            ps.setString(6, s.getExpectedEndDate());
            ps.setString(7, s.getStatus());
            ps.setDouble(8, s.getBudget());
            ps.setString(9, s.getNotes());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("SiteDAO.addSite(): " + e.getMessage());
            return false;
        }
    }

    /** Update an existing site. */
    public boolean updateSite(WorkSite s) {
        String sql = "UPDATE work_sites SET site_name=?, client_name=?, client_phone=?, address=?, " +
                     "start_date=?, expected_end_date=?, actual_end_date=?, status=?, budget=?, notes=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, s.getSiteName());
            ps.setString(2, s.getClientName());
            ps.setString(3, s.getClientPhone());
            ps.setString(4, s.getAddress());
            ps.setString(5, s.getStartDate());
            ps.setString(6, s.getExpectedEndDate());
            ps.setString(7, s.getActualEndDate());
            ps.setString(8, s.getStatus());
            ps.setDouble(9, s.getBudget());
            ps.setString(10, s.getNotes());
            ps.setInt(11, s.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("SiteDAO.updateSite(): " + e.getMessage());
            return false;
        }
    }

    /** Delete a site record permanently. */
    public boolean deleteSite(int id) {
        String sql = "DELETE FROM work_sites WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("SiteDAO.deleteSite(): " + e.getMessage());
            return false;
        }
    }

    /** Map ResultSet row → WorkSite object. */
    private WorkSite mapRow(ResultSet rs) throws SQLException {
        WorkSite s = new WorkSite();
        s.setId(rs.getInt("id"));
        s.setSiteName(rs.getString("site_name"));
        s.setClientName(rs.getString("client_name"));
        s.setClientPhone(rs.getString("client_phone"));
        s.setAddress(rs.getString("address"));
        s.setStartDate(rs.getString("start_date"));
        s.setExpectedEndDate(rs.getString("expected_end_date"));
        s.setActualEndDate(rs.getString("actual_end_date"));
        s.setStatus(rs.getString("status"));
        s.setBudget(rs.getDouble("budget"));
        s.setNotes(rs.getString("notes"));
        s.setCreatedAt(rs.getString("created_at"));
        return s;
    }
}