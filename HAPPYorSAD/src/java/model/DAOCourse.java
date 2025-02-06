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
        String query = "SELECT id, title, description, manager_id, mentor_id, status, created_at, updated_at, course_major_id FROM Course";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            ResultSet result = connect.executeQuery();
            while (result.next()) {
                int id = result.getInt("id");
                String title = result.getString("title");
                String description = result.getString("description");
                int managerId = result.getInt("manager_id"); // Sửa lại tên cột cho đúng
                int mentorId = result.getInt("mentor_id");
                LocalDateTime createdAt = result.getTimestamp("created_at").toLocalDateTime();
                LocalDateTime updatedAt = result.getTimestamp("updated_at").toLocalDateTime();
                int courseMajorId = result.getInt("course_major_id");
                String status = result.getString("status");

                Course course = new Course(id, title, description, managerId, mentorId, courseMajorId, status);
                listCourse.add(course);
            }
            result.close();
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listCourse;
    }

    public boolean createCourse(Course cr) {
        String sql = "INSERT INTO [dbo].[Course]\n"
                + "           ([title]\n"
                + "           ,[description]\n"
                + "           ,[manager_id]\n"
                + "           ,[mentor_id]\n"
                + "           ,[status]\n"
                + "           ,[course_major_id])\n"
                + "     VALUES(?, ?, ?, ?, ?, ?)";
        
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, cr.getTitle());
            pre.setString(2, cr.getDescription());
            pre.setInt(3, cr.getManagerId());
            pre.setInt(4, cr.getMentorId());
            pre.setString(5, "Active");
            pre.setInt(6, cr.getCourseMajorId());
            return pre.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }
    public List<Course> getAllCourseOrderByName() {
        ArrayList<Course> listCourse = new ArrayList<>();
        String query = "SELECT id, title, description, manager_id, mentor_id, status, created_at, updated_at, course_major_id FROM Course ORDER BY title";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            ResultSet result = connect.executeQuery();
            while (result.next()) {
                int id = result.getInt("id");
                String title = result.getString("title");
                String description = result.getString("description");
                int managerId = result.getInt("manager_id"); // Sửa lại tên cột cho đúng
                int mentorId = result.getInt("mentor_id");
                LocalDateTime createdAt = result.getTimestamp("created_at").toLocalDateTime();
                LocalDateTime updatedAt = result.getTimestamp("updated_at").toLocalDateTime();
                int courseMajorId = result.getInt("course_major_id");
                String status = result.getString("status");

                Course course = new Course(id, title, description, managerId, mentorId, courseMajorId, status);
                listCourse.add(course);
            }
            result.close();
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listCourse;
    }
    public static void main(String[] args) {
        DAOCourse dao = new DAOCourse();

        List<Course> listCourse1 = dao.getAllCourse();
        System.out.println(listCourse1);
    }
}
