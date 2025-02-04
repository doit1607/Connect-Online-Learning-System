/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.User;
import jakarta.servlet.jsp.jstl.sql.Result;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Ann
 */
public class DAOuser extends DBConnection {

    public boolean loginUser(String username, String password) {
        try {
            String sql = "Select * from [User] where username = ? and password = ?";
            PreparedStatement state = conn.prepareStatement(sql);
            state.setString(1, username);
            state.setString(2, password);
            ResultSet rs = state.executeQuery();
            if (rs.next()) {
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void addUser(User u) {
        try {

            String sql = "INSERT INTO [dbo].[User] "
                    + "([username], [avatar_path], [password], [status], [email], [phone_number], "
                    + "[date_of_birth], [gender], [created_at], [role], [is_guest]) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, u.getUsername());
            stmt.setString(2, u.getAvatarPath());
            stmt.setString(3, u.getPassword());
            stmt.setString(4, u.getStatus());
            stmt.setString(5, u.getEmail());
            stmt.setString(6, u.getPhoneNumber());
            stmt.setDate(7, new java.sql.Date(u.getDateOfBirth().getTime()));
            stmt.setString(8, u.getGender());
            stmt.setDate(9, new java.sql.Date(u.getCreatedAt().getTime()));
            stmt.setString(10, u.getRole());
            stmt.setBoolean(11, u.isGuest());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();

        }
    }

    public boolean checkUsernameExist(String username) {
        try {
            String sql = "Select * from [User] where username = ? ";
            PreparedStatement state = conn.prepareStatement(sql);
            state.setString(1, username);
            ResultSet rs = state.executeQuery();
            if (rs.next()) {
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public String getPasswordByUsername(String username) {
        String password ;
        try {
            String sql = "SELECT password FROM User WHERE username = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if(rs.next()){
                password = rs.getString("password");
                return password;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    public void UpdatePassword(String username,String password){
        try {
            String Sql = "UPDATE User SET password = ? WHERE username = ?";
            PreparedStatement st = conn.prepareStatement(Sql);
            st.setString(1, password);
            st.setString(2, username);
            int rowsUpdated = st.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        
        
    }

}
