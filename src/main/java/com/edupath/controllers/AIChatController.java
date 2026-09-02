package com.edupath.controllers;

import com.edupath.models.User;
import com.edupath.repositories.Userrepositories;
import com.edupath.service.AIChatService;
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
@RequestMapping("/api/chat")
public class AIChatController {

    @Autowired
    private AIChatService aiChatService;

    @Autowired
    private Userrepositories userRepository;

    @PostMapping("/ask")
    public ResponseEntity<Map<String, String>> askEduPathAI(@RequestBody Map<String, String> payload, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("error", "Not logged in"));
        }

        User user = userRepository.findById(userId).orElse(null);
        if (user == null || !"12".equals(user.getUserClass())) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(Map.of("error", "EduPath AI Chat is exclusively for Class 12 students."));
        }

        String userMessage = payload.get("message");
        if (userMessage == null || userMessage.trim().isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of("error", "Message cannot be empty"));
        }

        // Build the secret context
        String stream = user.getStream() != null ? user.getStream() : "Unknown Stream";
        String state = user.getState() != null ? user.getState() : "Unknown State";
        String percent = user.getPercentage() != null ? user.getPercentage() + "%" : "Unknown Marks";
        String category = user.getCategory() != null ? user.getCategory() : "General";
        String targetExam = user.getTargetExam() != null ? user.getTargetExam() : "Not decided";
        String expectedScore = user.getExpectedExamScore() != null ? String.valueOf(user.getExpectedExamScore()) : "Not provided";

        String context = String.format("Stream: %s | State: %s | 12th Marks: %s | Category: %s | Target Exam: %s | Expected Exam Score/Rank: %s",
                stream, state, percent, category, targetExam, expectedScore);

        String aiResponse = aiChatService.getChatResponse(userMessage, context);

        return ResponseEntity.ok(Map.of("reply", aiResponse));
    }
}
