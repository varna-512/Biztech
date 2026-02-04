<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Ideas | BizTech</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<!-- HEADER -->
<div class="header">
    <h1>BizTech</h1>
    <div class="welcome">My Ideas</div>
    <div class="role">Role: Client</div>
</div>
<div class="card">
        <a href="clientDashboard.jsp">
            <button>Back to Dashboard</button>
        </a>
    </div>
<div class="container">

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    con = DBConnection.getConnection();
    ps = con.prepareStatement(
        "SELECT i.*, u.name AS investor_name " +
        "FROM ideas i " +
        "LEFT JOIN connections c ON i.idea_id = c.idea_id AND c.status='ACCEPTED' " +
        "LEFT JOIN users u ON c.investor_id = u.user_id " +
        "WHERE i.user_id=? ORDER BY i.created_at DESC"
    );
    ps.setInt(1, userId);
    rs = ps.executeQuery();

    boolean hasIdeas = false;

    while (rs.next()) {
        hasIdeas = true;
%>

    <div class="card">

        <h3><%= rs.getString("title") %></h3>

        <p><strong>Category:</strong> <%= rs.getString("category") %></p>
        <p><strong>Idea Type:</strong> <%= rs.getString("idea_type") %></p>
        <p><strong>Stage:</strong> <%= rs.getString("stage") %></p>

        <p><strong>Problem:</strong><br>
            <%= rs.getString("problem") %>
        </p>

        <p><strong>Solution:</strong><br>
            <%= rs.getString("solution") %>
        </p>

        <p><strong>Description:</strong><br>
            <%= rs.getString("description") %>
        </p>

        <hr>

        <p><strong>Created On:</strong> <%= rs.getTimestamp("created_at") %></p>

        <%
        String investor = rs.getString("investor_name");
        if (investor != null) {
        %>
            <p style="color:green;">
                <strong>Accepted By:</strong> <%= investor %>
            </p>
        <%
        } else {
        %>
            <p style="color:#f59e0b;">
                <strong>Status:</strong> Open for connections
            </p>
        <%
        }
        %>

    </div>

<%
    }

    if (!hasIdeas) {
%>
    <div class="card">
        <p>You haven't submitted any ideas yet.</p>
    </div>
<%
    }

} catch (Exception e) {
    e.printStackTrace();
%>
    <p style="color:red;">Error loading ideas.</p>
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
