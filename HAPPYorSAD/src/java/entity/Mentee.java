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
public class Mentee {

    private int id;
    private int user_id;
    private String name;
    private int is_deleted;
    private String email;
    private String goals;
    private LocalDateTime createdAt;
    private int total_Mentee;
    private String image;
    
    public Mentee() {
    }

    public Mentee(int id, int user_id, String name, int is_deleted, String email, String goals, LocalDateTime createdAt, int total_Mentee, String image) {
        this.id = id;
        this.user_id = user_id;
        this.name = name;
        this.is_deleted = is_deleted;
        this.email = email;
        this.goals = goals;
        this.createdAt = createdAt;
        this.total_Mentee = total_Mentee;
        this.image = image;
    }

    public Mentee(String name, String email, String image) {
        this.name = name;
        this.email = email;
        this.image = image;
    }
    public Mentee(int id, int user_id, String name, int is_deleted, String email, String goals, LocalDateTime createdAt, String image) {
        this.id = id;
        this.user_id = user_id;
        this.name = name;
        this.is_deleted = is_deleted;
        this.email = email;
        this.goals = goals;
        this.createdAt = createdAt;
        this.image = image;
    }
    
    public Mentee(int id, int user_id, String name, int is_deleted, String email, String goals, LocalDateTime createdAt) {
        this.id = id;
        this.user_id = user_id;
        this.name = name;
        this.is_deleted = is_deleted;
        this.email = email;
        this.goals = goals;
        this.createdAt = createdAt;
    }

    public Mentee(int total_Mentee) {
        this.total_Mentee = total_Mentee;
    }
    

    public int getTotal_Mentee() {
        return total_Mentee;
    }

    public void setTotal_Mentee(int total_Mentee) {
        this.total_Mentee = total_Mentee;
    }

    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getIs_deleted() {
        return is_deleted;
    }

    public void setIs_deleted(int is_deleted) {
        this.is_deleted = is_deleted;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    
    @Override
    public String toString() {
        return "Mentee{" + "id=" + id + ", user_id=" + user_id + ", name=" + name + ", is_deleted=" + is_deleted + ", email=" + email + ", goals=" + goals + ", createdAt=" + createdAt + ", total_Mentee=" + total_Mentee + '}';
    }
    
    
}
