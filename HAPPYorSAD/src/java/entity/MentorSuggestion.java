/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Ann
 */
public class MentorSuggestion {
    private int id;
    private String name;
    private String email;
    private double rating;
    private String reviews;
    private String avatarPath;
    private String username;
    private String expertise;
    private double pricePerSlot;

    public MentorSuggestion() {
    }

    public MentorSuggestion(int id, String name, String email, double rating, String reviews, String avatarPath, String username, String expertise, double pricePerSlot) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.rating = rating;
        this.reviews = reviews;
        this.avatarPath = avatarPath;
        this.username = username;
        this.expertise = expertise;
        this.pricePerSlot = pricePerSlot;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getAvatarPath() {
        return avatarPath;
    }

    public void setAvatarPath(String avatarPath) {
        this.avatarPath = avatarPath;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getExpertise() {
        return expertise;
    }

    public void setExpertise(String expertise) {
        this.expertise = expertise;
    }

    public double getPricePerSlot() {
        return pricePerSlot;
    }

    public void setPricePerSlot(double pricePerSlot) {
        this.pricePerSlot = pricePerSlot;
    }
    
    

    @Override
    public String toString() {
        return "MentorSuggestion{" + "id=" + id + ", name=" + name + ", email=" + email + ", rating=" + rating + ", reviews=" + reviews + ", avatarPath=" + avatarPath + ", username=" + username + ", expertise=" + expertise + ", pricePerSlot=" + pricePerSlot + '}';
    }
    
    
}

