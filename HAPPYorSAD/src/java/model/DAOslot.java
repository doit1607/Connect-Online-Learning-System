/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Schedule;
import entity.ScheduleMonth;
import entity.Slot;
import java.lang.reflect.Array;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import java.sql.Date;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.logging.Logger;

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
    public List<Slot> getSlotsByDate2(Date date, int mentorId) {
        List<Slot> slots = new ArrayList<>();

        String query = "SELECT sl.id, sl.slot_date, st.slot_number, sl.is_booked, st.start_time,\n"
                + "       CASE \n"
                + "           WHEN st.start_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'\n"
                + "           WHEN st.start_time BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'\n"
                + "           ELSE 'Evening'\n"
                + "       END AS period\n"
                + "FROM Slot sl\n"
                + "JOIN Schedule sc ON sl.schedule_id = sc.id\n"
                + "JOIN Mentor_Schedule ms ON ms.schedule_id = sc.id  -- Thay đổi theo mối quan hệ mới\n"
                + "JOIN Mentor m ON ms.mentor_id = m.id  -- Liên kết với bảng Mentor thông qua Mentor_Schedule\n"
                + "JOIN Slot_Template st ON st.id = sl.slot_number_id\n"
                + "WHERE sl.slot_date = ?\n"
                + "AND ms.mentor_id = ? and sl.is_booked=0  -- Thay vì sc.mentor_id, dùng ms.mentor_id theo quan hệ mới\n"
                + "ORDER BY st.start_time;";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setDate(1, date);
            stmt.setInt(2, mentorId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                slots.add(new Slot(rs.getInt("id"),
                        rs.getDate("slot_date"),
                        rs.getInt("slot_number"),
                        rs.getBoolean("is_booked"),
                        rs.getTime("start_time"),
                        rs.getString("period")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slots;
    }

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

    public boolean addSlots(int scheduleId, String day, int slotNumber) {
        String sql = "INSERT INTO Slot (schedule_id, slot_date , slot_number_id, is_booked) VALUES (?, ?, ?, 'false')";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, scheduleId);
            ps.setString(2, day);
            ps.setInt(3, slotNumber);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;

    }

    public boolean deleteSlot(java.sql.Date slot_date, int mentorId, int scheduleId) {
        String deleteQuery = "DELETE Slot \n"
                + "FROM Slot\n"
                + "INNER JOIN Schedule ON Slot.schedule_id = Schedule.id\n"
                + "INNER JOIN Mentor ON Schedule.mentor_id = Mentor.id\n"
                + "WHERE Slot.slot_date = ?\n"
                + "AND Mentor.id = ?\n"
                + "AND Schedule.id = ?;";

        try (PreparedStatement ps = conn.prepareStatement(deleteQuery)) {
            ps.setDate(1, new java.sql.Date(slot_date.getTime())); // Chuyển sang java.sql.Date
            ps.setInt(2, mentorId);
            ps.setInt(3, scheduleId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean bookMultipleSlots(List<Integer> slotIds, Integer menteeId) {
        String sql = "UPDATE Slot SET mentee_id = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (Integer slotId : slotIds) {
                stmt.setInt(1, menteeId);
                stmt.setInt(2, slotId);
                stmt.addBatch();
            }
            return Arrays.stream(stmt.executeBatch()).allMatch(result -> result == 1);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Slot> getSlotTemplates() {
        List<Slot> slots = new ArrayList<>();
        String query = "SELECT slot_number, start_time, end_time FROM Slot_Template";
        try (PreparedStatement stmt = conn.prepareStatement(query);) {
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                slots.add(new Slot(rs.getInt("slot_number"),
                        rs.getTime("start_time"),
                        rs.getTime("end_time")));
            }

        } catch (SQLException ex) {
            Logger.getLogger(DAOslot.class.getName()).log(Level.SEVERE, null, ex);
        }
        return slots;
    }

    // Thêm slot vào ngày cụ thể
    public boolean insertSlot(int scheduleId, Date slotDate, int slotNumber) {
        String query = "INSERT INTO Slot (schedule_id, slot_date, slot_number_id) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query);) {
            stmt.setInt(1, scheduleId);
            stmt.setDate(2, (java.sql.Date) (slotDate));
            stmt.setInt(3, slotNumber);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;

    }

    public List<Slot> getSlotsBySchedule(int scheduleId) {
        List<Slot> slots = new ArrayList<>();
        String query = "SELECT sl.id, sl.slot_date, st.slot_number, \n"
                + "is_booked\n"
                + "FROM Slot sl \n"
                + "join Schedule s on s.id = sl.schedule_id\n"
                + "join Slot_Template st on st.id = sl.slot_number_id\n"
                + "WHERE s.id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, scheduleId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                slots.add(new Slot(rs.getInt("id"),
                        rs.getDate("slot_date"),
                        rs.getInt("slot_number"),
                        rs.getBoolean("is_booked")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slots;
    }

    public List<Slot> getSlotBySchedule(int scheduleId) {
        List<Slot> slots = new ArrayList<>();
        String query = "SELECT sl.id, sl.slot_date, st.slot_number, sl.is_booked, st.start_time, \n"
                + "       CASE \n"
                + "           WHEN sl.slot_date = s.start_date THEN 'Monday'\n"
                + "           WHEN sl.slot_date = DATEADD(DAY, 1, s.start_date) THEN 'Tuesday'\n"
                + "           WHEN sl.slot_date = DATEADD(DAY, 2, s.start_date) THEN 'Wednesday'\n"
                + "           WHEN sl.slot_date = DATEADD(DAY, 3, s.start_date) THEN 'Thursday'\n"
                + "           WHEN sl.slot_date = DATEADD(DAY, 4, s.start_date) THEN 'Friday'\n"
                + "           WHEN sl.slot_date = DATEADD(DAY, 5, s.start_date) THEN 'Saturday'\n"
                + "           WHEN sl.slot_date = DATEADD(DAY, 6, s.start_date) THEN 'Sunday'\n"
                + "       END AS day_of_week\n"
                + "FROM Slot sl\n"
                + "JOIN Schedule s ON s.id = sl.schedule_id\n"
                + "JOIN Slot_Template st ON st.id = sl.slot_number_id\n"
                + "WHERE sl.slot_date BETWEEN s.start_date AND DATEADD(DAY, 6, s.start_date)\n"
                + "AND s.id = ? ;";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, scheduleId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                slots.add(new Slot(
                        rs.getDate("slot_date"),
                        rs.getInt("slot_number"),
                        rs.getBoolean("is_booked"),
                        rs.getTime("start_time"),
                        rs.getString("day_of_week")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slots;
    }

    public List<Slot> getSlotByDay(int scheduleId, String day) {
        List<Slot> slots = new ArrayList<>();
        String query = "SELECT sl.id, sl.slot_date, st.slot_number, sl.is_booked, st.start_time,\n"
                + "       DATENAME(WEEKDAY, sl.slot_date) AS day_of_week\n"
                + "FROM Slot sl\n"
                + "JOIN Schedule s ON s.id = sl.schedule_id\n"
                + "JOIN Slot_Template st ON st.id = sl.slot_number_id\n"
                + "WHERE sl.slot_date BETWEEN s.start_date AND DATEADD(DAY, 6, s.start_date)\n"
                + "AND DATENAME(WEEKDAY, sl.slot_date) = ?\n"
                + "AND s.id = ?;";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, day);
            stmt.setInt(2, scheduleId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                slots.add(new Slot(
                        rs.getDate("slot_date"),
                        rs.getInt("slot_number"),
                        rs.getBoolean("is_booked"),
                        rs.getTime("start_time"),
                        rs.getString("day_of_week")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slots;
    }

    public List<Slot> getSlotsByDate1(Date date, int mentorId) {
        List<Slot> slots = new ArrayList<>();

        String query = "SELECT sl.id, sl.slot_date, st.slot_number, sl.is_booked, st.start_time,\n"
                + "       CASE \n"
                + "           WHEN st.start_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'\n"
                + "           WHEN st.start_time BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'\n"
                + "           ELSE 'Evening'\n"
                + "       END AS period\n"
                + "FROM Slot sl\n"
                + "JOIN Schedule sc ON sl.schedule_id = sc.id\n"
                + "JOIN Mentor_Schedule ms ON ms.schedule_id = sc.id  -- Thay đổi theo mối quan hệ mới\n"
                + "JOIN Mentor m ON ms.mentor_id = m.id  -- Liên kết với bảng Mentor thông qua Mentor_Schedule\n"
                + "JOIN Slot_Template st ON st.id = sl.slot_number_id\n"
                + "WHERE sl.slot_date = ?\n"
                + "AND ms.mentor_id = ?  -- Thay vì sc.mentor_id, dùng ms.mentor_id theo quan hệ mới\n"
                + "ORDER BY st.start_time;";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setDate(1, date);
            stmt.setInt(2, mentorId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                slots.add(new Slot(rs.getInt("id"),
                        rs.getDate("slot_date"),
                        rs.getInt("slot_number"),
                        rs.getBoolean("is_booked"),
                        rs.getTime("start_time"),
                        rs.getString("period")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slots;
    }

    public List<Slot> getSlotsByDate(Date date, int mentorId) {
        List<Slot> slots = new ArrayList<>();

        String query = "SELECT sl.id, sl.slot_date, st.slot_number, sl.is_booked, st.start_time,\n"
                + "       CASE \n"
                + "           WHEN st.start_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'\n"
                + "           WHEN st.start_time BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'\n"
                + "           ELSE 'Evening'\n"
                + "       END AS period\n"
                + "FROM Slot sl\n"
                + "JOIN Schedule sc ON sl.schedule_id = sc.id\n"
                + "JOIN Mentor_Schedule ms ON ms.schedule_id = sc.id\n"
                + "JOIN Mentor m ON sc.mentor_id = m.id\n"
                + "JOIN Slot_Template st ON st.id = sl.slot_number_id\n"
                + "WHERE sl.slot_date = ?\n"
                + "AND sc.mentor_id = ?\n"
                + "AND sl.is_booked = 0\n"
                + "ORDER BY st.start_time;";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setDate(1, date);
            stmt.setInt(2, mentorId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                slots.add(new Slot(rs.getInt("id"),
                        rs.getDate("slot_date"),
                        rs.getInt("slot_number"),
                        rs.getBoolean("is_booked"),
                        rs.getTime("start_time"),
                        rs.getString("period")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slots;
    }

    public boolean bookSlot(int slotId, int menteeId) {
        String query = "UPDATE Slot\n"
                + "SET mentee_id = ? \n"
                + "WHERE id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, menteeId); // Đúng thứ tự: mentee_id trước
            stmt.setInt(2, slotId);   // id sau
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Integer getSlotId(String slotDate, int slotNumber) {
        String query = "SELECT id FROM Slot WHERE slot_date = ? AND slot_number_id = ? AND mentee_id IS NULL";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, slotDate);
            stmt.setInt(2, slotNumber);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("id"); // Trả về slotId
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy slot
    }

    public List<ScheduleMonth> getSchedulesByMonth() {
        List<ScheduleMonth> schedules = new ArrayList<>();
        String sql = "SELECT s.id,\n"
                + "    DATENAME(MONTH, s.start_date) AS month,\n"
                + "    COUNT(sl.id) AS slot_count\n"
                + "FROM Schedule s\n"
                + "LEFT JOIN Slot sl ON s.id = sl.schedule_id \n"
                + "GROUP BY s.id, DATENAME(MONTH, s.start_date);";

        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                schedules.add(new ScheduleMonth(
                        rs.getInt("schedule_id"),
                        rs.getString("month"),
                        rs.getInt("slot_count")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return schedules;
    }

    public int getDefaultScheduleId() {
        String sql = "SELECT schedule_id FROM schedules WHERE MONTH(start_date) = MONTH(CURDATE()) LIMIT 1";
        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("schedule_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Trả về -1 nếu không có schedule cho tháng hiện tại
    }

    public boolean bookSlot1(int scheduleId, int menteeId) {
        String sql = "INSERT INTO Mentee_Slot (slot_id, mentee_id, status) VALUES (?, ?, 'Pending')";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, scheduleId);
            pstmt.setInt(2, menteeId);
            pstmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void bookSlotForMentee(int scheduleId, int menteeId, String status) throws SQLException {
        String sql = "INSERT INTO Mentee_Slot (slot_id, mentee_id, status) VALUES (?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, scheduleId);
            pstmt.setInt(2, menteeId);
            pstmt.setString(3, status);
            pstmt.executeUpdate();
        }
    }

    public void updateSlotStatus(int slotId, String status) throws SQLException {
        String sql = "UPDATE Mentee_Slot SET status = ? WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, slotId);
            pstmt.executeUpdate();
        }
    }

    public List<Object[]> getSlotsByMentor(int mentorId) throws SQLException {
        String sql = "SELECT ms.id, ms.status, ms.booking_time, ms.slot_id AS schedule_id, m.username AS menteeName "
                + "FROM Mentee_Slot ms "
                + "JOIN Mentor_Schedule msched ON ms.slot_id = msched.id "
                + "JOIN Mentee m ON ms.mentee_id = m.id "
                + "WHERE msched.mentor_id = ? "
                + "ORDER BY ms.booking_time";
        List<Object[]> slots = new ArrayList<>();
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, mentorId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Object[] slot = new Object[5];
                slot[0] = rs.getInt("id");
                slot[1] = rs.getString("status");
                slot[2] = rs.getTimestamp("booking_time");
                slot[3] = rs.getString("schedule_id");
                slot[4] = rs.getString("menteeName");
                slots.add(slot);
            }
        }
        return slots;
    }

    public List<Object[]> getSlotsByMenteeAndMentor(int menteeId, int mentorId) throws SQLException {
        String sql = "SELECT ms.id, ms.status, ms.booking_time, ms.slot_id AS schedule_id "
                + "FROM Mentee_Slot ms "
                + "JOIN Mentor_Schedule msched ON ms.slot_id = msched.id "
                + "WHERE ms.mentee_id = ? AND msched.mentor_id = ? "
                + "ORDER BY ms.booking_time";
        List<Object[]> slots = new ArrayList<>();
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, menteeId);
            pstmt.setInt(2, mentorId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Object[] slot = new Object[4];
                slot[0] = rs.getInt("id");
                slot[1] = rs.getString("status");
                slot[2] = rs.getTimestamp("booking_time");
                slot[3] = rs.getString("schedule_id");
                slots.add(slot);
            }
        }
        return slots;
    }

    public int getRequestIdFromSlot(int slotId) throws SQLException {
        String sql = "SELECT request_id FROM Mentee_Slot WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, slotId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("request_id");
            }
            return -1;
        }
    }
    
        public int getRequestIdByMenteeAndMentor(int menteeId, int mentorId) throws SQLException {
        String sql = "SELECT r.id FROM Request r " +
                     "JOIN Mentee_Slot ms ON r.id = ms.request_id " +
                     "JOIN Mentor_Schedule msched ON ms.slot_id = msched.id " +
                     "WHERE r.mentee_id = ? AND msched.mentor_id = ? " +
                     "LIMIT 1";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, menteeId);
            pstmt.setInt(2, mentorId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
            return -1;
        }
    }
    
    public boolean areAllSlotsDone(int requestId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Mentee_Slot WHERE request_id = ? AND status != 'Done'";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, requestId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) == 0;
            }
            return false;
        }
    }
    
        public void clearSlotsForRequest(int requestId) throws SQLException {
        String sql = "DELETE FROM Mentee_Slot WHERE request_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, requestId);
            pstmt.executeUpdate();
        }
    }
    
    public static void main(String[] args) {

        DAOslot slotDAO = new DAOslot();

        int testMentorId = 1; // Thay đổi ID này theo dữ liệu thực tế trong DB
        int scheduleID = 1;

        List<Integer> slotIds = Arrays.asList(10, 11, 12);
        boolean success = slotDAO.bookMultipleSlots(slotIds, scheduleID);

        Date testDate = Date.valueOf("2025-03-08"); // Định dạng YYYY-MM-DD
        int mentorId = 1;  // Đổi giá trị phù hợp
        int scheduleId = 1;

        boolean result = slotDAO.deleteSlot(testDate, mentorId, scheduleId);
        if (result) {
            System.out.println("✅ Slot deleted successfully for date: " + testDate);
        } else {
            System.out.println("❌ Failed to delete slot for date: " + testDate);
        }

    }

}
