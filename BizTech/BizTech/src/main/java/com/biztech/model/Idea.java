package com.biztech.model;

import java.sql.Timestamp;

public class Idea {

    private int ideaId;
    private int userId;

    private String title;
    private String ideaType;
    private String category;

    private String problem;
    private String solution;
    private String targetMarket;
    private String stage;
    private String description;

    private String status;
    private Timestamp createdAt;

    public int getIdeaId() { return ideaId; }
    public void setIdeaId(int ideaId) { this.ideaId = ideaId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getIdeaType() { return ideaType; }
    public void setIdeaType(String ideaType) { this.ideaType = ideaType; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getProblem() { return problem; }
    public void setProblem(String problem) { this.problem = problem; }

    public String getSolution() { return solution; }
    public void setSolution(String solution) { this.solution = solution; }

    public String getTargetMarket() { return targetMarket; }
    public void setTargetMarket(String targetMarket) { this.targetMarket = targetMarket; }

    public String getStage() { return stage; }
    public void setStage(String stage) { this.stage = stage; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
