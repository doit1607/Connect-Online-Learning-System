/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Request;
import java.security.Timestamp;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.sql.Date;
import java.time.LocalDateTime;
import java.util.List;
import model.DBConnection;
import static model.DBConnection.conn;

public class DAORequest extends DBConnection {

    public List<Request> getRequestByMentor(String mentor, String title, String status, LocalDate date, int page, int limit) {
        List<Request> requests = new ArrayList<>();
        int offset = (page - 1) * limit;

        StringBuilder sql = new StringBuilder(
                "SELECT r.id, r.mentee_id, r.mentor_id, u.username AS mentor_name, "
                + "r.title, r.start_date, r.end_date, r.content, r.status, "
                + "r.created_at, r.updated_at, r.course_id "
                + "FROM Request r "
                + "JOIN Mentor m ON r.mentor_id = m.id "
                + "JOIN [Users] u ON m.user_id = u.id "
                + "WHERE u.username = ? and r.status != 'draft'"
        );

        // Add filters dynamically
        if (date != null) {
            sql.append("AND r.created_at >= ? ");
        }
        if (status != null && !status.isEmpty()) {
            sql.append("AND r.status = ? ");
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
            if (status != null && !status.isEmpty()) {
                preparedStatement.setString(index++, status);
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

    public int getRequestCount(String mentor, String title, String status, LocalDate date) {
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
        if (status != null && !status.isEmpty()) {
            sql.append("AND r.status = ? ");
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
            if (status != null && !status.isEmpty()) {
                preparedStatement.setString(index++, status);
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

    public int insertRequestAndGetId(Request request) throws SQLException {
        String sql = "INSERT INTO Request (mentee_id, mentor_id, title, total_slot, totalprice, start_date, end_date, content, status, course_id) "
                + "OUTPUT INSERTED.id "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
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

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1); // Trả về ID của request vừa chèn
        }
        return -1;
    }

    // Lấy request theo ID
    public Request getRequestById(int id) {
        String sql = "SELECT * FROM Request WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Request(
                        rs.getInt("id"),
                        rs.getInt("mentee_id"),
                        rs.getInt("mentor_id"),
                        rs.getString("title"),
                        rs.getInt("total_slot"),
                        rs.getDate("start_date").toLocalDate(),
                        rs.getDate("end_date").toLocalDate(),
                        rs.getString("content"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getTimestamp("updated_at").toLocalDateTime(),
                        rs.getInt("course_id")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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

        String query = "SELECT r.[id], r.[mentee_id], r.[mentor_id], r.[title] AS request_title, "
                + "r.[total_slot], r.[start_date], r.[end_date], r.[content], r.[status], "
                + "r.[created_at], r.[updated_at], r.[course_id], r.[totalPrice], "
                + "c.[title] AS course_title, m.[name] AS mentor_name "
                + "FROM [SWP1].[dbo].[Request] r "
                + "JOIN [SWP1].[dbo].[Course] c ON r.course_id = c.id "
                + "JOIN [SWP1].[dbo].[Mentor] m ON r.mentor_id = m.user_id "
                + "WHERE r.mentee_id = ?"
                + "ORDER BY r.created_at DESC";

        try {
            PreparedStatement connect = conn.prepareStatement(query);
            connect.setInt(1, menteeId);
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

    // Hien thi cho manager tat ca request cua Mentee (Dung)
    public List<Request> showAllRequest() {
        List<Request> listReq = new ArrayList<>();
        String sql = "SELECT r.id, u.username, r.title, r.status FROM Request r \n"
                + "JOIN Mentee m ON r.mentee_id = m.id\n"
                + "JOIN Users u ON m.user_id = u.id\n"
                + "ORDER BY r.created_at DESC";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Request request = new Request();
                request.setId(rs.getInt("id"));
                request.setUserMentee(rs.getString("username"));
                request.setTitle(rs.getString("title"));
                request.setStatus(rs.getString("status"));
                listReq.add(request);
            }
        } catch (Exception e) {
        }
        return listReq;
    }

    // Dung de tim kiem va loc (Dung)
    public List<Request> getRequests(String search, String status, LocalDate startDate, LocalDate endDate) {
        List<Request> listRep = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT r.id, u.username, r.title, r.status "
                + "FROM Request r "
                + "JOIN Mentee m ON r.mentee_id = m.id "
                + "JOIN Users u ON m.user_id = u.id "
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
                    request.setTitle(rs.getString("title"));
                    request.setStatus(rs.getString("status"));
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

    public static void main(String[] args) {
        DAORequest dao = new DAORequest();
        List<Request> list = dao.getAllRequest(1);
        System.out.println(list);

//        LocalDate validDate = LocalDate.of(2025, 2, 18);
//        LocalDate validDate1 = LocalDate.of(2025, 2, 28);
////
////      dao.createRequest(3, "qqqqqqqqq", validDate, validTime, "tt", "open");
////      System.out.println(getMenteeIdByUserId(1));
//        int userId = 5; // Thay đổi giá trị này nếu cần test với user khác
//        int menteeId = dao.getMenteeIdByUserId(userId);
//
//        if (menteeId == -1) {
//            System.out.println("Không tìm thấy Mentee ID cho userId = " + userId);
//        } else {
//            System.out.println("Mentee ID tìm thấy: " + menteeId);
//        }
//        List<Request> request = dao.getAllRequest(2);
//        for (Request request1 : request) {
//            System.out.println(request1);
//        }
//        Request re = new Request(1, 1, "qqqqqqqqq", 5, validDate, validDate1, "yyyyyy", "Draft", 1);
//        dao.insertRequest(re);
//        System.out.println(dao);
    }

}
