package model;

import entity.Mentor;
import entity.Mentor1;
import entity.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Dell
 */
public class DAOMentor extends DBConnection {

    public static DAOuser userDao = new DAOuser();

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

    public List<Mentor> getMentorsSuggestion() {
        List<Mentor> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    u.fullname,\n"
                + "    u.username,\n"
                + "    m.expertise,\n"
                + "	m.image,\n"
                + "    COUNT(DISTINCT mr.mentee_id) AS total_mentees,\n"
                + "    m.rating AS mentor_rating,\n"
                + "    COUNT(mr.id) AS total_reviews,\n"
                + "    m.price_per_slot\n"
                + "FROM Mentor m\n"
                + "JOIN Users u ON m.user_id = u.id\n"
                + "LEFT JOIN mentor_reviews mr ON m.id = mr.mentor_id\n"
                + "GROUP BY u.fullname, u.username, m.expertise, m.rating, m.price_per_slot, m.image;";
        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(new Mentor(rs.getString("fullname"),
                        rs.getDouble("mentor_rating"), rs.getDouble("price_per_slot"),
                        rs.getString("expertise"), rs.getString("image"),
                        rs.getString("username"), rs.getInt("total_mentees"), rs.getInt("total_reviews"))
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

    public static Integer getMentorIdByUserId(int userId) {
        String sql = "SELECT m.id \n"
                + "FROM Users u join Mentor m on m.user_id = u.id\n"
                + "WHERE u.id = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, userId);
            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
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

    public static void main(String[] args) {
        DAOMentor dao = new DAOMentor();

        List<Mentor> list = dao.getMentorsByCourse("Business Strategy and Management");

        for (Mentor mentor : list) {
            System.out.println(mentor);
        }

    }

}
