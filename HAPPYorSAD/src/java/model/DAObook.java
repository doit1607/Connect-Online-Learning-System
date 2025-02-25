/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import entity.Schedule;
import entity.Slot;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import java.time.LocalDate;
import java.util.logging.Logger;

/**
 *
 * @author Ann
 */
public class DAObook extends DBConnection {

    private static final Logger LOGGER = Logger.getLogger(DAObook.class.getName());

    public Integer getSlotIdByDateAndNumber(Date slotDate, int slotNumberId) {
        String sql = "SELECT id FROM Slot WHERE slot_Date = ? AND slot_number_id = ?";

        int slotId = -1;
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setDate(1, (java.sql.Date) slotDate);
            stmt.setInt(2, slotNumberId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return slotId;
    }

    public Integer getSlotNumberIdByDateAndTime(Date slotDate, String startTime) {
        Integer slotNumberId = null;
        String sql = "SELECT st.id FROM Slot s join Slot_Template st on st.id = s.slot_number_id\n"
                + "WHERE s.slot_date = ? AND st.start_time = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, slotDate);
            ps.setString(2, startTime);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                slotNumberId = rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slotNumberId;
    }

    public boolean bookSlot(int menteeId, int scheduleId, Date slotDate, int slotNumber) {
        if (isSlotBooked(scheduleId, slotDate, slotNumber)) {
            LOGGER.log(Level.WARNING, "Slot already booked: Schedule ID {0}, Date {1}, Slot {2}", new Object[]{scheduleId, slotDate, slotNumber});
            return false;
        }
        String sql = "UPDATE Slot SET mentee_id = ? WHERE schedule_id = ? AND slot_date = ? AND slot_number_id = ? AND mentee_id IS NULL";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, menteeId);
            ps.setInt(2, scheduleId);
            ps.setDate(3, slotDate);
            ps.setInt(4, slotNumber);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error booking slot", e);
        }
        return false;
    }

    private boolean isSlotBooked(int scheduleId, Date slotDate, int slotNumber) {
        String sql = "SELECT mentee_id FROM Slot WHERE schedule_id = ? AND slot_date = ? AND slot_number_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, scheduleId);
            ps.setDate(2, slotDate);
            ps.setInt(3, slotNumber);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking slot availability", e);
        }
        return false;
    }

    public static void main(String[] args) {
        DAObook dao = new DAObook();
        Date slotDate = Date.valueOf("2025-03-03");
        String time = "10:00";
        int slotNumberId = 1;

        int retrievedSlotId = dao.getSlotNumberIdByDateAndTime(slotDate, time);

        System.out.println("Slot ID: " + retrievedSlotId);
    }

}
