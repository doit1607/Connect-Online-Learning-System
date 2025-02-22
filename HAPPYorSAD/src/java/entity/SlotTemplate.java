/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Time;

public class SlotTemplate {

    private int id;
    private int slotNumber;
    private Time startTime;
    private Time endTime;

    public SlotTemplate() {
    }

    public SlotTemplate(int id, int slotNumber, Time startTime, Time endTime) {
        this.id = id;
        this.slotNumber = slotNumber;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    // Getter & Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSlotNumber() {
        return slotNumber;
    }

    public void setSlotNumber(int slotNumber) {
        this.slotNumber = slotNumber;
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

    @Override
    public String toString() {
        return "SlotTemplate{" + "id=" + id + ", slotNumber=" + slotNumber + ", startTime=" + startTime + ", endTime=" + endTime + '}';
    }
    
    
}
