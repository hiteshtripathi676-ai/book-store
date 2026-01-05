package com.ebook.servlet;

import com.ebook.dao.UserDAO;
import com.ebook.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet for handling user authentication (Login/Logout)
 */
@WebServlet(name = "AuthServlet", urlPatterns = {"/login", "/logout", "/register"})
public class AuthServlet extends HttpServlet {
    
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getServletPath();
        
        switch (action) {
            case "/logout":
                handleLogout(request, response);
                break;
            case "/login":
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                break;
            case "/register":
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/home");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getServletPath();
        
        switch (action) {
            case "/login":
                handleLogin(request, response);
                break;
            case "/register":
                handleRegister(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/home");
        }
    }
    
    /**
     * Handle user login
     */
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        
        // Validate input
        if (email == null || email.trim().isEmpty() || 
            password == null || password.trim().isEmpty() ||
            role == null || role.trim().isEmpty()) {
            
            request.setAttribute("error", "Please fill in all fields");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }
        
        // Authenticate user
        User user = userDAO.loginUser(email.trim(), password, role.toUpperCase());
        
        if (user != null) {
            // Create session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userName", user.getFullName());
            session.setAttribute("userRole", user.getRole());
            session.setMaxInactiveInterval(30 * 60); // 30 minutes
            
            // Redirect based on role
            if (user.isAdmin()) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            request.setAttribute("error", "Invalid email, password, or role. Please try again.");
            request.setAttribute("email", email);
            request.setAttribute("role", role);
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
    
    /**
     * Handle user registration
     */
    private void handleRegister(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");
        
        // Validate input
        if (fullName == null || fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            
            request.setAttribute("error", "Please fill in all required fields");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        // Check password match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        // Check if email exists
        if (userDAO.emailExists(email.trim())) {
            request.setAttribute("error", "Email already registered. Please use a different email.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        // Create user
        User user = new User();
        user.setFullName(fullName.trim());
        user.setEmail(email.trim());
        user.setPassword(password);
        user.setPhone(phone != null ? phone.trim() : null);
        user.setRole(role != null && role.equalsIgnoreCase("ADMIN") ? "ADMIN" : "CUSTOMER");
        
        if (userDAO.registerUser(user)) {
            request.setAttribute("success", "Registration successful! Please login.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        }
    }
    
    /**
     * Handle user logout
     */
    private void handleLogout(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/home");
    }
}
