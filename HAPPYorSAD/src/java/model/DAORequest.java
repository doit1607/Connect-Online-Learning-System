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
import java.sql.Date;
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
    public boolean createRequest(Request request) {
        String sql = "INSERT INTO Request (mentee_id, mentor_id, title, deadline_date, deadline_hour, content, course_ids) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, request.getMenteeId());
            stmt.setInt(2, request.getMenteeId());
            stmt.setString(3, request.getTitle());
            stmt.setDate(4, Date.valueOf(request.getDeadlineDate()));
            stmt.setTime(5, java.sql.Time.valueOf(request.getDeadlineHour()));
            stmt.setString(6, request.getContent());
            stmt.setString(7, request.getCourseIds());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public Integer getMenteeIdByUserId(int userId) {
        int menteeId = -1;
        String sql = "SELECT id \n"
                + "FROM Mentee \n"
                + "WHERE user_id = ?;";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                menteeId = rs.getInt("id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return menteeId;
    }

    public List<Request> getAllRequest(int menteeId) {
        ArrayList<Request> listRequest = new ArrayList<>();
        String query = "SELECT [id]\n"
                + "      ,[mentee_id]\n"
                + "      ,[title]\n"
                + "      ,[deadline_date]\n"
                + "      ,[deadline_hour]\n"
                + "      ,[content]\n"
                + "      ,[status]\n"
                + "      ,[created_at]\n"
                + "      ,[updated_at]\n"
                + "      ,[course_ids]\n"
                + "  FROM [SWP1].[dbo].[Request]\n"
                + "  WHERE mentee_id = ? ORDER BY created_at DESC";

        try {
            PreparedStatement connect = conn.prepareStatement(query);
            connect.setInt(1, menteeId);
            ResultSet result = connect.executeQuery();
            while (result.next()) {
                Request request = new Request();
                request.setId(result.getInt("id"));
                request.setMenteeId(result.getInt("mentee_id"));
                request.setTitle(result.getString("title"));
                request.setDeadlineDate(result.getDate("deadline_date").toLocalDate());
                request.setDeadlineHour(result.getTime("deadline_hour").toLocalTime());
                request.setContent(result.getString("content"));
                request.setStatus(result.getString("status"));
                request.setCreatedAt(result.getTimestamp("created_at").toLocalDateTime());
                request.setUpdatedAt(result.getTimestamp("updated_at").toLocalDateTime());
                request.setCourseIds(result.getString("course_ids"));
                listRequest.add(request);
            }
            result.close();
            connect.close();
        } catch (Exception e) {
                e.printStackTrace();
        }
        return listRequest;
    }

    public static void main(String[] args) {
        DAORequest dao = new DAORequest();
//         LocalDate validDate = LocalDate.of(2025, 2, 18);
//    LocalTime validTime = LocalTime.of(12, 0);
//
//    dao.createRequest(3, "qqqqqqqqq", validDate, validTime, "tt", "open");
//        System.out.println(getMenteeIdByUserId(1));
//        int userId = 5; // Thay đổi giá trị này nếu cần test với user khác
//        int menteeId = dao.getMenteeIdByUserId(userId);
//
//        if (menteeId == -1) {
//            System.out.println("Không tìm thấy Mentee ID cho userId = " + userId);
//        } else {
//            System.out.println("Mentee ID tìm thấy: " + menteeId);
//        }
        List<Request> request = dao.getAllRequest(1);
        for (Request request1 : request) {
            System.out.println(request1);
        }
        
//        System.out.println(dao);
    }

}
