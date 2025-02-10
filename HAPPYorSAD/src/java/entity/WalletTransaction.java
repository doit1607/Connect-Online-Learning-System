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
public class WalletTransaction {
    
    private int id;
    private int walletId;
    private double amount;
    private String description;
    private int relatedUserId;
    private Date createdAt;
    private Date updatedAt;

    public WalletTransaction() {
    }

    public WalletTransaction(int id, int walletId, double amount, String description, int relatedUserId, Date createdAt, Date updatedAt) {
        this.id = id;
        this.walletId = walletId;
        this.amount = amount;
        this.description = description;
        this.relatedUserId = relatedUserId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getWalletId() {
        return walletId;
    }

    public void setWalletId(int walletId) {
        this.walletId = walletId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getRelatedUserId() {
        return relatedUserId;
    }

    public void setRelatedUserId(int relatedUserId) {
        this.relatedUserId = relatedUserId;
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
}
