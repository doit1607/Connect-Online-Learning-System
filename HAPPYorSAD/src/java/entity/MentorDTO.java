/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.time.LocalDateTime;

/**
 *
 * @author admin
 */
public class MentorDTO {
    private int id;
    private int userId;
    private String name;
    private String email;
    private double rating;
    private String image;
    private int total_mentees;
    private String username;
    private String phone_number;
    private double revenue;

    public MentorDTO() {
    }

    public MentorDTO(int id, int userId, String name, String email, double rating, String image, int total_mentees, String username, String phone_number, double revenue) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.rating = rating;
        this.image = image;
        this.total_mentees = total_mentees;
        this.username = username;
        this.phone_number = phone_number;
        this.revenue = revenue;
    }
public String convertMentorToJson(MentorDTO mentor) {
    StringBuilder jsonBuilder = new StringBuilder();
    jsonBuilder.append("{");
    jsonBuilder.append("\"id\":").append(mentor.getId()).append(",");
    jsonBuilder.append("\"userId\":").append(mentor.getUserId()).append(",");
    jsonBuilder.append("\"name\":\"").append(mentor.getName()).append("\",");
    jsonBuilder.append("\"email\":\"").append(mentor.getEmail()).append("\",");
    jsonBuilder.append("\"rating\":").append(mentor.getRating()).append(",");
    jsonBuilder.append("\"image\":\"").append(mentor.getImage()).append("\",");
    jsonBuilder.append("\"totalMentees\":").append(mentor.getTotal_mentees()).append(",");
    jsonBuilder.append("\"username\":\"").append(mentor.getUsername()).append("\",");
    jsonBuilder.append("\"phoneNumber\":\"").append(mentor.getPhone_number()).append("\",");
    jsonBuilder.append("\"revenue\":").append(mentor.getRevenue());
    jsonBuilder.append("}");
    return jsonBuilder.toString();
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public double getRevenue() {
        return revenue;
    }

    public void setRevenue(double revenue) {
        this.revenue = revenue;
    }
    
}
