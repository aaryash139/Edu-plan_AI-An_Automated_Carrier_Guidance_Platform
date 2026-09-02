package com.edupath.controllers;

import com.edupath.dto.CollegeDto;
import com.edupath.models.College;
import com.edupath.models.SavedCollege;
import com.edupath.models.User;
import com.edupath.repositories.CollegeRepository;
import com.edupath.repositories.SavedCollegeRepository;
import com.edupath.repositories.Userrepositories;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/colleges")
public class CollegeApiController {

    @Autowired
    private CollegeRepository collegeRepository;

    @Autowired
    private SavedCollegeRepository savedCollegeRepository;

    @Autowired
    private Userrepositories userRepository;

    @GetMapping
    public List<CollegeDto> searchColleges(
            @RequestParam(defaultValue = "") String search,
            @RequestParam(defaultValue = "") String state,
            @RequestParam(defaultValue = "") String stream,
            @RequestParam(defaultValue = "") String type,
            @RequestParam(defaultValue = "2000000") int maxFees,
            @RequestParam(defaultValue = "50") int minCutoff,
            @RequestParam(defaultValue = "9999") int maxRank,
            @RequestParam(value = "exam", required = false) List<String> exams,
            @RequestParam(defaultValue = "rank") String sort) {

        List<College> colleges = collegeRepository.searchColleges(
                search, state, stream, type, maxFees, minCutoff, maxRank
        );

        if (exams != null && !exams.isEmpty()) {
            colleges.removeIf(c -> c.getEntranceExam() == null || !exams.contains(c.getEntranceExam()));
        }

        sortColleges(colleges, sort);
        return colleges.stream().map(CollegeDto::from).collect(Collectors.toList());
    }

    @PostMapping("/save")
    public ResponseEntity<Map<String, String>> toggleSave(
            @RequestBody Map<String, Long> body,
            HttpSession session) {

        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        Long collegeId = body.get("collegeId");
        if (collegeId == null) {
            return ResponseEntity.badRequest().build();
        }

        User user = userRepository.findById(userId).orElse(null);
        College college = collegeRepository.findById(collegeId).orElse(null);
        if (user == null || college == null) {
            return ResponseEntity.badRequest().build();
        }

        if (savedCollegeRepository.existsByUser_IdAndCollege_Id(userId, collegeId)) {
            savedCollegeRepository.deleteByUser_IdAndCollege_Id(userId, collegeId);
            return ResponseEntity.ok(Map.of("status", "REMOVED"));
        }

        SavedCollege saved = new SavedCollege();
        saved.setUser(user);
        saved.setCollege(college);
        savedCollegeRepository.save(saved);
        return ResponseEntity.ok(Map.of("status", "SAVED"));
    }

    private void sortColleges(List<College> colleges, String sortBy) {
        switch (sortBy) {
            case "fees" -> colleges.sort(Comparator.comparing(College::getFees));
            case "cutoff" -> colleges.sort(Comparator.comparing(College::getCutoff).reversed());
            case "name" -> colleges.sort(Comparator.comparing(College::getName, String.CASE_INSENSITIVE_ORDER));
            default -> colleges.sort(Comparator.comparing(College::getNirfRank));
        }
    }
}
