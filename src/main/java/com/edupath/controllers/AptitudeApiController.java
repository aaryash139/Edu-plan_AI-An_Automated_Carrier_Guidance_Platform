package com.edupath.controllers;

import com.edupath.models.AptitudeResult;
import com.edupath.models.User;
import com.edupath.repositories.AptitudeResultRepository;
import com.edupath.repositories.Userrepositories;
import com.edupath.service.CourseRecommendation;
import com.edupath.service.CourserecommendationService;
import com.edupath.service.RecommendationService;
import com.edupath.service.GeminiService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * CHANGES FROM ORIGINAL:
 *  1. CourseRecommendationService inject kiya
 *  2. submit() mein user.getUserClass() check kiya
 *  3. Class 12 â†’ courses list response mein add ki
 *  4. Class 10 â†’ pehle jaisi stream recommendation wapas aati hai
 */
@RestController
@RequestMapping("/api/aptitude")
public class AptitudeApiController {

    @Autowired
    private AptitudeResultRepository aptitudeResultRepository;

    @Autowired
    private Userrepositories userRepository;

    @Autowired
    private RecommendationService recommendationService;

    // â† NAYA: Course recommendation service for Class 12
    @Autowired
    private CourserecommendationService courseRecommendationService;

    @Autowired
    private GeminiService geminiService;

    @PostMapping("/submit")
    public ResponseEntity<Map<String, Object>> submit(
            @RequestBody Map<String, Object> payload,
            HttpSession session) {

        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        User user = userRepository.findById(userId).orElse(null);
        if (user == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        // â”€â”€â”€ Scores read karo â”€â”€â”€
        int pcm      = readInt(payload, "level1", "pcm");
        int comm     = readInt(payload, "level1", "comm");
        int arts     = readInt(payload, "level1", "arts");
        int aptScore = readInt(payload, "level2", "aptitude_score");
        int analyst  = readInt(payload, "level3", "analyst");
        int leader   = readInt(payload, "level3", "leader");
        int humanist = readInt(payload, "level3", "humanist");

        // â”€â”€â”€ Base stream recommendation (PCM / COMM / ARTS) â”€â”€â”€
        String recommendation = recommendationService.recommend(
                aptScore, pcm, comm, arts, analyst, leader, humanist
        );

        // â”€â”€â”€ DB mein save karo â”€â”€â”€
        AptitudeResult result = new AptitudeResult();
        result.setUser(user);
        result.setAptScore(aptScore);
        result.setPcmScore(pcm);
        result.setCommScore(comm);
        result.setArtsScore(arts);
        result.setAnalystScore(analyst);
        result.setLeaderScore(leader);
        result.setHumanistScore(humanist);
        result.setRecommendation(recommendation);

        // Temporary placeholder for Gemini advice
        result.setGeminiRecommendation("Your detailed AI admission strategy is being generated. Please refresh the page in a few moments.");
        aptitudeResultRepository.save(result);

        // Run Gemini AI generation asynchronously to prevent blocking the UI
        new Thread(() -> {
            try {
                String geminiAdvice = geminiService.generateAdvice(result);
                result.setGeminiRecommendation(geminiAdvice);
                aptitudeResultRepository.save(result);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }).start();

        // â”€â”€â”€ Base response build karo â”€â”€â”€

        // â”€â”€â”€ Base response build karo â”€â”€â”€
        Map<String, Object> response = new LinkedHashMap<>(
                recommendationService.recommendDetailed(
                        payload, aptScore, pcm, comm, arts, analyst, leader, humanist)
        );
        if (!response.containsKey("recommendation")) {
            response.put("recommended_stream", recommendationService.toApiStream(recommendation));
            response.put("aptitude_score", aptScore);
            response.put("recommendation", recommendation);
        }
        response.put("gemini_recommendation", result.getGeminiRecommendation());

        // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        //  CLASS CHECK â†’ 12 hai toh courses add karo response mein
        // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        String userClass = user.getUserClass();     // "10" or "12" or null

        response.put("user_class", userClass);      // frontend ko bata do

        if ("12".equals(userClass)) {
            // â† NAYA BLOCK
            List<CourseRecommendation> courses = courseRecommendationService.recommend(
                    userClass,
                    user.getStream(),       // user profile ka stream (may be null)
                    recommendation,         // aptitude base result
                    aptScore,
                    analyst,
                    leader,
                    humanist
            );

            // Courses ko maps mein convert karo (JSON serialization ke liye)
            List<Map<String, Object>> courseList = courses.stream()
                    .map(c -> {
                        Map<String, Object> m = new LinkedHashMap<>();
                        m.put("name",         c.getCourseName());
                        m.put("duration",     c.getDuration());
                        m.put("category",     c.getCategory());
                        m.put("description",  c.getDescription());
                        m.put("exams",        c.getTopExams());
                        m.put("careers",      c.getCareerPaths());
                        m.put("match_reason", c.getMatchReason());
                        m.put("match_score",  c.getMatchScore());
                        return m;
                    })
                    .toList();

            response.put("courses",           courseList);
            response.put("result_type",       "COURSES");   // frontend check karega
            response.put("stream_used",       user.getStream() != null
                    ? user.getStream()
                    : recommendationService.toApiStream(recommendation));
        } else {
            // Class 10 ya unknown â†’ pehle jaisi stream recommendation
            response.put("result_type", "STREAM");
        }

        return ResponseEntity.ok(response);
    }

    // â”€â”€â”€ Unchanged helper â”€â”€â”€
    @SuppressWarnings("unchecked")
    private int readInt(Map<String, Object> payload, String section, String field) {
        Object sectionObj = payload.get(section);
        if (!(sectionObj instanceof Map<?, ?> sectionMap)) {
            return 0;
        }
        Object value = ((Map<String, Object>) sectionMap).get(field);
        if (value instanceof Number number) {
            return number.intValue();
        }
        return 0;
    }
}

