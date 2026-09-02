package com.edupath;

import com.edupath.models.User;
import com.edupath.repositories.Userrepositories;
import com.edupath.service.PasswordService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class LoginFlowTests {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private Userrepositories userRepository;

    @Autowired
    private PasswordService passwordService;

    @Test
    void demoStudentCanLogin() throws Exception {
        ensureDemoStudentExists();

        mockMvc.perform(post("/LoginServlet")
                        .param("email", "student@edupath.in")
                        .param("password", "Student@123")
                        .param("userRole", "student"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/dashboard"));
    }

    @Test
    void collegeSearchApiIsPublic() throws Exception {
        mockMvc.perform(get("/api/colleges"))
                .andExpect(status().isOk());
    }

    @Test
    void aptitudeSubmitRequiresLogin() throws Exception {
        mockMvc.perform(post("/api/aptitude/submit")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{\"level1\":{\"pcm\":1,\"comm\":1,\"arts\":1},\"level2\":{\"aptitude_score\":1},\"level3\":{\"analyst\":1,\"leader\":1,\"humanist\":1}}"))
                .andExpect(status().isUnauthorized());
    }

    private void ensureDemoStudentExists() {
        userRepository.findByEmail("student@edupath.in").orElseGet(() -> {
            User user = new User();
            user.setFirstName("Demo");
            user.setLastName("Student");
            user.setEmail("student@edupath.in");
            user.setPasswordHash(passwordService.hash("Student@123"));
            user.setUserClass("12");
            user.setStream("Science (PCM)");
            user.setState("Madhya Pradesh");
            user.setPercentage(85.0);
            user.setRole("student");
            return userRepository.save(user);
        });
    }
}
