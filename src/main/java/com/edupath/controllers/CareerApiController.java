package com.edupath.controllers;

import com.edupath.service.AIChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/career")
public class CareerApiController {

    @Autowired
    private AIChatService aiChatService;

    @PostMapping("/explore")
    public ResponseEntity<Map<String, String>> exploreCareer(@RequestBody Map<String, String> request) {
        String careerName = request.get("careerName");
        
        if (careerName == null || careerName.trim().isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of("error", "Career name is required"));
        }

        String htmlProfile = aiChatService.generateCareerProfile(careerName);
        return ResponseEntity.ok(Map.of("profileHtml", htmlProfile));
    }
}
