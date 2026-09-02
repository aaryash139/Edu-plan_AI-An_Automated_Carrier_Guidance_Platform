package com.edupath.config;

import com.edupath.models.College;
import com.edupath.models.User;
import com.edupath.repositories.CollegeRepository;
import com.edupath.repositories.SavedCollegeRepository;
import com.edupath.repositories.Userrepositories;
import com.edupath.service.PasswordService;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import java.io.BufferedReader;
import java.io.InputStreamReader;

@Configuration
public class DataInitializer {

    @Bean
    CommandLineRunner seedData(CollegeRepository collegeRepository,
                               SavedCollegeRepository savedCollegeRepository,
                               Userrepositories userRepository,
                               PasswordService passwordService) {
        return args -> {
            seedCollegesIfEmpty(collegeRepository, savedCollegeRepository);
            seedUsersIfEmpty(userRepository, passwordService);
        };
    }

    private void seedCollegesIfEmpty(CollegeRepository collegeRepository, SavedCollegeRepository savedCollegeRepository) {
        // Clear dependent tables first to avoid referential integrity violation
        savedCollegeRepository.deleteAll();
        // Force reload to apply new placement data
        collegeRepository.deleteAll();

        try (BufferedReader br = new BufferedReader(new InputStreamReader(
                new ClassPathResource("colleges.csv").getInputStream()))) {
            
            String line;
            boolean isFirstLine = true;
            while ((line = br.readLine()) != null) {
                if (isFirstLine) {
                    isFirstLine = false;
                    continue; // Skip CSV header
                }
                
                String[] data = parseCsvLine(line);
                if (data.length >= 10) {
                    try {
                        String name = data[0].trim();
                        String city = data[1].trim();
                        String state = data[2].trim();
                        String type = data[3].trim();
                        String stream = data[4].trim();
                        int fees = Integer.parseInt(data[5].trim());
                        int cutoff = Integer.parseInt(data[6].trim());
                        int rank = Integer.parseInt(data[7].trim());
                        String exam = data[8].trim();
                        double rating = Double.parseDouble(data[9].trim());
                        
                        String pRate = data.length > 10 ? data[10].trim() : "80%";
                        String avgPkg = data.length > 11 ? data[11].trim() : "Rs 5 LPA";
                        String topRec = data.length > 12 ? data[12].trim() : "TCS, Infosys";
                        String facs = data.length > 13 ? data[13].trim() : "Hostel, Labs, Library";
                        
                        collegeRepository.save(buildCollege(name, city, state, type, stream, fees, cutoff, rank, exam, rating, pRate, avgPkg, topRec, facs));
                    } catch (NumberFormatException e) {
                        System.err.println("Error parsing row in colleges.csv: " + line);
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("Error reading colleges.csv: " + e.getMessage());
        }
    }
    
    private String[] parseCsvLine(String line) {
        java.util.List<String> tokens = new java.util.ArrayList<>();
        StringBuilder sb = new StringBuilder();
        boolean inQuotes = false;
        for (int i = 0; i < line.length(); i++) {
            char c = line.charAt(i);
            if (c == '"') {
                inQuotes = !inQuotes;
            } else if (c == ',' && !inQuotes) {
                tokens.add(sb.toString());
                sb.setLength(0);
            } else {
                sb.append(c);
            }
        }
        tokens.add(sb.toString());
        return tokens.toArray(new String[0]);
    }

    private void seedUsersIfEmpty(Userrepositories userRepository, PasswordService passwordService) {
        if (userRepository.count() > 0) {
            return;
        }

        userRepository.save(buildUser(
                "Demo", "Student", "student@edupath.in", passwordService.hash("Student@123"),
                "12", "Science (PCM)", "Madhya Pradesh", 85.0, "student"));
        userRepository.save(buildUser(
                "Demo", "Admin", "admin@edupath.in", passwordService.hash("Admin@123"),
                null, null, null, null, "admin"));
    }

    private static User buildUser(String firstName, String lastName, String email, String passwordHash,
                                  String userClass, String stream, String state, Double percentage, String role) {
        User user = new User();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setPasswordHash(passwordHash);
        user.setUserClass(userClass);
        user.setStream(stream);
        user.setState(state);
        user.setPercentage(percentage);
        user.setRole(role);
        return user;
    }

    private static College buildCollege(String name, String city, String state,
                                        String type, String stream, int fees,
                                        int cutoff, int rank, String exam, double rating,
                                        String placementRate, String avgPackage, String topRecruiters, String facilities) {
        College college = new College();
        college.setName(name);
        college.setCity(city);
        college.setState(state);
        college.setCollegeType(type);
        college.setStream(stream);
        college.setFees(fees);
        college.setCutoff(cutoff);
        college.setNirfRank(rank);
        college.setEntranceExam(exam);
        college.setRating(rating);
        college.setPlacementRate(placementRate);
        college.setAvgPackage(avgPackage);
        college.setTopRecruiters(topRecruiters);
        college.setFacilities(facilities);
        return college;
    }
}
