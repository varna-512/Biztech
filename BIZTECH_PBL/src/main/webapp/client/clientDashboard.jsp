<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Client Dashboard | BizTech</title>

    <!-- IMPORTANT: context-path safe CSS -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<!-- HEADER -->
<div class="header">
    <h1>BizTech</h1>
    <div class="welcome">
        Welcome, ${sessionScope.name}
    </div>
    <div class="role">
        Role: Client
    </div>
   
    
</div>

<!-- MAIN CONTENT -->
<div class="container">

    <div class="action-grid">

        <!-- Submit New Idea -->
        <div class="action-tile">
            <h3>Submit New Idea</h3>
            <p>Share your startup idea with potential investors.</p>
            <a href="addIdea.jsp">
                <button class="tile-btn secondary-btn">Submit Idea</button>
            </a>
        </div>

        <!-- My Ideas -->
        <div class="action-tile">
            <h3>My Ideas</h3>
            <p>View and manage all ideas you have submitted.</p>
            <a href="myIdeas.jsp">
                <button class="tile-btn secondary-btn">View My Ideas</button>
            </a>
        </div>

        <!-- Connection Requests -->
        <div class="action-tile">
            <h3>Connection Requests</h3>
            <p>Review investor requests and accept or decline them.</p>
            <a href="connectionRequests.jsp">
                <button class="tile-btn secondary-btn">View Requests</button>
            </a>
        </div>

        <!-- My Profile -->
        <div class="action-tile">
            <h3>My Profile</h3>
            <p>Manage your client profile and personal details.</p>
            <a href="profile.jsp">
                <button class="tile-btn secondary-btn">View Profile</button>
            </a>
        </div>
        
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
