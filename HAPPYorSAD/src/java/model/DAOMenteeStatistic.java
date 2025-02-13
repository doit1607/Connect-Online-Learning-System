/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Mentee;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class DAOMenteeStatistic extends DBConnection {

//    public List<Mentee> getMentee() {
//        List<Mentee> listMentee = new ArrayList<>();
//        String sql = "SELECT [id]\n"
//                + "      ,[user_id]\n"
//                + "      ,[name]\n"
//                + "      ,[is_deleted]\n"
//                + "      ,[email]\n"
//                + "      ,[goals]\n"
//                + "      ,[created_at]\n"
//                + "  FROM [SWP1].[dbo].[Mentee]"
//                + "order by [name]";
//        try {
//            PreparedStatement connect = conn.prepareStatement(sql);
//            ResultSet rs = connect.executeQuery();
//            while (rs.next()) {
//                int id = rs.getInt("id");
//                int user_id = rs.getInt("user_id");
//                String name = rs.getString("name");
//                int is_deleted = rs.getInt("is_deleted");
//                String email = rs.getString("email");
//                String goals = rs.getString("goals");
//                LocalDateTime createdAt = rs.getTimestamp("created_at").toLocalDateTime();
//
//                Mentee mentee = new Mentee(id, user_id, name, is_deleted, email, goals, createdAt);
//                listMentee.add(mentee);
//            }
//        } catch (SQLException ex) {
//            ex.printStackTrace();
//        }
//        return listMentee;
//    }
    // dem so luong mentee trong db
    public int getTotalMentee() {
        String sql = "select count(*) from Mentee";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public List<Mentee> getCount() {
        ArrayList<Mentee> count = new ArrayList<>();
        String query = "SELECT COUNT(DISTINCT u_mentee.id) AS total_Mentee\n"
                + "FROM Users u_mentee\n"
                + "WHERE u_mentee.role = 'mentee' AND u_mentee.status = 'active';";
        try {
            PreparedStatement connect = conn.prepareStatement(query);
            ResultSet result = connect.executeQuery();
            while (result.next()) {
                int total_Mentee = result.getInt("total_Mentee");
                Mentee m = new Mentee(total_Mentee);
                count.add(m);
            }
            result.close();
            connect.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<Mentee> pagingMentee(int index) {
        List<Mentee> list = new ArrayList<>();
        String sql = "select * from Mentee\n"
                + "order by [name]\n"
                + "offset ? rows fetch next 2 rows only";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, (index - 1) * 2);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Mentee(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getTimestamp(7).toLocalDateTime()));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public static void main(String[] args) {
        DAOMenteeStatistic dao = new DAOMenteeStatistic();

        List<Mentee> listMentee1 = dao.getCount();
        for (Mentee mentee : listMentee1) {
            System.out.println(mentee);
        }
    }
}
