package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/updateConnection")
public class UpdateConnectionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String connIdStr = req.getParameter("connectionId");
        String status = req.getParameter("status"); // ACCEPTED / DECLINED

        if (connIdStr == null || status == null) {
            res.sendRedirect(req.getContextPath() + "/client/connectionRequests.jsp");
            return;
        }

        int connectionId = Integer.parseInt(connIdStr);
        Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // 1️⃣ Update selected connection
            PreparedStatement ps1 = con.prepareStatement(
                "UPDATE connections SET status=? WHERE connection_id=?"
            );
            ps1.setString(1, status);
            ps1.setInt(2, connectionId);
            ps1.executeUpdate();

            // 2️⃣ If ACCEPTED → auto-decline others
            if ("ACCEPTED".equals(status)) {

                PreparedStatement psGet = con.prepareStatement(
                    "SELECT idea_id FROM connections WHERE connection_id=?"
                );
                psGet.setInt(1, connectionId);
                ResultSet rs = psGet.executeQuery();

                int ideaId = -1;
                if (rs.next()) {
                    ideaId = rs.getInt("idea_id");
                }

                rs.close();
                psGet.close();

                if (ideaId != -1) {
                    PreparedStatement ps2 = con.prepareStatement(
                        "UPDATE connections SET status='DECLINED' " +
                        "WHERE idea_id=? AND connection_id<>?"
                    );
                    ps2.setInt(1, ideaId);
                    ps2.setInt(2, connectionId);
                    ps2.executeUpdate();
                }
            }

            con.commit();

        } catch (Exception e) {
            try { if (con != null) con.rollback(); } catch (Exception ignored) {}
            e.printStackTrace();
        } finally {
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }

        res.sendRedirect(req.getContextPath() + "/client/connectionRequests.jsp");
    }
}
