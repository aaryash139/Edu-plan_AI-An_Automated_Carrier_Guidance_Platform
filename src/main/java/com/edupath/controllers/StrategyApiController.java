package com.edupath.controllers;

import com.edupath.models.College;
import com.edupath.models.User;
import com.edupath.repositories.CollegeRepository;
import com.edupath.repositories.SavedCollegeRepository;
import com.edupath.repositories.Userrepositories;
import com.edupath.service.GeminiStrategyService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/strategy")
public class StrategyApiController {

    @Autowired
    private GeminiStrategyService geminiStrategyService;

    @Autowired
    private Userrepositories userRepository;

    @Autowired
    private SavedCollegeRepository savedCollegeRepository;
    
    @Autowired
    private CollegeRepository collegeRepository;

    @PostMapping("/generate")
    public ResponseEntity<Map<String, String>> generateStrategy(HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("error", "Not logged in"));
        }

        User user = userRepository.findById(userId).orElse(null);
        if (user == null || !"12".equals(user.getUserClass())) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(Map.of("error", "Only available for Class 12 students"));
        }

        String stream = user.getStream();
        Double percentage = user.getPercentage();

        if (stream == null || stream.isBlank() || percentage == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("error", "Please complete your profile (Stream and Percentage) first."));
        }

        int savedCount = savedCollegeRepository.findCollegesByUserId(userId).size();

        String htmlStrategy = geminiStrategyService.generateStrategy(user, savedCount);

        return ResponseEntity.ok(Map.of("strategyHtml", htmlStrategy));
    }

    @PostMapping("/college-insights")
    public ResponseEntity<Map<String, String>> collegeInsights(@RequestBody Map<String, Long> payload, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("error", "Not logged in"));
        }
        
        Long collegeId = payload.get("collegeId");
        if (collegeId == null) {
            return ResponseEntity.badRequest().body(Map.of("error", "College ID missing"));
        }
        
        College college = collegeRepository.findById(collegeId).orElse(null);
        if (college == null) {
            return ResponseEntity.badRequest().body(Map.of("error", "College not found"));
        }
        
        String htmlInsights = geminiStrategyService.generateCollegeInsights(college);
        return ResponseEntity.ok(Map.of("insightsHtml", htmlInsights));
    }
}
