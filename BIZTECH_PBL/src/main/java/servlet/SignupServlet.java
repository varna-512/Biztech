package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import dao.DBConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role");

        System.out.println("➡ Signup attempt: " + email);

        if (!password.equals(confirmPassword)) {
            request.setAttribute("msg", "Passwords do not match");
            forward(request, response, "signup.jsp");
            return;
        }

        try {
            Connection con = DBConnection.getConnection();

            if (con == null) {
                request.setAttribute("msg", "Database not connected");
                forward(request, response, "signup.jsp");
                return;
            }

            String sql =
                "INSERT INTO users(name, email, password, role) VALUES (?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, role);

            int rows = ps.executeUpdate();

            System.out.println("✅ Rows inserted: " + rows);

            request.setAttribute("msg", "Signup successful! Please login.");
            request.setAttribute("msgType", "success");
            forward(request, response, "login.jsp");


        } catch (Exception e) {
            request.setAttribute("msg", "Email already exists");
            forward(request, response, "signup.jsp");
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




