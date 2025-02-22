/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Date;
import java.sql.Time;

/**
 *
 * @author admin
 */
public class Slot {

    private int id;
    private int scheduleId;
    private Date slotDate;
    private int slotNumber;
    private boolean isBooked;
    private Time startTime;
    private Time endTime;
    private String day_of_week;
    private String period;

    // Constructor cho Slot Template
    public Slot(int slotNumber, Time startTime, Time endTime) {
        this.slotNumber = slotNumber;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public Slot(int id) {
        this.id = id;
    }
    

    public Slot(Date slotDate, int slotNumber, boolean isBooked, Time startTime, String day_of_week, String period) {
        this.slotDate = slotDate;
        this.slotNumber = slotNumber;
        this.isBooked = isBooked;
        this.startTime = startTime;
        this.day_of_week = day_of_week;
        this.period = period;
    }

    public Slot(Date slotDate, int slotNumber, boolean isBooked, Time startTime, String day_of_week) {
        this.slotDate = slotDate;
        this.slotNumber = slotNumber;
        this.isBooked = isBooked;
        this.startTime = startTime;
        this.day_of_week = day_of_week;
    }
    
    
    
    

    // Constructor đầy đủ
    public Slot(int id, Date slotDate, int slotNumber, boolean isBooked) {
        this.id = id;
        this.slotDate = slotDate;
        this.slotNumber = slotNumber;
        this.isBooked = isBooked;
    }

    public Slot(int id,Date slotDate, int slotNumber,boolean isBooked, Time startTime, String day_of_week) {
        this.id = id;
        this.slotDate = slotDate;
        this.slotNumber = slotNumber;
        this.isBooked = isBooked;
        this.startTime = startTime;
        this.day_of_week = day_of_week;
    }

 
    public Slot(int scheduleId, Date slotDate, int slotNumber) {
        this.scheduleId = scheduleId;
        this.slotDate = slotDate;
        this.slotNumber = slotNumber;
    }

    // Getter & Setter

    public String getPeriod() {
        return period;
    }

    public void setPeriod(String period) {
        this.period = period;
    }
    
    

    public String getDay_of_week() {
        return day_of_week;
    }

    public void setDay_of_week(String day_of_week) {
        this.day_of_week = day_of_week;
    }
    
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public Date getSlotDate() {
        return slotDate;
    }

    public void setSlotDate(Date slotDate) {
        this.slotDate = slotDate;
    }

    public int getSlotNumber() {
        return slotNumber;
    }

    public void setSlotNumber(int slotNumber) {
        this.slotNumber = slotNumber;
    }

    public boolean isBooked() {
        return isBooked;
    }

    public void setBooked(boolean booked) {
        isBooked = booked;
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

    public boolean isIsBooked() {
        return isBooked;
    }

    public void setIsBooked(boolean isBooked) {
        this.isBooked = isBooked;
    }

    @Override
    public String toString() {
        return "Slot{" + "id=" + id + ", scheduleId=" + scheduleId + ", slotDate=" + slotDate + ", slotNumber=" + slotNumber + ", isBooked=" + isBooked + ", startTime=" + startTime + ", endTime=" + endTime + '}';
    }

}
