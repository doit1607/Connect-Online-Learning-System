/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
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
    private LocalDate deadlineDate;
    private LocalTime deadlineHour;
    private String content;
    private String status = "Processing";
    private LocalDateTime createdAt = LocalDateTime.now();
    private LocalDateTime updatedAt = LocalDateTime.now();

    // Constructors
    public Request() {}

    public Request(int id, int menteeId, int mentorId, String title, LocalDate deadlineDate, LocalTime deadlineHour, String content, String status, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.menteeId = menteeId;
        this.mentorId = mentorId;
        this.title = title;
        this.deadlineDate = deadlineDate;
        this.deadlineHour = deadlineHour;
        this.content = content;
        setStatus(status);
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    public String getFormattedCreatedAt() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return this.createdAt.format(formatter);
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

    public LocalDate getDeadlineDate() {
        return deadlineDate;
    }

    public void setDeadlineDate(LocalDate deadlineDate) {
        this.deadlineDate = deadlineDate;
    }

    public LocalTime getDeadlineHour() {
        return deadlineHour;
    }

    public void setDeadlineHour(LocalTime deadlineHour) {
        this.deadlineHour = deadlineHour;
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
        if (status.equals("Processing") || status.equals("Rejected") || status.equals("Accepted")) {
            this.status = status;
        } else {
            throw new IllegalArgumentException("Invalid status value");
        }
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

}
