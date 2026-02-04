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

@WebServlet("/requestConnection")
public class RequestConnectionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        Integer investorId = (Integer) req.getSession().getAttribute("userId");
        if (investorId == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int ideaId = Integer.parseInt(req.getParameter("ideaId"));

        try (Connection con = DBConnection.getConnection()) {

            // Prevent duplicate request
            PreparedStatement check = con.prepareStatement(
                "SELECT connection_id FROM connections WHERE investor_id=? AND idea_id=?"
            );
            check.setInt(1, investorId);
            check.setInt(2, ideaId);

            ResultSet rs = check.executeQuery();
            if (rs.next()) {
                res.sendRedirect(req.getContextPath() + "/investor/connections.jsp");
                return;
            }

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO connections (investor_id, idea_id, status) VALUES (?, ?, 'REQUESTED')"
            );
            ps.setInt(1, investorId);
            ps.setInt(2, ideaId);
            ps.executeUpdate();

            res.sendRedirect(req.getContextPath() + "/investor/connections.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
