/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Course;
import entity.Major;
import entity.Mentor;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ann
 */
public class DAOmajor extends DBConnection {

    public List<Major> getMajorHome() {
        ArrayList<Major> l = new ArrayList<>();
        String query = "SELECT \n"
                + "    m.id,\n"
                + "    m.name,\n"
                + "	m.image,\n"
                + "    COUNT(CASE WHEN c.status = 'active' THEN c.id END) AS total_courses\n"
                + "FROM CourseMajor m\n"
                + "LEFT JOIN Course c ON m.id = c.course_major_id\n"
                + "GROUP BY m.id, m.name, m.image";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            ResultSet result = connect.executeQuery();
            while (result.next()) {
                int id = result.getInt("id");
                String name = result.getString("name");
                String image = result.getString("image");
                int total_courses = result.getInt("total_courses");

                Major m = new Major(id, name, image, total_courses);
                l.add(m);
            }
            result.close();
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return l;
    }

    public List<Major> getListAllMajor() {
        ArrayList<Major> listMajor = new ArrayList<>();
        String query = "SELECT [id]\n"
                + "      ,[name]\n"
                + "      ,[description]\n"
                + "      ,[image]\n"
                + "  FROM [SWP1].[dbo].[CourseMajor]";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            ResultSet result = connect.executeQuery();
            while (result.next()) {
                Major major = new Major();
                major.setId(result.getInt("id"));
                major.setName(result.getString("name"));
                major.setDescription(result.getString("description"));
                major.setImage(result.getString("image"));
                listMajor.add(major);
            }
        } catch (Exception e) {

        }
        return listMajor;
    }

    public List<Course> getListAllCourseByMajorId(int id) {
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
                + "  where [course_major_id] = ?";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            connect.setInt(1, id);
            ResultSet result = connect.executeQuery();
            
            while (result.next()) {
                Course course = new Course();
                course.setId(result.getInt(id));
                course.setTitle(result.getString("title"));
                course.setDescription(result.getString("description"));
                course.setManagerId(result.getInt("manager_id"));
                course.setMentorId(result.getInt("mentor_id"));
                course.setStatus(result.getString("status"));
                course.setCourseMajorId(result.getInt("course_major_id"));
                course.setImage(result.getString("image"));
                course.setPrice(result.getDouble("price"));

                listCourse.add(course);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listCourse;
    }

    public static void main(String[] args) {
        DAOmajor dao = new DAOmajor();

        List<Major> list = dao.getMajorHome();
        List<Course> listCourse = dao.getListAllCourseByMajorId(1);
         
        System.out.println(listCourse);

    }

}
