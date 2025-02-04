/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Mentee;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class DAOMenteeStatistic extends DBConnection {
    
    public List<Mentee> getMentee() {
        List<Mentee> listMentee = new ArrayList<>();
        String sql = "select name, acount_name, count(*) as number_of_mentee,"
                + "sum(total_hours) as total_hours, sum(total_courses) as total_courses"
                + "from Mentee"
                + "group by name, account_name";
        try {
            PreparedStatement connect = conn.prepareStatement(sql);
            ResultSet rs = connect.executeQuery();
            while (rs.next()) {
                String name = rs.getString("name");
                String account_name = rs.getString("account_name");
                int numOfMentee = rs.getInt("numberOfMentee");
                double totalHours = rs.getDouble("totalHours");
                int totalCourses = rs.getInt("totalCourses");
                
                Mentee mentee = new Mentee(name, account_name, numOfMentee, totalHours, totalCourses);
                listMentee.add(mentee);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listMentee;
    }
}
