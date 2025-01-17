/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Time;
import java.util.Date;

public class EntryHistory {
    private int id;
    private int userId;
    private int courseId;
    private String status;
    private String courseDescription;
    private int absentSlot;
    private int completedSlot;
    private int totalSlot;
    private double rating;
    private Time startTime;
    private Time endTime;
    private Date createdAt;
    private Date updatedAt;

    public EntryHistory() {
    }

    public EntryHistory(int id, int userId, int courseId, String status, String courseDescription, int absentSlot,
                        int completedSlot, int totalSlot, double rating, Time startTime, Time endTime, Date createdAt, Date updatedAt) {
        this.id = id;
        this.userId = userId;
        this.courseId = courseId;
        this.status = status;
        this.courseDescription = courseDescription;
        this.absentSlot = absentSlot;
        this.completedSlot = completedSlot;
        this.totalSlot = totalSlot;
        this.rating = rating;
        this.startTime = startTime;
        this.endTime = endTime;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
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

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCourseDescription() {
        return courseDescription;
    }

    public void setCourseDescription(String courseDescription) {
        this.courseDescription = courseDescription;
    }

    public int getAbsentSlot() {
        return absentSlot;
    }

    public void setAbsentSlot(int absentSlot) {
        this.absentSlot = absentSlot;
    }

    public int getCompletedSlot() {
        return completedSlot;
    }

    public void setCompletedSlot(int completedSlot) {
        this.completedSlot = completedSlot;
    }

    public int getTotalSlot() {
        return totalSlot;
    }

    public void setTotalSlot(int totalSlot) {
        this.totalSlot = totalSlot;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public Time getStartTime() {
        return startTime;
    }

    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }

    public Time getEndTime() {
        return endTime;
    }

    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
}
