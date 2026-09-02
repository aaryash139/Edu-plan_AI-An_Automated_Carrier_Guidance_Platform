package com.edupath.service;

import java.util.List;

/**
 * Ek course ka poora description hold karta hai.
 * Class 12 wale students ke liye use hoga.
 */
public class CourseRecommendation {

    private final String courseName;       // e.g. "B.Tech Computer Science"
    private final String duration;         // e.g. "4 Years"
    private final String category;         // e.g. "Engineering"
    private final String description;      // short 1-line description
    private final List<String> topExams;   // e.g. ["JEE Main", "JEE Advanced"]
    private final List<String> careerPaths;// e.g. ["Software Engineer", "Data Scientist"]
    private final String matchReason;      // why this course matches user's aptitude
    private final int matchScore;          // 0–100, higher = stronger match

    public CourseRecommendation(String courseName, String duration, String category,
                                String description, List<String> topExams,
                                List<String> careerPaths, String matchReason, int matchScore) {
        this.courseName   = courseName;
        this.duration     = duration;
        this.category     = category;
        this.description  = description;
        this.topExams     = topExams;
        this.careerPaths  = careerPaths;
        this.matchReason  = matchReason;
        this.matchScore   = matchScore;
    }

    public String getCourseName()        { return courseName; }
    public String getDuration()          { return duration; }
    public String getCategory()          { return category; }
    public String getDescription()       { return description; }
    public List<String> getTopExams()    { return topExams; }
    public List<String> getCareerPaths() { return careerPaths; }
    public String getMatchReason()       { return matchReason; }
    public int getMatchScore()           { return matchScore; }
}