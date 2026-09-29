package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class StyleServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) sb.append(line);

            JSONObject data = new JSONObject(sb.toString());

            int budget     = data.getInt("budget");
            int roomType   = data.getInt("room_type");
            int colorPref  = data.getInt("color_pref");
            int familySize = data.getInt("family_size");
            int roomLength = data.optInt("room_length", 12);
            int roomWidth  = data.optInt("room_width", 10);
            int doorPos    = data.optInt("door_pos", 1);
            int windowPos  = data.optInt("window_pos", 2);
            String naam    = data.getString("naam");
            String phone   = data.getString("phone");
            String photo   = data.optString("photo", "");

            String predictedStyle = getPredictionFromFlask(
                budget, roomType, colorPref, familySize,
                roomLength, roomWidth, doorPos, windowPos
            );

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/rk_group_db", "root", "Shani.com1"
            );

            String sql = "INSERT INTO interior_orders " +
                "(naam, phone, budget, room_type, color_pref, family_size, " +
                "room_photo, photo_path, predicted_style, payment_status, " +
                "room_length, room_width, door_pos, window_pos) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'pending', ?, ?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, naam);
            ps.setString(2, phone);
            ps.setInt(3, budget);
            ps.setInt(4, roomType);
            ps.setInt(5, colorPref);
            ps.setInt(6, familySize);
            ps.setString(7, photo);
            ps.setString(8, "uploads/room.jpg");
            ps.setString(9, predictedStyle);
            ps.setInt(10, roomLength);
            ps.setInt(11, roomWidth);
            ps.setInt(12, doorPos);
            ps.setInt(13, windowPos);
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) orderId = rs.getInt(1);

            conn.close();

            JSONObject responseJson = new JSONObject();
            responseJson.put("orderSaved", true);
            responseJson.put("orderId", orderId);
            out.print(responseJson.toString());

        } catch (Exception e) {
            out.print("{\"orderSaved\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
    }

    private String getPredictionFromFlask(int budget, int roomType, int colorPref,
                                          int familySize, int roomLength, int roomWidth,
                                          int doorPos, int windowPos) {
        try {
            URL url = new URL("http://localhost:5000/predict");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            JSONObject body = new JSONObject();
            body.put("budget",      budget);
            body.put("room_type",   roomType);
            body.put("color_pref",  colorPref);
            body.put("family_size", familySize);
            body.put("room_length", roomLength);
            body.put("room_width",  roomWidth);
            body.put("door_pos",    doorPos);
            body.put("window_pos",  windowPos);

            OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream());
            writer.write(body.toString());
            writer.flush();

            BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getInputStream())
            );
            StringBuilder result = new StringBuilder();
            String responseLine;
            while ((responseLine = br.readLine()) != null) result.append(responseLine);

            JSONObject res = new JSONObject(result.toString());
            return res.getString("style");

        } catch (Exception e) {
            return "Modern";
        }
    }
}