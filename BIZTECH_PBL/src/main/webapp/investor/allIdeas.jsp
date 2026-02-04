<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
/* ð Security */
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

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
    <title>Explore Ideas | BizTech</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<!-- HEADER -->
<div class="header">
    <h1>BizTech</h1>
    <div class="welcome">Explore Ideas</div>
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
boolean hasIdeas = false;

try {
    con = DBConnection.getConnection();

    ps = con.prepareStatement(
        "SELECT i.idea_id, i.title, i.idea_type, i.category, i.stage, " +
        "i.problem, i.solution, i.description, i.created_at, " +
        "u.name AS client_name " +
        "FROM ideas i " +
        "JOIN users u ON i.user_id = u.user_id " +
        "WHERE NOT EXISTS ( " +
        "   SELECT 1 FROM connections c " +
        "   WHERE c.idea_id = i.idea_id AND c.status = 'ACCEPTED' " +
        ") AND NOT EXISTS ( " +
        "   SELECT 1 FROM connections c2 " +
        "   WHERE c2.idea_id = i.idea_id AND c2.investor_id = ? " +
        ") " +
        "ORDER BY i.created_at DESC"
    );

    ps.setInt(1, investorId);
    rs = ps.executeQuery();

    while (rs.next()) {
        hasIdeas = true;
%>

    <div class="card">

        <h3><%= rs.getString("title") %></h3>

        <p><strong>Client:</strong> <%= rs.getString("client_name") %></p>
        <p><strong>Idea Type:</strong> <%= rs.getString("idea_type") %></p>
        <p><strong>Category:</strong> <%= rs.getString("category") %></p>
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

        <p class="muted">
            <strong>Submitted On:</strong> <%= rs.getTimestamp("created_at") %>
        </p>

        <form action="<%= request.getContextPath() %>/requestConnection" method="post">
            <input type="hidden" name="ideaId" value="<%= rs.getInt("idea_id") %>">
            <button class="btn-primary" type="submit">
                Send Connection Request
            </button>
        </form>

    </div>

<%
    }

    if (!hasIdeas) {
%>
    <div class="card">
        <p>No ideas available for exploration.</p>
    </div>
<%
    }

} catch (Exception e) {
    e.printStackTrace();
%>
    <div class="card">
        <p style="color:red;">Error loading ideas.</p>
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
