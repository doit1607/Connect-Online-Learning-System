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
    private String title;
    private String description;
    private int managerId;
    private int mentorId;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private int courseMajorId;

    // Constructor
    public Course(String title, String description, int managerId, int mentorId,
                  LocalDateTime createdAt, LocalDateTime updatedAt, int courseMajorId) {
        this.title = title;
        this.description = description;
        this.managerId = managerId;
        this.mentorId = mentorId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.courseMajorId = courseMajorId;
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
}
