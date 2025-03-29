package model;

import entity.Mentor;
import entity.Mentor1;
import entity.MentorDTO;
import entity.User;
import java.util.ArrayList;
import java.util.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Dell
 */
public class DAOMentor extends DBConnection {

    public static DAOuser userDao = new DAOuser();

    public List<Mentor> getMentorsWithSchedulesByStatus(String status) throws SQLException {
        List<Mentor> mentors = new ArrayList<>();
        String sql = "				 SELECT DISTINCT m.id, m.name \n"
                + "                 FROM Mentor m \n"
                + "                 JOIN Mentor_Slot ms ON m.id = ms.mentor_id \n"
                + "                 WHERE ms.status = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Mentor mentor = new Mentor();
                mentor.setMentorId(rs.getInt("id"));
                mentor.setName(rs.getString("name"));
                mentors.add(mentor);
            }

        }
        return mentors;
    }
    
     public List<Mentor> getMentorsWithSchedulesALL() throws SQLException {
        List<Mentor> mentors = new ArrayList<>();
        String sql = "				 SELECT DISTINCT m.id, m.name \n"
                + "                 FROM Mentor m \n"
                + "                 JOIN Mentor_Slot ms ON m.id = ms.mentor_id \n";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Mentor mentor = new Mentor();
                mentor.setMentorId(rs.getInt("id"));
                mentor.setName(rs.getString("name"));
                mentors.add(mentor);
            }

        }
        return mentors;
    }
     

    public List<Mentor> getMentorsWithSchedulesInMonth(int month) throws SQLException {
        List<Mentor> mentors = new ArrayList<>();
        String sql = "SELECT DISTINCT m.id, m.name\n"
                + "                 FROM Mentor m \n"
                + "                 JOIN Mentor_Slot ms ON m.id = ms.mentor_id \n"
                + "				 join Slot sl on sl.id = ms.slot_id\n"
                + "                 WHERE MONTH(sl.slot_date) = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, month);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Mentor mentor = new Mentor();
                mentor.setMentorId(rs.getInt("id"));
                mentor.setName(rs.getString("name"));
                mentors.add(mentor);
            }
        }
        return mentors;
    }

    public static Integer getMentorIdByUserId(int userId) {
        String sql = "SELECT id FROM Mentor WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Mentor> getMentorsWithPendingSchedules() {
        List<Mentor> mentors = new ArrayList<>();
        String sql = "SELECT DISTINCT m.id as mentorId, m.name -- Chỉ chọn các cột có thể so sánh\n"
                + "FROM mentor m\n"
                + "JOIN mentor_slot ms ON m.id = ms.mentor_id\n"
                + "WHERE ms.status = 'nonAvailable';";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Mentor mentor = new Mentor();
                mentor.setMentorId(rs.getInt("mentorId"));
                mentor.setName(rs.getString("name"));
                // Map các trường khác nếu cần
                mentors.add(mentor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mentors;
    }

    public int getMentorIdByNameOrId(String searchQuery) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            String sql = "SELECT id FROM Mentor WHERE name LIKE ? OR CAST(id AS VARCHAR) = ?";
            pstmt = conn.prepareStatement(sql);
            String pattern = "%" + searchQuery + "%";
            pstmt.setString(1, pattern);
            pstmt.setString(2, searchQuery);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
        }
        return -1;
    }

    public String getMentorNameById(int mentorId) {
        String sql = "SELECT name FROM Mentor WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, mentorId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Mentor> getAllMentor() {
        List<Mentor> mentors = new ArrayList<>();
        String sql = "SELECT id, name, image FROM Mentor"; // Điều chỉnh cột theo bảng của bạn

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Mentor mentor = new Mentor();
                mentor.setMentorId(rs.getInt("id"));
                mentor.setName(rs.getString("name"));
                mentor.setImage(rs.getString("image"));
                mentors.add(mentor);
            }
            System.out.println("Successfully retrieved " + mentors.size() + " mentors.");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mentors;
    }

    public List<Mentor1> getAllMentors(String search, int pageNumber, int pageSize) {
        List<Mentor1> list = new ArrayList<>();

        if (pageSize <= 0) {
            pageSize = 10;
        }

        int offset = (pageNumber - 1) * pageSize; // Tính toán offset

        String sql = "SELECT m.id, m.name, m.email, m.rating, m.is_deleted, "
                + "m.reviews, m.price_per_slot, m.expertise, m.bio, m.created_at, m.base_rate, m.multiplier,m.image, m.user_id "
                + "FROM Mentor m "
                + "JOIN Users u ON m.user_id = u.id "
                + "WHERE (LOWER(m.name) LIKE LOWER(?) OR LOWER(m.email) LIKE LOWER(?) OR LOWER(m.expertise) LIKE LOWER(?)) "
                + "ORDER BY m.id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            String searchParam = "%" + search.toLowerCase() + "%";
            stmt.setString(1, searchParam);
            stmt.setString(2, searchParam);
            stmt.setString(3, searchParam);
            stmt.setInt(4, offset);
            stmt.setInt(5, pageSize);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Mentor1 mentor = new Mentor1();
                    mentor.setId(rs.getInt("id"));
                    mentor.setName(rs.getString("name"));
                    mentor.setEmail(rs.getString("email"));
                    mentor.setRating(rs.getDouble("rating"));
                    mentor.setIsDeleted(rs.getBoolean("is_deleted"));
                    mentor.setReviews(rs.getString("reviews"));
                    mentor.setPricePerSlot(rs.getDouble("price_per_slot"));
                    mentor.setExpertise(rs.getString("expertise"));
                    mentor.setBio(rs.getString("bio"));
                    mentor.setCreatedAt(rs.getDate("created_at"));
                    mentor.setBaseRate(rs.getDouble("base_rate"));
                    mentor.setMultiplier(rs.getDouble("multiplier"));
                    mentor.setImage(rs.getString("image"));

                    User user = userDao.getMentorById(rs.getInt("user_id"));
                    mentor.setUser(user);

                    list.add(mentor);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public Mentor getMentorBySlotId(String slotDate, int slotNumberId) {
        String sql = "SELECT m.name, m.image, m.email \n"
                + "FROM Slot sl \n"
                + "JOIN Mentor m ON m.id = sl.mentor_id \n"
                + "WHERE sl.slot_date = ? and sl.slot_number_id=?";
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

    public int getTotalMentors(String search) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Mentor WHERE LOWER(name) LIKE LOWER(?) OR LOWER(email) LIKE LOWER(?) OR LOWER(expertise) LIKE LOWER(?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            String searchParam = "%" + search.toLowerCase() + "%";
            stmt.setString(1, searchParam);
            stmt.setString(2, searchParam);
            stmt.setString(3, searchParam);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return total;
    }

    public void toggleMentorStatus(String userName, String newStatus) {
        String sql = "UPDATE Users SET status = ? WHERE username = ?";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setString(2, userName);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Mentor> getMentors() {
        List<Mentor> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "	m.id,\n"
                + "    u.fullname AS mentor_name,\n"
                + "	u.username as username,\n"
                + "    m.expertise,\n"
                + "    COALESCE(AVG(r.rating), 0) AS average_rating\n"
                + "FROM Mentor m\n"
                + "LEFT JOIN Mentor_Reviews r ON m.id = r.mentor_id\n"
                + "LEFT JOIN Users u ON r.mentee_id = u.id AND u.role = 'mentee'\n"
                + "GROUP BY u.fullname, m.expertise, u.username, m.id";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(new Mentor(rs.getInt("id"),
                            rs.getString("mentor_name"),
                            rs.getDouble("average_rating"), rs.getString("username"), rs.getString("expertise")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public String getMentorName(int id) {
        String name = null;
        String sql = "Select * from Mentor where user_id = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                name = rs.getString("name");
                return name;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return name;
    }

    public int getMentorUserid(int mentorId) {
        String sql = "SELECT user_id FROM Mentor WHERE id = ?";
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, mentorId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("user_id");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public String getMentorUsername(int id) {
        String sql = "SELECT username FROM Users WHERE id = ?";
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("username");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Mentor> getMentorsSuggestion() {
        List<Mentor> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    u.fullname,\n"
                + "    u.username,\n"
                + "    m.expertise,\n"
                + "    m.image,\n"
                + "    m.price_per_slot\n"
                + "FROM Mentor m\n"
                + "JOIN Users u ON m.user_id = u.id;";
        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(new Mentor(rs.getString("fullname"),
                        0.0,
                        rs.getDouble("price_per_slot"),
                        rs.getString("expertise"),
                        rs.getString("image"),
                        rs.getString("username"),
                        0,
                        0)
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Mentor> getCount() {
        ArrayList<Mentor> count = new ArrayList<>();
        String query = "SELECT COUNT(DISTINCT u_mentor.id) AS total_Mentor\n"
                + "FROM Users u_mentor\n"
                + "WHERE u_mentor.role = 'mentor' AND u_mentor.status = 'active';";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            ResultSet result = connect.executeQuery();
            while (result.next()) {
                int total_Mentor = result.getInt("total_Mentor");
                Mentor m = new Mentor(total_Mentor);
                count.add(m);
            }
            result.close();
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<Mentor> getMentorsHome() {
        List<Mentor> list = new ArrayList<>();
        String sql = "SELECT "
                + "    m.image, "
                + "    m.name, "
                + "    m.expertise, "
                + "    m.rating, "
                + "    COUNT(DISTINCT r.mentee_id) AS total_mentees, "
                + "    COUNT(r.rating) AS rating_count "
                + "FROM Mentor m "
                + "LEFT JOIN Mentor_Reviews r ON m.id = r.mentor_id "
                + "LEFT JOIN Users u ON r.mentee_id = u.id AND u.role = 'mentee' "
                + "GROUP BY m.image, m.name, m.expertise, m.rating "
                + "ORDER BY total_mentees DESC, rating_count DESC, rating DESC";

        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(new Mentor(rs.getString("name"),
                        rs.getDouble("rating"), rs.getString("expertise"),
                        rs.getString("image"), rs.getInt("total_mentees"),
                        rs.getInt("rating_count"))
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Mentor> getMentorsByCourse(String title) {
        List<Mentor> list = new ArrayList<>();
        String sql = "SELECT\n"
                + "    m.image,\n"
                + "    m.name,\n"
                + "    m.expertise,\n"
                + "    m.rating,\n"
                + "    COUNT(DISTINCT r.mentee_id) AS total_mentees,\n"
                + "    COUNT(r.rating) AS rating_count\n"
                + "FROM Mentor m\n"
                + "LEFT JOIN Mentor_Reviews r ON m.id = r.mentor_id\n"
                + "LEFT JOIN Users u ON r.mentee_id = u.id AND u.role = 'mentee'\n"
                + "LEFT JOIN [MentorCourse] mc ON m.id = mc.mentor_id  \n"
                + "LEFT JOIN Course c ON mc.course_id = c.id   \n"
                + "WHERE 1=1  \n"
                + "  AND (c.title = ?) \n"
                + "GROUP BY m.image, m.name, m.expertise, m.rating\n"
                + "ORDER BY total_mentees DESC, rating_count DESC, rating DESC";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, title);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(new Mentor(
                            rs.getString("name"),
                            rs.getDouble("rating"),
                            rs.getString("expertise"),
                            rs.getString("image"),
                            rs.getInt("total_mentees"),
                            rs.getInt("rating_count"))
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // lay gia tien cua Mentor
    public static String getMentorPriceByID(int mentorId) {
        String sql = "select price_per_slot from Mentor where id = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, mentorId);
            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    int price = rs.getInt("price_per_slot");
                    return price > 0 ? String.valueOf(price) : "0";
                }
            }
        } catch (Exception e) {
        }
        return "0";
    }

    public Double getMentorPrice(int mentorId) {
        Double price = 0.0;
        String sql = "select price_per_slot from Mentor where id = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, mentorId);
            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    price = rs.getDouble("price_per_slot");
                }
            }
        } catch (Exception e) {
        }
        return price;
    }

    public void MentorCourse(int mentorId, int courseId) {
        String sql = "INSERT INTO MentorCourse (mentor_id, course_id) VALUES (?, ?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, mentorId);
            pre.setInt(2, courseId);
            pre.executeUpdate();
        } catch (Exception e) {
        }
    }

    public int getMentorByUserId(int userId) {
        String sql = "SELECT id \n"
                + "FROM Mentor \n"
                + "WHERE user_id = ?;";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public Mentor getMentorByID(int id) {
        Mentor mentor = null;
        String sql = "SELECT name, email, rating, bio, image FROM Mentor WHERE user_id = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    mentor = new Mentor();
                    mentor.setName(rs.getString("name"));
                    mentor.setEmail(rs.getString("email"));
                    mentor.setRating(rs.getInt("rating"));
                    mentor.setBio(rs.getString("bio"));
                    mentor.setImage(rs.getString("image"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mentor;
    }

    public Mentor getMentorByIdd(int id) {
        Mentor mentor = null;
        String sql = "SELECT m.name, m.email, m.rating, m.image,m.expertise, u.phone_number, u.username\n"
                + "FROM Mentor m\n"
                + "join Users u on m.user_id = u.id\n"
                + "WHERE m.id = ?\n"
                + "\n"
                + "group by m.name, m.email, m.rating,m.expertise, m.image, u.phone_number, u.username";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    mentor = new Mentor(rs.getString("name"),
                            rs.getString("email"),
                            rs.getInt("rating"),
                            rs.getString("expertise"),
                            rs.getString("image"),
                            rs.getString("phone_number"),
                            rs.getString("username"));

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mentor;
    }

    public boolean isMentorJoinedCourse(int mentorId, int courseId) {
        String sql = "SELECT COUNT(*) FROM MentorCourse WHERE mentor_id = ? AND course_id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, mentorId);
            ps.setInt(2, courseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Integer> getJoinedCoursesByMentorId(int mentorId) {
        List<Integer> joinedCourses = new ArrayList<>();
        String sql = "SELECT course_id FROM MentorCourse WHERE mentor_id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, mentorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                joinedCourses.add(rs.getInt("course_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return joinedCourses;
    }

    public Mentor1 getMentorById(int mentorId) {
        String query = "SELECT [id]\n"
                + "      ,[user_id]\n"
                + "      ,[name]\n"
                + "      ,[email]\n"
                + "      ,[rating]\n"
                + "      ,[is_deleted]\n"
                + "      ,[reviews]\n"
                + "      ,[price_per_slot]\n"
                + "      ,[expertise]\n"
                + "      ,[bio]\n"
                + "      ,[created_at]\n"
                + "      ,[base_rate]\n"
                + "      ,[multiplier]\n"
                + "      ,[image]\n"
                + "  FROM [SWP1].[dbo].[Mentor] WHERE id = ?";
        Mentor1 mentor = null;
        try {
            PreparedStatement stmt = conn.prepareStatement(query);

            stmt.setInt(1, mentorId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                mentor = new Mentor1(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getDouble("rating"),
                        rs.getBoolean("is_deleted"),
                        rs.getString("reviews"),
                        rs.getString("expertise"),
                        rs.getString("bio"),
                        rs.getDouble("base_rate"),
                        rs.getDouble("multiplier")
                );
                mentor.setImage(rs.getString("image"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mentor;
    }

    // Đếm số lượng mentor được review
    public int countMentorsReviewed(int mid) {
        String sql = "SELECT COUNT(*) AS total_reviews FROM mentor_reviews WHERE mentor_id = ? ";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, mid);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total_reviews");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Đếm số lượng mentee đã review
    public int countMenteesReviewed(int mid) {
        String sql = "SELECT COUNT(DISTINCT mentee_id) AS total_mentees FROM mentor_reviews WHERE mentor_id = ? ";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, mid);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total_mentees");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Mentor> filterMentors(Integer month, String status, String searchQuery, Date requestTime) {
        List<Mentor> mentorList = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Đảm bảo kết nối luôn mở
            if (conn == null || conn.isClosed()) {
                conn = getConnection();
            }

            StringBuilder sql = new StringBuilder(
                    "SELECT m.name, ms.mentor_id, sl.slot_date, sl.slot_number_id, "
                    + "       CONVERT(VARCHAR(8), st.start_time, 108) AS start_time, "
                    + "       CONVERT(VARCHAR(8), st.end_time, 108) AS end_time, ms.status "
                    + "FROM Mentor m "
                    + "LEFT JOIN Mentor_Slot ms ON m.id = ms.mentor_id "
                    + "JOIN Slot sl ON sl.id = ms.slot_id "
                    + "JOIN Slot_Template st ON st.id = sl.slot_number_id "
                    + "WHERE 1=1");

            List<Object> parameters = new ArrayList<>();
            if (month != null) {
                sql.append(" AND MONTH(sl.slot_date) = ?");
                parameters.add(month);
            }
            if (status != null && !status.isEmpty()) {
                sql.append(" AND ms.status = ?");
                parameters.add(status);
            }
            if (searchQuery != null && !searchQuery.isEmpty()) {
                sql.append(" AND (m.name LIKE ? OR m.id LIKE ?)");
                String searchPattern = "%" + searchQuery + "%";
                parameters.add(searchPattern);
                parameters.add(searchPattern);
            }

            sql.append(" GROUP BY ms.mentor_id, m.name, sl.slot_date, sl.slot_number_id, st.start_time, st.end_time, ms.status");

            pstmt = conn.prepareStatement(sql.toString());
            for (int i = 0; i < parameters.size(); i++) {
                pstmt.setObject(i + 1, parameters.get(i));
            }

            rs = pstmt.executeQuery();
            while (rs.next()) {
                Mentor mentor = new Mentor();
                mentor.setMentorId(rs.getInt("mentor_id"));
                mentor.setName(rs.getString("name"));
                mentorList.add(mentor);
            }
            return mentorList;

        } catch (SQLException e) {
            e.printStackTrace();
            return mentorList;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                // Không đóng conn tại đây, để các truy vấn tiếp theo không bị lỗi
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<MentorDTO> getTop10Mentors(int type) {
        List<MentorDTO> mentors = new ArrayList<>();
        String sql = "";

        if (type == 1) {
            // Doanh thu
            sql = " SELECT TOP(10) m.id, m.image, m.name, m.email, m.rating, \n"
                    + "           COALESCE(SUM(r.totalPrice), 0) AS total_revenue\n"
                    + "    FROM Mentor m\n"
                    + "    LEFT JOIN Request r ON m.id = r.mentor_id AND r.status = 'Closed'\n"
                    + "    GROUP BY m.id, m.name, m.email, m.image, m.rating\n"
                    + "	ORDER BY total_revenue DESC;";
        } else if (type == 2) {
            // Rating
            sql = sql = " SELECT TOP(10) m.id, m.image, m.name, m.email, m.rating, \n"
                    + "           COALESCE(SUM(r.totalPrice), 0) AS total_revenue\n"
                    + "    FROM Mentor m\n"
                    + "    LEFT JOIN Request r ON m.id = r.mentor_id AND r.status = 'Closed'\n"
                    + "    GROUP BY m.id, m.name, m.email, m.image, m.rating\n"
                    + "	ORDER BY m.rating DESC;";
        } else {
            return mentors; // Nếu type không hợp lệ
        }

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    MentorDTO mentor = new MentorDTO();
                    mentor.setId(rs.getInt("id"));
                    mentor.setName(rs.getString("name"));
                    mentor.setRating(rs.getDouble("rating"));
                    mentor.setEmail(rs.getString("email"));
                    mentor.setImage(rs.getString("image"));
                    mentor.setRevenue(rs.getDouble("total_revenue"));

                    mentors.add(mentor);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return mentors;
    }

    public List<Map<String, Object>> getMentorMenteeStats() {
        String sql = """
        WITH Last12Months AS (
            SELECT FORMAT(DATEADD(MONTH, -n, GETDATE()), 'yyyy-MM') AS month
            FROM (SELECT TOP 12 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS n FROM master.dbo.spt_values) AS numbers
        )
        SELECT l.month, 
               ISNULL(m.mentor_count, 0) AS mentor_count, 
               ISNULL(m.mentee_count, 0) AS mentee_count
        FROM Last12Months l
        LEFT JOIN (
            SELECT FORMAT(created_at, 'yyyy-MM') AS month, 
                   COUNT(DISTINCT CASE WHEN role = 'mentor' THEN id END) AS mentor_count, 
                   COUNT(DISTINCT CASE WHEN role = 'mentee' THEN id END) AS mentee_count
            FROM Users
            WHERE created_at >= DATEADD(MONTH, -12, GETDATE()) 
            GROUP BY FORMAT(created_at, 'yyyy-MM')
        ) m ON l.month = m.month
        ORDER BY l.month;
    """;

        List<Map<String, Object>> stats = new ArrayList<>();

        try (PreparedStatement st = conn.prepareStatement(sql); ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("month", rs.getString("month"));
                row.put("mentor_count", rs.getInt("mentor_count"));
                row.put("mentee_count", rs.getInt("mentee_count"));
                stats.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return stats;
    }

    public static void main(String[] args) {
        try {
            DAOMentor dao = new DAOMentor();

            System.out.println("Test 1: Filter by month (March)");
            List<Mentor> mentors1 = dao.filterMentors(3, null, null, null);
            printMentors(mentors1);

            System.out.println("\nTest 2: Filter by status (Accepted)");
            List<Mentor> mentors2 = dao.filterMentors(null, "Available", null, null);
            printMentors(mentors2);

            System.out.println("\nTest 3: Filter by name search (John)");
            List<Mentor> mentors3 = dao.filterMentors(null, null, "John", null);
            printMentors(mentors3);

            System.out.println("\nTest 4: Filter by specific date");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date testDate = sdf.parse("2025-03-20");
            List<Mentor> mentors4 = dao.filterMentors(null, null, null, testDate);
            printMentors(mentors4);

            System.out.println("\nTest 5: All filters combined");
            List<Mentor> mentors5 = dao.filterMentors(3, "nonAvailable", "John", testDate);
            printMentors(mentors5);

        } catch (Exception e) {
            System.err.println("Test Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void printMentors(List<Mentor> mentors) throws SQLException {
        if (mentors.isEmpty()) {
            System.out.println("No mentors found.");
            return;
        }
        
        DAOMentor dao = new DAOMentor();
        List<Mentor> l = dao.getMentorsWithSchedulesALL();
        System.out.println(l);
        System.out.println("Found " + mentors.size() + " mentors:");
        for (Mentor mentor : mentors) {
            System.out.println("ID: " + mentor.getMentorId() + ", Name: " + mentor.getName());
        }
    }
}
