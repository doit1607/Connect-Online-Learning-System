/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.Date;

/**
 *
 * @author CTT VNPAY
 */
public class ajaxServlet extends HttpServlet {

    @Override

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String amountStr = req.getParameter("amount");

        if (amountStr == null || amountStr.isEmpty()) {
            resp.sendRedirect("payment.jsp?error=Số tiền không hợp lệ!");
            return;
        }

        long amount;
        try {
            amount = Long.parseLong(amountStr) * 100; // VNPay yêu cầu đơn vị là VND * 100
        } catch (NumberFormatException e) {
            resp.sendRedirect("payment.jsp?error=Số tiền phải là số hợp lệ!");
            return;
        }

        // Cấu hình VNPay
        String vnp_TmnCode = "QRRGJECC";
        String vnp_HashSecret = "3ZW2QXLTFIKXSUS8ZQWR9HDOTQOMKKG1";
        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String vnp_OrderInfo = "Thanh toan don hang";
        String vnp_OrderType = "other";
        String vnp_Locale = "vn";
        String vnp_ReturnUrl = "http://localhost:9999/HAPPYorSAD/VNPayReturnServlet?service=deposit&amount="+amountStr;
        String vnp_IpAddr = req.getRemoteAddr();
        String vnp_TxnRef = String.valueOf(System.currentTimeMillis());

        // Tạo tham số gửi VNPay
        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", vnp_OrderInfo);
        vnp_Params.put("vnp_OrderType", vnp_OrderType);
        vnp_Params.put("vnp_Locale", vnp_Locale);
        vnp_Params.put("vnp_ReturnUrl", vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);
        vnp_Params.put("vnp_CreateDate", new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));

        // Tạo query string
        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder query = new StringBuilder();
        StringBuilder hashData = new StringBuilder();

        for (String fieldName : fieldNames) {
            String fieldValue = vnp_Params.get(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()) {
                hashData.append(fieldName).append("=").append(URLEncoder.encode(fieldValue, StandardCharsets.UTF_8.name()));
                query.append(fieldName).append("=").append(URLEncoder.encode(fieldValue, StandardCharsets.UTF_8.name()));
                if (!fieldName.equals(fieldNames.get(fieldNames.size() - 1))) {
                    hashData.append("&");
                    query.append("&");
                }
            }
        }

        // Tạo chữ ký bảo mật
        String secureHash = hmacSHA512(vnp_HashSecret, hashData.toString());
        query.append("&vnp_SecureHash=").append(secureHash);

        // URL thanh toán VNPay
        String paymentUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?" + query.toString();

        // Chuyển hướng trực tiếp đến VNPay
        resp.sendRedirect(paymentUrl);
    }

    private static String hmacSHA512(String key, String data) {
        try {
            javax.crypto.Mac hmacSHA512 = javax.crypto.Mac.getInstance("HmacSHA512");
            javax.crypto.spec.SecretKeySpec secretKey = new javax.crypto.spec.SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
            hmacSHA512.init(secretKey);
            byte[] hash = hmacSHA512.doFinal(data.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            return "";
        }
    }

}
