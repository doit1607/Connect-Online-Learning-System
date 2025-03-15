package controller;

import entity.Transaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.TransactionDAO;

/**
 *
 * @author dungb
 */
public class Wallet extends HttpServlet {

    private TransactionDAO transactionDAO;

    @Override
    public void init() throws ServletException {
        transactionDAO = new TransactionDAO(); // Khởi tạo DAO
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("usernameUser");
        if (username == null) {
            response.sendRedirect("LoginUser.jsp");
            return;
        }
        double balance = transactionDAO.getTotalBalance(username);
        double hold = transactionDAO.getHold(username);
        session.setAttribute("walletBalance", balance);
        session.setAttribute("walletHold", hold);
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String type = request.getParameter("type");
        String description = request.getParameter("description");
        String status = request.getParameter("status");

        List<Transaction> list;
        if (fromDate != null || toDate != null || type != null || description != null || status != null) {
            list = transactionDAO.searchTransactions(username, fromDate, toDate, type, description, status);
        } else {
            list = transactionDAO.listTransactionByUsername(username);
        }
        request.setAttribute("transaction", list);
        String service = request.getParameter("service");
        String msg = request.getParameter("msg");
        if (service != null) {
            if (service.equals("withdraw") || service.equals("deposit") || service.equals("error")) {
                request.setAttribute("msg", msg);
            }
        }
        request.getRequestDispatcher("view/Wallet.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("usernameUser");
        if (username == null) {
            response.sendRedirect("LoginUser.jsp");
            return;
        }
        String amountStr = request.getParameter("amount");
        String paymentMethod = request.getParameter("optradio");
        double amount = Double.parseDouble(amountStr);
        if ("deposit".equals(paymentMethod)) {
            int transactionId = transactionDAO.createTransaction(username, amount, "DEPOSIT", "Deposit via wallet");
            transactionDAO.updateTransactionStatus(transactionId, "Completed");
            transactionDAO.depositToWallet(username, amount);
            response.sendRedirect("/HAPPYorSAD/wallet?service=deposit&msg=Deposit successful");
        } else if ("withdraw".equals(paymentMethod)) {
            double availableBalance = transactionDAO.getBalance(username);
            if (amount <= availableBalance) {
                int transactionId = transactionDAO.createTransaction(username, amount, "WITHDRAW", "Withdraw via wallet");
                transactionDAO.updateTransactionStatus(transactionId, "Pending");
                transactionDAO.updateHold(username, amount);
                response.sendRedirect("/HAPPYorSAD/wallet?service=withdraw&msg=Withdraw request submitted");
            } else {
                response.sendRedirect("/HAPPYorSAD/wallet?service=error&msg=Insufficient balance");
            }
        } else {
            response.sendRedirect("/HAPPYorSAD/wallet?service=error&msg=Invalid payment method");
        }
    }
}