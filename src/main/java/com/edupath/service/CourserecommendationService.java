package com.edupath.service;

import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

/**
 * CLASS 10  →  stream suggest karo  (PCM / COMM / ARTS)  ← already kaam karta hai
 * CLASS 12  →  specific courses suggest karo              ← YEH NAYA SERVICE HAI
 *
 * Logic:
 *   1. stream (user.stream) se broad category decide hoti hai
 *   2. aptitude scores (analyst / leader / humanist) se
 *      uss category ke andar best courses rank hote hain
 *   3. Top 5 courses return hote hain, matchScore ke order mein
 */
@Service
public class CourserecommendationService {

    // ─────────────────────────────────────────────────────────────
    //  MAIN METHOD — controller yahi call karega
    //  userClass : "10" ya "12"  (User.getUserClass())
    //  stream    : "Science (PCM)", "Science (PCB)", "Commerce",
    //              "Arts / Humanities"  (User.getStream())
    //              null bhi ho sakta hai — toh aptitude se fallback
    //  baseRec   : "PCM" / "COMM" / "ARTS"  (RecommendationService ka output)
    // ─────────────────────────────────────────────────────────────
    public List<CourseRecommendation> recommend(
            String userClass,
            String stream,
            String baseRec,        // aptitude result
            int aptScore,
            int analyst,
            int leader,
            int humanist) {

        // Class 10 → course suggest karna nahi, sirf stream batao
        // (calling code check kare, phir bhi guard lagao)
        if (!"12".equals(userClass)) {
            return List.of();
        }

        // Stream null/blank hai toh aptitude result se determine karo
        String effectiveStream = resolveStream(stream, baseRec);

        List<CourseRecommendation> candidates = buildCandidates(
                effectiveStream, aptScore, analyst, leader, humanist);

        // matchScore ke descending order mein sort karo, top 5 lo
        candidates.sort(Comparator.comparingInt(CourseRecommendation::getMatchScore).reversed());
        return candidates.subList(0, Math.min(5, candidates.size()));
    }

    // ─────────────────────────────────────────────────────────────
    //  Stream resolve — agar user ne profile mein stream set nahi
    //  kiya toh aptitude base recommendation se decide karo
    // ─────────────────────────────────────────────────────────────
    private String resolveStream(String stream, String baseRec) {
        if (stream != null && !stream.isBlank()) {
            return stream.trim();
        }
        // fallback from aptitude
        return switch (baseRec) {
            case "PCM"  -> "Science (PCM)";
            case "COMM" -> "Commerce";
            default     -> "Arts / Humanities";
        };
    }

    // ─────────────────────────────────────────────────────────────
    //  BUILD CANDIDATE COURSES
    //  Har course ka matchScore = base + personality bonus
    //  base      : stream ke sath kitna align karta hai course
    //  bonus     : analyst/leader/humanist scores se milta hai
    // ─────────────────────────────────────────────────────────────
    private List<CourseRecommendation> buildCandidates(
            String stream, int aptScore, int analyst, int leader, int humanist) {

        List<CourseRecommendation> list = new ArrayList<>();

        // ── SCIENCE (PCM) ──────────────────────────────────────
        if (stream.contains("PCM")) {

            list.add(new CourseRecommendation(
                    "B.Tech Computer Science",
                    "4 Years",
                    "Engineering",
                    "Software, AI, and systems engineering — highest placement rates",
                    List.of("JEE Main", "JEE Advanced", "BITSAT", "MHT-CET"),
                    List.of("Software Engineer", "Data Scientist", "System Architect", "Product Manager"),
                    "Tumhara high aptitude score (" + aptScore + "/10) aur analytical thinking " +
                            "CS ke liye perfect match hai.",
                    // analyst score jitna zyada, score utna zyada
                    60 + clamp(analyst * 3) + clamp(aptScore * 2)
            ));

            list.add(new CourseRecommendation(
                    "B.Tech Electronics & Communication",
                    "4 Years",
                    "Engineering",
                    "Hardware, embedded systems, VLSI, and communication networks",
                    List.of("JEE Main", "JEE Advanced", "BITSAT"),
                    List.of("VLSI Engineer", "Telecom Engineer", "IoT Developer", "R&D Scientist"),
                    "PCM background + analytical mind ECE ke liye strong foundation banata hai.",
                    55 + clamp(analyst * 3) + clamp(aptScore)
            ));

            list.add(new CourseRecommendation(
                    "B.Sc. Mathematics / Statistics",
                    "3 Years",
                    "Pure Science",
                    "Deep mathematics — gateway to actuarial, data science, and research careers",
                    List.of("CUET", "IISc BS", "CMI Entrance"),
                    List.of("Data Analyst", "Actuary", "Statistician", "Quantitative Analyst"),
                    "PCM + high analyst score — pure math tumhare liye strong option hai.",
                    45 + clamp(analyst * 4)
            ));

            list.add(new CourseRecommendation(
                    "BCA (Bachelor of Computer Applications)",
                    "3 Years",
                    "Computer Science",
                    "Software-focused degree — faster route to IT career without PCM engineering",
                    List.of("CUET", "IPU CET", "State-level"),
                    List.of("Web Developer", "App Developer", "Database Admin", "IT Analyst"),
                    "PCM background ke bina bhi CS mein jana chahte ho toh BCA best short-cut hai.",
                    40 + clamp(analyst * 3)
            ));

            list.add(new CourseRecommendation(
                    "B.Tech Mechanical Engineering",
                    "4 Years",
                    "Engineering",
                    "Core engineering — design, manufacturing, thermodynamics",
                    List.of("JEE Main", "JEE Advanced"),
                    List.of("Mechanical Engineer", "Design Engineer", "R&D Engineer", "UPSC (Tech)"),
                    "PCM + practical problem-solving interest Mechanical ke liye solid base hai.",
                    42 + clamp(analyst * 2) + clamp(aptScore)
            ));

            list.add(new CourseRecommendation(
                    "B.Tech Civil Engineering",
                    "4 Years",
                    "Engineering",
                    "Infrastructure, construction, and urban planning",
                    List.of("JEE Main", "JEE Advanced"),
                    List.of("Civil Engineer", "Urban Planner", "Project Manager", "UPSC"),
                    "PCM + leadership quality tumhe infrastructure projects lead karne mein help karegi.",
                    35 + clamp(leader * 2) + clamp(analyst)
            ));
        }

        // ── SCIENCE (PCB) ──────────────────────────────────────
        if (stream.contains("PCB")) {

            list.add(new CourseRecommendation(
                    "MBBS",
                    "5.5 Years",
                    "Medical",
                    "Medical degree — doctor banne ka primary path",
                    List.of("NEET UG"),
                    List.of("Doctor (MD/MS)", "Surgeon", "Medical Researcher", "Hospital Admin"),
                    "PCB background + humanist personality — patient care aur medicine perfect fit hai.",
                    70 + clamp(humanist * 3)
            ));

            list.add(new CourseRecommendation(
                    "B.Pharm (Bachelor of Pharmacy)",
                    "4 Years",
                    "Pharmacy",
                    "Drug development, clinical research, and pharmaceutical industry",
                    List.of("NEET", "GPAT", "State Pharmacy CET"),
                    List.of("Pharmacist", "Drug Inspector", "Clinical Research Associate", "R&D Scientist"),
                    "PCB + analytical mind pharmacy aur clinical research ke liye ideal combination hai.",
                    55 + clamp(analyst * 2) + clamp(humanist * 2)
            ));

            list.add(new CourseRecommendation(
                    "B.Sc. Nursing",
                    "4 Years",
                    "Medical",
                    "Patient care, critical care, and healthcare management",
                    List.of("NEET (optional)", "AIIMS Nursing", "State Nursing CET"),
                    List.of("Registered Nurse", "ICU Nurse", "Healthcare Manager", "Nursing Faculty"),
                    "PCB + strong humanist score — yeh combination nursing ke liye exceptional hai.",
                    50 + clamp(humanist * 4)
            ));

            list.add(new CourseRecommendation(
                    "BPT (Physiotherapy)",
                    "4.5 Years",
                    "Medical Allied",
                    "Rehabilitation, sports medicine, and physical therapy",
                    List.of("NEET (some colleges)", "State CET"),
                    List.of("Physiotherapist", "Sports Therapist", "Rehab Specialist"),
                    "PCB + humanist personality BPT ke liye great match — direct patient impact.",
                    45 + clamp(humanist * 3)
            ));

            list.add(new CourseRecommendation(
                    "B.Sc. Biotechnology",
                    "3 Years",
                    "Life Sciences",
                    "Genetic engineering, bioinformatics, and biomedical research",
                    List.of("CUET", "JNU Entrance", "BHU PET"),
                    List.of("Biotech Researcher", "Genetic Counselor", "Bioinformatics Analyst"),
                    "PCB + analyst score — research-oriented path for science lovers.",
                    48 + clamp(analyst * 3)
            ));
        }

        // ── COMMERCE ───────────────────────────────────────────
        if (stream.equalsIgnoreCase("Commerce")) {

            list.add(new CourseRecommendation(
                    "CA (Chartered Accountancy)",
                    "4–5 Years",
                    "Finance & Accounting",
                    "India's most prestigious finance qualification — finance, audit, tax",
                    List.of("CA Foundation (ICAI)"),
                    List.of("Chartered Accountant", "CFO", "Tax Consultant", "Auditor"),
                    "Commerce + high analyst score CA ke liye perfect combination hai.",
                    60 + clamp(analyst * 4)
            ));

            list.add(new CourseRecommendation(
                    "BBA (Bachelor of Business Administration)",
                    "3 Years",
                    "Management",
                    "Business management, marketing, operations — MBA ka foundation",
                    List.of("CUET", "IPU CET", "Christ University Entrance", "DU JAT"),
                    List.of("Business Analyst", "Marketing Manager", "Entrepreneur", "MBA (IIM)"),
                    "Commerce + strong leader score BBA ke liye ideal fit hai.",
                    55 + clamp(leader * 4)
            ));

            list.add(new CourseRecommendation(
                    "B.Com (Hons)",
                    "3 Years",
                    "Commerce",
                    "Core commerce degree — accounting, economics, corporate law",
                    List.of("CUET", "DU Entrance", "State CET"),
                    List.of("Accountant", "Finance Analyst", "Bank PO", "Company Secretary"),
                    "Commerce background ka strongest academic choice — versatile career options.",
                    50 + clamp(analyst * 2) + clamp(leader * 2)
            ));

            list.add(new CourseRecommendation(
                    "B.Com + CMA (Cost & Management Accounting)",
                    "3 + 3 Years",
                    "Finance",
                    "Cost accounting, management reporting — industry finance specialist",
                    List.of("CMA Foundation (ICMAI)"),
                    List.of("Cost Accountant", "Management Accountant", "Financial Controller"),
                    "Commerce + analytical personality CMA ke liye strong match hai.",
                    48 + clamp(analyst * 3)
            ));

            list.add(new CourseRecommendation(
                    "BMS (Bachelor of Management Studies)",
                    "3 Years",
                    "Management",
                    "Business operations, HR, and strategy — practical management focus",
                    List.of("DU BMS Entrance", "Mumbai University CET"),
                    List.of("Operations Manager", "HR Manager", "Strategy Consultant"),
                    "Commerce + leader personality BMS ke liye natural choice hai.",
                    45 + clamp(leader * 3)
            ));
        }

        // ── ARTS / HUMANITIES ──────────────────────────────────
        if (stream.contains("Arts") || stream.contains("Humanities")) {

            list.add(new CourseRecommendation(
                    "LLB / BA LLB (Integrated)",
                    "5 Years",
                    "Law",
                    "Legal practice, corporate law, civil services — highly respected profession",
                    List.of("CLAT", "AILET", "LSAT India", "MH CET Law"),
                    List.of("Advocate", "Corporate Lawyer", "Judge", "Legal Advisor", "IAS (Law)"),
                    "Arts + strong leader score — law mein aage jaane ke liye yeh combination best hai.",
                    65 + clamp(leader * 4)
            ));

            list.add(new CourseRecommendation(
                    "BA Psychology (Hons)",
                    "3 Years",
                    "Social Sciences",
                    "Human behaviour, mental health, counselling — fastest growing field",
                    List.of("CUET", "Christ University", "Delhi University"),
                    List.of("Psychologist", "Counselor", "HR Specialist", "UX Researcher"),
                    "Arts + highest humanist score — Psychology tera natural calling hai.",
                    60 + clamp(humanist * 5)
            ));

            list.add(new CourseRecommendation(
                    "B.Journalism & Mass Communication (BJMC)",
                    "3 Years",
                    "Media & Communication",
                    "Print, digital media, PR, advertising — creative + informational careers",
                    List.of("IIMC Entrance", "CUET", "Symbiosis SET"),
                    List.of("Journalist", "Content Strategist", "PR Manager", "Documentary Filmmaker"),
                    "Arts + communication interest — BJMC creative + analytical dono aspects cover karta hai.",
                    55 + clamp(humanist * 2) + clamp(leader * 2)
            ));

            list.add(new CourseRecommendation(
                    "BA Political Science / International Relations",
                    "3 Years",
                    "Social Sciences",
                    "Politics, diplomacy, public policy — civil services gateway",
                    List.of("CUET", "JNU Entrance", "Jamia Entrance"),
                    List.of("Civil Servant (IAS/IFS)", "Policy Analyst", "Diplomat", "NGO Leader"),
                    "Arts + leader score — public service aur policy mein tumhara future bright hai.",
                    52 + clamp(leader * 3)
            ));

            list.add(new CourseRecommendation(
                    "B.Design / BFA (Fine Arts)",
                    "4 Years",
                    "Design & Arts",
                    "Product design, UI/UX, fine arts, animation — creative industry",
                    List.of("NID Entrance", "NIFT Entrance", "UCEED"),
                    List.of("UI/UX Designer", "Product Designer", "Animator", "Art Director"),
                    "Arts + creative-humanist mix — design fields mein unique career ban sakta hai.",
                    45 + clamp(humanist * 3)
            ));
        }

        return list;
    }

    // Utility: 0–20 ke beech rakhne ke liye (score 0–10 range mein aata hai)
    private int clamp(int val) {
        return Math.min(20, Math.max(0, val));
    }
}