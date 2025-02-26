/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Course;
import entity.Mentor;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Acer
 */
public class DAOCourse extends DBConnection {

    public List<Course> getAllCourse() {
        ArrayList<Course> listCourse = new ArrayList<>();
        String query = "SELECT [id]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[manager_id]\n"
                + "      ,[mentor_id]\n"
                + "      ,[status]\n"
                + "      ,[created_at]\n"
                + "      ,[updated_at]\n"
                + "      ,[course_major_id]\n"
                + "      ,[image]\n"
                + "  FROM [SWP1].[dbo].[Course]";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            ResultSet result = connect.executeQuery();
            while (result.next()) {
                int id = result.getInt("id");
                String title = result.getString("title");
                String description = result.getString("description");
                int managerId = result.getInt("manager_id");
                int mentorId = result.getInt("mentor_id");
                LocalDateTime createdAt = result.getTimestamp("created_at").toLocalDateTime();
                LocalDateTime updatedAt = result.getTimestamp("updated_at").toLocalDateTime();
                int courseMajorId = result.getInt("course_major_id");
                String status = result.getString("status");
                String image = result.getString("image");

                Course course = new Course(id, title, description, managerId, mentorId, status, createdAt, updatedAt, courseMajorId, image);
                listCourse.add(course);
            }
            result.close();
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listCourse;
    }

//    public boolean createCourse(String title, String description, String image) {
//        String sql = "INSERT INTO [dbo].[Course] ([title], [description], [status], [image]) "
//                + "VALUES (?, ?, ?, ?)";
//
//        try (PreparedStatement pre = conn.prepareStatement(sql)) {
//            pre.setString(1, title);
//            pre.setString(2, description);
//            pre.setString(3, "active");
//            pre.setString(4, image);
//
//            return pre.executeUpdate() > 0;
//        } catch (SQLException ex) {
//            ex.printStackTrace();
//        }
//        return false;
//    }
    public void createCourse(String title, String description, int majorId, String image) {
        String sql = "INSERT INTO [dbo].[Course] ([title], [description], [status], [course_major_id], [image]) "
                + "VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, title);
            pre.setString(2, description);
            pre.setString(3, "active");
            pre.setInt(4, majorId);
            pre.setString(5, image);
            pre.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Course> getAllCourseOrderByName() {
        ArrayList<Course> listCourse = new ArrayList<>();
        String query = "SELECT [id]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[manager_id]\n"
                + "      ,[mentor_id]\n"
                + "      ,[status]\n"
                + "      ,[created_at]\n"
                + "      ,[updated_at]\n"
                + "      ,[course_major_id]\n"
                + "      ,[image]\n"
                + "      ,[price]\n"
                + "  FROM [SWP1].[dbo].[Course]\n"
                + "  order by [title]";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            ResultSet result = connect.executeQuery();
            while (result.next()) {
                int id = result.getInt("id");
                String title = result.getString("title");
                String description = result.getString("description");
                int managerId = result.getInt("manager_id");
                int mentorId = result.getInt("mentor_id");
                LocalDateTime createdAt = result.getTimestamp("created_at").toLocalDateTime();
                LocalDateTime updatedAt = result.getTimestamp("updated_at").toLocalDateTime();
                int courseMajorId = result.getInt("course_major_id");
                String status = result.getString("status");
                String image = result.getString("image");

                Course course = new Course(id, title, description, managerId, mentorId, status, createdAt, updatedAt, courseMajorId, image);
                listCourse.add(course);
            }
            result.close();
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listCourse;
    }

    public List<Course> getAllCourseHome() {
        ArrayList<Course> listCourseHome = new ArrayList<>();
        String query = "Select  c.title, cm.name as CourseMajor,c.image,\n"
                + "COUNT(DISTINCT u_mentor.id) AS total_Mentor,\n"
                + "COUNT(DISTINCT u_mentee.id) AS total_Mentee\n"
                + "From Course c\n"
                + "Join CourseMajor cm on c.course_major_id = cm.id\n"
                + "left join Users u_mentor on c.mentor_id = u_mentor.id AND u_mentor.role = 'mentor'\n"
                + "LEFT JOIN Users u_mentee ON c.mentor_id = u_mentee.id AND u_mentee.role = 'mentee'\n"
                + "GROUP BY c.title, c.image, cm.name";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            ResultSet result = connect.executeQuery();
            while (result.next()) {
                String title = result.getString("title");
                String courseMajor = result.getString("CourseMajor");
                int total_Mentor = result.getInt("total_Mentor");
                int total_Mentee = result.getInt("total_Mentee");
                String image = result.getString("image");
                Course course = new Course(title, courseMajor, total_Mentor, total_Mentee, image);
                listCourseHome.add(course);
            }
            result.close();
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listCourseHome;
    }

    public List<Course> getAllCourseHome2() {
        ArrayList<Course> listCourseHome = new ArrayList<>();
        String query = "SELECT TOP 4\n"
                + "    c.title,\n"
                + "	c.image,\n"
                + "    cm.name as CourseMajor,\n"
                + "    COUNT(DISTINCT CASE WHEN u_mentor.status = 'active' THEN u_mentor.id END) AS total_Mentor,\n"
                + "    COUNT(DISTINCT u_mentee.id) AS total_Mentee\n"
                + "FROM Course c\n"
                + "JOIN CourseMajor cm ON c.course_major_id = cm.id\n"
                + "LEFT JOIN Users u_mentor ON c.mentor_id = u_mentor.id AND u_mentor.role = 'mentor'\n"
                + "LEFT JOIN Users u_mentee ON c.mentor_id = u_mentee.id AND u_mentee.role = 'mentee'\n"
                + "GROUP BY c.title, c.image, cm.name\n"
                + "ORDER BY total_Mentee DESC;";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            ResultSet result = connect.executeQuery();
            while (result.next()) {
                String title = result.getString("title");
                String courseMajor = result.getString("CourseMajor");
                int total_Mentor = result.getInt("total_Mentor");
                int total_Mentee = result.getInt("total_Mentee");
                String image = result.getString("image");
                Course course = new Course(title, courseMajor, total_Mentor, total_Mentee, image);
                listCourseHome.add(course);
            }
            result.close();
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listCourseHome;
    }

    public List<Course> getCountCourseHome() {
        ArrayList<Course> list = new ArrayList<>();
        String query = "SELECT  \n"
                + "    COUNT(DISTINCT c.id) AS total_Courses,  \n"
                + "    COUNT(DISTINCT m.id) AS total_Mentee  \n"
                + "FROM Course c  \n"
                + "LEFT JOIN Mentee m ON m.user_id IN (  \n"
                + "    SELECT id FROM Users WHERE role = 'mentee'  \n"
                + ")  \n"
                + "WHERE c.status = 'active'; ";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            ResultSet rs = connect.executeQuery();
            while (rs.next()) {
                list.add(new Course(rs.getInt("total_Mentee"), rs.getInt("total_Courses"))
                );
            }
            rs.close();
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateCourse(int id, String title, String status) {
        String query = "UPDATE Course SET title = ?, status = ? WHERE id = ?";

        try (PreparedStatement connect = conn.prepareStatement(query)) {
            connect.setString(1, title);
            connect.setString(2, status);
            connect.setInt(3, id);

            int rowsUpdated = connect.executeUpdate();
            return rowsUpdated > 0; // Trả về true nếu có ít nhất một dòng được cập nhật

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Course getCourseById(int id) {
        String query = "SELECT [id]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[manager_id]\n"
                + "      ,[mentor_id]\n"
                + "      ,[status]\n"
                + "      ,[created_at]\n"
                + "      ,[updated_at]\n"
                + "      ,[course_major_id]\n"
                + "      ,[image]\n"
                + "  FROM [SWP1].[dbo].[Course]\n"
                + "  Where [id] = ?";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            connect.setInt(1, id);
            ResultSet result = connect.executeQuery();

            while (result.next()) {
                id = result.getInt("id");
                String title = result.getString("title");
                String description = result.getString("description");
                int managerId = result.getInt("manager_id");
                int mentorId = result.getInt("mentor_id");
                LocalDateTime createdAt = result.getTimestamp("created_at").toLocalDateTime();
                LocalDateTime updatedAt = result.getTimestamp("updated_at").toLocalDateTime();
                int courseMajorId = result.getInt("course_major_id");
                String status = result.getString("status");
                String image = result.getString("image");

                return new Course(id, title, description, managerId, mentorId, status, createdAt, updatedAt, courseMajorId, image);

            }
            result.close();
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<Course> getCourseByMentorId(int mentorId) {
        ArrayList<Course> listCourse = new ArrayList<>();
        String query = "SELECT [id]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[manager_id]\n"
                + "      ,[mentor_id]\n"
                + "      ,[status]\n"
                + "      ,[created_at]\n"
                + "      ,[updated_at]\n"
                + "      ,[course_major_id]\n"
                + "      ,[image]\n"
                + "  FROM [SWP1].[dbo].[Course]\n"
                + "  where [mentor_id] = ?";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            connect.setInt(1, mentorId);
            ResultSet result = connect.executeQuery();

            while (result.next()) {
                int id = result.getInt("id");
                String title = result.getString("title");
                String description = result.getString("description");
                int managerId = result.getInt("manager_id");
                mentorId = result.getInt("mentor_id");
                LocalDateTime createdAt = result.getTimestamp("created_at").toLocalDateTime();
                LocalDateTime updatedAt = result.getTimestamp("updated_at").toLocalDateTime();
                int courseMajorId = result.getInt("course_major_id");
                String status = result.getString("status");
                String image = result.getString("image");
                Course course = new Course(id, title, description, managerId, mentorId, status, createdAt, updatedAt, courseMajorId, image);
                listCourse.add(course);

            }
            result.close();
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listCourse;

    }

    public List<Mentor> getMentorByCourseTitle(String courseTitle) {
        List<Mentor> mentors = new ArrayList<>();
        String sql = "SELECT id, user_id, name, email, rating, is_deleted, reviews, "
                + "price_per_slot, expertise, bio, created_at, base_rate, multiplier, image "
                + "FROM Mentor WHERE id = (SELECT mentor_id FROM Course WHERE title = ?)";

        try {
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, courseTitle);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Mentor mentor = new Mentor(
                        rs.getInt("id"),
                        rs.getInt("id"), // mentorId (cùng giá trị với id)
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getDouble("rating"),
                        rs.getString("reviews"),
                        rs.getDouble("price_per_slot"),
                        rs.getString("expertise"),
                        rs.getString("bio"),
                        rs.getTimestamp("created_at") != null
                        ? rs.getTimestamp("created_at").toLocalDateTime() : null,
                        rs.getDouble("base_rate"),
                        rs.getDouble("multiplier"),
                        rs.getBoolean("is_deleted")
                );
                mentor.setImage(rs.getString("image"));
                mentors.add(mentor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mentors;
    }

//    public int getTotalMenteesByCourse(int courseId) {
//        String sql = "SELECT COUNT(DISTINCT m.id) AS total_mentees "
//                + "FROM Mentee m "
//                + "JOIN CourseEnrollment ce ON m.id = ce.mentee_id "
//                + "WHERE ce.course_id = ?";
//        try {
//            PreparedStatement stmt = conn.prepareStatement(sql);
//
//            stmt.setInt(1, courseId);
//            ResultSet rs = stmt.executeQuery();
//            if (rs.next()) {
//                return rs.getInt("total_mentees");
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return 0;
//    }

    public int getTotalMentorsByCourse(int courseId) {
        String sql = "SELECT COUNT(DISTINCT c.mentor_id) AS total_mentors "
                + "FROM Course c "
                + "WHERE c.id = ?";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setInt(1, courseId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total_mentors");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public String getCourseMajor(int courseId) {
        String sql = "SELECT cm.name AS course_major "
                + "FROM Course c "
                + "JOIN CourseMajor cm ON c.course_major_id = cm.id "
                + "WHERE c.id = ?";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setInt(1, courseId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("course_major");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Course> getTop3CoursesByMajor(int majorId) {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT top 3  [id]\n"
                + "      ,[title]\n"
                + "      ,[description]\n"
                + "      ,[manager_id]\n"
                + "      ,[mentor_id]\n"
                + "      ,[status]\n"
                + "      ,[created_at]\n"
                + "      ,[updated_at]\n"
                + "      ,[course_major_id]\n"
                + "      ,[image]\n"
                + "      ,[price]\n"
                + "  FROM [SWP1].[dbo].[Course]\n"
                + "  where [course_major_id] = ?";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setInt(1, majorId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setTitle(rs.getString("title"));
                course.setDescription(rs.getString("description"));
                course.setManagerId(rs.getInt("manager_id"));
                course.setMentorId(rs.getInt("mentor_id"));
                course.setStatus(rs.getString("status"));
                course.setCourseMajorId(rs.getInt("course_major_id"));
                course.setImage(rs.getString("image"));
                course.setPrice(rs.getDouble("price"));

                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }

    public static void main(String[] args) {
        DAOCourse dao = new DAOCourse();

//        List<Course> listCourseHome = dao.getAllCourseHome();
//
//        for (Course course : listCourseHome) {
//            System.out.println(course);
//        }
//        List<Course> listCourse1 = dao.getAllCourse();
//        System.out.println(listCourse1);
//        Course newCourse = new Course(0, "Java Programming", "Learn Java from basic to advanced", 1, 2, "active", LocalDateTime.now(), LocalDateTime.now(), 3);
//
//        boolean result = dao.createCourse("Java", "Basic");
//        if (result) {
//            System.out.println("Create course successfully");
//        } else {
//            System.out.println("Create failed!");
//        }
        Course course = dao.getCourseById(1);
//        int a = dao.getTotalMenteesByCourse(2);
        int b = dao.getTotalMentorsByCourse(2);
        String str = dao.getCourseMajor(2);
//        System.out.println(a);
        System.out.println(b);
        System.out.println(str);
        System.out.println(course);
    }
}
