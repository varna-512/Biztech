
<%@ page import="java.sql.*" %>
<%@ page import="dao.DBConnection" %>

<%
Integer userId = (Integer) session.getAttribute("userId");
String role = (String) session.getAttribute("role");
String connIdStr = request.getParameter("connectionId");

if (userId == null || connIdStr == null) {
    response.sendRedirect("login.jsp");
    return;
}

int connectionId = Integer.parseInt(connIdStr);

/* Check connection is ACCEPTED */
Connection conCheck = DBConnection.getConnection();
PreparedStatement psCheck = conCheck.prepareStatement(
    "SELECT c.status, i.title " +
    "FROM connections c JOIN ideas i ON c.idea_id=i.idea_id " +
    "WHERE c.connection_id=?"
);
psCheck.setInt(1, connectionId);
ResultSet rsCheck = psCheck.executeQuery();

String ideaTitle = "";
if (rsCheck.next()) {
    if (!"ACCEPTED".equals(rsCheck.getString("status"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    ideaTitle = rsCheck.getString("title");
}
conCheck.close();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chat | BizTech</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<div class="header">
    <h1>BizTech</h1>
    <div class="welcome">Chat – <%= ideaTitle %></div>
    <div class="role">Role: <%= role %></div>
</div>

<div class="container">

    <!-- CHAT MESSAGES -->
    <div class="card" style="max-height:400px; overflow-y:auto;">

<%
Connection con = DBConnection.getConnection();
PreparedStatement ps = con.prepareStatement(
    "SELECT m.message, m.sent_at, u.name, m.sender_id " +
    "FROM messages m JOIN users u ON m.sender_id=u.user_id " +
    "WHERE m.connection_id=? ORDER BY m.sent_at"
);
ps.setInt(1, connectionId);
ResultSet rs = ps.executeQuery();

while (rs.next()) {
    boolean isMe = rs.getInt("sender_id") == userId;
%>

        <div style="margin-bottom:12px;">
            <strong><%= isMe ? "You" : rs.getString("name") %>:</strong>
            <p style="margin:4px 0;"><%= rs.getString("message") %></p>
            <small style="color:#6b7280;"><%= rs.getTimestamp("sent_at") %></small>
        </div>

<%
}
con.close();
%>

    </div>

    <!-- SEND MESSAGE -->
    <div class="card">
        <form action="<%= request.getContextPath() %>/sendMessage" method="post">
            <input type="hidden" name="connectionId" value="<%= connectionId %>">
            <textarea name="message" rows="3" placeholder="Type your message..." required></textarea>
            <br>
            <button class="btn-primary">Send</button>
        </form>
    </div>

</div>

</body>
</html>
