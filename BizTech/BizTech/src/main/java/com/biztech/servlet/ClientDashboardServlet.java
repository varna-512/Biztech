package com.biztech.servlet;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/client_dashboard")
public class ClientDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try {
            req.getRequestDispatcher("client_dashboard.jsp")
               .forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
