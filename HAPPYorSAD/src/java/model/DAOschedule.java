/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Schedule;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ann
 */
public class DAOschedule extends DBConnection {

    public boolean addSchedule(int mentorId, Date scheduleDate) {
        String sql = "INSERT INTO Schedule (mentor_id, schedule_date) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, mentorId);
            ps.setDate(2, java.sql.Date.valueOf(LocalDate.MAX));
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Schedule> getSchedulesByMentor(int mentorId) {
        List<Schedule> schedules = new ArrayList<>();
        String sql = "SELECT * FROM Schedule WHERE mentor_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, mentorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                schedules.add(new Schedule(rs.getInt("id"), rs.getInt("mentor_id"), rs.getDate("schedule_date")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return schedules;
    }
}
