package com.edupath.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import jakarta.servlet.http.HttpServletResponse;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> auth
                        // Use string-based matchers so Spring Security 6 resolves
                        // MvcRequestMatcher for controller endpoints automatically.
                        .requestMatchers(
                                "/", "/index", "/login", "/login.jsp",
                                "/signup", "/signup.jsp",
                                "/RegisterServlet", "/LoginServlet",
                                "/error", "/ping"
                        ).permitAll()
                        // Static resources & special paths still use AntPathRequestMatcher
                        // because they are NOT mapped to any @Controller.
                        .requestMatchers(
                                new AntPathRequestMatcher("/h2-console/**"),
                                new AntPathRequestMatcher("/css/**"),
                                new AntPathRequestMatcher("/js/**"),
                                new AntPathRequestMatcher("/images/**"),
                                new AntPathRequestMatcher("/webjars/**"),
                                new AntPathRequestMatcher("/favicon.ico"),
                                // JSP forward dispatches re-enter the filter chain;
                                // permit them to avoid redirect loops.
                                new AntPathRequestMatcher("/WEB-INF/**")
                        ).permitAll()
                        .requestMatchers("/api/colleges").permitAll()
                        .anyRequest().permitAll()
                )
                .csrf(csrf -> csrf
                        // Use string-based matchers for controller endpoints so that
                        // MvcRequestMatcher is used and CSRF ignore actually takes effect.
                        .ignoringRequestMatchers(
                                new AntPathRequestMatcher("/LoginServlet"),
                                new AntPathRequestMatcher("/RegisterServlet"),
                                new AntPathRequestMatcher("/updateProfile")
                        )
                        // Use AntPathRequestMatcher for wildcard / non-MVC paths.
                        .ignoringRequestMatchers(
                                new AntPathRequestMatcher("/api/**"),
                                new AntPathRequestMatcher("/h2-console/**"),
                                new AntPathRequestMatcher("/admin/**")
                        )
                )
                .headers(headers -> headers.frameOptions(frame -> frame.sameOrigin()))
                .formLogin(form -> form.disable())
                .httpBasic(basic -> basic.disable())
                .exceptionHandling(ex -> ex
                        .authenticationEntryPoint((request, response, authException) -> {
                            if (request.getRequestURI() != null && request.getRequestURI().startsWith("/api/")) {
                                response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
                            } else {
                                response.sendRedirect("/login");
                            }
                        })
                );

        return http.build();
    }
}