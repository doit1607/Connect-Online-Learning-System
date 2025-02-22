package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import model.TransactionDAO;

public class PaymentServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PaymentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PaymentServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        double amount = Double.parseDouble(request.getParameter("amount"));

        // Tạo giao dịch nạp tiền
        TransactionDAO transactionDAO = new TransactionDAO();
        int transactionId = transactionDAO.createTransaction((String) session.getAttribute("usernameUser"), amount, "DEPOSIT");

        // Chuyển hướng đến VNPay để thanh toán
        String vnpayUrl = generatePaymentUrl(transactionId, amount);
        response.sendRedirect(vnpayUrl);
    }

    public static String generateSecureHash(String data, String secretKey) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            String hashData = secretKey + data;
            byte[] byteData = md.digest(hashData.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : byteData) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return "";
    }

    public static String generatePaymentUrl(int transactionId, double amount) throws UnsupportedEncodingException {
        String vnpayUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
        String vnp_TmnCode = "QRRGJECC"; // Mã website của bạn
        String vnp_HashSecret = "3ZW2QXLTFIKXSUS8ZQWR9HDOTQOMKKG1"; // Chuỗi bí mật của bạn
        String vnp_TxnRef = String.valueOf(transactionId);
        int vnp_Amount = (int) (amount * 100);
        String vnp_OrderInfo = "Payment for order #" + vnp_TxnRef;
        String vnp_ReturnUrl = "http://localhost:9999/HAPPYorSAD/VNPayReturnServlet"; // URL trả về của bạn

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", "2.0.0");
        vnp_Params.put("vnp_Command", "pay");
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_Amount", String.valueOf(vnp_Amount));
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_OrderInfo", vnp_OrderInfo);
        vnp_Params.put("vnp_OrderType", "bill");
        vnp_Params.put("vnp_Locale", "vn");
        vnp_Params.put("vnp_ReturnUrl", vnp_ReturnUrl);

        TreeMap<String, String> sortedParams = new TreeMap<>(vnp_Params);

        StringBuilder data = new StringBuilder();
        for (Map.Entry<String, String> entry : sortedParams.entrySet()) {
            data.append(URLEncoder.encode(entry.getKey(), StandardCharsets.UTF_8)).append("=")
                    .append(URLEncoder.encode(entry.getValue(), StandardCharsets.UTF_8)).append("&");
        }
        data.deleteCharAt(data.length() - 1);

        String vnp_SecureHash = generateSecureHash(data.toString(), vnp_HashSecret);

        return vnpayUrl + "?" + data + "&vnp_SecureHashType=SHA256&vnp_SecureHash=" + vnp_SecureHash;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
