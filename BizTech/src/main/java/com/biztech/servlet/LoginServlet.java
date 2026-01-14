package com.biztech.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.biztech.db.DBConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT user_id, name, role FROM users WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession(true);

                session.setAttribute("userId", rs.getInt("user_id"));
                session.setAttribute("name", rs.getString("name"));
                session.setAttribute("role", rs.getString("role"));

                // 🚀 ALWAYS redirect to ONE servlet
                response.sendRedirect("redirect");

            } else {
                request.setAttribute("msg", "Invalid email or password");
                forward(request, response, "login.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Login error");
            forward(request, response, "login.jsp");
        }
    }

    private void forward(HttpServletRequest req, HttpServletResponse res, String page)
            throws IOException {
        try {
            RequestDispatcher rd = req.getRequestDispatcher(page);
            rd.forward(req, res);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
