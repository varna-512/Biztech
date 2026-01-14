package com.biztech.servlet;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

import com.biztech.db.DBConnection;
import com.biztech.model.Idea;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/viewIdeas")
public class ViewIdeasServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        int userId = (int) session.getAttribute("userId");

        ArrayList<Idea> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT idea_id, title, idea_type, category, stage FROM ideas WHERE user_id=?"
            );
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Idea i = new Idea();
                i.setIdeaId(rs.getInt("idea_id"));
                i.setTitle(rs.getString("title"));
                i.setIdeaType(rs.getString("idea_type"));
                i.setCategory(rs.getString("category"));
                i.setStage(rs.getString("stage"));
                list.add(i);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("ideas", list);
        req.getRequestDispatcher("myIdeas.jsp").forward(req, resp);
    }
}
