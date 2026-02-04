package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/saveProfile")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        Integer userId = (Integer) req.getSession().getAttribute("userId");
        if (userId == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String fullName = req.getParameter("fullName");
        String dob = req.getParameter("dob");
        String experience = req.getParameter("experience");
        String interest = req.getParameter("interest");
        String bio = req.getParameter("bio");

        try {
            Connection con = DBConnection.getConnection();

            // Check if profile already exists
            PreparedStatement check = con.prepareStatement(
                "SELECT profile_id FROM profiles WHERE user_id=?"
            );
            check.setInt(1, userId);
            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                // UPDATE
                PreparedStatement update = con.prepareStatement(
                    "UPDATE profiles SET full_name=?, dob=?, experience=?, interest=?, bio=? WHERE user_id=?"
                );
                update.setString(1, emptyToNull(fullName));
                update.setString(2, emptyToNull(dob));
                update.setString(3, emptyToNull(experience));
                update.setString(4, emptyToNull(interest));
                update.setString(5, emptyToNull(bio));
                update.setInt(6, userId);
                update.executeUpdate();
            } else {
                // INSERT
                PreparedStatement insert = con.prepareStatement(
                    "INSERT INTO profiles (user_id, full_name, dob, experience, interest, bio) VALUES (?,?,?,?,?,?)"
                );
                insert.setInt(1, userId);
                insert.setString(2, emptyToNull(fullName));
                insert.setString(3, emptyToNull(dob));
                insert.setString(4, emptyToNull(experience));
                insert.setString(5, emptyToNull(interest));
                insert.setString(6, emptyToNull(bio));
                insert.executeUpdate();
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        String role = (String) req.getSession().getAttribute("role");

        if ("CLIENT".equals(role)) {
            res.sendRedirect(req.getContextPath() + "/client/profile.jsp?saved=1");
        } else {
            res.sendRedirect(req.getContextPath() + "/investor/profile.jsp?saved=1");
        }

    }

    private String emptyToNull(String val) {
        return (val == null || val.trim().isEmpty()) ? null : val;
    }
}
