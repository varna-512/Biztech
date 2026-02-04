package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/sendMessage")
public class SendMessageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        Integer userId = (Integer) req.getSession().getAttribute("userId");
        String connectionIdStr = req.getParameter("connectionId");
        String message = req.getParameter("message");

        if (userId == null || connectionIdStr == null || message == null || message.trim().isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int connectionId = Integer.parseInt(connectionIdStr);

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO messages (connection_id, sender_id, message) VALUES (?,?,?)"
            );
            ps.setInt(1, connectionId);
            ps.setInt(2, userId);
            ps.setString(3, message);

            ps.executeUpdate();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        res.sendRedirect(req.getContextPath() + "/chat.jsp?connectionId=" + connectionId);
    }
}
