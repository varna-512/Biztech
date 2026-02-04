<%@ page language="java" contentType="text/html; charset=UTF-8" %>
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
    <title>Connection Requests | BizTech</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

<div class="container">
    <h2>Connection Requests</h2>

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
boolean hasData = false;

try {
    con = DBConnection.getConnection();

    ps = con.prepareStatement(
        "SELECT c.connection_id, c.status, " +
        "u.name AS investor_name, " +
        "i.title AS idea_title, " +
        // 🔹 ADDED PROFILE FIELDS
        "p.experience, p.interest, p.bio " +
        "FROM connections c " +
        "JOIN ideas i ON c.idea_id = i.idea_id " +
        "JOIN users u ON c.investor_id = u.user_id " +
        "LEFT JOIN profiles p ON p.user_id = u.user_id " +
        "WHERE i.user_id = ? " +
        "ORDER BY c.created_at DESC"
    );

    ps.setInt(1, userId);
    rs = ps.executeQuery();

    while (rs.next()) {
        hasData = true;
        String status = rs.getString("status");
%>

    <div class="card">
        <h3><%= rs.getString("idea_title") %></h3>

        <p><strong>Investor:</strong> <%= rs.getString("investor_name") %></p>

        <!-- 🔹 ADDED PROFILE DETAILS -->
        <p>
            <strong>Experience:</strong>
            <%= rs.getInt("experience") %> years
        </p>

        <p>
            <strong>Interest:</strong>
            <%= rs.getString("interest") != null
                    ? rs.getString("interest")
                    : "Not specified" %>
        </p>

        <p>
            <strong>Bio:</strong><br>
            <%= rs.getString("bio") != null
                    ? rs.getString("bio")
                    : "No bio available" %>
        </p>
        <!-- 🔹 END PROFILE DETAILS -->

        <p><strong>Status:</strong> <%= status %></p>

        <% if ("REQUESTED".equals(status)) { %>

            <form action="<%= request.getContextPath() %>/updateConnection" method="post">
                <input type="hidden" name="connectionId"
                       value="<%= rs.getInt("connection_id") %>">

                <button type="submit" name="status" value="ACCEPTED">
                    Accept
                </button>

                <button type="submit" name="status" value="DECLINED">
                    Decline
                </button>
            </form>

        <% } else if ("ACCEPTED".equals(status)) { %>

            <p style="color: green;"><strong>✔ Connection Accepted</strong></p>

            <a href="<%= request.getContextPath() %>/chat.jsp?connectionId=<%= rs.getInt("connection_id") %>">
                <button>Chat</button>
            </a>

        <% } else { %>

            <p style="color: gray;">Connection Closed</p>

        <% } %>
    </div>

<%
    }

    if (!hasData) {
%>
    <div class="card">
        <p>No connection requests available.</p>
    </div>
<%
    }

} catch (Exception e) {
    e.printStackTrace();
%>
    <div class="card">
        <p style="color:red;">Error loading connection requests.</p>
        <pre><%= e.getMessage() %></pre>
    </div>
<%
} finally {
    try { if (rs != null) rs.close(); } catch (Exception ignored) {}
    try { if (ps != null) ps.close(); } catch (Exception ignored) {}
    try { if (con != null) con.close(); } catch (Exception ignored) {}
}
%>

    <div class="card">
        <a href="clientDashboard.jsp">
            <button>Back to Dashboard</button>
        </a>
    </div>

</div>

</body>
</html>
