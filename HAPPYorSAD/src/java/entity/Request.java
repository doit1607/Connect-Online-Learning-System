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
    private String userMentee;
    private String title;
    private double totalprice;
    private int totalSlot;
    private LocalDate startDate;
    private LocalDate endDate;
    private String content;
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private int courseId;
    private String mentorname;
    private String coursename;
    private Slot slots;
    

    // Constructors
    public Request() {
    }

    public Request(String title, double totalprice, int totalSlot, LocalDate startDate, LocalDate endDate, String content, String status, String mentorname, String coursename) {
        this.title = title;
        this.totalprice = totalprice;
        this.totalSlot = totalSlot;
        this.startDate = startDate;
        this.endDate = endDate;
        this.content = content;
        this.status = status;
        this.mentorname = mentorname;
        this.coursename = coursename;
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
    
     public Request(int menteeId, int mentorId, String title, int totalSlot, double totalprice, LocalDate startDate, LocalDate endDate, String content, String status, int courseId) {
        this.menteeId = menteeId;
        this.mentorId = mentorId;
        this.title = title;
        this.totalSlot = totalSlot;
        this.totalprice = totalprice;
        this.startDate = startDate;
        this.endDate = endDate;
        this.content = content;
        this.status = status;
        this.courseId = courseId;
    }
     
    // dung cho showAllRequest ben DAORequest
    public Request(int menteeId, String userMentee, String title, String status) {
        this.menteeId = menteeId;
        this.userMentee = userMentee;
        this.title = title;
        this.status = status;
    }
    
    // dung cho Request detail
    public Request(String userMentee, String courseName, String title, String content, int totalSlot, LocalDate startDate, LocalDate endDate, LocalDateTime createdAt) {
        this.userMentee = userMentee;
        this.coursename = courseName;
        this.title = title;
        this.content = content;
        this.totalSlot = totalSlot;
        this.startDate = startDate;
        this.endDate = endDate;
        this.createdAt = createdAt;
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

    public Slot getSlots() {
        return slots;
    }

    public void setSlots(Slot slots) {
        this.slots = slots;
    }

    public String getUserMentee() {
        return userMentee;
    }

    public void setUserMentee(String userMentee) {
        this.userMentee = userMentee;
    }
     
    public double getTotalprice() {
        return totalprice;
    }

    public void setTotalprice(double totalprice) {
        this.totalprice = totalprice;
    }

    public String getMentorname() {
        return mentorname;
    }

    public void setMentorname(String mentorname) {
        this.mentorname = mentorname;
    }

    public String getCoursename() {
        return coursename;
    }

    public void setCoursename(String coursename) {
        this.coursename = coursename;
    }
     
    public User getMentee(){
        DAOuser dao = new DAOuser();
        return dao.getMenteeById(this.menteeId);
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
    public double gettotalprice() {
        return totalprice;
    }

    public void settotalprice(double totalprice) {
        this.totalprice = totalprice;
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
        return "Request{" + "id=" + id + ", menteeId=" + menteeId + ", mentorId=" + mentorId + ", title=" + title + ", totalprice=" + totalprice + ", totalSlot=" + totalSlot + ", startDate=" + startDate + ", endDate=" + endDate + ", content=" + content + ", status=" + status + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", courseId=" + courseId + ", mentorname=" + mentorname + ", coursename=" + coursename + ", slots=" + slots + '}';
    }

   
    public List<Course> getRequestedCourses(){
        DAOCourse dao =  new DAOCourse();
        List<Course> list = new ArrayList<>();
        list.add(dao.getCourseById(this.courseId));
        return list;
    }
}
