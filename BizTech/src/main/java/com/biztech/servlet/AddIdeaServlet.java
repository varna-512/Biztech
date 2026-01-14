package com.biztech.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.biztech.db.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/addIdea")
public class AddIdeaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        int userId = (int) session.getAttribute("userId");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO ideas (user_id, title, idea_type, category, problem, solution, target_market, stage, description) " +
                "VALUES (?,?,?,?,?,?,?,?,?)"
            );

            ps.setInt(1, userId);
            ps.setString(2, req.getParameter("title"));
            ps.setString(3, req.getParameter("ideaType"));
            ps.setString(4, req.getParameter("category"));
            ps.setString(5, req.getParameter("problem"));
            ps.setString(6, req.getParameter("solution"));
            ps.setString(7, req.getParameter("targetMarket"));
            ps.setString(8, req.getParameter("stage"));
            ps.setString(9, req.getParameter("description"));

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        resp.sendRedirect("viewIdeas");
    }
}
