/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.time.LocalDateTime;

/**
 *
 * @author dungb
 */
public class Mentor {

    private int id;
    private int mentorId;
    private int userId;
    private String name;
    private String email;
    private double rating;
    private String reviews;
    private double pricePerSlot;
    private String expertise; // profression
    private String bio;
    private LocalDateTime createdAt;
    private double baseRate;
    private double multiplier;
    private boolean is_deleted;
    private String image;
    private int total_mentees;
    private int rating_count;
    private String username;  // join Users
    private int CurentlyRequests;
    private int completed;

    // Constructor
    public Mentor(int id, int mentorId, int userId, String name, String email, double rating, String reviews,
            double pricePerSlot, String expertise, String bio, LocalDateTime createdAt,
            double baseRate, double multiplier, boolean is_deleted) {
        this.id = id;
        this.mentorId = mentorId;
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.rating = rating;
        this.reviews = reviews;
        this.pricePerSlot = pricePerSlot;
        this.expertise = expertise;
        this.bio = bio;
        this.createdAt = createdAt;
        this.baseRate = baseRate;
        this.multiplier = multiplier;
        this.is_deleted = is_deleted;
    }

    public Mentor(String name, double rating, double pricePerSlot, String expertise, String image, String username) {
        this.name = name;
        this.rating = rating;
        this.pricePerSlot = pricePerSlot;
        this.expertise = expertise;
        this.image = image;
        this.username = username;
    }

   

    public Mentor(String name, double rating, String expertise, String image, int total_mentees, int rating_count) {
        this.name = name;
        this.rating = rating;
        this.expertise = expertise;
        this.image = image;
        this.total_mentees = total_mentees;
        this.rating_count = rating_count;
    }

    public Mentor(int id, String name, double rating, String username, String expertise) {
        this.id = id;
        this.name = name;
        this.rating = rating;
        this.username = username;
        this.expertise = expertise;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getCurentlyRequests() {
        return CurentlyRequests;
    }

    public void setCurentlyRequests(int CurentlyRequests) {
        this.CurentlyRequests = CurentlyRequests;
    }

    public int getCompleted() {
        return completed;
    }

    public void setCompleted(int completed) {
        this.completed = completed;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getTotal_mentees() {
        return total_mentees;
    }

    public void setTotal_mentees(int total_mentees) {
        this.total_mentees = total_mentees;
    }

    public int getRating_count() {
        return rating_count;
    }

    public void setRating_count(int rating_count) {
        this.rating_count = rating_count;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
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

    public boolean isIs_deleted() {
        return is_deleted;
    }

    public void setIs_deleted(boolean is_deleted) {
        this.is_deleted = is_deleted;
    }

    public double calculateFinalPrice() {
        return baseRate * multiplier;
    }

    @Override
    public String toString() {
        return "Mentor{" + "id=" + id + ", mentorId=" + mentorId + ", userId=" + userId + ", name=" + name + ", email=" + email + ", rating=" + rating + ", reviews=" + reviews + ", pricePerSlot=" + pricePerSlot + ", expertise=" + expertise + ", bio=" + bio + ", createdAt=" + createdAt + ", baseRate=" + baseRate + ", multiplier=" + multiplier + ", is_deleted=" + is_deleted + ", image=" + image + ", total_mentees=" + total_mentees + ", rating_count=" + rating_count + '}';
    }

}
