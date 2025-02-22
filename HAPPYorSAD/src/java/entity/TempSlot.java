/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author Ann
 */
public class TempSlot {

    private int scheduleId;
    private Date selectedDate;
    private int slotNumber;
    private String startTime; // Thêm thuộc tính này

    public TempSlot(int scheduleId, Date selectedDate, int slotNumber, String startTime) {
        this.scheduleId = scheduleId;
        this.selectedDate = selectedDate;
        this.slotNumber = slotNumber;
        this.startTime = startTime;
    }

    // Getter & Setter
    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public Date getSelectedDate() {
        return selectedDate;
    }

    public void setSelectedDate(Date selectedDate) {
        this.selectedDate = selectedDate;
    }

    public int getSlotNumber() {
        return slotNumber;
    }

    public void setSlotNumber(int slotNumber) {
        this.slotNumber = slotNumber;
    }
    

    @Override
    public String toString() {
        return "TempSlot{"
                + "scheduleId=" + scheduleId
                + ", selectedDate=" + selectedDate
                + ", slotNumber=" + slotNumber
                + ", startTime='" + startTime + '\''
                + '}';
    }
}
