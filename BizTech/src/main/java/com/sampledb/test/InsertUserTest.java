package com.sampledb.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;


public class InsertUserTest {

    public static void main(String[] args) {

        try {
            // 1. Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 2. Connect to biztech_db
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/biztech_db",
                "root",
                "root"
            );

            // 3. SQL INSERT (id is skipped)
            String sql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, "Varna");
            ps.setString(2, "varna@test.com");
            ps.setString(3, "12345");
            ps.setString(4, "CLIENT"); // must match ENUM exactly

            int rows = ps.executeUpdate();

            if (rows > 0) {
                System.out.println("User inserted successfully");
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
