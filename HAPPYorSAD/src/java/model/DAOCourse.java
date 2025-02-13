/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Course;
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

    public boolean createCourse(String title, String description) {
        String sql = "INSERT INTO [dbo].[Course] ([title], [description], [status]) "
                + "VALUES (?, ?, ?)";

        try (PreparedStatement pre = conn.prepareStatement(sql)) {
            pre.setString(1, title);
            pre.setString(2, description);
            pre.setString(3, "Active"); // Trạng thái mặc định

            return pre.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
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
                + "    COUNT(DISTINCT u_mentor.id) AS total_Mentor,\n"
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
        String query = "SELECT \n"
                + "    COUNT(DISTINCT c.id) AS total_Courses,\n"
                + "    COUNT(DISTINCT m.id) AS total_Mentee\n"
                + "FROM Course c\n"
                + "LEFT JOIN Mentee m ON m.user_id IN (\n"
                + "    SELECT id FROM Users WHERE role = 'mentee'\n"
                + ");";
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

    public static void main(String[] args) {
        DAOCourse dao = new DAOCourse();

        List<Course> listCourseHome = dao.getAllCourseHome();

        for (Course course : listCourseHome) {
            System.out.println(listCourseHome);
        }

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
    }
}
