<%@ page session="true" %>
<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Client Dashboard | BizTech</title>
    <link rel="stylesheet" href="css/dashboard.css">
</head>
<body>

<div class="header">
    <h2>Welcome, <%= session.getAttribute("name") %></h2>
    <p class="role">Client Dashboard</p>
</div>

<div class="dashboard">

    <div class="card">
        <h3>Submit New Idea</h3>
        <p>Share your business idea with investors.</p>
        <a href="add_idea.jsp" class="btn">Add Idea</a>
    </div>

    <div class="card">
        <h3>My Ideas</h3>
        <p>View all ideas you have submitted.</p>
        <a href="viewIdeas" class="btn">View Ideas</a>
    </div>

    <div class="card">
        <h3>Investor Responses</h3>
        <p>Check interest from investors.</p>
        <a href="#" class="btn disabled">Coming Soon</a>
    </div>

</div>

<div class="footer">
    <a href="logout.jsp" class="logout">Logout</a>
</div>

</body>
</html>
