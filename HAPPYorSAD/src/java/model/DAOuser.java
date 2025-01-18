/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

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

    public boolean addUser(String username, String password, String email, String phoneNumber, String dateOfBirth, String gender) throws ParseException {
        try {

            String sql = "INSERT INTO User (username, password, email, phone_number, date_of_birth, gender, is_guest, status, role) "
                    + "VALUES (?, ?, ?, ?, ?, ?, false, 'active', 'user')";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, email);
            stmt.setString(4, phoneNumber);
            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            Date parsedDate = formatter.parse(dateOfBirth);
            java.sql.Date sqlDate = new java.sql.Date(parsedDate.getTime());
            stmt.setDate(5, sqlDate);
            stmt.setString(6, gender);
            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Registration successful. Welcome, " + username + "!");
                return true;
            } else {
                System.out.println("Registration failed.");
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
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

  

}
