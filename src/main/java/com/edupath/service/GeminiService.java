package com.edupath.service;

import com.edupath.models.AptitudeResult;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.*;

@Service
public class GeminiService {

    private static final Logger log = LoggerFactory.getLogger(GeminiService.class);

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Value("${gemini.api.key:}")
    private String apiKey;

    @Value("${gemini.model:gemini-2.5-flash}")
    private String modelName;

    /**
     * Generates personalized advice based on the AptitudeResult using Google Gemini API.
     * Falls back to a structured default advice if the API key is not configured or calls fail.
     */
    public String generateAdvice(AptitudeResult result) {
        if (apiKey == null || apiKey.trim().isEmpty()) {
            log.info("[GeminiService] API key is not configured. Using local fallback counseling generator.");
            return generateFallbackAdvice(result);
        }

        String prompt = buildPrompt(result);

        try {
            String url = "https://generativelanguage.googleapis.com/v1beta/models/" + modelName + ":generateContent?key=" + apiKey;

            // Prepare Request Body
            Map<String, Object> requestBody = new LinkedHashMap<>();
            Map<String, Object> textPart = Map.of("text", prompt);
            Map<String, Object> partsContent = Map.of("parts", List.of(textPart));
            requestBody.put("contents", List.of(partsContent));

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);

            log.debug("[GeminiService] Sending request to Gemini API model: {}", modelName);
            ResponseEntity<String> responseEntity = restTemplate.postForEntity(url, entity, String.class);

            if (responseEntity.getStatusCode().is2xxSuccessful() && responseEntity.getBody() != null) {
                JsonNode root = objectMapper.readTree(responseEntity.getBody());
                JsonNode textNode = root.path("candidates")
                        .path(0)
                        .path("content")
                        .path("parts")
                        .path(0)
                        .path("text");
                
                if (!textNode.isMissingNode()) {
                    String generatedText = textNode.asText().trim();
                    log.info("[GeminiService] Successfully generated counseling advice from Gemini.");
                    return generatedText;
                }
            }

            log.warn("[GeminiService] Failed to extract text from Gemini response: {}", responseEntity.getBody());
        } catch (Exception e) {
            log.error("[GeminiService] Error calling Gemini API: {}", e.getMessage(), e);
        }

        return generateFallbackAdvice(result);
    }

    private String buildPrompt(AptitudeResult result) {
        String baseRec = result.getRecommendation();
        String streamName = switch (baseRec) {
            case "PCM" -> "Science (PCM)";
            case "COMM" -> "Commerce";
            default -> "Arts & Humanities";
        };

        return String.format(
                "You are an empathetic, professional academic career counselor. A Class 10 student has completed an aptitude assessment to determine their ideal stream.\n\n" +
                "Here is their performance and profiling data:\n" +
                "- Suggested stream (by algorithmic matching): %s\n" +
                "- Level 1 (Interests): Science/PCM (%d/10), Commerce (%d/10), Arts/Humanities (%d/10)\n" +
                "- Level 2 (Scored Aptitude - math, logic, verbal): %d/10\n" +
                "- Level 3 (Personality Traits): Analyst (%d/10), Leader (%d/10), Humanist (%d/10)\n\n" +
                "Provide a highly personalized and motivating career counseling report of about 150-250 words.\n" +
                "Requirements:\n" +
                "1. Address the student directly with encouragement.\n" +
                "2. Synthesize how their combined metrics (such as high logic with humanist personality) support the recommendation, or mention interesting overlaps.\n" +
                "3. Provide 2-3 specific subject combinations, career directions, or next steps to explore.\n\n" +
                "Ensure the response is formatted in clean Markdown with appropriate bolding, bullet points, and section breaks. Do not use generic placeholders like [Student Name].",
                streamName,
                result.getPcmScore(), result.getCommScore(), result.getArtsScore(),
                result.getAptScore(),
                result.getAnalystScore(), result.getLeaderScore(), result.getHumanistScore()
        );
    }

    private String generateFallbackAdvice(AptitudeResult result) {
        String baseRec = result.getRecommendation();
        String streamName = switch (baseRec) {
            case "PCM" -> "Science (PCM)";
            case "COMM" -> "Commerce";
            default -> "Arts & Humanities";
        };

        return String.format(
                "### 🎓 Your Personalized Career Guidance Report\n\n" +
                "Based on your diagnostic profile, your strongest academic match is **%s**.\n\n" +
                "#### **Key Observations:**\n" +
                "* **Aptitude & Analysis**: You achieved an aptitude score of **%d/10**, showcasing reliable reasoning abilities suited to critical academic analysis.\n" +
                "* **Interest & Personality Profile**: Your primary personality style aligns with **%s** traits, which supports your match. \n\n" +
                "#### **Recommended Action Items:**\n" +
                "1. **Explore Key Electives**: Look into core subjects associated with %s to find areas of interest.\n" +
                "2. **Research Careers**: Connect with mentors or explore pathways in engineering, management, or design depending on your final subject selection.\n" +
                "3. **Consult College Requirements**: Explore matching colleges to understand their entrance exam criteria.",
                streamName,
                result.getAptScore(),
                baseRec.equals("PCM") ? "Analyst" : baseRec.equals("COMM") ? "Leader" : "Humanist",
                streamName
        );
    }
}
