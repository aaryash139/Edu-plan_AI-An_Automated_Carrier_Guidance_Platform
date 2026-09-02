package com.edupath.controllers;

import com.edupath.models.User;
import com.edupath.repositories.Userrepositories;
import com.edupath.service.PasswordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class UserController {

    @Autowired
    private Userrepositories userRepository;

    @Autowired
    private PasswordService passwordService;

    @GetMapping("/signup")
    public String showSignupPage() {
        return "signup";
    }

    @PostMapping("/RegisterServlet")
    public String registerUser(@ModelAttribute User user, Model model) {
        if (userRepository.existsByEmail(user.getEmail())) {
            model.addAttribute("errorMsg", "This email is already registered.");
            return "signup";
        }

        user.setPasswordHash(passwordService.hash(user.getPasswordHash()));
        if (user.getRole() == null || user.getRole().isBlank()) {
            user.setRole("student");
        }

        userRepository.save(user);
        return "redirect:/login?registered=true";
    }
}
