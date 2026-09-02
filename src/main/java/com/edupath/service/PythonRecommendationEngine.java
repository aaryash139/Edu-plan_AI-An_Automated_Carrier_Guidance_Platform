package com.edupath.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Component
public class PythonRecommendationEngine {

    private static final Logger log = LoggerFactory.getLogger(PythonRecommendationEngine.class);

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Value("${edupath.python.enabled:true}")
    private boolean enabled;

    @Value("${edupath.python.command:python}")
    private String pythonCommand;

    @Value("${edupath.python.timeout-seconds:10}")
    private int timeoutSeconds;

    @Value("${gemini.api.key:}")
    private String geminiApiKey;

    /**
     * Runs recommend.py and returns PCM, COMM, or ARTS; empty if Python fails.
     */
    public String recommend(int aptScore, int pcm, int comm, int arts,
                            int analyst, int leader, int humanist) {
        if (!enabled) {
            return "";
        }

        Path scriptPath = resolveScriptPath();
        if (scriptPath == null) {
            log.warn("[EduPath] recommend.py not found on classpath");
            return "";
        }

        List<String> command = new ArrayList<>();
        command.add(pythonCommand);
        command.add(scriptPath.toAbsolutePath().toString());
        command.add(String.valueOf(aptScore));
        command.add(String.valueOf(pcm));
        command.add(String.valueOf(comm));
        command.add(String.valueOf(arts));
        command.add(String.valueOf(analyst));
        command.add(String.valueOf(leader));
        command.add(String.valueOf(humanist));

        return runAndParseStream(command);
    }

    /**
     * Optional JSON mode — returns full map from Python (scores + stream).
     */
    public Map<String, Object> recommendFromPayload(Map<String, Object> payload) {
        if (!enabled) {
            return Map.of();
        }

        Path scriptPath = resolveScriptPath();
        if (scriptPath == null) {
            return Map.of();
        }

        try {
            String jsonPayload = objectMapper.writeValueAsString(payload);

            List<String> command = new ArrayList<>();
            command.add(pythonCommand);
            command.add(scriptPath.toAbsolutePath().toString());
            command.add("--json");
            command.add(jsonPayload);

            String output = runProcess(command);
            if (output.isBlank()) {
                return Map.of();
            }

            @SuppressWarnings("unchecked")
            Map<String, Object> result = objectMapper.readValue(output, Map.class);
            return result;
        } catch (Exception e) {
            log.warn("[EduPath] Python JSON engine failed: {}", e.getMessage());
            return Map.of();
        }
    }

    private String runAndParseStream(List<String> command) {
        String raw = runProcess(command);
        if (raw.isBlank()) {
            return "";
        }
        String stream = raw.trim().toUpperCase();
        if (stream.equals("PCM") || stream.equals("COMM") || stream.equals("ARTS")) {
            return stream;
        }
        log.warn("[EduPath] Unexpected Python output: {}", raw);
        return "";
    }

    private String runProcess(List<String> command) {
        try {
            ProcessBuilder pb = new ProcessBuilder(command);
            if (geminiApiKey != null && !geminiApiKey.isEmpty()) {
                pb.environment().put("GEMINI_API_KEY", geminiApiKey);
            }
            pb.redirectErrorStream(true);
            Process process = pb.start();

            boolean finished = process.waitFor(timeoutSeconds, TimeUnit.SECONDS);
            if (!finished) {
                process.destroyForcibly();
                log.warn("[EduPath] Python engine timed out");
                return "";
            }

            StringBuilder output = new StringBuilder();
            try (BufferedReader reader = new BufferedReader(
                    new InputStreamReader(process.getInputStream(), StandardCharsets.UTF_8))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    output.append(line.trim());
                }
            }

            if (process.exitValue() != 0) {
                log.warn("[EduPath] Python exit code {} — output: {}", process.exitValue(), output);
                return "";
            }

            return output.toString();
        } catch (Exception e) {
            log.warn("[EduPath] Python engine error: {}", e.getMessage());
            return "";
        }
    }

    private Path resolveScriptPath() {
        try {
            ClassPathResource resource = new ClassPathResource("python/recommend.py");
            if (!resource.exists()) {
                return null;
            }

            if (resource.isFile()) {
                return resource.getFile().toPath();
            }

            try (InputStream in = resource.getInputStream()) {
                Path temp = Files.createTempFile("edupath-recommend-", ".py");
                Files.copy(in, temp, java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                temp.toFile().deleteOnExit();
                return temp;
            }
        } catch (Exception e) {
            log.warn("[EduPath] Could not load recommend.py: {}", e.getMessage());
            return null;
        }
    }

    public boolean isEnabled() {
        return enabled;
    }
}
