package com.edupath.controllers;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AptitudePageController {

    @GetMapping("/aptitude-test")
    public String aptitudeTest(HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login?next=/aptitude-test";
        }
        return "aptitude-test";
    }

    @GetMapping("/aptitude-result")
    public String aptitudeResult(HttpSession session) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login?next=/aptitude-result";
        }
        return "aptituderesult";
    }
}
