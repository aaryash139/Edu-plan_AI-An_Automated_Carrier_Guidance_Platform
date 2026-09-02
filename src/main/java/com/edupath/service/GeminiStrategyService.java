package com.edupath.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

@Service
public class GeminiStrategyService {

    @Value("${gemini.api.key:}")
    private String geminiApiKey;

    @Value("${gemini.model:gemini-2.5-flash}")
    private String geminiModel;

    private final HttpClient httpClient = HttpClient.newBuilder()
            .version(HttpClient.Version.HTTP_2)
            .connectTimeout(Duration.ofSeconds(15))
            .build();
    
    private final ObjectMapper objectMapper = new ObjectMapper();

    public String generateStrategy(com.edupath.models.User user, int savedCollegesCount) {
        if (geminiApiKey == null || geminiApiKey.isBlank()) {
            return "<div style='color:var(--error); padding:1rem; border:1px solid var(--error); border-radius:8px;'>Gemini API Key is missing. Please add it to application.properties.</div>";
        }

        String targetExam = user.getTargetExam() != null ? user.getTargetExam() : "Not decided";
        String expectedScore = user.getExpectedExamScore() != null ? String.valueOf(user.getExpectedExamScore()) : "Not provided";
        String category = user.getCategory() != null ? user.getCategory() : "General";

        String prompt = "You are an expert Indian College Admission Counselor. " +
                "A Class 12 student has asked for an admission strategy. " +
                "Their Stream is: " + user.getStream() + ". " +
                "Their expected/actual 12th percentage is: " + user.getPercentage() + "%. " +
                "Their category is: " + category + ". " +
                "Target Entrance Exam: " + targetExam + " with Expected Score/Rank: " + expectedScore + ". " +
                "They have " + savedCollegesCount + " colleges saved in their shortlist. " +
                "Write a short, highly structured admission strategy for them in HTML format. " +
                "IMPORTANT: You MUST explicitly categorize your college recommendations into the following 3 buckets using <h3> tags: " +
                "<h3>Dream Colleges</h3> (Top-tier, aspirational colleges that are slightly above their current marks/rank), " +
                "<h3>Reach/Target Colleges</h3> (Perfect matches for their current profile), " +
                "<h3>Safety Colleges</h3> (Guaranteed admission backups). " +
                "Format beautifully with <p> and <ul> tags. Do NOT wrap the response in ```html markdown blocks, just return raw HTML.";

        return callGemini(prompt);
    }
    
    public String generateCollegeInsights(com.edupath.models.College college) {
        if (geminiApiKey == null || geminiApiKey.isBlank()) {
            return "<div style='color:var(--error); padding:1rem; border:1px solid var(--error); border-radius:8px;'>Gemini API Key is missing. Please add it to application.properties.</div>";
        }

        String prompt = "You are an expert educational counselor. Generate an engaging 'Quick Admission Insight' for the following college: " +
                college.getName() + " located in " + college.getCity() + ", " + college.getState() + ". " +
                "It is a " + college.getCollegeType() + " offering " + college.getStream() + " courses. " +
                "Its annual fees is around Rs " + college.getFees() + " and typical cutoff is " + college.getCutoff() + "%. " +
                "Its entrance exam is " + college.getEntranceExam() + ". " +
                "Please generate a short HTML response containing: " +
                "1. A brief 2-sentence overview of its reputation. " +
                "2. <b>Estimated Placements:</b> Typical average package and 2-3 top recruiting companies for this type of college. " +
                "3. <b>Admission Tips:</b> Brief advice on how to secure admission here. " +
                "Format as a beautiful HTML snippet using <h4>, <p>, and <ul> tags. Use modern inline CSS (e.g. color:#4f46e5 for headings). " +
                "Do NOT wrap the response in ```html markdown blocks, just return raw HTML.";

        return callGemini(prompt);
    }
    
    private String callGemini(String prompt) {
        try {
            String escapedPrompt = prompt.replace("\"", "\\\"");
            String requestBody = "{\"contents\":[{\"parts\":[{\"text\":\"" + escapedPrompt + "\"}]}]}";
            
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("https://generativelanguage.googleapis.com/v1beta/models/" + geminiModel + ":generateContent?key=" + geminiApiKey))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 200) {
                JsonNode root = objectMapper.readTree(response.body());
                String htmlResponse = root.path("candidates").get(0).path("content").path("parts").get(0).path("text").asText();
                if (htmlResponse.startsWith("```html")) {
                    htmlResponse = htmlResponse.substring(7);
                }
                if (htmlResponse.endsWith("```")) {
                    htmlResponse = htmlResponse.substring(0, htmlResponse.length() - 3);
                }
                return htmlResponse;
            } else {
                return "<div style='color:var(--error);'>Error from Gemini API: " + response.statusCode() + " - " + response.body() + "</div>";
            }
        } catch (Exception e) {
            return "<div style='color:var(--error);'>Exception generating insight: " + e.getMessage() + "</div>";
        }
    }
}
