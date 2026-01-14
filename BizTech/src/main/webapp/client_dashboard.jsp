<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.biztech.model.Idea" %>

<%
    // 🔐 Session validation (DO NOT REMOVE)
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>BizTech | Client Dashboard</title>
    <link rel="stylesheet" href="client_dashboard.css">
</head>
<body>

<!-- ================= TOP HEADER ================= -->
<header class="topbar">
    <div class="logo">BizTech</div>
    <div class="title">Client Dashboard</div>
    <div class="user">
        👤 <%= session.getAttribute("name") %>
    </div>
</header>

<!-- ================= MAIN CONTAINER ================= -->
<div class="container">

    <!-- ===== SIDEBAR ===== -->
    <aside class="sidebar">
        <ul>
            <li class="active">Dashboard</li>
            <li><a href="addIdea.jsp">Post Idea</a></li>
            <li><a href="client_dashboard">My Ideas</a></li>
            <li>Profile</li>
            <li class="logout">
                <a href="logout">Logout</a>
            </li>
        </ul>
    </aside>

    <!-- ===== MAIN CONTENT ===== -->
    <main class="content">

        <!-- ===== WELCOME CARD ===== -->
        <div class="card welcome">
            <h2>Welcome, <%= session.getAttribute("name") %></h2>
            <p>Role: <span class="badge">Client</span></p>
            <p>Manage your ideas and business details.</p>
        </div>

        <!-- ===== POST IDEA CARD ===== -->
        <div class="card">
            <h3>Post New Idea</h3>

            <form action="addIdea" method="post">

                <input type="text" name="title" placeholder="Idea Title" required>

                <select name="ideaType" required>
                    <option value="">Idea Type</option>
                    <option value="Student">Student</option>
                    <option value="Small Business">Small Business</option>
                </select>

                <select name="category" required>
                    <option value="">Select Category</option>
                    <option value="Technology">Technology</option>
                    <option value="Business">Business</option>
                    <option value="Healthcare">Healthcare</option>
                    <option value="Social">Social</option>
                </select>

                <textarea name="problem" placeholder="Problem Statement" required></textarea>

                <textarea name="solution" placeholder="Proposed Solution" required></textarea>

                <input type="text" name="targetMarket" placeholder="Target Market">

                <select name="stage">
                    <option value="Idea">Idea</option>
                    <option value="Prototype">Prototype</option>
                    <option value="Running">Running</option>
                </select>

                <textarea name="description" placeholder="Additional Description"></textarea>

                <button type="submit">Submit Idea</button>
            </form>
        </div>

        <!-- ===== MY IDEAS TABLE ===== -->
        <div class="card">
            <h3>My Ideas</h3>

            <table>
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Type</th>
                        <th>Category</th>
                        <th>Stage</th>
                    </tr>
                </thead>
                <tbody>

                <%
                    ArrayList<Idea> ideas =
                        (ArrayList<Idea>) request.getAttribute("ideas");

                    if (ideas != null && !ideas.isEmpty()) {
                        for (Idea i : ideas) {
                %>
                    <tr>
                        <td><%= i.getTitle() %></td>
                        <td><%= i.getIdeaType() %></td>
                        <td><%= i.getCategory() %></td>
                        <td class="status"><%= i.getStage() %></td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="4" style="text-align:center;">
                            No ideas posted yet
                        </td>
                    </tr>
                <%
                    }
                %>

                </tbody>
            </table>
        </div>

    </main>
</div>

</body>
</html>
