package com.biztech.servlet;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/redirect")
public class RoleRedirectServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String role = session.getAttribute("role").toString();

        if ("client".equalsIgnoreCase(role)) {
            response.sendRedirect("client_dashboard");
        } 
        else if ("investor".equalsIgnoreCase(role)) {
            response.sendRedirect("investor_dashboard");
        } 
        else {
            response.sendRedirect("login.jsp");
        }
    }
}
