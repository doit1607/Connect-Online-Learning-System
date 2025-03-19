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
        String sql = "SELECT \n"
                + "    c.id AS CourseID,\n"
                + "    c.title AS CourseTitle,\n"
                + "    c.description AS CourseDescription,\n"
                + "    c.manager_id AS ManagerID,\n"
                + "    c.mentor_id AS MentorID,\n"
                + "    c.status AS CourseStatus,\n"
                + "    c.created_at AS CreatedAt,\n"
                + "    c.updated_at AS UpdatedAt,\n"
                + "    c.course_major_id AS CourseMajorID,\n"
                + "    c.image AS CourseImage \n"
                + "FROM \n"
                + "    Course c\n"
                + "LEFT JOIN \n"
                + "    CourseMajor cm ON c.course_major_id = cm.id\n"
                + "LEFT JOIN \n"
                + "    CV cv ON ',' + cv.courses + ',' LIKE '%,' + cm.name + ',%'\n"
                + "WHERE \n"
                + "    c.course_major_id = ?\n"
                + "GROUP BY \n"
                + "    c.id, c.title, c.description, c.manager_id, c.mentor_id, \n"
                + "    c.status, c.created_at, c.updated_at, c.course_major_id, c.image;";

        try {
            PreparedStatement connect = conn.prepareStatement(sql);
            connect.setInt(1, id);
            ResultSet rs = connect.executeQuery();

           while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("CourseID"));
                course.setTitle(rs.getString("CourseTitle"));
                course.setDescription(rs.getString("CourseDescription"));
                course.setManagerId(rs.getInt("ManagerID"));
                course.setMentorId(rs.getInt("MentorID"));
                course.setStatus(rs.getString("CourseStatus"));
                course.setCourseMajorId(rs.getInt("CourseMajorID"));
                course.setImage(rs.getString("CourseImage"));

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
        List<Course> listCourse = dao.getListAllCourseByMajorId(2);

        System.out.println(listCourse + " \n");

    }

}
