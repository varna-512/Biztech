<%
    // Prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Invalidate session
    if (session != null) {
        session.invalidate();
    }

    // Redirect to HOME page
    response.sendRedirect(request.getContextPath() + "/index.jsp");
%>
