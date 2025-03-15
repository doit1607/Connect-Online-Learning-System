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
                + "AND ms.mentor_id = ? and SL.status='Available'  -- Thay vì sc.mentor_id, dùng ms.mentor_id theo quan hệ mới\n"
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

    public boolean addSlots(int scheduleId, String day, int slotNumber, String status) {
        String sql = "INSERT INTO Slot (schedule_id, slot_date , slot_number_id, status) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, scheduleId);
            ps.setString(2, day);
            ps.setInt(3, slotNumber);
            ps.setString(4, status);
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

    public List<Slot> getSlotsByDate3(Date date, int mentorId) {
        List<Slot> slots = new ArrayList<>();

        String query = "    SELECT sl.id, sl.slot_date, st.slot_number, sl.is_booked, sl.status, st.start_time,\n"
                + "           CASE \n"
                + "               WHEN st.start_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'\n"
                + "               WHEN st.start_time BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'\n"
                + "               ELSE 'Evening'\n"
                + "           END AS period\n"
                + "    FROM Slot sl\n"
                + "    JOIN Schedule sc ON sl.schedule_id = sc.id\n"
                + "    JOIN Mentor_Schedule ms ON ms.schedule_id = sc.id\n"
                + "    JOIN Mentor m ON ms.mentor_id = m.id\n"
                + "    JOIN Slot_Template st ON st.id = sl.slot_number_id\n"
                + "    WHERE sl.slot_date = ?\n"
                + "      AND ms.mentor_id = ?\n"
                + "      AND sl.mentee_id is not null\n"
                + "    ORDER BY st.start_time;";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setDate(1, date);
            stmt.setInt(2, mentorId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                slots.add(new Slot(rs.getInt("id"),
                        rs.getDate("slot_date"),
                        rs.getInt("slot_number"),
                        rs.getBoolean("is_booked"),
                        rs.getString("status"),
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
                + "SET mentee_id = ?\n"
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

    public Slot getSlotByDateAndNumber(String date, int slotNumber) {
        Slot slot = null;
        String query = "SELECT * FROM Slot WHERE slot_date = ? AND slot_number_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, date);
            ps.setInt(2, slotNumber);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    slot = new Slot();
                    slot.setId(rs.getInt("id"));
                    slot.setSlotDate(rs.getDate("slot_date"));
                    slot.setSlotNumber(rs.getInt("slot_number_id"));
                    slot.setRequest_id(rs.getInt("request_id"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slot;
    }

    public Slot getSlotByDateAndNumberr(String date, int slotNumber) {
        Slot slot = null;
        String query = "SELECT s.*, ms.* \n"
                + "FROM Slot s \n"
                + "LEFT JOIN mentee_Slot ms ON s.id = ms.slot_id \n"
                + "WHERE s.slot_date = ? AND s.slot_number_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, date);
            ps.setInt(2, slotNumber);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    slot = new Slot();
                    slot.setId(rs.getInt("id"));
                    slot.setSlotDate(rs.getDate("slot_date"));
                    slot.setSlotNumber(rs.getInt("slot_number_id"));
                    slot.setStatus(rs.getString("status"));
                    slot.setRequest_id(rs.getInt("request_id"));

                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slot;
    }

//    public Slot getSlotByDateAndNumberr(String date, int slotNumber) {
//        Slot slot = null;
//        String query = "SELECT sl.*, ms.*, r.mentor_id\n"
//                + "FROM Slot sl \n"
//                + "join Mentee_Slot ms on ms.slot_id = sl.id\n"
//                + "join Request r on r.id = ms.request_id\n"
//                + "WHERE sl.slot_date = ? AND slot_number_id = ?";
//        try (PreparedStatement ps = conn.prepareStatement(query)) {
//            ps.setString(1, date);
//            ps.setInt(2, slotNumber);
//            try (ResultSet rs = ps.executeQuery()) {
//                if (rs.next()) {
//                    slot = new Slot();
//                    slot.setId(rs.getInt("id"));
//                    slot.setSlotDate(rs.getDate("slot_date"));
//                    slot.setSlotNumber(rs.getInt("slot_number_id"));
//                    slot.setStatus(rs.getString("status"));
//                    slot.setRequest_id(rs.getInt("request_id"));
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return slot;
//    }
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
        String sql = "UPDATE Mentor_Slot SET status = ? WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, slotId);
        ps.executeUpdate();
    }

    public void updateSlotStatuss(int slotId, int menteeId, int requestId, String status) throws SQLException {
        String sql = "UPDATE Mentee_Slot SET status = ? WHERE [slot_id] = ? AND [mentee_id] = ? AND [request_id] = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, slotId);
        ps.setInt(2, menteeId);
        ps.setInt(3, requestId);
        ps.setString(4, status);

        ps.executeUpdate();
    }

    public void updateSlotStatusss(int slotId, int mentorId, String status) throws SQLException {
        String sql = "UPDATE Mentor_Slot SET status = ? WHERE [slot_id] = ? AND [mentor_id] = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, slotId);
        ps.setInt(3, mentorId);

        ps.executeUpdate();
    }

    public void updateSlotStatus1(int slotId, String status) throws SQLException {
        String sql = "UPDATE Slot SET status = ?, updated_at = GETDATE() WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, slotId);
        ps.executeUpdate();
    }

    public List<Slot> getSlotsByRequestId(int requestId) throws SQLException {
        List<Slot> slots = new ArrayList<>();
        String sql = "SELECT * FROM Mentee_Slot WHERE request_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, requestId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Slot slot = new Slot();
            slot.setId(rs.getInt("id"));
            slot.setStatus(rs.getString("status"));
            // Các trường khác
            slots.add(slot);
        }
        return slots;
    }

    public List<Slot> getSlotsByRequestId1(int requestId) throws SQLException {
        List<Slot> slots = new ArrayList<>();
        String sql = "SELECT s.slot_date, s.status, s.slot_number_id, st.start_time, st.end_time, s.request_id\n"
                + "FROM Slot s\n"
                + "join Slot_Template st on s.slot_number_id = st.id\n"
                + "WHERE request_id = ?\n"
                + "group by  s.slot_date, s.status, s.slot_number_id, st.start_time, st.end_time, s.request_id";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, requestId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Slot slot = new Slot(rs.getDate("slot_Date"),
                    rs.getInt("slot_number_id"),
                    rs.getTime("start_time"),
                    rs.getTime("end_time"),
                    rs.getString("status"),
                    rs.getInt("request_id"));

            slots.add(slot);
        }
        return slots;
    }

    public boolean areAllSlotsComplete(int requestId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Slot WHERE request_id = ? AND status != 'Complete'";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, requestId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) == 0; // Nếu không còn slot nào chưa complete
        }
        return false;
    }

    // Cập nhật request_id cho slot
    public void updateRequestIdForSlot(int slotId, int requestId) throws SQLException {
        String sql = "UPDATE Slot SET request_id = ? WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, requestId);
        ps.setInt(2, slotId);
        ps.executeUpdate();
    }

    // Xóa request_id khỏi tất cả slot liên quan đến request (đặt về NULL)
    public void removeRequestIdFromSlots(int requestId) throws SQLException {
        String sql = "UPDATE Slot SET request_id = NULL WHERE request_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, requestId);
        ps.executeUpdate();
    }

    public List<Slot> getSlotsByDate4(Date date, int mentorId) {
        List<Slot> slots = new ArrayList<>();

        String query = "SELECT sl.id, sl.slot_date, st.slot_number, st.start_time \n"
                + "FROM Slot sl\n"
                + "JOIN Mentor_Slot ms ON ms.slot_id = sl.id\n"
                + "JOIN Slot_Template st ON st.id = sl.slot_number_id\n"
                + "WHERE sl.slot_date = ?\n"
                + "AND ms.mentor_id = ?\n"
                + "group by sl.id, sl.slot_date, st.slot_number, st.start_time \n"
                + "ORDER BY st.start_time;";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setDate(1, date);
            stmt.setInt(2, mentorId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                boolean add = slots.add(new Slot(
                        rs.getInt("id"),
                        rs.getDate("slot_date"),
                        rs.getInt("slot_number"),
                        rs.getTime("start_time")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slots;
    }

    public List<Slot> getSlotsByDate5(Date date, int mentorId) {
        List<Slot> slots = new ArrayList<>();

        String query = "SELECT sl.id, sl.slot_date, st.slot_number, st.start_time \n"
                + "FROM Slot sl\n"
                + "JOIN Mentor_Slot ms ON ms.slot_id = sl.id\n"
                + "JOIN Slot_Template st ON st.id = sl.slot_number_id\n"
                + "WHERE sl.slot_date = ?\n"
                + "AND ms.mentor_id = ? and ms.status = 'Available'\n"
                + "group by sl.id, sl.slot_date, st.slot_number, st.start_time \n"
                + "ORDER BY st.start_time;";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setDate(1, date);
            stmt.setInt(2, mentorId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                boolean add = slots.add(new Slot(
                        rs.getInt("id"),
                        rs.getDate("slot_date"),
                        rs.getInt("slot_number"),
                        rs.getTime("start_time")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slots;
    }

    public int getSlotId(int scheduleId, Date slotDate, int slotNumber) {
        String sql = "SELECT * FROM Slot WHERE schedule_id = ? AND slot_date = ? AND slot_number_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, scheduleId);
            ps.setDate(2, slotDate);
            ps.setInt(3, slotNumber);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Trả về -1 nếu không tìm thấy
    }

    public static void main(String[] args) {

        DAOslot slotDAO = new DAOslot();

        int testMentorId = 1; // Thay đổi ID này theo dữ liệu thực tế trong DB
        int scheduleID = 659;

        try {
            List<Slot> sl = slotDAO.getSlotsByRequestId(scheduleID);
            for (Slot slot : sl) {
                System.out.println(slot);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOslot.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
