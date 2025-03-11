/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.TransactionDAO;

/**
 *
 * @author dungb
 */
public class VNPayReturnServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            doGet(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vnp_TxnRef = request.getParameter("vnp_TxnRef"); // Lấy mã giao dịch
        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode"); // Mã phản hồi từ VNPay
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("usernameUser");
        TransactionDAO transactionDAO = new TransactionDAO();
        double amount = Double.parseDouble(request.getParameter("amount"));
        String service = request.getParameter("service");
        if ("deposit".equalsIgnoreCase(service)) {
            if ("00".equals(vnp_ResponseCode)) {
                int id = transactionDAO.createTransaction(username, amount, "DEPOSIT" , "Nap tien thanh cong");
                transactionDAO.depositToWallet(username, amount);
                double balance = transactionDAO.getBalance(username);
                double totalbalance = transactionDAO.getTotalBalance(username);
                String msg = "Your payment is sucessfull!";
                session.setAttribute("walletBalance", balance);
                session.setAttribute("walletTotalbalance", totalbalance);
                response.sendRedirect("Wallet?service=deposit");
            } else {
                transactionDAO.updateTransactionStatus(Integer.parseInt(vnp_TxnRef), "FAILED");
                String msg = "Your payment is failed!";
                response.sendRedirect("Wallet?service=error&msg="+msg);
            }
        }
        if ("withdraw".equalsIgnoreCase(service)) {
            double wallet = transactionDAO.getBalance(username); 

            if (amount <= wallet) {
                int id = transactionDAO.createTransaction(username, amount, "WITHDRAW","Rut tien thanh cong");
                transactionDAO.withdrawToWallet(username, amount);
                double newBalance = transactionDAO.getBalance(username); 

                String msg = "Your payment is successful!";
                session.setAttribute("walletBalance", newBalance); 
                response.sendRedirect("Wallet?service=withdraw&msg="+msg);

            } else {
                String msg = "Your withdrawal request was unsuccessful due to insufficient funds in your wallet.";
                response.sendRedirect("Wallet?service=error&msg="+msg);            }

        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
