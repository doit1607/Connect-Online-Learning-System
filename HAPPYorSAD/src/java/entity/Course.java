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

public class Course {

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
    public Course() {
    }

    public Course(int id, String title, String description, int managerId, int mentorId, String status, LocalDateTime createdAt, LocalDateTime updatedAt, int courseMajorId, String courseMajor, int total_Mentor, int total_Mentee, String image, int total_Courses, Double price) {
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
    }

    public Course(int id, String title, String description, int managerId, int mentorId, String status, LocalDateTime createdAt, LocalDateTime updatedAt, int courseMajorId, String image, Double price) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.managerId = managerId;
        this.mentorId = mentorId;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.courseMajorId = courseMajorId;
        this.image = image;
        this.price = price;
    }
    
    
    public Course(int id, String title, String description, int managerId, int mentorId, String status, LocalDateTime createdAt, LocalDateTime updatedAt, int courseMajorId, String image) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.managerId = managerId;
        this.mentorId = mentorId;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.courseMajorId = courseMajorId;
        this.image = image;
    }

    public Course(int total_Mentee, int total_Courses) {
        this.total_Mentee = total_Mentee;
        this.total_Courses = total_Courses;
    }

    public int getTotal_Courses() {
        return total_Courses;
    }

    public void setTotal_Courses(int total_Courses) {
        this.total_Courses = total_Courses;
    }
    
    
    
    public Course(int id, String title, String description, int managerId, int mentorId, String status, LocalDateTime createdAt, LocalDateTime updatedAt, int courseMajorId) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.managerId = managerId;
        this.mentorId = mentorId;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.courseMajorId = courseMajorId;
    }

    public Course(int id, String title, String description, int managerId, int mentorId, int courseMajorId, String status) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.managerId = managerId;
        this.mentorId = mentorId;
        this.status = status;
        this.courseMajorId = courseMajorId;
    }

    public Course(String title, String CourseMajor, int total_Mentor, int total_Mentee, String image) {
        this.title = title;
        this.total_Mentor = total_Mentor;
        this.total_Mentee = total_Mentee;
        this.courseMajor = CourseMajor;
        this.image = image;
    }
    

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getCourseMajor() {
        return courseMajor;
    }

    public void setCourseMajor(String CourseMajor) {
        this.courseMajor = CourseMajor;
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

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Course{" + "id=" + id + ", title=" + title + ", description=" + description + ", managerId=" + managerId + ", mentorId=" + mentorId + ", status=" + status + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", courseMajorId=" + courseMajorId + ", courseMajor=" + courseMajor + ", total_Mentor=" + total_Mentor + ", total_Mentee=" + total_Mentee + ", image=" + image + ", total_Courses=" + total_Courses + ", price=" + price + '}';
    }
    
    

  
}
