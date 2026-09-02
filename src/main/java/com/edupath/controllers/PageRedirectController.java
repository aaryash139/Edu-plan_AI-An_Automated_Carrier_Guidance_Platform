package com.edupath.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageRedirectController {

    @GetMapping("/index.jsp")
    public String indexJsp() { return "redirect:/"; }

    @GetMapping("/login.jsp")
    public String loginJsp() { return "redirect:/login"; }

    @GetMapping("/signup.jsp")
    public String signupJsp() { return "redirect:/signup"; }

    @GetMapping("/dashboard.jsp")
    public String dashboardJsp() { return "redirect:/dashboard"; }

    @GetMapping("/collegesearch.jsp")
    public String collegesJsp() { return "redirect:/colleges"; }

    @GetMapping("/college-search.jsp")
    public String collegeSearchJsp() { return "redirect:/colleges"; }

    @GetMapping("/aptitude-test.jsp")
    public String aptitudeJsp() { return "redirect:/aptitude-test"; }

    @GetMapping("/aptitude-result.jsp")
    public String aptitudeResultJsp() { return "redirect:/aptitude-result"; }
}
