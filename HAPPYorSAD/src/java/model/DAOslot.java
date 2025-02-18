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
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ann
 */
public class DAOslot extends DBConnection {

    public boolean addSlot(int scheduleId, int slotNumber) {
        String sql = "INSERT INTO Slot (schedule_id, slot_number, is_booked) VALUES (?, ?, 0)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, scheduleId);
            ps.setInt(2, slotNumber);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Slot> getSlotsBySchedule(int scheduleId) {
        List<Slot> slots = new ArrayList<>();
        String sql = "SELECT * FROM Slot WHERE schedule_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, scheduleId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                slots.add(new Slot(rs.getInt("slot_id"), rs.getInt("schedule_id"), rs.getInt("slot_number"),
                        rs.getBoolean("is_booked"), rs.getInt("booked_by_mentee_id")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slots;
    }
}
