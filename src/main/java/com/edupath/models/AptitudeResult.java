package com.edupath.models;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "aptitude_results")
public class AptitudeResult {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "apt_score", nullable = false)
    private int aptScore;

    @Column(name = "pcm_score", nullable = false)
    private int pcmScore;

    @Column(name = "comm_score", nullable = false)
    private int commScore;

    @Column(name = "arts_score", nullable = false)
    private int artsScore;

    @Column(name = "analyst_score", nullable = false)
    private int analystScore;

    @Column(name = "leader_score", nullable = false)
    private int leaderScore;

    @Column(name = "humanist_score", nullable = false)
    private int humanistScore;

    @Column(nullable = false, length = 20)
    private String recommendation;

    @Column(name = "gemini_recommendation", columnDefinition = "TEXT")
    private String geminiRecommendation;

    @Column(name = "test_date", nullable = false)
    private LocalDateTime testDate = LocalDateTime.now();

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public int getAptScore() { return aptScore; }
    public void setAptScore(int aptScore) { this.aptScore = aptScore; }

    public int getPcmScore() { return pcmScore; }
    public void setPcmScore(int pcmScore) { this.pcmScore = pcmScore; }

    public int getCommScore() { return commScore; }
    public void setCommScore(int commScore) { this.commScore = commScore; }

    public int getArtsScore() { return artsScore; }
    public void setArtsScore(int artsScore) { this.artsScore = artsScore; }

    public int getAnalystScore() { return analystScore; }
    public void setAnalystScore(int analystScore) { this.analystScore = analystScore; }

    public int getLeaderScore() { return leaderScore; }
    public void setLeaderScore(int leaderScore) { this.leaderScore = leaderScore; }

    public int getHumanistScore() { return humanistScore; }
    public void setHumanistScore(int humanistScore) { this.humanistScore = humanistScore; }

    public String getRecommendation() { return recommendation; }
    public void setRecommendation(String recommendation) { this.recommendation = recommendation; }

    public String getGeminiRecommendation() { return geminiRecommendation; }
    public void setGeminiRecommendation(String geminiRecommendation) { this.geminiRecommendation = geminiRecommendation; }

    public LocalDateTime getTestDate() { return testDate; }
    public void setTestDate(LocalDateTime testDate) { this.testDate = testDate; }
}
