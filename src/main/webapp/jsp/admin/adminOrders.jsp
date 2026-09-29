<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Orders</title>
    <style>
        body { font-family: Arial; padding: 20px; background: #f5f5f5; }
        h2 { color: #5a3e28; margin-bottom: 20px; }
        table { width: 100%; background: white; border-radius: 10px;
                border-collapse: collapse; overflow: hidden;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08); }
        th { background: #5a3e28; color: white; padding: 12px; text-align: left; font-size: 13px; }
        td { padding: 12px; border-bottom: 1px solid #f0e8e0; font-size: 13px; }
        tr:hover { background: #faf7f4; }
        .paid    { color: green; font-weight: bold; }
        .pending { color: orange; font-weight: bold; }
    </style>
</head>
<body>
    <h2>Saare Orders — RK Group Admin</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Naam</th>
            <th>Phone</th>
            <th>Room</th>
            <th>Budget</th>
            <th>Predicted Style</th>
            <th>Payment</th>
            <th>Kab Aaya</th>
        </tr>

        <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/rk_group", "root", ""
            );

            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(
                "SELECT * FROM interior_orders ORDER BY banaya_kab DESC"
            );

            String[] roomNames   = {"", "Bedroom", "Living Room", "Kitchen/Office"};
            String[] budgetNames = {"", "1L se Kam", "1-3 Lakh", "3L se Zyada"};

            while (rs.next()) {
                String payStatus = rs.getString("payment_status");
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("naam") %></td>
            <td><%= rs.getString("phone") %></td>
            <td><%= roomNames[rs.getInt("room_type")] %></td>
            <td><%= budgetNames[rs.getInt("budget")] %></td>
            <td><%= rs.getString("predicted_style") %></td>
            <td class="<%= payStatus %>"><%= payStatus.toUpperCase() %></td>
            <td><%= rs.getTimestamp("banaya_kab") %></td>
        </tr>
        <%
            }
            conn.close();
        } catch (Exception e) {
            out.print("<tr><td colspan='8'>DB Error: " + e.getMessage() + "</td></tr>");
        }
        %>
    </table>
</body>
</html>