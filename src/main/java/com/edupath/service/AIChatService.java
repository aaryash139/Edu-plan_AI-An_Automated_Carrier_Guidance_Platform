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
public class AIChatService {

    @Value("${gemini.api.key:}")
    private String geminiApiKey;

    @Value("${gemini.model:gemini-2.5-flash}")
    private String geminiModel;

    private final HttpClient httpClient = HttpClient.newBuilder()
            .version(HttpClient.Version.HTTP_2)
            .connectTimeout(Duration.ofSeconds(10))
            .build();
    
    private final ObjectMapper objectMapper = new ObjectMapper();

    public String getChatResponse(String userMessage, String studentContext) {
        if (geminiApiKey == null || geminiApiKey.isBlank()) {
            return "Error: Gemini API Key is missing. Please add it to application.properties.";
        }

        String systemInstruction = "You are 'EduPath AI', an expert Indian College Admission Counselor. " +
                "You are chatting directly with a Class 12 student. " +
                "Here is their profile context: " + studentContext + ". " +
                "Keep your answers short, friendly, and highly relevant to Indian colleges, entrance exams (JEE, NEET, CUET, etc.), and their specific state/stream. " +
                "Do not use markdown blocks like ```html, just use simple text with occasional emojis.";

        try {
            // Escape quotes and newlines for JSON payload
            String escapedInstruction = systemInstruction.replace("\"", "\\\"").replace("\n", " ");
            String escapedMessage = userMessage.replace("\"", "\\\"").replace("\n", " ");

            // Using system instructions feature of Gemini API if possible, or just prepending it.
            // For simplicity, we prepend it as a system persona in the text prompt.
            String fullPrompt = "System Persona: " + escapedInstruction + "\\n\\nStudent Question: " + escapedMessage;

            String requestBody = "{\"contents\":[{\"parts\":[{\"text\":\"" + fullPrompt + "\"}]}]}";
            
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("https://generativelanguage.googleapis.com/v1beta/models/" + geminiModel + ":generateContent?key=" + geminiApiKey))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            if (response.statusCode() == 200) {
                JsonNode root = objectMapper.readTree(response.body());
                return root.path("candidates").get(0).path("content").path("parts").get(0).path("text").asText();
            } else {
                return "Sorry, I'm having trouble connecting to the AI brain right now. (Status: " + response.statusCode() + ")";
            }
        } catch (Exception e) {
            return "Oops! Something went wrong on my end. Please try again later.";
        }
    }

    public String generateCareerProfile(String careerName) {
        if (geminiApiKey == null || geminiApiKey.isBlank()) {
            return "<div style='color:var(--error); padding:1rem; border:1px solid var(--error); border-radius:8px;'>Gemini API Key is missing. Please add it to application.properties.</div>";
        }

        String prompt = "You are an expert Indian Career Counselor. " +
                "Generate a highly structured and beautiful HTML profile for the career: " + careerName + ". " +
                "Include the following sections using <h3> tags: " +
                "<h3>Overview</h3> (What the job is about), " +
                "<h3>How to become one in India</h3> (Required degrees, entrance exams like JEE/NEET/CAT/CLAT if applicable), " +
                "<h3>Salary Insights & Scope</h3> (Average starting and mid-level salary in India, future demand), " +
                "<h3>Top Skills Required</h3>. " +
                "Format beautifully with <p>, <ul>, and <li> tags. Do NOT wrap the response in ```html markdown blocks, just return raw HTML.";

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
                return root.path("candidates").get(0).path("content").path("parts").get(0).path("text").asText();
            } else {
                return "<div style='color:var(--error);'>Failed to fetch career profile. Status: " + response.statusCode() + "</div>";
            }
        } catch (Exception e) {
            return "<div style='color:var(--error);'>An error occurred while generating the career profile.</div>";
        }
    }
}
