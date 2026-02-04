<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login | BizTech</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body class="auth-body">

<div class="auth-box">

    <div class="title">BizTech</div>
    <div class="subtitle">Login</div>

    <%-- 🔴 LOGIN ERROR (RED) --%>
    <%
        String error = (String) request.getAttribute("error");
    %>

    <% if (error != null) { %>
        <div class="msg">
            <%= error %>
        </div>
    <% } %>

    <%-- 🟢 SIGNUP SUCCESS (GREEN) --%>
    <%
        String msg = (String) request.getAttribute("msg");
        String msgType = (String) request.getAttribute("msgType");
    %>

    <% if (msg != null) { %>
        <div class="msg <%= msgType != null ? msgType : "" %>">
            <%= msg %>
        </div>
    <% } %>

    <form action="login" method="post">

        <label>Email</label>
        <input type="email" name="email" placeholder="Enter your email" required>

        <label>Password</label>
        <input type="password" name="password" placeholder="Enter your password" required>

        <button type="submit">Login</button>
    </form>

    <div class="switch">
        New user? <a href="signup.jsp">Signup</a>
    </div>

</div>

</body>
</html>
