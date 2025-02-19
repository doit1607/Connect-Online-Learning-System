/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


import entity.Request;
import java.sql.PreparedStatement;
import java.sql.Date;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Acer
 */
public class DAORequest extends DBConnection {

//    public DAORequest() {
//        super(); // Gọi constructor của DBConnection để mở kết nối
//        System.out.println("DEBUG: DAORequest - conn = " + conn);
//    }

//    public void createRequest(int id, String title, LocalDate deadlineDate, LocalTime deadlineHour, String content, String status) {
//        String sql = "INSERT INTO Request (mentee_id, title, deadline_date, deadline_hour, content, status) VALUES (?, ?, ?, ?, ?, ?)";
//
//        try {
//            PreparedStatement statement = conn.prepareStatement(sql);
//            statement.setInt(1, id);
//            statement.setString(2, title);
//            statement.setDate(3, Date.valueOf(deadlineDate));
//            statement.setTime(4, java.sql.Time.valueOf(deadlineHour));
//            statement.setString(5, content);
//            statement.setString(6, status);
//
//            int rowsInserted = statement.executeUpdate();
//            if (rowsInserted > 0) {
//                System.out.println("Request thanh cong");
//            } else {
//                System.out.println("khong thanh cong");
//            }
//
//            statement.close(); // Đóng statement
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
     public boolean createRequest(Request request) {
        String sql = "INSERT INTO Request (mentee_id, title, deadline_date, deadline_hour, content, status, course_ids) VALUES (?, ?, ?, ?, ?, 'Open', ?)";
        try {
             PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, request.getMenteeId());
            stmt.setString(2, request.getTitle());
            stmt.setDate(3, Date.valueOf(request.getDeadlineDate()));
            stmt.setTime(4, java.sql.Time.valueOf(request.getDeadlineHour()));
            stmt.setString(5, request.getContent());
            stmt.setString(6, request.getCourseId());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public void updateRequestStatus(int requestId, String status) {
        String sql = "UPDATE Request SET status = ?, updated_at = GETDATE() WHERE id = ?";
        try {
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, status);
            statement.setInt(2, requestId);
            statement.executeUpdate();
        } catch (Exception e) {
        }
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
                request.setCourseId(result.getString("course_ids"));
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
