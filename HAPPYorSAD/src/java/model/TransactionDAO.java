/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Transaction;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Array;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import static model.DBConnection.conn;

/**
 *
 * @author dungb
 */
public class TransactionDAO extends DBConnection {

    // Create a new transaction
    public int createTransaction(String username, double amount, String type, String description) {
        int transactionId = 0;
        try {
            String query = "INSERT INTO Transactions (username, type, amount , Description) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, type);
            stmt.setDouble(3, amount);
            stmt.setString(4, description);
            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                transactionId = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return transactionId;
    }

    // Update transaction status
    public void updateTransactionStatus(int transactionId, String status) {
        try {
            String query = "UPDATE Transactions SET status = ? WHERE transaction_id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, status);
            stmt.setInt(2, transactionId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateHold(String username, double hold) {
        String sql = "UPDATE Wallets SET hold = hold + ? WHERE username = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setDouble(1, hold);
            st.setString(2, username);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateHoldAfterReject(String username, double hold) {
        String sql = "UPDATE Wallets SET hold = hold - ? WHERE username = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setDouble(1, hold);
            st.setString(2, username);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Deposit money to user's wallet
    public void depositToWallet(String username, double amount) {
        try {
            String query = "UPDATE Wallets SET balance = balance + ? WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setDouble(1, amount);
            stmt.setString(2, username);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
        public void processRefund(String username, double refundAmount) throws SQLException {
        String sql = "UPDATE Wallets SET balance = balance + ? WHERE username = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
             ps.setDouble(1, refundAmount);
            ps.setString(2, username);
            ps.executeUpdate();
        }
    }

    public void withdrawToWallet(String username, double amount) {
        try {
            String query = "UPDATE Wallets SET balance = balance - ? WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setDouble(1, amount);
            stmt.setString(2, username);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Get transaction by ID
    public Transaction getTransactionById(int transactionId) {
        Transaction transaction = null;
        try {
            String query = "SELECT * FROM Transactions WHERE transaction_id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, transactionId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String username = rs.getString("username");
                String type = rs.getString("type");
                double amount = rs.getDouble("amount");
                Date transactionDate = rs.getDate("transaction_date");
                String status = rs.getString("status");
                int courseId = rs.getInt("course_id");
                String managerUsername = rs.getString("manager_username");
                String description = rs.getString("Description");

                transaction = new Transaction(transactionId, username, type, amount, transactionDate, status, courseId, managerUsername, description);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return transaction;
    }

    public double getBalance(String username) {
        double balance = 0.0;

        String query = "SELECT (balance - hold) AS total_balance FROM Wallets WHERE username = ?";
        try {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                balance = rs.getDouble("total_balance");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return balance;
    }

    public double getTotalBalance(String username) {
        double balance = 0.0;
        String query = "SELECT balance FROM Wallets WHERE username = ?";

        try {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                balance = rs.getDouble("balance");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return balance;
    }

    public double getHold(String username) {
        double balance = 0.0;
        String query = "SELECT hold FROM Wallets WHERE username = ?";

        try {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                balance = rs.getDouble("hold");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return balance;
    }

    // Phương thức cập nhật số dư ví của người dùng
    public void updateBalance(String username, double newBalance) {
        String query = "UPDATE Wallets SET balance = ? WHERE username = ?";
        try {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setDouble(1, newBalance);
            stmt.setString(2, username);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Transaction> listTransactionByUsername(String username) {
        List<Transaction> transactionList = new ArrayList<>();
        String sql = "Select * from Transactions where username = ? order by transaction_date desc";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Transaction trans = new Transaction();
                trans.setTransactionDate(rs.getTimestamp("transaction_date"));
                trans.setType(rs.getString("type"));
                trans.setAmount(rs.getDouble("amount"));
                trans.setStatus(rs.getString("status"));
                trans.setDescription(rs.getString("Description"));
                transactionList.add(trans);
            }

        } catch (Exception e) {
        }
        return transactionList;

    }

    public List<Transaction> searchTransactions(String username, String fromDate, String toDate, String type, String description, String status) {
        List<Transaction> transactionList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Transactions WHERE username = ?");
        List<String> params = new ArrayList<>();
        if (fromDate != null && !fromDate.isEmpty()) {
            sql.append(" AND transaction_date >= ?");
            params.add(fromDate);
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql.append(" AND transaction_date <= ?");
            params.add(toDate);
        }
        if (type != null && !type.isEmpty()) {
            sql.append(" AND type = ?");
            params.add(type);
        }
        if (description != null && !description.isEmpty()) {
            sql.append(" AND Description LIKE ?");
            params.add("%" + description + "%");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
            params.add(status);
        }
        sql.append(" ORDER BY transaction_date DESC");
        try {
            PreparedStatement stmt = conn.prepareStatement(sql.toString());
            stmt.setString(1, username);
            for (int i = 0; i < params.size(); i++) {
                stmt.setString(i + 2, params.get(i));
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Transaction trans = new Transaction();
                trans.setTransactionId(rs.getInt("transaction_id"));
                trans.setUsername(rs.getString("username"));
                trans.setType(rs.getString("type"));
                trans.setAmount(rs.getDouble("amount"));
                trans.setTransactionDate(rs.getTimestamp("transaction_date"));
                trans.setStatus(rs.getString("status"));
                trans.setCourseId(rs.getInt("course_id"));
                trans.setManagerUsername(rs.getString("manager_username"));
                trans.setDescription(rs.getString("Description"));
                transactionList.add(trans);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return transactionList;
    }
}
