/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Mentor;
import entity.Mentor_Slot;
import entity.Slot;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DBConnection;
import static model.DBConnection.conn;

/**
 *
 * @author Ann
 */
public class DAOmentor_Slot extends DBConnection {

    public boolean addSlotss(int mentor_id, int slot_id, String status) {
        String sql = "INSERT INTO Mentor_Slot (mentor_id, slot_id, status) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, mentor_id);
            ps.setInt(2, slot_id);
            ps.setString(3, status);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;

    }
    public boolean updateSlotStatus2(int mentorId, int slotId, String status) {
    // Cập nhật trạng thái slot trong database
    // Ví dụ: UPDATE Mentor_Slot SET status = ? WHERE mentorId = ? AND slot_id = ?
        return false;
    // Cập nhật trạng thái slot trong database
    // Ví dụ: UPDATE Mentor_Slot SET status = ? WHERE mentorId = ? AND slot_id = ?
}
    
    public List<Mentor_Slot> getFilteredSlots(int mentorId, Integer month, String status, Date requestTime) {
    // Truy vấn SQL để lấy slot theo mentorId và các bộ lọc
    // Ví dụ: SELECT * FROM Mentor_Slot WHERE mentorId = ? AND MONTH(slot_date) = ? AND status = ? AND request_time = ?
        return null;
    // Truy vấn SQL để lấy slot theo mentorId và các bộ lọc
    // Ví dụ: SELECT * FROM Mentor_Slot WHERE mentorId = ? AND MONTH(slot_date) = ? AND status = ? AND request_time = ?
}

    public Mentor getMentorBySlotId(String slotDate, int slotNumberId) {
        String sql = "SELECT m.name, m.image, m.email \n"
                + "                         FROM Mentor_Slot ms \n"
                + "                             JOIN Mentor m ON m.id = ms.mentor_id \n"
                + "            	join Slot sl on sl.id = ms.slot_id\n"
                + "                            WHERE sl.slot_date = ? and slot_number_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, slotDate);
            stmt.setInt(2, slotNumberId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Mentor(
                            rs.getString("name"),
                            rs.getString("image"),
                            rs.getString("email")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý lỗi hoặc log lỗi
        }
        return null; // Trả về null nếu không tìm thấy
    }

    public List<Mentor_Slot> getSlotsByRequestId1(int requestId) throws SQLException {
        List<Mentor_Slot> slots = new ArrayList<>();
        String sql = "SELECT sl.slot_date, ms.status, sl.slot_number_id, \n"
                + "       st.start_time, st.end_time, ms.request_id, msl.mentor_id\n"
                + "FROM Mentee_Slot ms\n"
                + "JOIN Slot sl ON sl.id = ms.slot_id\n"
                + "JOIN Slot_Template st ON sl.slot_number_id = st.id\n"
                + "JOIN Mentor_Slot msl ON sl.id = msl.slot_id  -- Thêm JOIN với Mentor_Slot để lấy mentor_id\n"
                + "WHERE ms.request_id = ?\n"
                + "GROUP BY sl.slot_date, ms.status, sl.slot_number_id, \n"
                + "         st.start_time, st.end_time, ms.request_id, msl.mentor_id;";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, requestId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Mentor_Slot slot = new Mentor_Slot(
                    rs.getInt("request_id"),
                    rs.getInt("slot_id"),
                    rs.getInt("mentor_id"),
                    rs.getDate("slot_date"),
                    rs.getInt("slot_number_id"),
                    rs.getTime("start_time"),
                    rs.getTime("end_time"),
                    rs.getString("status"));

            slots.add(slot);
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

    public List<Slot> getSlotsByDate1(Date date, int mentorId) {
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

    public List<Slot> getSlotsByDateForRequest(Date date, int mentorId) {
        List<Slot> slots = new ArrayList<>();

        String query = "SELECT sl.id, sl.slot_date, st.slot_number, st.start_time, st.end_time, ms.status \n"
                + "FROM Slot sl\n"
                + "JOIN Mentor_Slot ms ON ms.slot_id = sl.id\n"
                + "JOIN Slot_Template st ON st.id = sl.slot_number_id\n"
                + "WHERE sl.slot_date = ? \n"
                + "AND ms.mentor_id = ?\n"
                + "group by sl.id, sl.slot_date, st.slot_number, st.start_time, ms.status,  st.end_time \n"
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
                        rs.getTime("start_time"),
                        rs.getTime("end_time")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slots;
    }

//    String query = "SELECT sl.id, sl.slot_date, st.slot_number, st.start_time \n"
//                + "FROM Slot sl\n"
//                + "JOIN Mentor_Slot ms ON ms.slot_id = sl.id\n"
//                + "JOIN Slot_Template st ON st.id = sl.slot_number_id\n"
//                + "WHERE sl.slot_date = ? and status = 'Available'\n"
//                + "AND ms.mentor_id = ?\n"
//                + "group by sl.id, sl.slot_date, st.slot_number, st.start_time \n"
//                + "ORDER BY st.start_time;";
    public List<Mentor_Slot> getSlotsByDateMentorDetai(Date date, int mentorId) {
        List<Mentor_Slot> slots = new ArrayList<>();

        String sql = "SELECT \n"
                + "    sl.slot_date, "
                + "sl.id, \n"
                + "    msl.status, \n"
                + "    sl.slot_number_id, \n"
                + "    st.start_time, \n"
                + "    st.end_time, \n"
                + "    msl.mentor_id\n"
                + "FROM Mentor_Slot msl\n"
                + "JOIN Slot sl ON sl.id = msl.slot_id\n"
                + "JOIN Slot_Template st ON sl.slot_number_id = st.id\n"
                + "WHERE sl.slot_date = ?  -- Thay bằng ngày bạn muốn test\n"
                + "AND msl.mentor_id = ?  -- Thay bằng ID Mentor cần test\n"
                + "GROUP BY \n"
                + "    sl.slot_date, \n"
                + "    msl.status, \n"
                + "    sl.slot_number_id, \n"
                + "    st.start_time, \n"
                + "    st.end_time,"
                + "sl.id, \n"
                + "    msl.mentor_id;";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, date);
            stmt.setInt(2, mentorId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Mentor_Slot slot = new Mentor_Slot(
                        rs.getInt("mentor_id"),
                        rs.getDate("slot_date"),
                        rs.getInt("slot_number_id"),
                        rs.getTime("start_time"),
                        rs.getTime("end_time"),
                        rs.getString("status"));

                slots.add(slot);
            }
            return slots;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slots;
    }

    public List<Mentor_Slot> getSlotsByDateMentorAttendance(Date date, int mentorId) {
        List<Mentor_Slot> slots = new ArrayList<>();

        String sql = "SELECT \n"
                + "    sl.slot_date, "
                + "sl.id, \n"
                + "    msl.status, \n"
                + "    sl.slot_number_id, \n"
                + "    st.start_time, \n"
                + "    st.end_time, \n"
                + "    msl.mentor_id\n"
                + "FROM Mentor_Slot msl\n"
                + "JOIN Slot sl ON sl.id = msl.slot_id\n"
                + "JOIN Slot_Template st ON sl.slot_number_id = st.id\n"
                + "WHERE sl.slot_date = ?   -- Thay bằng ngày bạn muốn test\n"
                + "AND msl.mentor_id = ?  -- Thay bằng ID Mentor cần test\n"
                + "GROUP BY \n"
                + "    sl.slot_date, \n"
                + "    msl.status, \n"
                + "    sl.slot_number_id, \n"
                + "    st.start_time, \n"
                + "    st.end_time,"
                + "sl.id, \n"
                + "    msl.mentor_id;";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, date);
            stmt.setInt(2, mentorId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Mentor_Slot slot = new Mentor_Slot(
                        rs.getInt("mentor_id"),
                        rs.getDate("slot_date"),
                        rs.getInt("slot_number_id"),
                        rs.getTime("start_time"),
                        rs.getTime("end_time"),
                        rs.getString("status"));

                slots.add(slot);
            }
            return slots;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slots;
    }

    public Mentor_Slot getSlotsByDateMentorAtt(String date, int slotNumber) {
        Mentor_Slot slot = null;

        String sql = "SELECT \n"
                + "    sl.slot_date, \n"
                + "    sl.id, \n"
                + "    msl.status, \n"
                + "    sl.slot_number_id, \n"
                + "    st.start_time, \n"
                + "    st.end_time, \n"
                + "    msl.mentor_id\n"
                + "FROM Mentor_Slot msl\n"
                + "JOIN Slot sl ON sl.id = msl.slot_id\n"
                + "JOIN Slot_Template st ON sl.slot_number_id = st.id\n"
                + "WHERE sl.slot_date = ?  -- Thay bằng ngày bạn muốn test\n"
                + "AND sl.slot_number_id = ?  -- Thay bằng ID slot bạn muốn test\n"
                + "GROUP BY \n"
                + "    sl.slot_date, \n"
                + "    msl.status, \n"
                + "    sl.slot_number_id, \n"
                + "    st.start_time, \n"
                + "    st.end_time, \n"
                + "    sl.id, \n"
                + "    msl.mentor_id;";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, date);
            stmt.setInt(2, slotNumber);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                slot = new Mentor_Slot(
                        rs.getInt("id"),
                        rs.getInt("mentor_id"),
                        rs.getDate("slot_date"),
                        rs.getInt("slot_number_id"),
                        rs.getTime("start_time"),
                        rs.getTime("end_time"),
                        rs.getString("status"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slot;
    }

    public void updateSlotStatus(int slotId, String status) throws SQLException {
        String sql = "UPDATE Mentor_Slot SET status = ? WHERE slot_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, slotId);
        ps.executeUpdate();
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
                    slot.setStatus(rs.getString("status"));
                    slot.setRequest_id(rs.getInt("request_id"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slot;
    }

    public List<Mentor_Slot> getNonAvailableSlots(Integer mentorId) {
        List<Mentor_Slot> slots = new ArrayList<>();
        String sql = "SELECT s.id, s.slot_date, ms.mentor_id, ms.status , "
                + "st.start_time, st.end_time, s.slot_number_id "
                + "FROM Mentor_Slot ms "
                + "JOIN Slot s ON s.id = ms.slot_id "
                + "JOIN Slot_Template st ON st.id = s.slot_number_id "
                + "WHERE ms.mentor_id = ? AND ms.status = 'nonAvailable' "
                + "GROUP BY s.id, s.slot_date, ms.mentor_id, ms.status, st.start_time, st.end_time, s.slot_number_id "
                + "ORDER BY st.start_time;";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, mentorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // Map kết quả vào đối tượng Slot
                slots.add(new Mentor_Slot(
                        rs.getInt("id"),
                        rs.getInt("mentor_id"),
                        rs.getDate("slot_date"),
                        rs.getInt("slot_number_id"),
                        rs.getTime("start_time"),
                        rs.getTime("end_time"),
                        rs.getString("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return slots;
    }

    public boolean deleteSlot(int mentorId, int slotId) {
        String sql = "DELETE FROM mentor_slot WHERE mentor_id = ? AND slot_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, mentorId);
            ps.setInt(2, slotId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Successfully deleted slot with slotId: " + slotId + " for mentorId: " + mentorId);
                return true;
            } else {
                System.out.println("No slot found to delete with slotId: " + slotId + " for mentorId: " + mentorId);
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) {
        DAOmentor_Slot dao = new DAOmentor_Slot();
        LocalDate localDate = LocalDate.parse("2025-03-03");
        Date sqlDate = Date.valueOf(localDate); // Chuyển LocalDate thành java.sql.Date

        String date = "2025-03-03";
        Mentor_Slot slot = dao.getSlotsByDateMentorAtt(date, 1);

        System.out.println(slot);
    }

}
