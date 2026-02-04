<!DOCTYPE html>

<html>
<head>
    <title>Add Idea | BizTech</title>
    <link rel="stylesheet" href="../css/style.css">
    
</head>
<body>
<div class="header">
    <h1>BizTech</h1>
    <div class="welcome">Idea Submission</div>
    <div class="role">Role: <%= session.getAttribute("role") %></div>
</div>
<div class="card">
        <a href="clientDashboard.jsp">
            <button>Back to Dashboard</button>
        </a>
    </div>

   
    
</div>


<div class="container">
    <div class="card">
        <h2>Submit New Idea</h2>

        <form action="../addIdea" method="post">

            <!-- Idea Title -->
            <input type="text" name="title" placeholder="Idea Title" required>

            <!-- Idea Nature -->
            <select name="ideaNature" required>
                <option value="" disabled selected>Select Idea Type</option>
                <option value="STUDENT">Student Project</option>
                <option value="TECHNOLOGY">Technology</option>
                <option value="BUSINESS_MODEL">Business Model</option>
                <option value="STARTUP">Startup</option>
                <option value="SOCIAL_IMPACT">Social Impact</option>
            </select>

            <!-- Category -->
            <input type="text" name="category" placeholder="Category (eg: FinTech, Health, AI)">

            <!-- Stage -->
            <select name="stage" required>
                <option value="" disabled selected>Select Stage</option>
                <option value="IDEA">Idea</option>
                <option value="PROTOTYPE">Prototype</option>
                <option value="MVP">MVP</option>
            </select>

            <!-- Problem -->
            <textarea name="problem" placeholder="Problem"></textarea>

            <!-- Solution -->
            <textarea name="solution" placeholder="Solution"></textarea>

            <!-- Description -->
            <textarea name="description" placeholder="Description"></textarea>

            <!-- Submit -->
            <button type="submit">Submit Idea</button>
            
            
            

        </form>
    </div>
</div>

</body>
</html>
