<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
Integer investorId = (Integer) session.getAttribute("userId");
if (investorId == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

String ideaIdStr = request.getParameter("ideaId");
if (ideaIdStr == null) {
    out.println("Invalid Idea");
    return;
}

int ideaId = Integer.parseInt(ideaIdStr);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Idea Details | BizTech</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<div class="header">
    <h1>BizTech</h1>
    <div class="welcome">Idea Details</div>
    <div class="role">Role: Investor</div>
</div>

<div class="container">

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    con = DBConnection.getConnection();

    ps = con.prepareStatement(
        "SELECT i.*, u.name AS client_name, u.email AS client_email " +
        "FROM ideas i " +
        "JOIN users u ON i.user_id = u.user_id " +
        "WHERE i.idea_id = ?"
    );

    ps.setInt(1, ideaId);
    rs = ps.executeQuery();

    if (rs.next()) {
%>

    <div class="card">
        <h2><%= rs.getString("title") %></h2>

        <p><strong>Idea Type:</strong> <%= rs.getString("idea_type") %></p>
        <p><strong>Category:</strong> <%= rs.getString("category") %></p>
        <p><strong>Stage:</strong> <%= rs.getString("stage") %></p>

        <hr>

        <p><strong>Problem:</strong></p>
        <p><%= rs.getString("problem") %></p>

        <p><strong>Solution:</strong></p>
        <p><%= rs.getString("solution") %></p>

        <p><strong>Description:</strong></p>
        <p><%= rs.getString("description") %></p>

        <hr>

        <h3>Client Details</h3>
        <p><strong>Name:</strong> <%= rs.getString("client_name") %></p>
        <p><strong>Email:</strong> <%= rs.getString("client_email") %></p>
    </div>

<%
    } else {
%>
    <div class="card">
        <p>Idea not found.</p>
    </div>
<%
    }

} catch (Exception e) {
    e.printStackTrace();
%>
    <div class="card">
        <p style="color:red;">Error loading idea details.</p>
    </div>
<%
} finally {
    try { if (rs != null) rs.close(); } catch (Exception ignored) {}
    try { if (ps != null) ps.close(); } catch (Exception ignored) {}
    try { if (con != null) con.close(); } catch (Exception ignored) {}
}
%>

<a href="connections.jsp">
    <button>Back to My Connections</button>
</a>

</div>

</body>
</html>
