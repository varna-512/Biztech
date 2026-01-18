package com.biztech.servlet;

import java.io.IOException;

import com.biztech.dao.IdeaDAO;
import com.biztech.model.Idea;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/addIdea")
public class AddIdeaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        Idea i = new Idea();
        i.setUserId((int) session.getAttribute("userId"));
        i.setTitle(req.getParameter("title"));
        i.setIdeaType(req.getParameter("ideaType"));
        i.setCategory(req.getParameter("category"));
        i.setProblem(req.getParameter("problem"));
        i.setSolution(req.getParameter("solution"));
        i.setTargetMarket(req.getParameter("targetMarket"));
        i.setStage(req.getParameter("stage"));
        i.setDescription(req.getParameter("description"));

        IdeaDAO dao = new IdeaDAO();
        dao.addIdea(i);

        resp.sendRedirect("viewIdeas");
    }
}
