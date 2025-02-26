/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Ann
 */
public class ScheduleMonth {
    private int scheduleId;
    private String monthName;
    private int slotCount;

    public ScheduleMonth(int scheduleId, String monthName, int slotCount) {
        this.scheduleId = scheduleId;
        this.monthName = monthName;
        this.slotCount = slotCount;
    }

    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public String getMonthName() {
        return monthName;
    }

    public void setMonthName(String monthName) {
        this.monthName = monthName;
    }

    public int getSlotCount() {
        return slotCount;
    }

    public void setSlotCount(int slotCount) {
        this.slotCount = slotCount;
    }

    @Override
    public String toString() {
        return "ScheduleMonth{" + "scheduleId=" + scheduleId + ", monthName=" + monthName + ", slotCount=" + slotCount + '}';
    }
    
    
}
