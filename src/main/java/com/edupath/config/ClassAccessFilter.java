package com.edupath.config;

import com.edupath.models.User;
import com.edupath.repositories.Userrepositories;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class ClassAccessFilter implements Filter {

    @Autowired
    private Userrepositories userRepository;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String path = req.getRequestURI();

        // Only intercept specific modules
        boolean isAptitudePath = path.startsWith("/aptitude-test") || path.startsWith("/api/aptitude");
        boolean isCollegePath = path.startsWith("/colleges") || path.startsWith("/api/colleges");

        if ((isAptitudePath || isCollegePath) && session != null) {
            Long userId = (Long) session.getAttribute("userId");
            if (userId != null) {
                User user = userRepository.findById(userId).orElse(null);
                if (user != null) {
                    String userClass = user.getUserClass();
                    
                    // Class 10: Can only access Aptitude module
                    if ("10".equals(userClass) && isCollegePath) {
                        res.sendRedirect("/dashboard");
                        return;
                    }
                    
                    // Class 12: Can only access College Discovery module
                    if ("12".equals(userClass) && isAptitudePath) {
                        res.sendRedirect("/dashboard");
                        return;
                    }
                }
            }
        }

        chain.doFilter(request, response);
    }
}
