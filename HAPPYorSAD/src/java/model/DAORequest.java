/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Request;
//import entity.MentorSchedule;
import java.lang.System.Logger;
import java.security.Timestamp;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.sql.Date;
import java.util.Collections;
import java.util.HashMap;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import model.DBConnection;
import static model.DBConnection.conn;

public class DAORequest extends DBConnection {


    public void updateRequestTotalPrice(int requestId, double finalPrice) throws SQLException {
        String sql = "UPDATE request SET totalprice = ? WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, finalPrice);
            ps.setInt(2, requestId);
            ps.executeUpdate();
        }
    }

    public void updateRequestStatus(int requestId, String status) throws SQLException {
        String sql = "UPDATE request SET status = ? WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, requestId);
            ps.executeUpdate();
        }
    }

    public List<Request> getRequestByMentor(String mentor, String title, String[] status, LocalDate date, int page, int limit) {
        List<Request> requests = new ArrayList<>();
        int offset = (page - 1) * limit;

        StringBuilder sql = new StringBuilder(
                "SELECT r.id, r.mentee_id, r.mentor_id, u.username AS mentor_name, "
                + "r.title, r.start_date, r.end_date, r.content, r.status, "
                + "r.created_at, r.updated_at, r.course_id "
                + "FROM Request r "
                + "JOIN Mentor m ON r.mentor_id = m.id "
                + "JOIN [Users] u ON m.user_id = u.id "
                + "WHERE u.username = ? AND r.status != 'draft' "
        );

        // Add filters dynamically
        if (date != null) {
            sql.append("AND r.created_at >= ? ");
        }
        if (status != null && status.length > 0) {
            sql.append("AND r.status IN (");
            sql.append(String.join(", ", Collections.nCopies(status.length, "?"))); // Tạo danh sách ?, ?, ?
            sql.append(") ");
        }
        if (title != null && !title.isEmpty()) {
            sql.append("AND r.title LIKE ? ");
        }

        // Add pagination
        sql.append("ORDER BY r.end_date ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement preparedStatement = conn.prepareStatement(sql.toString())) {
            int index = 1;
            preparedStatement.setString(index++, mentor);

            if (date != null) {
                preparedStatement.setDate(index++, java.sql.Date.valueOf(date));
            }
            if (status != null && status.length > 0) {
                for (String s : status) {
                    preparedStatement.setString(index++, s);
                }
            }
            if (title != null && !title.isEmpty()) {
                preparedStatement.setString(index++, "%" + title + "%"); // Fix LIKE query
            }

            preparedStatement.setInt(index++, offset);
            preparedStatement.setInt(index, limit);

            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    Request request = new Request(
                            rs.getInt("id"),
                            rs.getInt("mentee_id"),
                            rs.getInt("mentor_id"),
                            rs.getString("title"),
                            rs.getDate("start_date").toLocalDate(),
                            rs.getDate("end_date").toLocalDate(),
                            rs.getString("content"),
                            rs.getString("status"),
                            rs.getTimestamp("created_at").toLocalDateTime(),
                            rs.getTimestamp("updated_at").toLocalDateTime(),
                            rs.getInt("course_id")
                    );
                    requests.add(request);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return requests;
    }

    public Integer getMentorIdByRequestId(int requestId) {
        String sql = "SELECT mentor_id FROM Request WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, requestId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("mentor_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy
    }

    public int getRequestCount(String mentor, String title, String[] status, LocalDate date) {
        int count = 0;

        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) AS total_count "
                + "FROM Request r "
                + "JOIN Mentor m ON r.mentor_id = m.id "
                + "JOIN [Users] u ON m.user_id = u.id "
                + "WHERE u.username = ? "
        );

        // Add filters dynamically
        if (date != null) {
            sql.append("AND r.created_at >= ? ");
        }
        if (status != null && status.length > 0) {
            sql.append("AND r.status IN (");
            sql.append(String.join(", ", Collections.nCopies(status.length, "?"))); // Dynamic placeholders
            sql.append(") ");
        }
        if (title != null && !title.isEmpty()) {
            sql.append("AND r.title LIKE ? ");
        }

        try (PreparedStatement preparedStatement = conn.prepareStatement(sql.toString())) {
            int index = 1;
            preparedStatement.setString(index++, mentor);

            if (date != null) {
                preparedStatement.setDate(index++, java.sql.Date.valueOf(date));
            }
            if (status != null && status.length > 0) {
                for (String s : status) {
                    preparedStatement.setString(index++, s);
                }
            }
            if (title != null && !title.isEmpty()) {
                preparedStatement.setString(index++, "%" + title + "%"); // Fix LIKE query
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
    public int getRequestCount(String status) {
        int count = 0;

        String sql = "SELECT COUNT(*) AS total_count FROM Request r Where r.status = ?";
        


        try (PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
            preparedStatement.setString(1, status);
            

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

    public void updateRequestStatus1(int requestId, String status) throws SQLException {
        String sql = "UPDATE Request SET status = ?, updated_at = GETDATE() WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, requestId);
        ps.executeUpdate();
    }

    public boolean insertRequest(Request request) {
        String sql = "INSERT INTO Request (mentee_id,mentor_id,title,total_slot,start_date,end_date,content,status,course_id,totalprice) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?,?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, request.getMenteeId());
            stmt.setInt(2, request.getMentorId());
            stmt.setString(3, request.getTitle());
            stmt.setInt(4, request.getTotalSlot());

            stmt.setDate(5, java.sql.Date.valueOf(request.getStartDate()));
            stmt.setDate(6, java.sql.Date.valueOf(request.getEndDate()));

            stmt.setString(7, request.getContent());
            stmt.setString(8, request.getStatus());
            stmt.setInt(9, request.getCourseId());
            stmt.setDouble(10, request.gettotalprice());
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int insertRequestAndGetId(Request request) {
        String sql = "INSERT INTO Request (mentee_id, mentor_id, title, total_slot, totalprice, start_date, end_date, content, status, course_id) "
                + "OUTPUT INSERTED.id "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        int generatedId = -1;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, request.getMenteeId());
            ps.setInt(2, request.getMentorId());
            ps.setString(3, request.getTitle());
            ps.setInt(4, request.getTotalSlot());
            ps.setDouble(5, request.getTotalprice());
            ps.setObject(6, request.getStartDate());
            ps.setObject(7, request.getEndDate());
            ps.setString(8, request.getContent());
            ps.setString(9, request.getStatus());
            ps.setInt(10, request.getCourseId());

            System.out.println("SQL: " + sql + " Request: " + request);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    generatedId = rs.getInt(1); // Lấy ID của request vừa chèn
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Ghi log lỗi
        }

        return generatedId;
    }

    // Lấy request theo ID
    public Request getRequestById(int id) {
        String sql = "SELECT * FROM Request WHERE id = ?";
        Request request = new Request(); // Khởi tạo đối tượng rỗng

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                request.setId(rs.getInt("id"));
                request.setMenteeId(rs.getInt("mentee_id"));
                request.setMentorId(rs.getInt("mentor_id"));
                request.setTitle(rs.getString("title"));
                request.setTotalSlot(rs.getInt("total_slot"));
                request.setStartDate(rs.getDate("start_date").toLocalDate());
                request.setEndDate(rs.getDate("end_date").toLocalDate());
                request.setContent(rs.getString("content"));
                request.setStatus(rs.getString("status"));
                request.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                request.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
                request.setCourseId(rs.getInt("course_id"));
                request.setTotalprice(rs.getDouble("totalPrice"));

                return request;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null; // Trả về null nếu không tìm thấy request
    }

    public boolean updateRequest(Request req) {
        String sql = "UPDATE Request SET title=?, total_slot=?, start_date=?, end_date=?, content=?, totalPrice=?, updated_at=GETDATE(),status =? WHERE id=? ";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, req.getTitle());
            stmt.setInt(2, req.getTotalSlot());
            stmt.setDate(3, java.sql.Date.valueOf(req.getStartDate()));
            stmt.setDate(4, java.sql.Date.valueOf(req.getEndDate()));
            stmt.setString(5, req.getContent());
            stmt.setDouble(6, req.gettotalprice());
            stmt.setInt(8, req.getId());
            stmt.setString(7, req.getStatus());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateRequestSubmit(Request req) {
        String sql = "UPDATE Request SET title=?, total_slot=?, start_date=?, end_date=?, content=?, totalPrice=?, updated_at=GETDATE() WHERE id=? AND status='Draft'";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, req.getTitle());
            stmt.setInt(2, req.getTotalSlot());
            stmt.setDate(3, java.sql.Date.valueOf(req.getStartDate()));
            stmt.setDate(4, java.sql.Date.valueOf(req.getEndDate()));
            stmt.setString(5, req.getContent());
            stmt.setDouble(6, req.gettotalprice());
            stmt.setInt(7, req.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lay ID cua Mentee boi User_ID
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

    // Lay ID cua Mentor boi User_ID
    public Integer getMentorIdByUserId(int userId) {
        int mentorId = -1;
        String sql = "select id from Mentor where user_id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                mentorId = rs.getInt("id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mentorId;
    }

    public List<Request> getAllRequest(int menteeId, int index) {
        ArrayList<Request> listRequest = new ArrayList<>();

        String query = "SELECT r.[id], r.[mentee_id], r.[mentor_id], r.[title] AS request_title, "
                + "r.[total_slot], r.[start_date], r.[end_date], r.[content], r.[status], "
                + "r.[created_at], r.[updated_at], r.[course_id], r.[totalPrice], "
                + "c.[title] AS course_title, m.[name] AS mentor_name "
                + "FROM [SWP1].[dbo].[Request] r "
                + "JOIN [SWP1].[dbo].[Course] c ON r.course_id = c.id "
                + "JOIN [SWP1].[dbo].[Mentor] m ON r.mentor_id = m.user_id "
                + "WHERE r.mentee_id = ? order by created_at desc "
                + "offset ? rows fetch next 10 rows only";

        try {
            PreparedStatement connect = conn.prepareStatement(query);
            connect.setInt(1, menteeId);
            connect.setInt(2, (index - 1) * 10);
            ResultSet result = connect.executeQuery();

            while (result.next()) {
                Request request = new Request();
                request.setId(result.getInt("id"));
                request.setMenteeId(result.getInt("mentee_id"));
                request.setMentorId(result.getInt("mentor_id"));

                // Lấy title từ bảng Request
                request.setTitle(result.getString("request_title"));

                request.setTotalSlot(result.getInt("total_slot"));
                request.setStartDate(result.getDate("start_date").toLocalDate());
                request.setEndDate(result.getDate("end_date").toLocalDate());
                request.setContent(result.getString("content"));
                request.setStatus(result.getString("status"));
                request.setCreatedAt(result.getTimestamp("created_at").toLocalDateTime());
                request.setUpdatedAt(result.getTimestamp("updated_at").toLocalDateTime());
                request.setCourseId(result.getInt("course_id"));

                // Lấy totalPrice từ bảng Request
                request.settotalprice(result.getDouble("totalPrice"));

                // Lấy title từ bảng Course
                request.setCoursename(result.getString("course_title"));

                // Lấy name từ bảng Mentor
                request.setMentorname(result.getString("mentor_name"));

                listRequest.add(request);
            }

            result.close();
            connect.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listRequest;
    }

    // dem so luong request
    public int getTotalRequest() {
        String sql = "select count(*) from Request";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    // Hien thi cho manager tat ca request cua Mentee (Dung)
    public List<Request> showAllRequest(int index) {
        List<Request> listReq = new ArrayList<>();
        String sql = "SELECT r.id, u.username, r.title AS request_title, r.totalPrice, r.status, "
                + "c.title AS course_title, m2.name AS mentor_name "
                + "FROM Request r \n"
                + "JOIN Mentee m ON r.mentee_id = m.id\n"
                + "JOIN Users u ON m.user_id = u.id\n"
                + "JOIN Course c ON r.course_id = c.id\n"
                + "JOIN Mentor m2 ON r.mentor_id = m2.user_id\n"
                + "WHERE r.status != 'Draft'\n"
                + "ORDER BY r.created_at DESC\n"
                + "offset ? rows fetch next 10 rows only";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, (index - 1) * 10);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Request request = new Request();
                request.setId(rs.getInt("id"));
                request.setUserMentee(rs.getString("username"));
                request.setTitle(rs.getString("request_title"));
                request.setTotalprice(rs.getDouble("totalPrice"));
                request.setStatus(rs.getString("status"));
                request.setCoursename(rs.getString("course_title"));
                request.setMentorname(rs.getString("mentor_name"));
                listReq.add(request);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listReq;
    }

    // Dung de tim kiem va loc (Dung)
    public List<Request> getAllRequests(String search, String status, LocalDate startDate, LocalDate endDate) {
        List<Request> listRep = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT r.id, r.content, r.total_slot ,u.username, r.title AS request_title, r.totalPrice, r.status, "
                + "c.title AS course_title, m2.name AS mentor_name "
                + "FROM Request r "
                + "JOIN Mentee m ON r.mentee_id = m.id "
                + "JOIN Users u ON m.user_id = u.id "
                + "JOIN Course c ON r.course_id = c.id "
                + "JOIN Mentor m2 ON r.mentor_id = m2.user_id "
                + "WHERE 1=1");

        if (search != null && !search.isEmpty()) {
            sql.append(" AND u.username LIKE ?");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND r.status = ?");
        }
        if (startDate != null) {
            sql.append(" AND CONVERT(DATE, r.start_date) >= ?");
        }
        if (endDate != null) {
            sql.append(" AND CONVERT(DATE, r.end_date) <= ?");
        }
        sql.append(" ORDER BY r.created_at DESC");

        try (PreparedStatement pre = conn.prepareStatement(sql.toString())) {
            int index = 1;
            if (search != null && !search.isEmpty()) {
                pre.setString(index++, "%" + search + "%");
            }
            if (status != null && !status.isEmpty()) {
                pre.setString(index++, status);
            }
            if (startDate != null) {
                pre.setDate(index++, Date.valueOf(startDate));
            }
            if (endDate != null) {
                pre.setDate(index++, Date.valueOf(endDate));
            }

            try (ResultSet rs = pre.executeQuery()) {
                while (rs.next()) {
                    Request request = new Request();
                    request.setId(rs.getInt("id"));
                    request.setUserMentee(rs.getString("username"));
                    request.setTitle(rs.getString("request_title"));
                    request.setTotalprice(rs.getDouble("totalPrice"));
                    request.setStatus(rs.getString("status"));
                    request.setCoursename(rs.getString("course_title"));
                    request.setMentorname(rs.getString("mentor_name"));
                    request.setContent(rs.getString("content"));
                    request.setTotalSlot(rs.getInt("total_slot"));
                    listRep.add(request);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listRep;
    }

    // Dung cho Request Detail by ID
    public Request requestById(int id) {
        String sql = "select u.username, c.title as [courseName], r.title,  r.content, r.total_slot, r.start_date, r.end_date, r.created_at from Request r\n"
                + "join Course c on r.course_id = c.id\n"
                + "join Mentee m on r.mentee_id = m.id\n"
                + "join Users u on m.user_id = u.id where r.id = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return new Request(rs.getString("username"),
                        rs.getString("courseName"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getInt("total_slot"),
                        rs.getDate("start_date").toLocalDate(),
                        rs.getDate("end_date").toLocalDate(),
                        rs.getTimestamp("created_at").toLocalDateTime());
            }
        } catch (Exception e) {
        }
        return null;
    }

    public boolean addRejectReason(int requestId, String reason) {
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

    public double getTotalReceivedAmountByMentor(String mentor) {
        double totalAmount = 0.0;

        String sql = "SELECT COALESCE(SUM(c.price), 0) AS total_received "
                + "FROM Request r "
                + "JOIN Mentor m ON r.mentor_id = m.id "
                + "JOIN [Users] u ON m.user_id = u.id "
                + "JOIN Course c ON r.course_id = c.id "
                + "WHERE u.username = ? AND r.status = 'Closed'";

        try (PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
            preparedStatement.setString(1, mentor);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    totalAmount = rs.getDouble("total_received");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalAmount;
    }

    public List<Integer> getRequestByYear(String username, int year) {
        // Khởi tạo danh sách với 12 tháng, mặc định là 0
        List<Integer> requestData = new ArrayList<>(Collections.nCopies(12, 0));

        String sql = "SELECT MONTH(r.created_at) AS month, COUNT(*) AS total_requests "
                + "FROM Request r "
                + "JOIN Mentor m ON m.id = r.mentor_id "
                + "JOIN Users u ON u.id = m.user_id "
                + "WHERE YEAR(r.created_at) = ? AND u.username = ? "
                + "GROUP BY MONTH(r.created_at) "
                + "ORDER BY MONTH(r.created_at)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, year);
            stmt.setString(2, username);

            ResultSet rs = stmt.executeQuery();

            // Sử dụng Map để lưu dữ liệu tạm thời
            Map<Integer, Integer> monthData = new HashMap<>();
            while (rs.next()) {
                int month = rs.getInt("month");
                int count = rs.getInt("total_requests");
                monthData.put(month, count);
            }

            // Đưa dữ liệu từ Map vào List
            for (int i = 1; i <= 12; i++) {
                requestData.set(i - 1, monthData.getOrDefault(i, 0));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return requestData;
    }

//    // Request cua mentor cho manager
//    public List<MentorSchedule> getMentorSchedule() {
//        List<MentorSchedule> schedule = new ArrayList<>();
//        String sql = "select ms.id as [schedule_id], u.username, Month(s.start_date) as [month], s.created_at, ms.status from Users u\n"
//                + "join Mentor m on u.id = m.user_id\n"
//                + "join Mentor_Schedule ms on m.id = ms.mentor_id\n"
//                + "join Schedule s on ms.schedule_id = s.id\n"
//                + "where ms.status = 'Pending' order by s.created_at desc";
//        try {
//            PreparedStatement pre = conn.prepareStatement(sql);
//            ResultSet rs = pre.executeQuery();
//            while (rs.next()) {
//                schedule.add(new MentorSchedule(
//                        rs.getInt("schedule_id"),
//                        rs.getString("username"),
//                        rs.getInt("month"),
//                        rs.getTimestamp("created_at").toLocalDateTime(),
//                        rs.getString("status")));
//            }
//        } catch (Exception e) {
//        }
//        return schedule;
//    }
    // update trang thai lich day cho Mentor
    public boolean updateSchedule(int id, String status) {
        String sql = "update Mentor_Schedule set status = ? where schedule_id = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, status);
            pre.setInt(2, id);
            int rowsUpdated = pre.executeUpdate();
            return rowsUpdated > 0; // tra ve true neu co it nhat 1 dong bi anh huong
        } catch (Exception e) {
        }
        return false;
    }

    // Reject schedule
    public void rejectSchedule(String username, String reason) {
        String sql = "UPDATE Mentor_Schedule SET status = 'Rejected' WHERE schedule_id = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            pre.executeUpdate();
//            saveNotification(username, "Schedule has been rejected. Reason: " + reason);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

//    // thong bao cho Mentor sau khi Schedule bi reject
//    public void saveNotification(String username, String message) {
//        String sql = "INSERT INTO NotificationForCV (username, message, created_at) VALUES (?, ?, GETDATE())";
//        try {
//            PreparedStatement pre = conn.prepareStatement(sql);
//            pre.setString(1, username);
//            pre.setString(2, message);
//            pre.executeUpdate();
//        } catch (Exception e) {
//        }
//    }
    public List<Request> getRequestByStatus(int menteeId, String status, int index) {
        List<Request> list = new ArrayList<>();
        String sql = "SELECT * FROM Request WHERE mentee_id = ? AND status = ? ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, menteeId);
            ps.setString(2, status);
            ps.setInt(3, (index - 1) * 10);
            ResultSet result = ps.executeQuery();
            while (result.next()) {
                Request request = new Request();
                request.setId(result.getInt("id"));
                request.setMenteeId(result.getInt("mentee_id"));
                request.setMentorId(result.getInt("mentor_id"));
                request.setTitle(result.getString("title"));
                request.setTotalSlot(result.getInt("total_slot"));
                request.setStartDate(result.getDate("start_date").toLocalDate());
                request.setEndDate(result.getDate("end_date").toLocalDate());
                request.setContent(result.getString("content"));
                request.setStatus(result.getString("status"));
                request.setCreatedAt(result.getTimestamp("created_at").toLocalDateTime());
                request.setUpdatedAt(result.getTimestamp("updated_at").toLocalDateTime());
                request.setCourseId(result.getInt("course_id"));
                request.settotalprice(result.getDouble("totalPrice"));
                list.add(request);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    //for admin
    public double getTotalReceivedAmount() {
        double totalAmount = 0.0;

        String sql = "SELECT COALESCE(SUM(c.price), 0) AS total_received "
                + "FROM Request r "
                + "JOIN Course c ON r.course_id = c.id "
                + "WHERE r.status = 'Closed'";

        try (PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
            
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    totalAmount = rs.getDouble("total_received");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalAmount;
    }

    public static void main(String[] args) {
        DAORequest dao = new DAORequest();

//        try {
//            dao.updateRequestStatus(745, "Processing");
////        System.out.println(dao);
//        } catch (SQLException ex) {
//            java.util.logging.Logger.getLogger(DAORequest.class.getName()).log(Level.SEVERE, null, ex);
//        }
         List<Request> list = dao.getRequestByStatus(1, "Open", 10);
         System.out.println(list);
    }

}
