/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Schedule;
import entity.SlotTemplate;
import java.sql.Date;
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

    public Date getStartDateByScheduleId(int scheduleId) {
        String sql = "SELECT start_date FROM Schedule WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, scheduleId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDate("start_date");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

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

    public static Integer getScheduleIdsByMentorId(int mentorId) {
        int scheduleId = -1;
        String sql = "SELECT s.id FROM Mentor m JOIN Schedule s ON m.id = s.mentor_id WHERE m.id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, mentorId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    scheduleId = rs.getInt("id");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return scheduleId;
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

    public Schedule getScheduleById(int scheduleId) {
        String sql = "SELECT start_date, end_date FROM Schedule\n"
                + "WHERE id = ?";
        Schedule schedule = null;

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, scheduleId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                schedule = new Schedule(
                        rs.getDate("start_date"),
                        rs.getDate("end_date"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return schedule;
    }

    public Date getEndDateByScheduleId(int scheduleId) {
        String sql = "SELECT end_date FROM Schedule WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, scheduleId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDate("end_date");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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

    public List<SlotTemplate> getAvailableSlotNumbers(int scheduleId, Date slotDate) {
        List<SlotTemplate> availableSlots = new ArrayList<>();
        String query = "SELECT st.id, st.slot_number, st.start_time, st.end_time\n"
                + "FROM Slot_Template st\n"
                + "WHERE NOT EXISTS (\n"
                + "    SELECT 1 FROM Slot s \n"
                + "    WHERE s.schedule_id = ?\n"
                + "   AND s.slot_date = ? \n" // yyyy-MM-dd
                + "    AND s.slot_number_id = st.slot_number\n"
                + ");";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, scheduleId);
            stmt.setDate(2, (java.sql.Date) slotDate);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                availableSlots.add(new SlotTemplate(
                        rs.getInt("id"),
                        rs.getInt("slot_number"),
                        rs.getTime("start_time"),
                        rs.getTime("end_time")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return availableSlots;
    }

    public static void main(String[] args) {
        DAOschedule scheduleDAO = new DAOschedule();
//        int scheduleId = 1; // Thay đổi ID để test
//        Schedule schedule = scheduleDAO.getScheduleById(scheduleId);
//        if (schedule != null) {
//            System.out.println("Start Date: " + schedule.getStart_date());
//            System.out.println("End Date: " + schedule.getEnd_date());
//        } else {
//            System.out.println("No schedule found for ID: " + scheduleId);
//        }

        int scheduleId = 1;
//        Date slotDate = Date.valueOf("2025-03-04");
//        List<SlotTemplate> availableSlots = scheduleDAO.getAvailableSlotNumbers(scheduleId, slotDate);
//        System.out.println("Available Slots:");
//        for (SlotTemplate slot : availableSlots) {
//            System.out.println("ID: " + slot.getId()
//                    + ", Slot Number: " + slot.getSlotNumber()
//                    + ", Start Time: " + slot.getStartTime()
//                    + ", End Time: " + slot.getEndTime());
//        }
//        

        Date end_date = scheduleDAO.getEndDateByScheduleId(scheduleId);
        System.out.println(end_date);

//          Date str = scheduleDAO.getStartDateByScheduleId(scheduleId);
//          System.out.println(str);
    }

}
