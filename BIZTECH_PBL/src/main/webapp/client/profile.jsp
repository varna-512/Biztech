<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

String fullName = "";
String dob = "";
String experience = "";
String interest = "";
String bio = "";

Connection con = DBConnection.getConnection();
PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM profiles WHERE user_id=?"
);
ps.setInt(1, userId);
ResultSet rs = ps.executeQuery();

if (rs.next()) {
    fullName = rs.getString("full_name") == null ? "" : rs.getString("full_name");
    dob = rs.getString("dob") == null ? "" : rs.getString("dob");
    experience = rs.getString("experience") == null ? "" : rs.getString("experience");
    interest = rs.getString("interest") == null ? "" : rs.getString("interest");
    bio = rs.getString("bio") == null ? "" : rs.getString("bio");
}
con.close();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile | BizTech</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<!-- HEADER -->
<div class="header">
    <h1>BizTech</h1>
    <div class="welcome">My Profile</div>
    <div class="role">Role: <%= session.getAttribute("role") %></div>
</div>
<div class="card">
        <a href="clientDashboard.jsp">
            <button>Back to Dashboard</button>
        </a>
    </div>

<div class="container">

<!-- ✅ SUCCESS MESSAGE -->
<%
if ("1".equals(request.getParameter("saved"))) {
%>
    <div class="card" style="background:#dcfce7;border-left:6px solid #22c55e;">
        <p style="margin:0;color:#166534;font-weight:600;">
            ✅ Profile saved successfully
        </p>
    </div>
<%
}
%>

<div class="card">
<form action="<%= request.getContextPath() %>/saveProfile" method="post">

    <label>Full Name</label>
    <input type="text" name="fullName" value="<%= fullName %>">

    <label>Date of Birth</label>
    <input type="date" name="dob"
           value="<%= dob %>"
           min="<%= java.time.LocalDate.now().minusYears(100) %>"
           max="<%= java.time.LocalDate.now() %>">

    <label>Years of Experience</label>
    <input type="number" name="experience" value="<%= experience %>">

    <label>Field of Interest</label>
    <input type="text" name="interest" value="<%= interest %>">

    <label>Bio</label>
    <textarea name="bio"><%= bio %></textarea>

    <br><br>
    <button class="btn-primary">Save Profile</button>

</form>
</div>

</div>

</body>
</html>
