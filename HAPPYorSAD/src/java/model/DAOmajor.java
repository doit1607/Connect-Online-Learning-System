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
                + "    m.name,\n"
                + "	m.image,\n"
                + "    COUNT(c.id) AS total_courses\n"
                + "FROM CourseMajor m\n"
                + "LEFT JOIN Course c ON m.id = c.course_major_id\n"
                + "GROUP BY m.name, m.image";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            ResultSet result = connect.executeQuery();
            while (result.next()) {
                String name = result.getString("name");
                String image = result.getString("image");
                int total_courses = result.getInt("total_courses");

                Major m = new Major(name, image, total_courses);
                l.add(m);
            }
            result.close();
            connect.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return l;
    }


    public static void main(String[] args) {
        DAOmajor dao = new DAOmajor();

        List<Major> list = dao.getMajorHome();

        System.out.println(list);

    }

}
