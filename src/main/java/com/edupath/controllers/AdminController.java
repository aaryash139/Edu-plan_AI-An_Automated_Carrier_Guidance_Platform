package com.edupath.controllers;

import com.edupath.models.College;
import com.edupath.repositories.CollegeRepository;
import com.edupath.repositories.Userrepositories;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class AdminController {

    @Autowired
    private CollegeRepository collegeRepository;

    @Autowired
    private Userrepositories userRepository;

    @GetMapping("/admin")
    public String adminDashboard(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/dashboard?error=access";
        }

        List<College> colleges = collegeRepository.findAll();
        model.addAttribute("colleges", colleges);
        model.addAttribute("collegeCount", colleges.size());
        
        List<com.edupath.models.User> users = userRepository.findAll();
        model.addAttribute("users", users);
        model.addAttribute("userCount", users.size());
        
        model.addAttribute("username", session.getAttribute("username"));
        return "admin";
    }

    @PostMapping("/admin/colleges/add")
    public String addCollege(
            @RequestParam String name,
            @RequestParam String city,
            @RequestParam String state,
            @RequestParam String collegeType,
            @RequestParam String stream,
            @RequestParam int fees,
            @RequestParam int cutoff,
            @RequestParam int nirfRank,
            @RequestParam(required = false) String entranceExam,
            @RequestParam(defaultValue = "0") double rating,
            @RequestParam(defaultValue = "80%") String placementRate,
            @RequestParam(defaultValue = "₹5 LPA") String avgPackage,
            @RequestParam(defaultValue = "TCS, Infosys") String topRecruiters,
            @RequestParam(defaultValue = "Hostel, Labs, Library") String facilities,
            HttpSession session) {

        if (!isAdmin(session)) {
            return "redirect:/dashboard?error=access";
        }

        College college = new College();
        college.setName(name);
        college.setCity(city);
        college.setState(state);
        college.setCollegeType(collegeType);
        college.setStream(stream);
        college.setFees(fees);
        college.setCutoff(cutoff);
        college.setNirfRank(nirfRank);
        college.setEntranceExam(entranceExam != null ? entranceExam.trim() : "");
        college.setRating(rating);
        college.setPlacementRate(placementRate);
        college.setAvgPackage(avgPackage);
        college.setTopRecruiters(topRecruiters);
        college.setFacilities(facilities);
        collegeRepository.save(college);

        return "redirect:/admin?msg=added";
    }

    @PostMapping("/admin/colleges/delete")
    public String deleteCollege(@RequestParam Long collegeId, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/dashboard?error=access";
        }

        collegeRepository.deleteById(collegeId);
        return "redirect:/admin?deleted=true";
    }

    private boolean isAdmin(HttpSession session) {
        Object role = session.getAttribute("role");
        return role != null && "admin".equalsIgnoreCase(role.toString());
    }
}
