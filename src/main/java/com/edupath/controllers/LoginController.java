package com.edupath.controllers;

import com.edupath.models.User;
import com.edupath.repositories.Userrepositories;
import com.edupath.service.PasswordService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class LoginController {

    @Autowired
    private Userrepositories userRepository;

    @Autowired
    private PasswordService passwordService;

    @Value("${edupath.admin.code:EDUPATH_ADMIN_2025}")
    private String adminSecretCode;

    // ── TEMPORARY TEST ENDPOINT ──
    @GetMapping("/ping")
    @ResponseBody
    public String ping() {
        return "pong";
    }
    // ──────────────────────────────

    @GetMapping("/login")
    public String showLoginPage(
            @RequestParam(required = false) String error,
            @RequestParam(required = false) String registered,
            @RequestParam(required = false) String role,
            @RequestParam(required = false) String next,
            Model model) {

        if (error != null) {
            if ("role".equals(error)) {
                model.addAttribute("errorMsg", "This account does not match the selected login type.");
            } else if ("admincode".equals(error)) {
                model.addAttribute("errorMsg", "Invalid admin secret code. Access denied.");
            } else {
                model.addAttribute("errorMsg", "Invalid email or password.");
            }
        }
        if (registered != null) {
            model.addAttribute("successMsg", "Account created! Please login.");
        }
        if (next != null && !next.isBlank()) {
            model.addAttribute("nextUrl", next);
        }
        if (role != null) {
            model.addAttribute("loginRole", role);
        }
        return "login";
    }

    @PostMapping("/LoginServlet")
    public String processLogin(
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam(defaultValue = "student") String userRole,
            @RequestParam(required = false) String adminCode,
            @RequestParam(required = false) String next,
            HttpSession session) {

        String expectedRole = userRole == null || userRole.isBlank() ? "student" : userRole.trim().toLowerCase();

        if ("admin".equals(expectedRole)) {
            if (adminCode == null || !adminSecretCode.equals(adminCode.trim())) {
                return "redirect:/login?error=admincode";
            }
        }

        User user = userRepository.findByEmail(email.trim()).orElse(null);

        if (user == null || !passwordService.matches(password, user.getPasswordHash())) {
            return "redirect:/login?error=true";
        }

        if (!expectedRole.equalsIgnoreCase(user.getRole())) {
            return "redirect:/login?error=role";
        }

        session.setAttribute("userId", user.getId());
        session.setAttribute("username", user.getFirstName() + " " + user.getLastName());
        session.setAttribute("email", user.getEmail());
        session.setAttribute("role", user.getRole());

        if ("admin".equalsIgnoreCase(user.getRole())) {
            return "redirect:/admin";
        }

        if (next != null && !next.isBlank() && next.startsWith("/") && !next.startsWith("//")) {
            return "redirect:" + next;
        }
        return "redirect:/dashboard";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}