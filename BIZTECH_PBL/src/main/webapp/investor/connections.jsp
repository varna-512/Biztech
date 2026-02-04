<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
Integer investorId = (Integer) session.getAttribute("userId");
if (investorId == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Connections | BizTech</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<div class="header">
    <h1>BizTech</h1>
    <div class="welcome">My Connections</div>
    <div class="role">Role: Investor</div>
</div>

<div class="card">
    <a href="investorDashboard.jsp">
        <button>Back to Dashboard</button>
    </a>
</div>

<div class="container">

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
boolean hasConnections = false;

try {
    con = DBConnection.getConnection();

    ps = con.prepareStatement(
        "SELECT c.connection_id, c.status, c.created_at, c.idea_id, " +
        "i.title AS idea_title, " +
        "u.name AS client_name " +
        "FROM connections c " +
        "JOIN ideas i ON c.idea_id = i.idea_id " +
        "JOIN users u ON i.user_id = u.user_id " +
        "WHERE c.investor_id = ? " +
        "ORDER BY c.created_at DESC"
    );

    ps.setInt(1, investorId);
    rs = ps.executeQuery();

    while (rs.next()) {
        hasConnections = true;
        String status = rs.getString("status");
        int ideaId = rs.getInt("idea_id");
%>

    <div class="card">
        <h3><%= rs.getString("idea_title") %></h3>

        <p><strong>Client:</strong> <%= rs.getString("client_name") %></p>
        <p><strong>Status:</strong> <%= status %></p>
        <p><strong>Requested On:</strong> <%= rs.getTimestamp("created_at") %></p>

        <!-- 🔹 NEW: View Idea (study back) -->
        <a href="viewIdea.jsp?ideaId=<%= ideaId %>">
            <button class="btn-secondary">View Idea</button>
        </a>

        <% if ("ACCEPTED".equals(status)) { %>
            <a href="<%= request.getContextPath() %>/chat.jsp?connectionId=<%= rs.getInt("connection_id") %>">
                <button class="btn-primary">Chat</button>
            </a>
        <% } %>
    </div>

<%
    }

    if (!hasConnections) {
%>
    <div class="card">
        <p>No connections yet.</p>
    </div>
<%
    }

} catch (Exception e) {
    e.printStackTrace();
%>
    <div class="card">
        <p style="color:red;">Error loading connections.</p>
        <pre><%= e.getMessage() %></pre>
    </div>
<%
} finally {
    try { if (rs != null) rs.close(); } catch (Exception ignored) {}
    try { if (ps != null) ps.close(); } catch (Exception ignored) {}
    try { if (con != null) con.close(); } catch (Exception ignored) {}
}
%>

</div>

</body>
</html>
