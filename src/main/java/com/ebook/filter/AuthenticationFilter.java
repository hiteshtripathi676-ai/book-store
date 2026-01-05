package com.ebook.filter;

import com.ebook.model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filter for protecting routes that require authentication
 */
public class AuthenticationFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        // Check if user is logged in
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        
        if (!isLoggedIn) {
            // Redirect to login page
            httpResponse.sendRedirect(contextPath + "/login?error=Please login to continue");
            return;
        }
        
        // Check if accessing admin routes
        if (requestURI.startsWith(contextPath + "/admin")) {
            User user = (User) session.getAttribute("user");
            
            if (user == null || !"ADMIN".equals(user.getRole())) {
                // Redirect to home page with error message
                httpResponse.sendRedirect(contextPath + "/home?error=Access denied. Admin privileges required.");
                return;
            }
        }
        
        // Continue with the request
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
