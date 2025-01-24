/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.CV;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class DAOCV extends DBConnection {

    public int addCV(CV cv) {
        int n = 0;
        String sql = "INSERT INTO [dbo].[CV]\n"
                + "           ([user_id]\n"
                + "           ,[file_path]\n"
                + "           ,[status]\n"
                + "           ,[valid_from]\n"
                + "           ,[valid_until]\n"
                + "           ,[created_at]\n"
                + "           ,[updated_at])\n"
                + "     VALUES(" + cv.getId() + ",'" + cv.getFilePath() + "','" + cv.getStatus()
                + "'," + cv.getValidFrom() + "," + cv.getValidFrom() + "," + cv.getCreatedAt()
                + "," + cv.getUpdatedAt() + ")";
        System.out.println(sql);
        try {
            Statement state = conn.createStatement();
            n = state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOCV.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int updateCV(CV cv) {
        int n = 0;
        String sql = "UPDATE [dbo].[CV]\n"
                + "   SET [user_id] = ?\n"
                + "      ,[file_path] = ?\n"
                + "      ,[status] = ?\n"
                + "      ,[valid_from] = ?\n"
                + "      ,[valid_until] = ?\n"
                + "      ,[created_at] = ?\n"
                + "      ,[updated_at] = ?\n"
                + " WHERE [id] = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, cv.getUserId());
            pre.setString(2, cv.getFilePath());
            pre.setString(3, cv.getStatus());
            pre.setDate(4, java.sql.Date.valueOf(cv.getValidFrom()));
            pre.setDate(5, java.sql.Date.valueOf(cv.getValidUntil()));
            pre.setDate(6, java.sql.Date.valueOf(cv.getCreatedAt()));
            pre.setDate(7, java.sql.Date.valueOf(cv.getUpdatedAt()));

            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCV.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public Vector<CV> getCV(String sql) {
        Vector<CV> vector = new Vector<CV>();
        try {
            //default:ResultSet.TYPE_FORWARD_ONLY
            Statement state = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                //rs.getDataType(index[start 1]|fieldName);
                int ID = rs.getInt(1),
                        userID = rs.getInt(2);
                String filePath = rs.getString("file_path"),
                        status = rs.getString("status");
                LocalDate validFrom = rs.getTimestamp("valid_from").toLocalDateTime().toLocalDate(),
                        validUntil = rs.getTimestamp("valid_until").toLocalDateTime().toLocalDate(),
                        createdAt = rs.getTimestamp("created_at").toLocalDateTime().toLocalDate(),
                        updatedAt = rs.getTimestamp("updated_at").toLocalDateTime().toLocalDate();
                CV cv = new CV(ID, userID, filePath, status,
                        validFrom, validUntil, createdAt, updatedAt);
                vector.add(cv);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOCV.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }
}
