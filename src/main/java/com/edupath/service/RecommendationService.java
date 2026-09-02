package com.edupath.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class RecommendationService {

    private static final Logger log = LoggerFactory.getLogger(RecommendationService.class);

    @Autowired
    private PythonRecommendationEngine pythonEngine;

    /**
     * Python engine first; Java formula fallback if Python missing or fails.
     */
    public String recommend(int aptScore, int pcm, int comm, int arts,
                            int analyst, int leader, int humanist) {
        String fromPython = pythonEngine.recommend(aptScore, pcm, comm, arts, analyst, leader, humanist);
        if (!fromPython.isBlank()) {
            log.debug("[EduPath] Recommendation from Python engine: {}", fromPython);
            return fromPython;
        }

        log.debug("[EduPath] Using Java fallback recommendation engine");
        return recommendWithJava(aptScore, pcm, comm, arts, analyst, leader, humanist);
    }

    /**
     * Full JSON response from Python when available (for API enrichment).
     */
    public Map<String, Object> recommendDetailed(Map<String, Object> payload,
                                                  int aptScore, int pcm, int comm, int arts,
                                                  int analyst, int leader, int humanist) {
        Map<String, Object> pythonResult = pythonEngine.recommendFromPayload(payload);
        if (!pythonResult.isEmpty()) {
            return pythonResult;
        }

        String stream = recommendWithJava(aptScore, pcm, comm, arts, analyst, leader, humanist);
        return Map.of(
                "recommendation", stream,
                "recommended_stream", toApiStream(stream),
                "aptitude_score", aptScore,
                "engine", "java"
        );
    }

    public String recommendWithJava(int aptScore, int pcm, int comm, int arts,
                                    int analyst, int leader, int humanist) {
        int totalL1 = pcm + comm + arts;
        if (totalL1 == 0) totalL1 = 1;
        int totalL3 = analyst + leader + humanist;
        if (totalL3 == 0) totalL3 = 1;

        double scorePcm = (pcm / (double) totalL1) * 40
                + (analyst / (double) totalL3) * 40
                + (aptScore / 10.0) * 20;

        double scoreComm = (comm / (double) totalL1) * 40
                + (leader / (double) totalL3) * 40
                + ((10 - aptScore) / 10.0) * 10;

        double scoreArts = (arts / (double) totalL1) * 40
                + (humanist / (double) totalL3) * 40;

        if (scorePcm >= scoreComm && scorePcm >= scoreArts) return "PCM";
        if (scoreComm >= scoreArts) return "COMM";
        return "ARTS";
    }

    public String toApiStream(String recommendation) {
        return switch (recommendation) {
            case "PCM" -> "PCM";
            case "COMM" -> "COMMERCE";
            default -> "ARTS_HUMANITIES";
        };
    }
}
