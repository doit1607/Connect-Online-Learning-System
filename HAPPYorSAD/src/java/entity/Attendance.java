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
public class Attendance {

    private int id;
    private int slotId;
    private int mentorId;
    private int menteeId;
    private boolean isDone;
    private Date markedAt;

    public Attendance() {
    }

    public Attendance(int id, int slotId, int mentorId, int menteeId, boolean isDone, Date markedAt) {
        this.id = id;
        this.slotId = slotId;
        this.mentorId = mentorId;
        this.menteeId = menteeId;
        this.isDone = isDone;
        this.markedAt = markedAt;
    }

    public Attendance(int slotId, int mentorId, int menteeId, boolean isDone, Date markedAt) {
        this.slotId = slotId;
        this.mentorId = mentorId;
        this.menteeId = menteeId;
        this.isDone = isDone;
        this.markedAt = markedAt;
    }
    
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSlotId() {
        return slotId;
    }

    public void setSlotId(int slotId) {
        this.slotId = slotId;
    }

    public int getMentorId() {
        return mentorId;
    }

    public void setMentorId(int mentorId) {
        this.mentorId = mentorId;
    }

    public int getMenteeId() {
        return menteeId;
    }

    public void setMenteeId(int menteeId) {
        this.menteeId = menteeId;
    }

    public boolean isIsDone() {
        return isDone;
    }

    public void setIsDone(boolean isDone) {
        this.isDone = isDone;
    }

    public Date getMarkedAt() {
        return markedAt;
    }

    public void setMarkedAt(Date markedAt) {
        this.markedAt = markedAt;
    }

    @Override
    public String toString() {
        return "Attendance{" + "id=" + id + ", slotId=" + slotId + ", mentorId=" + mentorId + ", menteeId=" + menteeId + ", isDone=" + isDone + ", markedAt=" + markedAt + '}';
    }

}
