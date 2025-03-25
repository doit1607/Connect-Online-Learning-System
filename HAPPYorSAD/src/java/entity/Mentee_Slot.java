/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;
import java.sql.Time;

/**
 *
 * @author Ann
 */
public class Mentee_Slot {

    private int mentee_id;
    private int slot_id;
    private int request_id;
    private String status;

    private Date slot_date;
    private int slot_number;
    private Time start_time;
    private Time end_time;

    public Mentee_Slot() {
    }

    public Mentee_Slot(int request_id, String status, Date slot_date, int slot_number, Time start_time, Time end_time) {
        this.request_id = request_id;
        this.status = status;
        this.slot_date = slot_date;
        this.slot_number = slot_number;
        this.start_time = start_time;
        this.end_time = end_time;
    }

    public Mentee_Slot(int slot_id,int mentee_id, int request_id, String status, Date slot_date, int slot_number, Time start_time, Time end_time) {
        this.slot_id = slot_id;
        this.mentee_id = mentee_id;
        this.request_id = request_id;
        this.status = status;
        this.slot_date = slot_date;
        this.slot_number = slot_number;
        this.start_time = start_time;
        this.end_time = end_time;
    }



    public Mentee_Slot(int mentee_id, int request_id, String status, Date slot_date, int slot_number, Time start_time, Time end_time) {
        this.mentee_id = mentee_id;
        this.request_id = request_id;
        this.status = status;
        this.slot_date = slot_date;
        this.slot_number = slot_number;
        this.start_time = start_time;
        this.end_time = end_time;
    }

    public Mentee_Slot(int mentee_id, int slot_id, int request_id, String status) {
        this.mentee_id = mentee_id;
        this.slot_id = slot_id;
        this.request_id = request_id;
        this.status = status;
    }

    public int getMentee_id() {
        return mentee_id;
    }

    public void setMentee_id(int mentee_id) {
        this.mentee_id = mentee_id;
    }

    public int getSlot_id() {
        return slot_id;
    }

    public void setSlot_id(int slot_id) {
        this.slot_id = slot_id;
    }

    public Date getSlot_date() {
        return slot_date;
    }

    public void setSlot_date(Date slot_date) {
        this.slot_date = slot_date;
    }

    public int getSlot_number() {
        return slot_number;
    }

    public void setSlot_number(int slot_number) {
        this.slot_number = slot_number;
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

    public int getRequest_id() {
        return request_id;
    }

    public void setRequest_id(int request_id) {
        this.request_id = request_id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Mentee_Slot{" + "mentee_id=" + mentee_id + ", slot_id=" + slot_id + ", request_id=" + request_id + ", status=" + status + ", slot_date=" + slot_date + ", slot_number=" + slot_number + ", start_time=" + start_time + ", end_time=" + end_time + '}';
    }

}
