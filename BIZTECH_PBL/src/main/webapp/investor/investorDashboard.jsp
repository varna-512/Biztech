<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Investor Dashboard | BizTech</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

</head>
<body>

<!-- HEADER -->
<div class="header">
    <h1>BizTech</h1>
    <div class="welcome">Welcome, <%= session.getAttribute("name") %></div>
    <div class="role">Role: Investor</div>
</div>

<!-- MAIN -->
<div class="container">

    <div class="action-grid">

        <!-- Explore Ideas -->
        <div class="action-tile">
            <h3>Explore Ideas</h3>
            <p>Discover innovative ideas submitted by founders and clients.</p>
            <a href="allIdeas.jsp">
                <button class="tile-btn secondary-btn">Explore Ideas</button>
            </a>
        </div>

        <!-- My Connections -->
        <div class="action-tile">
            <h3>My Connections</h3>
            <p>Track accepted and declined connections in one place.</p>
            <a href="connections.jsp">
                <button class="tile-btn secondary-btn">View Connections</button>
            </a>
        </div>

        <!-- My Profile -->
        <div class="action-tile">
            <h3>My Profile</h3>
            <p>Manage your investor profile and personal details.</p>
            <a href="profile.jsp">
                <button class="tile-btn secondary-btn">View Profile</button>
            </a>
        </div>

        <!-- Logout -->
        <div class="action-tile">
            <h3>Logout</h3>
            <p>Exit your BizTech account securely.</p>
            <a href="<%= request.getContextPath() %>/logout.jsp">
                <button class="tile-btn secondary-btn">Logout</button>
            </a>
        </div>

    </div>

</div>

</body>
</html>
