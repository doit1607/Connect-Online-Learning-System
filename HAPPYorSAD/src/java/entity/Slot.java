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
    private int slotNumber;
    private boolean isBooked;
    private Integer bookedByMenteeId;

    public Slot() {
    }

    public Slot(int slotId, int scheduleId, int slotNumber, boolean isBooked, Integer bookedByMenteeId) {
        this.slotId = slotId;
        this.scheduleId = scheduleId;
        this.slotNumber = slotNumber;
        this.isBooked = isBooked;
        this.bookedByMenteeId = bookedByMenteeId;
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

    public int getSlotNumber() {
        return slotNumber;
    }

    public void setSlotNumber(int slotNumber) {
        this.slotNumber = slotNumber;
    }

    public boolean isBooked() {
        return isBooked;
    }

    public void setBooked(boolean isBooked) {
        this.isBooked = isBooked;
    }

    public Integer getBookedByMenteeId() {
        return bookedByMenteeId;
    }

    public void setBookedByMenteeId(Integer bookedByMenteeId) {
        this.bookedByMenteeId = bookedByMenteeId;
    }

    @Override
    public String toString() {
        return "Slot{" + "slotId=" + slotId + ", scheduleId=" + scheduleId + ", slotNumber=" + slotNumber + ", isBooked=" + isBooked + ", bookedByMenteeId=" + bookedByMenteeId + '}';
    }

}
