package dao;

import model.Worker;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * WorkerDAO.java
 * Handles all database operations for workers.
 */
public class WorkerDAO {

    /** Returns all active workers with their assigned site name. */
    public List<Worker> getAllWorkers() {
        List<Worker> list = new ArrayList<>();
        String sql = "SELECT w.*, ws.site_name FROM workers w " +
                     "LEFT JOIN work_sites ws ON w.site_id = ws.id " +
                     "ORDER BY w.name";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("WorkerDAO.getAllWorkers(): " + e.getMessage());
        }
        return list;
    }

    /** Get single worker by ID. */
    public Worker getById(int id) {
        Worker w = null;
        String sql = "SELECT w.*, ws.site_name FROM workers w " +
                     "LEFT JOIN work_sites ws ON w.site_id = ws.id WHERE w.id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) w = mapRow(rs);
        } catch (SQLException e) {
            System.err.println("WorkerDAO.getById(): " + e.getMessage());
        }
        return w;
    }

    /** Add a new worker. */
    public boolean addWorker(Worker w) {
        String sql = "INSERT INTO workers (name, phone, skill, daily_salary, site_id, attendance_note, is_active, joined_date) " +
                     "VALUES (?, ?, ?, ?, ?, ?, 1, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, w.getName());
            ps.setString(2, w.getPhone());
            ps.setString(3, w.getSkill());
            ps.setDouble(4, w.getDailySalary());
            if (w.getSiteId() > 0) ps.setInt(5, w.getSiteId());
            else ps.setNull(5, Types.INTEGER);
            ps.setString(6, w.getAttendanceNote());
            ps.setString(7, w.getJoinedDate());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("WorkerDAO.addWorker(): " + e.getMessage());
            return false;
        }
    }

    /** Update existing worker details. */
    public boolean updateWorker(Worker w) {
        String sql = "UPDATE workers SET name=?, phone=?, skill=?, daily_salary=?, " +
                     "site_id=?, attendance_note=?, is_active=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, w.getName());
            ps.setString(2, w.getPhone());
            ps.setString(3, w.getSkill());
            ps.setDouble(4, w.getDailySalary());
            if (w.getSiteId() > 0) ps.setInt(5, w.getSiteId());
            else ps.setNull(5, Types.INTEGER);
            ps.setString(6, w.getAttendanceNote());
            ps.setInt(7, w.isActive() ? 1 : 0);
            ps.setInt(8, w.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("WorkerDAO.updateWorker(): " + e.getMessage());
            return false;
        }
    }

    /** Soft-delete (deactivate) a worker. */
    public boolean deleteWorker(int id) {
        String sql = "UPDATE workers SET is_active = 0 WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("WorkerDAO.deleteWorker(): " + e.getMessage());
            return false;
        }
    }

    private Worker mapRow(ResultSet rs) throws SQLException {
        Worker w = new Worker();
        w.setId(rs.getInt("id"));
        w.setName(rs.getString("name"));
        w.setPhone(rs.getString("phone"));
        w.setSkill(rs.getString("skill"));
        w.setDailySalary(rs.getDouble("daily_salary"));
        w.setSiteId(rs.getInt("site_id"));
        w.setSiteName(rs.getString("site_name"));
        w.setAttendanceNote(rs.getString("attendance_note"));
        w.setActive(rs.getInt("is_active") == 1);
        w.setJoinedDate(rs.getString("joined_date"));
        w.setCreatedAt(rs.getString("created_at"));
        return w;
    }
}