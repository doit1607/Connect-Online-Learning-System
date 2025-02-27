/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Date;

/**
 *
 * @author Dell
 */
public class Mentor1 {
    private int id;
    private User user;
    private int mentorId;
    private int userId;
    private String name;
    private String email;
    private double rating;
    private boolean isDeleted;
    private String reviews;
    private double pricePerSlot;
    private String expertise;
    private String bio;
    private Date createdAt;
    private double baseRate;
    private double multiplier;
    private int totalMentees;
    private int ratingCount;
    private String image;

    public Mentor1(int id, int userId, String name, String email, double rating, boolean isDeleted, String reviews, String expertise, String bio, double baseRate, double multiplier) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.rating = rating;
        this.isDeleted = isDeleted;
        this.reviews = reviews;
        this.expertise = expertise;
        this.bio = bio;
        this.baseRate = baseRate;
        this.multiplier = multiplier;

    }
    
    public Mentor1(int id, User user, int mentorId, int userId, String name, String email, double rating, boolean isDeleted, String reviews, double pricePerSlot, String expertise, String bio, Date createdAt, double baseRate, double multiplier, int totalMentees, int ratingCount, String image) {
        this.id = id;
        this.user = user;
        this.mentorId = mentorId;
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.rating = rating;
        this.isDeleted = isDeleted;
        this.reviews = reviews;
        this.pricePerSlot = pricePerSlot;
        this.expertise = expertise;
        this.bio = bio;
        this.createdAt = createdAt;
        this.baseRate = baseRate;
        this.multiplier = multiplier;
        this.totalMentees = totalMentees;
        this.ratingCount = ratingCount;
        this.image = image;
    }

    public Mentor1() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getMentorId() {
        return mentorId;
    }

    public void setMentorId(int mentorId) {
        this.mentorId = mentorId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public boolean isIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

    public String getReviews() {
        return reviews;
    }

    public void setReviews(String reviews) {
        this.reviews = reviews;
    }

    public double getPricePerSlot() {
        return pricePerSlot;
    }

    public void setPricePerSlot(double pricePerSlot) {
        this.pricePerSlot = pricePerSlot;
    }

    public String getExpertise() {
        return expertise;
    }

    public void setExpertise(String expertise) {
        this.expertise = expertise;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public double getBaseRate() {
        return baseRate;
    }

    public void setBaseRate(double baseRate) {
        this.baseRate = baseRate;
    }

    public double getMultiplier() {
        return multiplier;
    }

    public void setMultiplier(double multiplier) {
        this.multiplier = multiplier;
    }

    public int getTotalMentees() {
        return totalMentees;
    }

    public void setTotalMentees(int totalMentees) {
        this.totalMentees = totalMentees;
    }

    public int getRatingCount() {
        return ratingCount;
    }

    public void setRatingCount(int ratingCount) {
        this.ratingCount = ratingCount;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    
 
}
