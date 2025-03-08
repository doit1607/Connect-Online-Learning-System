/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import entity.Transaction;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
/**
 *
 * @author dungb
 */
public class TransactionDAO extends DBConnection{

    // Create a new transaction
    public int createTransaction(String username, double amount, String type) {
        int transactionId = 0;
        try {
            String query = "INSERT INTO Transactions (username, type, amount) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, type);
            stmt.setDouble(3, amount);
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
    public void updateHold(String username,double hold){
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
    
    public void updateHoldAfterReject(String username , double hold){
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
        try{
            String query = "UPDATE Wallets SET balance = balance + ? WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setDouble(1, amount);
            stmt.setString(2, username);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void withdrawToWallet(String username, double amount) {
        try{
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

                transaction = new Transaction(transactionId, username, type, amount, transactionDate, status, courseId, managerUsername);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return transaction;
    }
        public int createWithdrawTransaction(String username, double amount, String type) {
        int transactionId = -1;
        double balance = getBalance(username);  
        if (balance >= amount) {
            transactionId = createTransaction(username, amount, type);  
            if (transactionId != -1) {
                updateBalance(username, balance - amount);  
            }
        } else {
            System.out.println("Insufficient balance");
            return -1;  
        }
        
        return transactionId;
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
    
    public List<Transaction> listTransactionByUsername(String username){
        List<Transaction> transactionList = new ArrayList<>();
        String sql = "Select * from Transactions where username = ? ";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                Transaction trans = new Transaction();
                trans.setTransactionDate(rs.getDate("transaction_date"));
                trans.setType(rs.getString("type"));
                trans.setAmount(rs.getDouble("amount"));
                trans.setStatus(rs.getString("status"));
                transactionList.add(trans);
            }
            
            
        } catch (Exception e) {
        }
        return transactionList;
        
    }
}
