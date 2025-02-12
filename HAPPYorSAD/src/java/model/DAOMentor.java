package model;

import entity.Mentor;
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

    public static void main(String[] args) {
        DAOMentor dao = new DAOMentor();

        List<Mentor> list = dao.getCount();

        for (Mentor mentor : list) {
            System.out.println(mentor);
        }

    }

}
