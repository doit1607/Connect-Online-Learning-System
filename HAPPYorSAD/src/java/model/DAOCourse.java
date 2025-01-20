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
        String query = "SELECT *\n"
                + "  FROM [course]";
               

        try {
            PreparedStatement connect = conn.prepareStatement(query);
            ResultSet result = connect.executeQuery();
            while (result.next()) {
                int id = result.getInt("id");
                String title = result.getString("title");
                String description = result.getString("description");
                int managerId = result.getInt("managerId");
                int mentorId = result.getInt("mentorId");
                LocalDateTime createdAt = result.getTimestamp("createdAt").toLocalDateTime();
                LocalDateTime updatedAt = result.getTimestamp("updatedAt").toLocalDateTime();
                int courseMajorId = result.getInt("courseMajorId");               

                Course course = new Course(id, title, description, managerId, mentorId, createdAt, updatedAt, courseMajorId);
                listCourse.add(course);
            }
            connect.close();
            result.close();
            return listCourse;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
}
