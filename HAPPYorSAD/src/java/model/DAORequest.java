/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Request;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import entity.Test;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.DBConnection;
import static model.DBConnection.conn;


public class DAORequest extends DBConnection {

    public List<Request> getRequestByMentor(String mentor, LocalDate date, int page, int limit) {
        List<Request> requests = new ArrayList<>();

        // Calculate the offset for pagination (page starts at 1)
        int offset = (page - 1) * limit;

        // Start the SQL query
        StringBuilder sql = new StringBuilder(
            "SELECT r.id, r.mentee_id, r.mentor_id, u.username AS mentor_name, " +
            "r.title, r.deadline_date, r.deadline_hour, r.content, r.status, " +
            "r.created_at, r.updated_at, r.course_ids " +
            "FROM Request r " +
            "JOIN Mentor m ON r.mentor_id = m.id " +
            "JOIN [Users] u ON m.user_id = u.id " +
            "WHERE u.username = ? "
        );


        // Add the date filter if the date is not null
        if (date != null) {
            sql.append("AND r.created_at >= ? ");
        }

        // Add pagination and ordering
        sql.append("ORDER BY r.deadline_date ASC " +
                   "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement preparedStatement = conn.prepareStatement(sql.toString())) {
            preparedStatement.setString(1, mentor);  // Set mentor name

            int index = 2;
            if (date != null) {
                preparedStatement.setDate(index++, java.sql.Date.valueOf(date));  // Set the date if not null
            }

            preparedStatement.setInt(index++, offset);  // Set the OFFSET (pagination)
            preparedStatement.setInt(index, limit);     // Set the LIMIT (pagination)

            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Request request = new Request(
                        rs.getInt("id"),
                        rs.getInt("mentee_id"),
                        rs.getInt("mentor_id"),
                        rs.getString("title"),
                        rs.getDate("deadline_date").toLocalDate(),
                        rs.getTime("deadline_hour").toLocalTime(),
                        rs.getString("content"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getTimestamp("updated_at").toLocalDateTime(),
                        rs.getString("course_ids")
                    );
                    requests.add(request);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return requests;
    }

    public int getRequestCount(String mentor, LocalDate date) {
        int count = 0;

        // Start the SQL query
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) AS total_count " +
            "FROM Request r " +
            "JOIN Mentor m ON r.mentor_id = m.id " +
            "JOIN [Users] u ON m.user_id = u.id " +
            "WHERE u.username = ? "
        );

        // Add the date filter if the date is not null
        if (date != null) {
            sql.append("AND r.created_at >= ? ");
        }

        try (PreparedStatement preparedStatement = conn.prepareStatement(sql.toString())) {
            preparedStatement.setString(1, mentor);  // Set mentor name

            int index = 2;
            if (date != null) {
                preparedStatement.setDate(index++, java.sql.Date.valueOf(date));  // Set the date if not null
            }

            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt("total_count");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }
    public void updateRequestStatus(int requestId, String newStatus) {
        String sql = "UPDATE Request SET status = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newStatus);
            stmt.setInt(2, requestId);

            int rowsUpdated = stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public boolean addRejectReason(int requestId, String reason){
        boolean isUpdated = false;

        String sql = "INSERT INTO RejectedRequest (request_Id, message) VALUES (?, ?)";

        try (PreparedStatement insertStmt = conn.prepareStatement(sql)) {
            insertStmt.setInt(1, requestId);
            insertStmt.setString(2, reason);
            isUpdated = insertStmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isUpdated;
    }
}
