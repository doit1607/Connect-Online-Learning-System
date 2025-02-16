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
    private Date scheduleDate;

    public Schedule() {
    }

    public Schedule(int id, int mentorId, Date scheduleDate) {
        this.id = id;
        this.mentorId = mentorId;
        this.scheduleDate = scheduleDate;
    }

    public Schedule(int mentorId, Date scheduleDate) {
        this.mentorId = mentorId;
        this.scheduleDate = scheduleDate;
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

    public Date getScheduleDate() {
        return scheduleDate;
    }

    public void setScheduleDate(Date scheduleDate) {
        this.scheduleDate = scheduleDate;
    }

    @Override
    public String toString() {
        return "Schedule{" + "id=" + id + ", mentorId=" + mentorId + ", scheduleDate=" + scheduleDate + '}';
    }

}
