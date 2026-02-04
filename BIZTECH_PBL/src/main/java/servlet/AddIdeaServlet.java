package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import dao.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/addIdea")
public class AddIdeaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int userId = (int) req.getSession().getAttribute("userId");
        

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO ideas (user_id,title,idea_type,category,stage,problem,solution,description) VALUES (?,?,?,?,?,?,?,?)"
            );

            ps.setInt(1, userId);
            ps.setString(2, req.getParameter("title"));
            ps.setString(3, req.getParameter("ideaNature"));

            ps.setString(4, req.getParameter("category"));
            ps.setString(5, req.getParameter("stage"));
            ps.setString(6, req.getParameter("problem"));
            ps.setString(7, req.getParameter("solution"));
            ps.setString(8, req.getParameter("description"));

            ps.executeUpdate();
            res.sendRedirect("client/myIdeas.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
