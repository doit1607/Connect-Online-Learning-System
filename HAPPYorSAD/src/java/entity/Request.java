/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.DAOCourse;
import model.DAOuser;

/**
 *
 * @author admin
 */
public class Request {

    private int id;
    private int menteeId;
    private int mentorId;
    private String title;
    private int totalSlot;
    private LocalDate startDate;
    private LocalDate endDate;
    private String content;
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private int courseId;

    // Constructors
    public Request() {
    }

    public Request(int id, int menteeId, int mentorId, String title, LocalDate startDate, LocalDate endDate, String content, String status, LocalDateTime createdAt, LocalDateTime updatedAt, int courseId) {
        this.id = id;
        this.menteeId = menteeId;
        this.mentorId = mentorId;
        this.title = title;
        this.startDate = startDate;
        this.endDate = endDate;
        this.content = content;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.courseId = courseId;
    }

    public Request(int id, int menteeId, int mentorId, String title, int totalSlot,
            LocalDate startDate, LocalDate endDate, String content,
            String status, LocalDateTime createdAt, LocalDateTime updatedAt, int courseId) {
        this.id = id;
        this.menteeId = menteeId;
        this.mentorId = mentorId;
        this.title = title;
        this.totalSlot = totalSlot;
        this.startDate = startDate;
        this.endDate = endDate;
        this.content = content;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.courseId = courseId;
    }

    public Request( int menteeId, int mentorId, String title, int totalSlot,
            LocalDate startDate, LocalDate endDate, String content,
            String status, LocalDateTime createdAt, LocalDateTime updatedAt, int courseId) {
        this.menteeId = menteeId;
        this.mentorId = mentorId;
        this.title = title;
        this.totalSlot = totalSlot;
        this.startDate = startDate;
        this.endDate = endDate;
        this.content = content;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.courseId = courseId;
    }

    public Request(int menteeId, int mentorId, String title, int totalSlot, LocalDate startDate, LocalDate endDate, String content, String status, int courseId) {
        this.menteeId = menteeId;
        this.mentorId = mentorId;
        this.title = title;
        this.totalSlot = totalSlot;
        this.startDate = startDate;
        this.endDate = endDate;
        this.content = content;
        this.status = status;
        this.courseId = courseId;
    }
    
     public Request(int menteeId, int mentorId, String title, int totalSlot, LocalDate startDate, LocalDate endDate, String content, int courseId) {
        this.menteeId = menteeId;
        this.mentorId = mentorId;
        this.title = title;
        this.totalSlot = totalSlot;
        this.startDate = startDate;
        this.endDate = endDate;
        this.content = content;
        this.courseId = courseId;
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

    public int getMentorId() {
        return mentorId;
    }

    public void setMentorId(int mentorId) {
        this.mentorId = mentorId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getTotalSlot() {
        return totalSlot;
    }

    public void setTotalSlot(int totalSlot) {
        this.totalSlot = totalSlot;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    @Override
    public String toString() {
        return "Request{"
                + "id=" + id
                + ", menteeId=" + menteeId
                + ", mentorId=" + mentorId
                + ", title='" + title + '\''
                + ", totalSlot=" + totalSlot
                + ", startDate=" + startDate
                + ", endDate=" + endDate
                + ", content='" + content + '\''
                + ", status='" + status + '\''
                + ", createdAt=" + createdAt
                + ", updatedAt=" + updatedAt
                + ", courseIds='" + courseId + '\''
                + '}';
    }
//    public List<Course> getRequestedCourses(){
//        DAOCourse dao =  new DAOCourse();
//        String[] strCourseIds = this.courseId.split(",");
//        List<Course> list = new ArrayList<>();
//        for (String strCourseId : strCourseIds) {
//            int cid = Integer.parseInt(strCourseId);
//            list.add(dao.getCourseById(cid));
//        }
//        return list;
//    }
}
