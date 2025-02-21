/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.ResultSet;

import java.sql.DriverManager;
import java.sql.SQLException;


public class DBConnection {

    public static Connection conn = null;

    public DBConnection(String URL, String userName, String pass) {
        try {
            //        URL: String connection : server(IP,port),DBName
//        userName,password: account of SQLServer
//        call Driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            // call connection
            conn = DriverManager.getConnection(URL, userName, pass);
            System.out.println("connected");
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public DBConnection() {
        this("jdbc:sqlserver://localhost:1433;databaseName=SWP1",
                "sa", "123456");
    }

    public ResultSet getData(String sql) {
        ResultSet rs = null;
        try {
            rs = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE).executeQuery(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return rs;
    }
    public static Connection getConnection() {
    if (conn == null) {
        new DBConnection(); // Tạo kết nối nếu chưa có
    }
    return conn;
}

    public static void main(String[] args) {
        new DBConnection();
    }
}
