<%@ page language="java" contentType="text/html; charset=UTF-8" %>
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

    <% String msg = (String) request.getAttribute("msg");
       if (msg != null) { %>
        <div class="msg"><%= msg %></div>
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











