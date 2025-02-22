/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Date;

/**
 *
 * @author admin
 */
public class Schedule {

    private int id;
    private int mentorId;
    private Date start_date;
    private Date end_date;

    public Schedule() {
    }

    public Schedule(int id, int mentorId) {
        this.id = id;
        this.mentorId = mentorId;
    }

    public Schedule(Date end_date) {
        this.end_date = end_date;
    }
    
    

    public Schedule(Date start_date, Date end_date) {
        this.start_date = start_date;
        this.end_date = end_date;
    }

    public Date getStart_date() {
        return start_date;
    }

    public void setStart_date(Date start_date) {
        this.start_date = start_date;
    }

    public Date getEnd_date() {
        return end_date;
    }

    public void setEnd_date(Date end_date) {
        this.end_date = end_date;
    }
    
    

    public Schedule(int mentorId) {
        this.mentorId = mentorId;
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

    @Override
    public String toString() {
        return "Schedule{" + "id=" + id + ", mentorId=" + mentorId + ", start_date=" + start_date + ", end_date=" + end_date + '}';
    }


    

}
