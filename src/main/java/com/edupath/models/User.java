package com.edupath.models;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Long id;

    @Column(name = "first_name", nullable = false, length = 80)
    private String firstName;

    @Column(name = "last_name", nullable = false, length = 80)
    private String lastName;

    @Column(nullable = false, unique = true, length = 150)
    private String email;

    @Column(length = 20)
    private String mobile;

    @Column(name = "password_hash", nullable = false, length = 128)
    private String passwordHash;

    @Column(name = "class_level", length = 10)
    private String userClass;

    @Column(length = 80)
    private String stream;

    @Column(length = 80)
    private String state;

    private Double percentage;

    @Column(length = 50)
    private String category = "General";

    @Column(name = "target_exam", length = 80)
    private String targetExam;

    @Column(name = "expected_exam_score")
    private Integer expectedExamScore;

    @Column(nullable = false, length = 20)
    private String role = "student";

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    public String getUserClass() { return userClass; }
    public void setUserClass(String userClass) { this.userClass = userClass; }

    public String getStream() { return stream; }
    public void setStream(String stream) { this.stream = stream; }

    public String getState() { return state; }
    public void setState(String state) { this.state = state; }

    public Double getPercentage() { return percentage; }
    public void setPercentage(Double percentage) { this.percentage = percentage; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getTargetExam() { return targetExam; }
    public void setTargetExam(String targetExam) { this.targetExam = targetExam; }

    public Integer getExpectedExamScore() { return expectedExamScore; }
    public void setExpectedExamScore(Integer expectedExamScore) { this.expectedExamScore = expectedExamScore; }
}
