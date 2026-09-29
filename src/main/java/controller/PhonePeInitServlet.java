package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.util.Base64;

import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/phonepe-init")
@MultipartConfig(maxFileSize = 10485760)
public class PhonePeInitServlet extends HttpServlet {

    private static final String MERCHANT_ID  = "YOUR_MERCHANT_ID";
    private static final String SALT_KEY     = "YOUR_SALT_KEY";
    private static final int    SALT_INDEX   = 1;
    // Sandbox (testing):
    private static final String PHONEPE_URL  =
        "https://api-preprod.phonepe.com/apis/pg-sandbox/pg/v1/pay";
    // Live ke liye baad mein change karna:
    // "https://api.phonepe.com/apis/hermes/pg/v1/pay"

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        // Form fields lena
        String name        = req.getParameter("customer_name");
        String phone       = req.getParameter("customer_phone");
        String roomType    = req.getParameter("room_type");
        String demands     = req.getParameter("demands");
        String budgetRange = req.getParameter("budget_range");
        String customBudget= req.getParameter("custom_budget");
        String finalBudget = (customBudget != null && !customBudget.isEmpty())
                             ? "₹" + customBudget : budgetRange;

        // Photo bytes session mein store
        Part photoPart = req.getPart("room_photo");
        byte[] photoBytes = photoPart.getInputStream().readAllBytes();

        HttpSession session = req.getSession();
        session.setAttribute("pending_photo", photoBytes);
        session.setAttribute("pending_room_type", roomType);
        session.setAttribute("pending_demands", demands);
        session.setAttribute("pending_budget", finalBudget);
        session.setAttribute("pending_customer_name", name);
        session.setAttribute("pending_customer_phone", phone);

        // Transaction ID
        String txnId = "RK" + System.currentTimeMillis();
        session.setAttribute("pending_txn_id", txnId);

        // Base URL
        String baseUrl = req.getScheme() + "://" + req.getServerName()
                         + ":" + req.getServerPort() + req.getContextPath();

        // PhonePe payload
        JSONObject data = new JSONObject();
        data.put("merchantId", MERCHANT_ID);
        data.put("merchantTransactionId", txnId);
        data.put("merchantUserId", "RK_" + phone);
        data.put("amount", 50000); // ₹500 in paise
        data.put("redirectUrl", baseUrl + "/phonepe-callback");
        data.put("redirectMode", "POST");
        data.put("callbackUrl", baseUrl + "/phonepe-callback");
        data.put("mobileNumber", phone);
        data.put("paymentInstrument",
                 new JSONObject().put("type", "PAY_PAGE"));

        String base64 = Base64.getEncoder()
                              .encodeToString(data.toString().getBytes("UTF-8"));
        String checksum = null;
		try {
			checksum = sha256(base64 + "/pg/v1/pay" + SALT_KEY)
			                  + "###" + SALT_INDEX;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        // API call
        JSONObject body = new JSONObject();
        body.put("request", base64);

        URL url = new URL(PHONEPE_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("X-VERIFY", checksum);
        conn.setDoOutput(true);
        conn.getOutputStream().write(body.toString().getBytes("UTF-8"));

        BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getInputStream(), "UTF-8"));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) sb.append(line);

        JSONObject res = new JSONObject(sb.toString());
        String payUrl = res.getJSONObject("data")
                           .getJSONObject("instrumentResponse")
                           .getJSONObject("redirectInfo")
                           .getString("url");

        resp.sendRedirect(payUrl);
    }

    private String sha256(String input) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(input.getBytes("UTF-8"));
        StringBuilder hex = new StringBuilder();
        for (byte b : hash) hex.append(String.format("%02x", b));
        return hex.toString();
    }
}