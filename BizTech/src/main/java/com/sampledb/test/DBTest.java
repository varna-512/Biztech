package com.sampledb.test;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBTest {

    public static void main(String[] args) {

        try {
            // 1. Load MySQL Driver (confirms JAR is connected)
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL Driver Loaded Successfully");

            // 2. Connect to Database
            String url = "jdbc:mysql://localhost:3306/biztech_db";
            String user = "root";
            String password = "root";

            Connection con = DriverManager.getConnection(url, user, password);

            if (con != null) {
                System.out.println("Database Connected Successfully");
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
