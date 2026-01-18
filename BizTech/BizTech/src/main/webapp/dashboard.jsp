<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>

<h2>Welcome, <%= session.getAttribute("userName") %></h2>
<p>Role: <%= session.getAttribute("role") %></p>

<a href="logout.jsp">Logout</a>

</body>
</html>

