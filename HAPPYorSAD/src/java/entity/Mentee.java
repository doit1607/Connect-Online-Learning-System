/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author dungb
 */
import java.time.LocalDateTime;

public class Mentee {
    private int id;
    private int menteeId;
    private int userId; // Assuming mentee_id and userID are related
    private String name;
    private String email;
    private String goals;
    private LocalDateTime createdAt;

    // Constructor
    public Mentee(int id, int menteeId, int userId, String name, String email, String goals, LocalDateTime createdAt) {
        this.id = id;
        this.menteeId = menteeId;
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.goals = goals;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMenteeId() {
        return menteeId;
    }

    public void setMenteeId(int menteeId) {
        this.menteeId = menteeId;
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

    public String getGoals() {
        return goals;
    }

    public void setGoals(String goals) {
        this.goals = goals;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
  }
