package com.biztech.dao;

import java.sql.*;
import java.util.ArrayList;

import com.biztech.db.DBConnection;
import com.biztech.model.Idea;

public class IdeaDAO {

    // ADD IDEA
    public boolean addIdea(Idea i) {

        String sql =
            "INSERT INTO ideas (user_id, title, idea_type, category, problem, solution, target_market, stage, description) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, i.getUserId());
            ps.setString(2, i.getTitle());
            ps.setString(3, i.getIdeaType());
            ps.setString(4, i.getCategory());
            ps.setString(5, i.getProblem());
            ps.setString(6, i.getSolution());
            ps.setString(7, i.getTargetMarket());
            ps.setString(8, i.getStage());
            ps.setString(9, i.getDescription());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // FETCH IDEAS BY USER
    public ArrayList<Idea> getIdeasByUser(int userId) {

        ArrayList<Idea> list = new ArrayList<>();

        String sql =
            "SELECT * FROM ideas WHERE user_id=? ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Idea i = new Idea();
                i.setIdeaId(rs.getInt("idea_id"));
                i.setTitle(rs.getString("title"));
                i.setIdeaType(rs.getString("idea_type"));
                i.setCategory(rs.getString("category"));
                i.setStage(rs.getString("stage"));
                i.setStatus(rs.getString("status"));
                i.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(i);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
