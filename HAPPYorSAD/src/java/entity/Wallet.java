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
public class Wallet {
    private int id;
    private int userId;
    private String role;
    private double balance;
    private Date createdAt;
    private Date updatedAt;
    private String status;
    private String associatedPaymentMethod;

    public Wallet() {
    }

    public Wallet(int id, int userId, String role, double balance, Date createdAt, Date updatedAt, String status, String associatedPaymentMethod) {
        this.id = id;
        this.userId = userId;
        this.role = role;
        this.balance = balance;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.status = status;
        this.associatedPaymentMethod = associatedPaymentMethod;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAssociatedPaymentMethod() {
        return associatedPaymentMethod;
    }

    public void setAssociatedPaymentMethod(String associatedPaymentMethod) {
        this.associatedPaymentMethod = associatedPaymentMethod;
    }
}
