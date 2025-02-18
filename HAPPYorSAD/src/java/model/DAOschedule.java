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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Ann
 */
public class DAOschedule extends DBConnection {

    public static DAOschedule dao = new DAOschedule();

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

    public void deleteSchedule(int scheduleId) {
        String sql = "DELETE FROM Schedule WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, scheduleId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static List<Integer> getScheduleIdsByMentorId(int mentorId) {
        List<Integer> scheduleIds = new ArrayList<>();
        String sql = "SELECT s.id FROM Mentor m JOIN Schedule s ON m.id = s.mentor_id WHERE m.id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, mentorId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    scheduleIds.add(rs.getInt("id"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return scheduleIds;
    }


    public int getScheduleId(int mentorId, String dayOfWeek) {
        int scheduleId = -1;
        String sql = "SELECT id FROM Schedule WHERE mentor_id = ? AND day_of_week = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, mentorId);
            stmt.setString(2, dayOfWeek);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                scheduleId = rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return scheduleId;
    }

    public boolean deleteSchedule(int mentorId, String dayOfWeek) {
        String sql = "DELETE FROM Schedule WHERE mentor_id = ? AND day_of_week = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, mentorId);
            stmt.setString(2, dayOfWeek);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getOrCreateScheduleId(int mentorId, String dayOfWeek) {
        int scheduleId = getScheduleId(mentorId, dayOfWeek);
        
        return scheduleId;
    }

    public static void main(String[] args) {
        int mentorId = 1;  // Thay đổi ID theo database
        List<Integer> scheduleIds = getScheduleIdsByMentorId(mentorId);

        for (Integer scheduleId : scheduleIds) {
            System.out.println(scheduleId);
        }
    }

}
