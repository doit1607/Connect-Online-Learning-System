/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;


public class CV {
    public String username;
    public String profession;
    public String professionIntro;
    public List<String> courses;
    public String serviceDescription;
    public String achievementDescription;
    public LocalDateTime createdAt;
    public String status;
    public String message;
    public Double price;

    public CV() {
    }

    public CV(String username, String profession, String professionIntro, List<String> courses, String serviceDescription, String achievementDescription, LocalDateTime createdAt, String status, String message) {
        this.username = username;
        this.profession = profession;
        this.professionIntro = professionIntro;
        this.courses = courses;
        this.serviceDescription = serviceDescription;
        this.achievementDescription = achievementDescription;
        this.createdAt = createdAt;
        this.status = status;
        
    }

    public CV(String username, String profession, String professionIntro, List<String> courses, String serviceDescription, String achievementDescription, LocalDateTime createdAt, String message, Double price) {
        this.username = username;
        this.profession = profession;
        this.professionIntro = professionIntro;
        this.courses = courses;
        this.serviceDescription = serviceDescription;
        this.achievementDescription = achievementDescription;
        this.createdAt = createdAt;
        this.message = message;
        this.price = price;
    }
    
    public CV(String username, String profession, String professionIntro, List<String> courses, String serviceDescription, String achievementDescription, LocalDateTime createdAt, String message) {
        this.username = username;
        this.profession = profession;
        this.professionIntro = professionIntro;
        this.courses = courses;
        this.serviceDescription = serviceDescription;
        this.achievementDescription = achievementDescription;
        this.createdAt = createdAt;
        this.message = message;
    }
    

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getProfession() {
        return profession;
    }

    public void setProfession(String profession) {
        this.profession = profession;
    }

    public String getProfessionIntro() {
        return professionIntro;
    }

    public void setProfessionIntro(String professionIntro) {
        this.professionIntro = professionIntro;
    }

    public List<String> getCourses() {
        return courses;
    }

    public void setCourses(List<String> courses) {
        this.courses = courses;
    }

    public String getServiceDescription() {
        return serviceDescription;
    }

    public void setServiceDescription(String serviceDescription) {
        this.serviceDescription = serviceDescription;
    }

    public String getAchievementDescription() {
        return achievementDescription;
    }

    public void setAchievementDescription(String achievementDescription) {
        this.achievementDescription = achievementDescription;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public Date getCreatedAtAsDate() {
        return createdAt != null ? Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
    
}
