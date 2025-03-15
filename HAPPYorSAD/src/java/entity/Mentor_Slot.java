/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Time;
import java.util.Date;

/**
 *
 * @author Ann
 */
public class Mentor_Slot {

    private int mentor_id;
    private int slot_id;
    private String status;

    private Date slot_date;
    private int slot_number_id;
    private Time start_time;
    private Time end_time;
    private int request_id;

    public Mentor_Slot() {
    }

    public Mentor_Slot(int mentor_id, int slot_id, String status) {
        this.mentor_id = mentor_id;
        this.slot_id = slot_id;
        this.status = status;
    }

    public Mentor_Slot(int request_id, int slot_id, int mentor_id, Date slot_date, int slot_number_id, Time start_time, Time end_time, String status) {
        this.request_id = request_id;
        this.slot_id = slot_id;
        this.mentor_id = mentor_id;
        this.slot_date = slot_date;
        this.slot_number_id = slot_number_id;
        this.start_time = start_time;
        this.end_time = end_time;
        this.status = status;

    }
    
 
    public Mentor_Slot(int mentor_id, String status, Date slot_date, int slot_number_id, Time start_time, Time end_time) {
        this.mentor_id = mentor_id;
        this.status = status;
        this.slot_date = slot_date;
        this.slot_number_id = slot_number_id;
        this.start_time = start_time;
        this.end_time = end_time;
    }
     
    
  public Mentor_Slot(int slot_id, int mentor_id, Date slot_date, int slot_number_id, Time start_time, Time end_time, String status) {
        this.slot_id = slot_id;
        this.mentor_id = mentor_id;
        this.slot_date = slot_date;
        this.slot_number_id = slot_number_id;
        this.start_time = start_time;
        this.end_time = end_time;
        this.status = status;

    }
       public Mentor_Slot( int mentor_id, Date slot_date, int slot_number_id, Time start_time, Time end_time, String status) {
        this.mentor_id = mentor_id;
        this.slot_date = slot_date;
        this.slot_number_id = slot_number_id;
        this.start_time = start_time;
        this.end_time = end_time;
        this.status = status;

    }
     


    public int getRequest_id() {
        return request_id;
    }

    public void setRequest_id(int request_id) {
        this.request_id = request_id;
    }

    public Date getSlot_date() {
        return slot_date;
    }

    public void setSlot_date(Date slot_date) {
        this.slot_date = slot_date;
    }

    public int getSlot_number_id() {
        return slot_number_id;
    }

    public void setSlot_number_id(int slot_number) {
        this.slot_number_id = slot_number;
    }

    public Time getStart_time() {
        return start_time;
    }

    public void setStart_time(Time start_time) {
        this.start_time = start_time;
    }

    public Time getEnd_time() {
        return end_time;
    }

    public void setEnd_time(Time end_time) {
        this.end_time = end_time;
    }

    public int getMentor_id() {
        return mentor_id;
    }

    public void setMentor_id(int mentor_id) {
        this.mentor_id = mentor_id;
    }

    public int getSlot_id() {
        return slot_id;
    }

    public void setSlot_id(int slot_id) {
        this.slot_id = slot_id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Mentor_Slot{" + "mentor_id=" + mentor_id + ", slot_id=" + slot_id + ", status=" + status + ", slot_date=" + slot_date + ", slot_number_id=" + slot_number_id + ", start_time=" + start_time + ", end_time=" + end_time + ", request_id=" + request_id + '}';
    }

}
