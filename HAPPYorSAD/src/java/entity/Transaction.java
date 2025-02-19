/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author admin
 */

public class Transaction {
    private int transactionId;
    private String username;
    private String type;  // 'DEPOSIT', 'WITHDRAW', 'COURSE_REGISTRATION'
    private double amount;
    private Date transactionDate;
    private String status;  // 'PENDING', 'COMPLETED', 'FAILED'
    private int courseId;  // For course registration
    private String managerUsername;  // For manager's username during registration

    // Constructor
    
    public Transaction() {
    }

    public Transaction(int transactionId, String username, String type, double amount, Date transactionDate, String status, int courseId, String managerUsername) {
        this.transactionId = transactionId;
        this.username = username;
        this.type = type;
        this.amount = amount;
        this.transactionDate = transactionDate;
        this.status = status;
        this.courseId = courseId;
        this.managerUsername = managerUsername;
    }

    // Getters and Setters
    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getManagerUsername() {
        return managerUsername;
    }

    public void setManagerUsername(String managerUsername) {
        this.managerUsername = managerUsername;
    }
}