<%@ page session="true" %>
<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Submit New Idea | BizTech</title>
    <link rel="stylesheet" href="css/addIdea.css">
</head>
<body>

<div class="header">
    <h2>Submit New Idea</h2>
    <p>Provide details about your idea</p>
</div>

<div class="form-container">
    <form class="idea-form" action="addIdea" method="post">

        <div class="form-group">
            <label>Idea Title</label>
            <input type="text" name="title" required>
        </div>

        <div class="form-group">
            <label>Idea Type</label>
            <select name="ideaType">
                <option>Student</option>
                <option>Startup</option>
                <option>Small Business</option>
            </select>
        </div>

        <div class="form-group">
            <label>Category</label>
            <input type="text" name="category">
        </div>

        <div class="form-group">
            <label>Problem</label>
            <textarea name="problem"></textarea>
        </div>

        <div class="form-group">
            <label>Solution</label>
            <textarea name="solution"></textarea>
        </div>

        <div class="form-group">
            <label>Target Market</label>
            <input type="text" name="targetMarket">
        </div>

        <div class="form-group">
            <label>Stage</label>
            <select name="stage">
                <option>Idea</option>
                <option>Prototype</option>
                <option>Running</option>
            </select>
        </div>

        <div class="form-group">
            <label>Description</label>
            <textarea name="description"></textarea>
        </div>

        <div class="form-actions">
            <a href="client_dashboard" class="btn-secondary">Cancel</a>
            <button type="submit" class="btn-primary">Submit Idea</button>
        </div>

    </form>
</div>

</body>
</html>
