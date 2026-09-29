package controller;

import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.JSONArray;
import org.json.JSONObject;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class StyleResultServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderId = request.getParameter("orderId");
        String paid    = request.getParameter("paid");

        if (!"true".equals(paid)) {
            response.sendRedirect("jsp/public/styleForm.jsp");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/rk_group_db", "root", "Shani.com1"
            );

            PreparedStatement ps = conn.prepareStatement(
                "SELECT * FROM interior_orders WHERE id = ?"
            );
            ps.setInt(1, Integer.parseInt(orderId));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int budget     = rs.getInt("budget");
                int roomType   = rs.getInt("room_type");
                int colorPref  = rs.getInt("color_pref");
                int familySize = rs.getInt("family_size");
                int roomLength = rs.getInt("room_length");
                int roomWidth  = rs.getInt("room_width");
                int doorPos    = rs.getInt("door_pos");
                int windowPos  = rs.getInt("window_pos");
                String naam    = rs.getString("naam");
                String style   = rs.getString("predicted_style");
                String roomPhotoBase64 = rs.getString("room_photo");

                // Get full details from Flask
                JSONObject details = getDetailsFromFlask(
                    budget, roomType, colorPref, familySize,
                    roomLength, roomWidth, doorPos, windowPos
                );

                // Save customer photo
                String generatedImageUrl = "";
                if (roomPhotoBase64 != null && !roomPhotoBase64.isEmpty()) {
                    try {
                        String base64Data = roomPhotoBase64;
                        if (roomPhotoBase64.contains(",")) {
                            base64Data = roomPhotoBase64.split(",")[1];
                        }
                        byte[] imageBytes = java.util.Base64.getDecoder().decode(base64Data);
                        String savePath = getServletContext().getRealPath("/") + "uploads/";
                        new java.io.File(savePath).mkdirs();
                        String fileName = "room_" + orderId + ".jpg";
                        new FileOutputStream(savePath + fileName).write(imageBytes);
                        generatedImageUrl = "/RKGroupFurnituresInterior/uploads/" + fileName;
                    } catch (Exception imgEx) {
                        System.out.println("Image save error: " + imgEx.getMessage());
                    }
                }

                // Extract furniture data
                JSONArray  furnitureArr  = details.optJSONArray("furniture_list");
                JSONObject budgetObj     = details.optJSONObject("budget_breakdown");
                JSONObject placementObj  = details.optJSONObject("placement");
                JSONObject roomSugObj    = details.optJSONObject("room_suggestions");

                // Set attributes
                request.setAttribute("style",           style);
                request.setAttribute("hindiNaam",       details.optString("hindi_naam", ""));
                request.setAttribute("description",     details.optString("description", ""));
                request.setAttribute("rang",            details.optString("rang", ""));
                request.setAttribute("suggestion",      details.optString("suggestion", ""));
                request.setAttribute("naam",            naam);
                request.setAttribute("generatedImageUrl", generatedImageUrl);
                request.setAttribute("furnitureList",   furnitureArr  != null ? furnitureArr.toString()  : "[]");
                request.setAttribute("budgetBreakdown", budgetObj     != null ? budgetObj.toString()     : "{}");
                request.setAttribute("placement",       placementObj  != null ? placementObj.toString()  : "{}");
                request.setAttribute("freeSpace",       String.valueOf(details.optDouble("free_space", 0)));
                request.setAttribute("totalArea",       String.valueOf(details.optDouble("total_area", 0)));
                request.setAttribute("walkablePercent", String.valueOf(details.optDouble("walkable_percent", 0)));
                request.setAttribute("roomLength",      String.valueOf(roomLength));
                request.setAttribute("roomWidth",       String.valueOf(roomWidth));
                request.setAttribute("roomSuggestions", roomSugObj != null ? roomSugObj.toString() : "{}");

                // DB update
                PreparedStatement update = conn.prepareStatement(
                    "UPDATE interior_orders SET payment_status='paid', result_shown=1 WHERE id=?"
                );
                update.setInt(1, Integer.parseInt(orderId));
                update.executeUpdate();
            }

            conn.close();

            RequestDispatcher rd = request.getRequestDispatcher("jsp/public/styleResult.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            response.getWriter().print("An error occurred: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private JSONObject getDetailsFromFlask(int budget, int roomType, int colorPref,
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
            String line;
            while ((line = br.readLine()) != null) result.append(line);

            return new JSONObject(result.toString());

        } catch (Exception e) {
            System.out.println("Flask error: " + e.getMessage());
            return new JSONObject();
        }
    }
}