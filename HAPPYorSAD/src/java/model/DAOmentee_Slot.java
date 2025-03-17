/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Mentee;
import entity.Mentee_Slot;
import entity.Mentor_Slot;
import entity.Slot;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import static model.DBConnection.conn;

/**
 *
 * @author Ann
 */
public class DAOmentee_Slot extends DBConnection {

    public Integer getSlotId(String slotDate, int slotNumber) {
        String query = "SELECT id FROM Slot WHERE slot_date = ? AND slot_number_id = ? ";
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

    public boolean bookSlot(int menteeId, int slotId, int requestId, String status) {
        String query = "INSERT INTO Mentee_Slot (mentee_id, slot_id, request_id, status) VALUES (?, ?, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, menteeId);
            pstmt.setInt(2, slotId);
            pstmt.setInt(3, requestId); // Kiểm tra xem requestId có null không
            pstmt.setString(4, status);

            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void updateRequestIdForSlot(int slotId, int menteeId, int requestId) throws SQLException {
        String sql = "UPDATE [dbo].[Mentee_Slot]\n"
                + "SET [request_id] = ?\n"
                + "WHERE [mentee_id] = ? AND [slot_id] = ?;";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, requestId);
        ps.setInt(2, slotId);
        ps.setInt(2, menteeId);
        ps.executeUpdate();
    }

    public List<Mentee_Slot> getSlotsByRequestId(int requestId) throws SQLException {
        List<Mentee_Slot> slots = new ArrayList<>();
        String sql = "SELECT mentee_id, slot_id, request_id, status FROM Mentee_Slot WHERE request_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, requestId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Mentee_Slot slot = new Mentee_Slot();
            slot.setMentee_id(rs.getInt("mentee_id"));
            slot.setSlot_id(rs.getInt("slot_id"));
            slot.setRequest_id(rs.getInt("request_id"));
            slot.setStatus(rs.getString("status"));
            slots.add(slot);
        }
        return slots;
    }

    public List<Mentee_Slot> getSlotsByRequestId1(int requestId) throws SQLException {
        List<Mentee_Slot> slots = new ArrayList<>();
        String sql = "SELECT sl.slot_date, ms.status, sl.slot_number_id, \n"
                + "       st.start_time, st.end_time, ms.request_id\n"
                + "FROM Mentee_Slot ms\n"
                + "join Slot sl on sl.id = ms.slot_id\n"
                + "JOIN Slot_Template st ON sl.slot_number_id = st.id\n"
                + "WHERE ms.request_id = ?\n"
                + "GROUP BY sl.slot_date, ms.status, sl.slot_number_id, \n"
                + "       st.start_time, st.end_time, ms.request_id";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, requestId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Mentee_Slot slot = new Mentee_Slot(
                    rs.getInt("request_id"),
                    rs.getString("status"),
                    rs.getDate("slot_date"),
                    rs.getInt("slot_number_id"),
                    rs.getTime("start_time"),
                    rs.getTime("end_time"));

            slots.add(slot);
        }
        return slots;
    }

    public List<Mentee_Slot> getSlotsByRequestIdd(int requestId) throws SQLException {
        List<Mentee_Slot> slots = new ArrayList<>();
        String sql = "SELECT * FROM Mentee_Slot WHERE request_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, requestId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Mentee_Slot slot = new Mentee_Slot();
            slot.setSlot_id(rs.getInt("slot_id"));
            slot.setStatus(rs.getString("status"));
            // Các trường khác
            slots.add(slot);
        }
        return slots;
    }

    public void updateMenteeSlotStatus(int slotId, int menteeId, int requestId, String status) throws SQLException {
        String sql = "UPDATE Mentee_Slot SET status = ? WHERE [slot_id] = ? AND [mentee_id] = ? AND [request_id] = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, slotId);
        ps.setInt(3, menteeId);
        ps.setInt(4, requestId);

        ps.executeUpdate();
    }

    public void updateMenteeSlotStatusCF(int slotId, String status) throws SQLException {
        String sql = "UPDATE Mentee_Slot SET status = ? WHERE [slot_id] = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, slotId);

        ps.executeUpdate();
    }

    public void updateMentorSlotStatus(int slotId, int mentorId, String status) throws SQLException {
        String sql = "UPDATE mentor_Slot SET status = ? WHERE [slot_id] = ? AND [mentor_id] = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, slotId);
        ps.setInt(3, mentorId);

        ps.executeUpdate();
    }

    public void updateMentorSlotStatus1(int slotId, String status) throws SQLException {
        String sql = "UPDATE mentor_Slot SET status = ? WHERE [slot_id] = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, slotId);

        ps.executeUpdate();
    }

    public boolean updateSlotStatus(int slotId, String status) {
        String sql = "UPDATE mentee_slot SET status = ? WHERE slot_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, slotId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu cập nhật thành công
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Mentee_Slot getMenteeSlotsByMentorSlotId(int mentorSlotId) {
        Mentee_Slot menteeSlot = null;
        String sql = "SELECT * FROM mentee_slot WHERE slot_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, mentorSlotId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) { // Chỉ lấy bản ghi đầu tiên (nếu có)
                menteeSlot = new Mentee_Slot();
                menteeSlot.setMentee_id(rs.getInt("mentee_id"));
                menteeSlot.setSlot_id(rs.getInt("slot_id"));
                menteeSlot.setRequest_id(rs.getInt("request_id"));
                menteeSlot.setStatus(rs.getString("status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menteeSlot;
    }

    public Mentee getMenteeBySlotId(String date, int slotNumber) {
        String sql = "SELECT m.name, m.image, m.email \n"
                + "               FROM Mentee_Slot ms \n"
                + "                JOIN Mentee m ON m.id = ms.mentee_id \n"
                + "		join Slot sl on sl.id = ms.slot_id\n"
                + "               WHERE sl.slot_date = ? and slot_number_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, date);
            stmt.setInt(2, slotNumber);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Mentee(
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

    public List<Mentee_Slot> getSlotsByDateMenteeAttendance(java.sql.Date date, int menteeId) {
        List<Mentee_Slot> slots = new ArrayList<>();

        String sql = "SELECT \n"
                + "    sl.slot_date, msl.slot_id, \n"
                + "    msl.status, \n"
                + "    sl.slot_number_id, \n"
                + "    st.start_time, \n"
                + "    st.end_time,\n"
                + "	sl.id , msl.request_id,\n"
                + "    msl.mentee_id\n"
                + "FROM Mentee_Slot msl\n"
                + "JOIN Slot sl ON sl.id = msl.slot_id\n"
                + "JOIN Slot_Template st ON sl.slot_number_id = st.id\n"
                + "WHERE sl.slot_date = ?  -- Thay bằng ngày bạn muốn test\n"
                + "AND msl.mentee_id = ?  -- Thay bằng ID Mentor cần test\n"
                + "GROUP BY \n"
                + "    sl.slot_date, \n"
                + "    msl.status, \n"
                + "    sl.slot_number_id, \n"
                + "    st.start_time, \n"
                + "    st.end_time, \n"
                + "	sl.id,\n"
                + "    msl.mentee_id, msl.slot_id,  msl.request_id;";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, date);
            stmt.setInt(2, menteeId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Mentee_Slot slot = new Mentee_Slot(
                        rs.getInt("mentee_id"),
                        rs.getInt("slot_id"),
                        rs.getInt("request_id"),
                        rs.getString("status"),
                        rs.getDate("slot_date"),
                        rs.getInt("slot_number_id"),
                        rs.getTime("start_time"),
                        rs.getTime("end_time"));

                slots.add(slot);
            }
            return slots;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slots;
    }

    public void deleteSlotsByRequestIdAndStatus(int requestId, String status) {
        String sql = "DELETE FROM mentee_slot WHERE request_id = ? AND status = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, requestId);
            ps.setString(2, status);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Slot> getSlotsByRequestIdAndStatus(int requestId, String status) {
        List<Slot> slots = new ArrayList<>();
        String sql = "SELECT s.* FROM mentee_slot ms JOIN Slot s ON ms.slot_id = s.id WHERE ms.request_id = ? AND ms.status = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, requestId);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Slot slot = new Slot(rs.getInt("id"),
                        rs.getDate("slot_date"),
                        rs.getInt("slot_number_id"));
                slots.add(slot);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return slots;
    }

    public List<Slot> getSlotsByMenteeIdAndStatus(int menteeId, String status) {
        List<Slot> bookedSlots = new ArrayList<>();
        String sql = "SELECT s.id, s.slot_date, s.slot_number_id, ms.request_id\n"
                + "FROM Slot s\n"
                + "JOIN Mentee_Slot ms ON s.id = ms.slot_id\n"
                + "WHERE ms.mentee_id = ? AND ms.status = ?;";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, menteeId);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Slot slot = new Slot();
                slot.setId(rs.getInt("id"));
                slot.setSlotDate(rs.getDate("slot_date"));
                slot.setSlotNumber(rs.getInt("slot_number_id"));
                slot.setRequest_id(rs.getObject("request_id") != null ? rs.getInt("request_id") : null);
                bookedSlots.add(slot);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return bookedSlots;
    }

    public static void main(String[] args) {
        DAOmentee_Slot dao = new DAOmentee_Slot();
        LocalDate localDate = LocalDate.parse("2025-03-03");
        java.sql.Date sqlDate = java.sql.Date.valueOf(localDate); // Chuyển LocalDate thành java.sql.Date

        List<Slot> slots = dao.getSlotsByMenteeIdAndStatus(2, "Studying");
        System.out.println(slots);
    }

}
