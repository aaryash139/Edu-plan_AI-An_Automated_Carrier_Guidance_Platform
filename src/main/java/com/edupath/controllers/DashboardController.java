package com.edupath.controllers;

import com.edupath.dto.NotificationDto;
import com.edupath.models.AptitudeResult;
import com.edupath.models.College;
import com.edupath.models.User;
import com.edupath.repositories.AptitudeResultRepository;
import com.edupath.repositories.SavedCollegeRepository;
import com.edupath.repositories.Userrepositories;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
public class DashboardController {

    private static final DateTimeFormatter DATE_FMT =
            DateTimeFormatter.ofPattern("dd MMM yyyy", Locale.ENGLISH);

    @Autowired
    private Userrepositories userRepository;

    @Autowired
    private AptitudeResultRepository aptitudeResultRepository;

    @Autowired
    private SavedCollegeRepository savedCollegeRepository;

    @Autowired
    private com.edupath.repositories.CollegeRepository collegeRepository;

    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }

        User user = userRepository.findById(userId).orElse(null);
        if (user == null) {
            return "redirect:/login";
        }

        List<AptitudeResult> testHistory = aptitudeResultRepository
                .findByUser_IdOrderByTestDateDesc(userId);
        AptitudeResult latestResult = testHistory.isEmpty() ? null : testHistory.get(0);
        List<College> savedColleges = savedCollegeRepository.findCollegesByUserId(userId);

        int profileComplete = calculateProfileComplete(user);
        String profileClassLabel = buildProfileClassLabel(user);
        String recommendedStreamLabel = latestResult != null
                ? formatRecommendation(latestResult.getRecommendation())
                : "Take the aptitude test to discover your stream";
        String lastTestLabel = latestResult != null
                ? "Last test: " + latestResult.getTestDate().format(DATE_FMT)
                : "No tests taken yet";

        int unreadCount = 0;
        List<NotificationDto> notifications = buildNotifications(
                user, latestResult, savedColleges.size(), profileComplete);
        for (NotificationDto n : notifications) {
            if (n.isUnread()) {
                unreadCount++;
            }
        }

        Set<String> savedStates = savedColleges.stream()
                .map(College::getState)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());

        model.addAttribute("student", user);
        model.addAttribute("testHistory", testHistory);
        model.addAttribute("testCount", testHistory.size());
        model.addAttribute("latestResult", latestResult);
        model.addAttribute("savedColleges", savedColleges);
        model.addAttribute("savedCount", savedColleges.size());
        model.addAttribute("savedStateCount", savedStates.size());
        model.addAttribute("bestAptScore", testHistory.stream()
                .mapToInt(AptitudeResult::getAptScore)
                .max()
                .orElse(0) + "/10");
        model.addAttribute("profileComplete", profileComplete);
        model.addAttribute("profileClassLabel", profileClassLabel);
        model.addAttribute("recommendedStreamLabel", recommendedStreamLabel);
        model.addAttribute("lastTestLabel", lastTestLabel);
        model.addAttribute("notifications", notifications);
        model.addAttribute("unreadCount", unreadCount);
        model.addAttribute("memberSince", user.getCreatedAt().format(
                DateTimeFormatter.ofPattern("MMM yyyy", Locale.ENGLISH)));

        List<College> recommendedColleges = new ArrayList<>();
        List<College> beyondStateColleges = new ArrayList<>();
        
        if ("12".equals(user.getUserClass()) && isFilled(user.getState()) && isFilled(user.getStream()) && user.getPercentage() != null) {
            
            // Smart Category Cutoff Logic
            int effectiveCutoff = user.getPercentage().intValue();
            if ("OBC".equals(user.getCategory())) effectiveCutoff += 5; // give 5% buffer
            if ("SC/ST".equals(user.getCategory())) effectiveCutoff += 10; // give 10% buffer
            
            recommendedColleges = collegeRepository.findRecommendations(user.getState(), user.getStream(), effectiveCutoff);
            if (recommendedColleges.size() > 4) {
                recommendedColleges = recommendedColleges.subList(0, 4);
            }
            
            beyondStateColleges = collegeRepository.findBeyondStateRecommendations(user.getState(), user.getStream(), effectiveCutoff);
            if (beyondStateColleges.size() > 4) {
                beyondStateColleges = beyondStateColleges.subList(0, 4);
            }
        }
        model.addAttribute("aiColleges", recommendedColleges);
        model.addAttribute("beyondStateColleges", beyondStateColleges);

        return "dashboard";
    }

    @PostMapping("/updateProfile")
    public String updateProfile(
            @RequestParam String firstName,
            @RequestParam String lastName,
            @RequestParam String mobile,
            @RequestParam String userClass,
            @RequestParam String stream,
            @RequestParam String state,
            @RequestParam(required = false) Double percentage,
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String targetExam,
            @RequestParam(required = false) Integer expectedExamScore,
            HttpSession session) {

        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }

        User user = userRepository.findById(userId).orElse(null);
        if (user == null) {
            return "redirect:/login";
        }

        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setMobile(mobile);
        user.setUserClass(userClass);
        user.setStream(stream);
        user.setState(state);
        if (percentage != null) {
            user.setPercentage(percentage);
        }
        if (category != null) {
            user.setCategory(category);
        }
        if (targetExam != null) {
            user.setTargetExam(targetExam);
        }
        if (expectedExamScore != null) {
            user.setExpectedExamScore(expectedExamScore);
        }

        userRepository.save(user);
        session.setAttribute("username", firstName + " " + user.getLastName());

        return "redirect:/dashboard?profileUpdated=true";
    }

    private int calculateProfileComplete(User user) {
        int filled = 0;
        if (isFilled(user.getFirstName())) filled++;
        if (isFilled(user.getLastName())) filled++;
        if (isFilled(user.getMobile())) filled++;
        if (isFilled(user.getUserClass())) filled++;
        if (isFilled(user.getStream())) filled++;
        if (isFilled(user.getState())) filled++;
        if (user.getPercentage() != null) filled++;
        return Math.round((filled * 100f) / 7f);
    }

    private boolean isFilled(String value) {
        return value != null && !value.isBlank();
    }

    private String buildProfileClassLabel(User user) {
        if (!isFilled(user.getUserClass()) && !isFilled(user.getStream())) {
            return "Complete your profile";
        }
        String cls = isFilled(user.getUserClass()) ? "Class " + user.getUserClass() : "Class not set";
        String stream = isFilled(user.getStream()) ? user.getStream() : "Stream not set";
        return cls + " · " + stream;
    }

    private String formatRecommendation(String recommendation) {
        if (recommendation == null) {
            return "Not available";
        }
        return switch (recommendation.toUpperCase(Locale.ENGLISH)) {
            case "PCM" -> "Science (PCM)";
            case "COMM" -> "Commerce";
            case "ARTS" -> "Arts / Humanities";
            default -> recommendation;
        };
    }

    private List<NotificationDto> buildNotifications(User user,
                                                   AptitudeResult latestResult,
                                                   int savedCount,
                                                   int profileComplete) {
        List<NotificationDto> notifications = new ArrayList<>();

        notifications.add(new NotificationDto(
                "Welcome to EduPath!",
                "Your account is ready. Start by taking the aptitude test to discover your ideal career path.",
                user.getCreatedAt().format(DATE_FMT),
                latestResult == null
        ));

        if (latestResult != null) {
            notifications.add(new NotificationDto(
                    "Your aptitude result is ready",
                    "You scored " + latestResult.getAptScore() + "/10. Recommended stream: "
                            + formatRecommendation(latestResult.getRecommendation()) + ".",
                    latestResult.getTestDate().format(DATE_FMT),
                    true
            ));
        }

        if (profileComplete < 100) {
            notifications.add(new NotificationDto(
                    "Complete your profile",
                    "Your profile is " + profileComplete + "% complete. Add class, stream, state, and percentage for better recommendations.",
                    "Profile",
                    profileComplete < 85
            ));
        }

        if (savedCount > 0) {
            notifications.add(new NotificationDto(
                    "Saved colleges updated",
                    "You have " + savedCount + " college(s) in your shortlist. Compare fees, cut-offs, and exams anytime.",
                    "Saved list",
                    false
            ));
        }

        return notifications;
    }
}
