<%@ page import="java.util.ArrayList" %>
<%@ page import="com.biztech.model.Idea" %>
<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    ArrayList<Idea> ideas = (ArrayList<Idea>) request.getAttribute("ideas");
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Ideas | BizTech</title>
    <link rel="stylesheet" href="css/viewIdeas.css">
</head>
<body>

<div class="header">
    <h2>My Ideas</h2>
    <p>All ideas you have submitted</p>
</div>

<div class="content">

    <div class="action-bar">
        <a href="add_idea.jsp" class="btn-primary">+ Add New Idea</a>
    </div>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Type</th>
                    <th>Category</th>
                    <th>Stage</th>
                    <th>Status</th>
                    <th>Submitted</th>
                </tr>
            </thead>
            <tbody>
            <%
                if (ideas != null && !ideas.isEmpty()) {
                    for (Idea i : ideas) {
            %>
                <tr>
                    <td><%= i.getTitle() %></td>
                    <td><%= i.getIdeaType() %></td>
                    <td><%= i.getCategory() %></td>
                    <td><%= i.getStage() %></td>
                    <td>
                        <span class="status <%= i.getStatus().toLowerCase() %>">
                            <%= i.getStatus() %>
                        </span>
                    </td>
                    <td><%= i.getCreatedAt() %></td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="6" style="text-align:center;">No ideas submitted yet.</td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

</div>

</body>
</html>
