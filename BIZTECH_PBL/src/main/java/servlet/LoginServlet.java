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
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM users WHERE email=? AND password=?"
            );
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = req.getSession();
                session.setAttribute("userId", rs.getInt("user_id"));
                session.setAttribute("name", rs.getString("name"));
                session.setAttribute("role", rs.getString("role"));

                if ("CLIENT".equals(rs.getString("role"))) {
                    res.sendRedirect("client/clientDashboard.jsp");
                } else {
                    res.sendRedirect("investor/investorDashboard.jsp");
                }

            } else {
                // 🔥 THIS IS THE FIX
                req.setAttribute("error", "Invalid email or password");
                req.getRequestDispatcher("login.jsp").forward(req, res);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Something went wrong. Try again.");
            req.getRequestDispatcher("login.jsp").forward(req, res);
        }
    }
}
