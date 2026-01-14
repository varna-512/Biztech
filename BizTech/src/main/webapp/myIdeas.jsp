<%@ page import="java.util.*, com.biztech.model.Idea" %>

<h2>My Ideas</h2>

<table border="1">
<tr>
    <th>Title</th>
    <th>Type</th>
    <th>Category</th>
    <th>Stage</th>
</tr>

<%
ArrayList<Idea> ideas = (ArrayList<Idea>) request.getAttribute("ideas");
for (Idea i : ideas) {
%>
<tr>
    <td><%= i.getTitle() %></td>
    <td><%= i.getIdeaType() %></td>
    <td><%= i.getCategory() %></td>
    <td><%= i.getStage() %></td>
</tr>
<% } %>
</table>
