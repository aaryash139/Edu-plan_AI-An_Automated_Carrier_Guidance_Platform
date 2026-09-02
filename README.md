# EduPath AI (Automated Career Guidance Platform)

EduPath AI is an intelligent, AI-driven career guidance and college recommendation platform designed to help students discover the best career paths, evaluate their aptitude, and find the perfect college based on real-time data and AI insights.

## ?? Key Features

### For Students
*   **Aptitude Test Framework:** A comprehensive assessment system that evaluates a student's strengths, logic, and skills to suggest the most suitable career streams.
*   **AI-Powered College Insights:** Utilizes Google Gemini AI to generate personalized, real-time insights about a college's environment, placement records, and campus life directly from the dashboard.
*   **Advanced College Search Engine:** Robust filtering capabilities allowing students to search for colleges across India by stream, state, maximum fees, required cutoff, accepted exams, and NIRF rankings.
*   **Saved Colleges (Wishlist):** A personalized space for students to save and track their target colleges for future reference.
*   **Career Library:** An extensive repository of information detailing various career paths, future scopes, and required qualifications.

### For Administrators & System
*   **Dynamic Placement Engine:** Programmatically manages realistic placement rates, average packages, and top recruiter data for over 230+ colleges.
*   **Automated Data Seeding:** A self-initializing database that automatically cleans and loads hundreds of colleges and demo user accounts on the first startup.
*   **Security & Authentication:** Fully secured login and registration flows built with Spring Security and password hashing.

## ?? Tech Stack

**Frontend:**
*   JSP (JavaServer Pages)
*   HTML5, CSS3, Vanilla JavaScript
*   Lucide Icons (for UI elements)

**Backend:**
*   Java 21
*   Spring Boot 3.2.x
*   Spring Data JPA & Hibernate
*   Spring Security

**Database:**
*   H2 Database (Embedded for rapid local development)
*   MySQL / PostgreSQL (Production-ready configurations included)

**AI & External Integrations:**
*   Google Gemini AI API (Dynamic College Insights & Semantic Analysis)
*   Python Integration (Recommendation Engine algorithms)

## ?? Live Demo
*   **Web Application:** [https://edu-plan-ai-an-automated-carrier.onrender.com/](https://edu-plan-ai-an-automated-carrier.onrender.com/)
*   **Database:** Serverless PostgreSQL or Embedded H2

## ?? Local Development Setup

### Prerequisites
*   Java 21 JDK installed
*   IntelliJ IDEA (or Eclipse)

### 1. Database Setup
No manual database setup is required for local development! The project uses an embedded H2 database (`edupath_db.mv.db`) that automatically initializes and creates tables when the application starts.

### 2. Backend & Frontend Setup
The project is a monolithic Spring Boot application where the backend serves the frontend JSPs.
1. Open the project in IntelliJ IDEA.
2. Ensure the `gemini.api.key` in `src/main/resources/application.properties` is valid.
3. Run the `EdupathApplication.java` main class.
4. The application will start and be accessible at `http://localhost:8080`.

*Demo Accounts:*
*   Student: `student@edupath.in` / `Student@123`
*   Admin: `admin@edupath.in` / `Admin@123`

## ?? Deployment (CI/CD)

**Deployment Link:** [https://edu-plan-ai-an-automated-carrier.onrender.com/](https://edu-plan-ai-an-automated-carrier.onrender.com/)

The project is configured for seamless cloud deployment:
*   **Dockerfile:** Included in the root directory for deploying the Spring Boot application seamlessly to container services like Render, Railway, or Koyeb.
*   **WAR Packaging:** The `pom.xml` is explicitly configured to package the application as a `.war` file to natively support JSP view rendering in a production environment.
*   **Environment Variables:** Fully supports overriding the Database URL and Gemini API Key using environment variables (`SPRING_PROFILES_ACTIVE`, `GEMINI_API_KEY`) for secure production deployments.

## ?? License
This project is proprietary and developed for prototyping, academic, and demonstration purposes.
