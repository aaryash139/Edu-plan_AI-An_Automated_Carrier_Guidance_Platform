package com.edupath.controllers;

import com.edupath.models.College;
import com.edupath.models.SavedCollege;
import com.edupath.models.User;
import com.edupath.repositories.CollegeRepository;
import com.edupath.repositories.SavedCollegeRepository;
import com.edupath.repositories.Userrepositories;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Comparator;
import java.util.List;

@Controller
public class CollegeController {

    @Autowired
    private CollegeRepository collegeRepository;

    @Autowired
    private SavedCollegeRepository savedCollegeRepository;

    @Autowired
    private Userrepositories userRepository;

    @GetMapping("/colleges")
    public String showColleges(
            @RequestParam(defaultValue = "") String search,
            @RequestParam(defaultValue = "") String state,
            @RequestParam(defaultValue = "") String stream,
            @RequestParam(defaultValue = "") String type,
            @RequestParam(defaultValue = "2000000") int maxFees,
            @RequestParam(defaultValue = "50") int minCutoff,
            @RequestParam(defaultValue = "9999") int maxRank,
            @RequestParam(value = "exam", required = false) List<String> exams,
            @RequestParam(defaultValue = "rank") String sortBy,
            HttpSession session,
            Model model) {

        List<College> colleges = collegeRepository.searchColleges(
                search, state, stream, type, maxFees, minCutoff, maxRank
        );

        if (exams != null && !exams.isEmpty()) {
            colleges.removeIf(c -> c.getEntranceExam() == null || !exams.contains(c.getEntranceExam()));
        }

        sortColleges(colleges, sortBy);

        model.addAttribute("colleges", colleges);
        model.addAttribute("resultCount", colleges.size());
        model.addAttribute("filterSearch", search);
        model.addAttribute("filterState", state);
        model.addAttribute("filterStream", stream);
        model.addAttribute("filterType", type);
        model.addAttribute("filterMaxFees", maxFees);
        model.addAttribute("filterCutoff", minCutoff);
        model.addAttribute("filterRank", maxRank);
        model.addAttribute("filterExams", exams);
        model.addAttribute("filterSort", sortBy);

        Long userId = (Long) session.getAttribute("userId");
        if (userId != null) {
            model.addAttribute("savedCollegeIds", savedCollegeRepository.findCollegeIdsByUserId(userId));
        }

        return "collegesearch";
    }

    @PostMapping("/saveCollege")
    @ResponseBody
    public String saveCollege(
            @RequestParam Long collegeId,
            @RequestParam String action,
            HttpSession session) {

        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) return "NOT_LOGGED_IN";

        User user = userRepository.findById(userId).orElse(null);
        if (user == null) return "NOT_LOGGED_IN";

        College college = collegeRepository.findById(collegeId).orElse(null);
        if (college == null) return "COLLEGE_NOT_FOUND";

        if ("save".equals(action)) {
            if (savedCollegeRepository.existsByUser_IdAndCollege_Id(userId, collegeId)) {
                return "ALREADY_SAVED";
            }
            SavedCollege saved = new SavedCollege();
            saved.setUser(user);
            saved.setCollege(college);
            savedCollegeRepository.save(saved);
            return "SAVED";
        }

        if ("remove".equals(action)) {
            savedCollegeRepository.deleteByUser_IdAndCollege_Id(userId, collegeId);
            return "REMOVED";
        }

        return "UNKNOWN_ACTION";
    }

    private void sortColleges(List<College> colleges, String sortBy) {
        switch (sortBy) {
            case "fees" -> colleges.sort(Comparator.comparing(College::getFees));
            case "cutoff" -> colleges.sort(Comparator.comparing(College::getCutoff).reversed());
            case "name" -> colleges.sort(Comparator.comparing(College::getName, String.CASE_INSENSITIVE_ORDER));
            default -> colleges.sort(Comparator.comparing(College::getNirfRank));
        }
    }

    @GetMapping("/college/{id}")
    public String showCollegeDetails(@PathVariable Long id, HttpSession session, Model model) {
        College college = collegeRepository.findById(id).orElse(null);
        if (college == null) {
            return "redirect:/colleges";
        }
        
        Long userId = (Long) session.getAttribute("userId");
        if (userId != null) {
            boolean isSaved = savedCollegeRepository.existsByUser_IdAndCollege_Id(userId, id);
            model.addAttribute("isSaved", isSaved);
        }
        
        model.addAttribute("college", college);
        return "college-details";
    }
}
