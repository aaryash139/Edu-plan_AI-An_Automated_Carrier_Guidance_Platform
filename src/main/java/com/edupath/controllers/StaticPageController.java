package com.edupath.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class StaticPageController {

    @GetMapping("/career-library")
    public String careerLibrary() { return "career-library"; }

    @GetMapping("/aptitude-framework")
    public String aptitudeFramework() { return "aptitude-framework"; }

    @GetMapping("/blog")
    public String blog() { return "blog"; }

    @GetMapping("/privacy-policy")
    public String privacyPolicy() { return "privacy-policy"; }

    @GetMapping("/terms-of-service")
    public String termsOfService() { return "terms-of-service"; }

    @GetMapping("/contact")
    public String contact() { return "contact-support"; }
}
