package com.biztech.servlet;

import java.io.IOException;
import java.util.ArrayList;

import com.biztech.dao.IdeaDAO;
import com.biztech.model.Idea;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/viewIdeas")
public class ViewIdeasServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        IdeaDAO dao = new IdeaDAO();
        ArrayList<Idea> ideas = dao.getIdeasByUser(userId);

        req.setAttribute("ideas", ideas);
        req.getRequestDispatcher("view_ideas.jsp").forward(req, resp);
    }
}
