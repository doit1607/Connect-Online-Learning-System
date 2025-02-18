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
public class Slot {

    private int slotId;
    private int scheduleId;
    private Date startTime;
    private Date endTime;
    private int duration;
    private String status;
    private boolean is_booked;

    public boolean getIs_booked() {
        return is_booked;
    }

    public void setIs_booked(boolean is_booked) {
        
        this.is_booked = is_booked;
    }

    public Slot(int scheduleId, Date startTime, Date endTime, int duration, boolean is_booked) {
        this.scheduleId = scheduleId;
        this.startTime = startTime;
        this.endTime = endTime;
        this.duration = duration;
        this.is_booked = is_booked;
    }

    public Slot(Date startTime, Date endTime, int duration, String status) {
        this.startTime = startTime;
        this.endTime = endTime;
        this.duration = duration;
        this.status = status;
    }

    public Slot( Date startTime, Date endTime, boolean is_booked) {
        this.startTime = startTime;
        this.endTime = endTime;
        this.is_booked = is_booked;
    }

    public int getSlotId() {
        return slotId;
    }

    public void setSlotId(int slotId) {
        this.slotId = slotId;
    }

    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Slot{" + "slotId=" + slotId + ", scheduleId=" + scheduleId + ", startTime=" + startTime + ", endTime=" + endTime + ", duration=" + duration + ", status=" + status + ", is_booked=" + is_booked + '}';
    }

   
}
