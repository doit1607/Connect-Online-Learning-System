/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author admin
 */
public class Schedule {

    private int id;
    private int mentorId;
    private Date startDate;
    private Date endDate;
    
    private String day_of_week;

    public Schedule() {
    }

    public Schedule(int id, int mentorId, Date startDate, Date endDate) {
        this.id = id;
        this.mentorId = mentorId;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public Schedule(int id, int mentorId, Date startDate, Date endDate, String day_of_week) {
        this.id = id;
        this.mentorId = mentorId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.day_of_week = day_of_week;
    }
    

    public Schedule(int mentorId, Date startDate, Date endDate) {
        this.mentorId = mentorId;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public Schedule(String day_of_week) {
        this.day_of_week = day_of_week;
    }
    
    



    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMentorId() {
        return mentorId;
    }

    public void setMentorId(int mentorId) {
        this.mentorId = mentorId;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getDay_of_week() {
        return day_of_week;
    }

    public void setDay_of_week(String day_of_week) {
        this.day_of_week = day_of_week;
    }

    @Override
    public String toString() {
        return "Schedule{" + "id=" + id + ", mentorId=" + mentorId + ", startDate=" + startDate + ", endDate=" + endDate + ", day_of_week=" + day_of_week + '}';
    }

   
    
   

}
