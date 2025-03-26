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
public class CourseDTO {
     private int id;
    private String title;
    private String description;
    private int managerId;
    private int mentorId;
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private int courseMajorId;
    private String courseMajor;
    private int total_Mentor, total_Mentee;
    private String image;
    private int total_Courses;
    private Double price;
    private int menteeCount;

    public CourseDTO(int id, String title, String description, int managerId, int mentorId, String status, LocalDateTime createdAt, LocalDateTime updatedAt, int courseMajorId, String courseMajor, int total_Mentor, int total_Mentee, String image, int total_Courses, Double price, int menteeCount) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.managerId = managerId;
        this.mentorId = mentorId;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.courseMajorId = courseMajorId;
        this.courseMajor = courseMajor;
        this.total_Mentor = total_Mentor;
        this.total_Mentee = total_Mentee;
        this.image = image;
        this.total_Courses = total_Courses;
        this.price = price;
        this.menteeCount = menteeCount;
    }

    public CourseDTO() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getManagerId() {
        return managerId;
    }

    public void setManagerId(int managerId) {
        this.managerId = managerId;
    }

    public int getMentorId() {
        return mentorId;
    }

    public void setMentorId(int mentorId) {
        this.mentorId = mentorId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public int getCourseMajorId() {
        return courseMajorId;
    }

    public void setCourseMajorId(int courseMajorId) {
        this.courseMajorId = courseMajorId;
    }

    public String getCourseMajor() {
        return courseMajor;
    }

    public void setCourseMajor(String courseMajor) {
        this.courseMajor = courseMajor;
    }

    public int getTotal_Mentor() {
        return total_Mentor;
    }

    public void setTotal_Mentor(int total_Mentor) {
        this.total_Mentor = total_Mentor;
    }

    public int getTotal_Mentee() {
        return total_Mentee;
    }

    public void setTotal_Mentee(int total_Mentee) {
        this.total_Mentee = total_Mentee;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getTotal_Courses() {
        return total_Courses;
    }

    public void setTotal_Courses(int total_Courses) {
        this.total_Courses = total_Courses;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public int getMenteeCount() {
        return menteeCount;
    }

    public void setMenteeCount(int menteeCount) {
        this.menteeCount = menteeCount;
    }
    
}
