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
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
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

//    public boolean addSchedule(int mentorId, Date scheduleDate) {
//        String sql = "INSERT INTO Mentor_Schedule (mentor_id, schedule_date) VALUES (?, ?)";
//        try (PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setInt(1, mentorId);
//            ps.setDate(2, java.sql.Date.valueOf(LocalDate.MAX));
//            return ps.executeUpdate() > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
    public void deleteSchedule(int scheduleId) {
        String sql = "DELETE FROM Schedule WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, scheduleId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

//    public static Integer getScheduleIdsByMentorId(int mentorId) {
//        int scheduleId = -1;
//        String sql = "SELECT ms.id FROM Mentor m \n"
//                + "JOIN Mentor_Schedule ms ON m.id = ms.mentor_id \n"
//                + "WHERE m.id = ?";
//
//        try (PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setInt(1, mentorId);
//            try (ResultSet rs = ps.executeQuery()) {
//                while (rs.next()) {
//                    scheduleId = rs.getInt("id");
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return scheduleId;
//    }
    public static Integer getScheduleIdsByMentorId(int mentorId) {
        int scheduleId = -1;
        String sql = "SELECT ms.id FROM Mentor m \n"
                + "JOIN Mentor_Schedule ms ON m.id = ms.mentor_id \n"
                + "WHERE m.id = ?";

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

    public Date getDateByScheduleId(int scheduleId) {
        String sql = "SELECT start_date, end_date FROM Schedule WHERE id = ?";
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

    public Integer getScheduleIdByMentorIdAndMonth(int mentorId, String month) {
        Integer scheduleId = null;
        String sql = "SELECT s.id \n"
                + "FROM Schedule s\n"
                + "JOIN Mentor_Schedule ms ON ms.schedule_id = s.id\n"
                + "JOIN Mentor m ON m.id = ms.mentor_id\n"
                + "WHERE m.id = ? AND FORMAT(start_Date, 'yyyy-MM') = ?;";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, mentorId);
            ps.setString(2, month);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                scheduleId = rs.getInt("scheduleId");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return scheduleId;
    }

    public Map<String, List<Schedule>> getSchedulesByMonth() {
        Map<String, List<Schedule>> schedulesByMonth = new LinkedHashMap<>();
        String query = "SELECT * FROM schedule ORDER BY start_date";

        SimpleDateFormat formatter = new SimpleDateFormat("MMMM yyyy", Locale.ENGLISH);
        try (PreparedStatement stmt = conn.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Date startDate = rs.getDate("start_date");
                Date endDate = rs.getDate("end_date");
                Schedule schedule = new Schedule(startDate, endDate);
                // Định dạng lại tháng & năm (Ví dụ: "Tháng 3, 2025")
                String monthKey = formatter.format(startDate);
                schedulesByMonth
                        .computeIfAbsent(monthKey, k -> new ArrayList<>())
                        .add(schedule);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return schedulesByMonth;
    }

    public List<Schedule> getSchedulesByMonth(int year, int month) {
        List<Schedule> schedules = new ArrayList<>();
        String sql = "SELECT * FROM schedule\n"
                + "WHERE YEAR(start_date) = ? AND MONTH(start_date) = ?\n"
                + "ORDER BY start_date ASC;";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, year);
            stmt.setInt(2, month);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Schedule schedule = new Schedule();
                schedule.setId(rs.getInt("id"));
                schedule.setStart_date(rs.getDate("start_date"));
                schedules.add(schedule);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log lỗi hoặc sử dụng LOGGER.warning(e.getMessage())
        }

        return schedules;
    }

    public Integer getScheduleIdByNearestStartDate() {
        String sql = "SELECT id FROM Schedule where start_date='?'\n";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

//    public Integer createScheduleForMonth(int mentorId, String month) {
//        Integer newScheduleId = null;
//        String insertScheduleQuery = "INSERT INTO Schedule (startDate, endDate) VALUES (?, ?)";
//        String insertMentorScheduleQuery = "INSERT INTO Mentor_Schedule (mentor_Id, schedule_Id) VALUES (?, ?)";
//        String sql = "INSERT INTO Schedule (mentorId, startDate, endDate) VALUES (?, ?, ?)";
//        try (PreparedStatement psSchedule = conn.prepareStatement(insertScheduleQuery)) {
//
//            psSchedule.setDate(1, startDate);
//            psSchedule.setDate(2, endDate);
//            psSchedule.executeUpdate();
//
//            ResultSet generatedKeys = psSchedule.getGeneratedKeys();
//            if (generatedKeys.next()) {
//                newScheduleId = generatedKeys.getInt(1);
//            } else {
//                throw new SQLException("No available.");
//            }
//
//            try (PreparedStatement psMentorSchedule = conn.prepareStatement(insertMentorScheduleQuery)) {
//                psMentorSchedule.setInt(1, mentorId);
//                psMentorSchedule.setInt(2, newScheduleId);
//                psMentorSchedule.executeUpdate();
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return newScheduleId;
//    }
    public static void main(String[] args) {
        DAOschedule scheduleDAO = new DAOschedule();
//        Map<String, List<Schedule>> schedulesByMonth = dao.getSchedulesByMonth();
//
//        for (String month : schedulesByMonth.keySet()) {
//            System.out.println("📅 " + month);
//            for (Schedule schedule : schedulesByMonth.get(month)) {
//                System.out.println("  " + schedule);
//            }
//        }

        List<Schedule> schedules = scheduleDAO.getSchedulesByMonth(2025, 2);
        // In kết quả
        if (schedules.isEmpty()) {
            System.out.println("Không có schedule nào trong tháng 2/2025.");
        } else {
            System.out.println("Danh sách schedule trong tháng 2/2025:");
            for (Schedule schedule : schedules) {
                System.out.println(schedule);
            }
        }

    }

}
