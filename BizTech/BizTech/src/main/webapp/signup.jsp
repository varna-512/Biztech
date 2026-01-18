<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Signup | BizTech</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="auth-body">

<div class="auth-box">

    <div class="title">BizTech</div>
    <div class="subtitle">Create Account</div>

    <% String msg = (String) request.getAttribute("msg");
       if (msg != null) { %>
        <div class="msg"><%= msg %></div>
    <% } %>

    <form action="signup" method="post">

        <label>Name</label>
        <input type="text" name="name" placeholder="Enter your name" required>

        <label>Email</label>
        <input type="email" name="email" placeholder="Enter your email" required>

        <label>Password</label>
        <input type="password" name="password" placeholder="Create password" required>

        <label>Confirm Password</label>
        <input type="password" name="confirmPassword" placeholder="Confirm password" required>

        <label>Role</label>
        <select name="role" required>
            <option value="">Select role</option>
            <option value="INVESTOR">Investor</option>
            <option value="CLIENT">Client</option>
        </select>

        <button type="submit">Signup</button>
    </form>

    <div class="switch">
        Have an account? <a href="login.jsp">Login</a>
    </div>

</div>

</body>
</html>
