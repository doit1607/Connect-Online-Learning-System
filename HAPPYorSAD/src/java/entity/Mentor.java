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
    private int userId; // Assuming mentor_id and userID are related
    private String name;
    private String email;
    private double rating;
    private int reviews;
    private double pricePerSlot;
    private String expertise;
    private String bio;
    private LocalDateTime createdAt;
    private double baseRate;
    private double multiplier;

    // Constructor
    public Mentor(int id, int mentorId, int userId, String name, String email, double rating, int reviews,
                  double pricePerSlot, String expertise, String bio, LocalDateTime createdAt,
                  double baseRate, double multiplier) {
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

    public int getReviews() {
        return reviews;
    }

    public void setReviews(int reviews) {
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

    // Method to calculate the final price per slot based on baseRate and multiplier
    public double calculateFinalPrice() {
        return baseRate * multiplier;
    }
}

