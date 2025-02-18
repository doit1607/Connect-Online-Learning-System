/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Schedule;
import entity.Slot;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 *
 * @author Ann
 */
public class DAOslot extends DBConnection {

//    public boolean addSlot(int mentorId, String dayOfWeek, Time startTime, Time endTime, int duration) {
//        String getScheduleIdQuery = "SELECT id FROM Schedule WHERE mentor_id = ? AND day_of_week = ?";
//        String insertSlotQuery = "INSERT INTO Slot (schedule_id, starttime, endtime, duration, is_booked) VALUES (?, ?, ?, ?, 0)";
//
//        try (PreparedStatement ps1 = conn.prepareStatement(getScheduleIdQuery); PreparedStatement ps2 = conn.prepareStatement(insertSlotQuery)) {
//            // Lấy schedule_id của ngày trong tuần
//            ps1.setInt(1, mentorId);
//            ps1.setString(2, dayOfWeek);
//            ResultSet rs = ps1.executeQuery();
//
//            if (rs.next()) {
//                int scheduleId = rs.getInt("id");
//
//                // Chèn slot mới vào bảng Slot
//                ps2.setInt(1, scheduleId);
//                ps2.setTime(2, startTime);
//                ps2.setTime(3, endTime);
//                ps2.setInt(4, duration);
//
//                return ps2.executeUpdate() > 0;
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return false;
//    }
    public boolean addSlot(int scheduleId, Time startTime, Time endTime) {
        String sql = "INSERT INTO Slot (schedule_id, start_time, end_time, is_booked) VALUES (?, ?, ?, false)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, scheduleId);
            stmt.setTime(2, startTime);
            stmt.setTime(3, endTime);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteSlot(int slotId) {
        String deleteQuery = "DELETE FROM Slot WHERE slot_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(deleteQuery)) {
            ps.setInt(1, slotId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Slot> getSlotsByDay(int mentorId, String dayOfWeek) {
        List<Slot> slots = new ArrayList<>();
        String sql = "SELECT s.starttime, s.endtime, s.is_booked \n"
                + "                FROM Slot s \n"
                + "                JOIN Schedule sc ON s.schedule_id = sc.id \n"
                + "                WHERE sc.mentor_id = ? AND sc.day_of_week = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, mentorId);
            ps.setString(2, dayOfWeek);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                slots.add(new Slot(
                        rs.getTime("starttime"),
                        rs.getTime("endtime"),
                        rs.getBoolean("is_booked")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slots;
    }

    public List<Schedule> getDaysBySchedule(int scheduleId, int mentorId) {
        List<Schedule> dayOfweek = new ArrayList<>();
        String sql = "select s.day_of_week\n"
                + "from schedule s join Slot sl on sl.schedule_id = s.id\n"
                + "join Mentor m on m.id = s.mentor_id\n"
                + "where s.id = ? and m.id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, scheduleId);      
            stmt.setInt(2, mentorId);  
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                dayOfweek.add(new Schedule(rs.getString("day_of_week")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dayOfweek;
    }

    public static void main(String[] args) {
        DAOslot dao = new DAOslot();
        int mentorId = 1;
        int sche = 1;

        List<Schedule> l = dao.getDaysBySchedule(sche, mentorId);

        for (Schedule schedule : l) {
            System.out.println(schedule);
        }

    }
}
