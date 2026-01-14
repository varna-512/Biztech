package com.biztech.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL =
        "jdbc:mysql://localhost:3306/biztech_db" +
        "?useSSL=false" +
        "&serverTimezone=UTC" +
        "&allowPublicKeyRetrieval=true";

    private static final String USER = "root";
    private static final String PASSWORD = "root"; 
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println(" DATABASE CONNECTED SUCCESSFULLY");
            return con;
        } catch (Exception e) {
            System.out.println(" DATABASE CONNECTION FAILED");
            e.printStackTrace();
            return null;
        }
    }
}


