<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.biztech.model.Idea" %>

<%
    // 🔐 Session validation (MANDATORY)
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    ArrayList<Idea> ideas =
        (ArrayList<Idea>) request.getAttribute("ideas");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BizTech | My Ideas</title>
    <link rel="stylesheet" href="client_dashboard.css">
</head>
<body>

<div class="topbar">
    <div class="logo">BizTech</div>
    <div class="title">My Ideas</div>
    <div class="user">
        Welcome, <%= session.getAttribute("name") %>
    </div>
</div>

<div class="container">

    <!-- Sidebar -->
    <div class="sidebar">
        <ul>
            <li><a href="client-dashboard">Dashboard</a></li>
            <li class="active"><a href="viewIdeas">My Ideas</a></li>
            <li><a href="addIdea.jsp">Add Idea</a></li>
            <li class="logout"><a href="logout.jsp">Logout</a></li>
        </ul>
    </div>

    <!-- Content -->
    <div class="content">
        <div class="card">

            <h2>Submitted Ideas</h2>

            <%
                if (ideas == null || ideas.isEmpty()) {
            %>
                <p>No ideas submitted yet.</p>
            <%
                } else {
            %>

            <table>
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Idea Type</th>
                        <th>Category</th>
                        <th>Stage</th>
                        <th>Created At</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    for (Idea i : ideas) {
                %>
                    <tr>
                        <td><%= i.getTitle() %></td>
                        <td><%= i.getIdeaType() %></td>
                        <td><%= i.getCategory() %></td>
                        <td class="status"><%= i.getStage() %></td>
                        <td><%= i.getCreatedAt() %></td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>

            <%
                }
            %>

        </div>
    </div>
</div>

</body>
</html>
