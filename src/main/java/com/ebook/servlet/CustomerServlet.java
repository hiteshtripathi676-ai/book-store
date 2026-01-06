package com.ebook.servlet;

import com.ebook.dao.UserDAO;
import com.ebook.dao.OrderDAO;
import com.ebook.dao.BookDAO;
import com.ebook.dao.CategoryDAO;
import com.ebook.dao.SellRequestDAO;
import com.ebook.model.User;
import com.ebook.model.Order;
import com.ebook.model.SellRequest;
import com.ebook.util.CloudinaryUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;

/**
 * Servlet for handling customer profile and related operations
 */
@WebServlet(name = "CustomerServlet", urlPatterns = {
    "/profile",
    "/profile/update",
    "/profile/change-password",
    "/my-orders",
    "/order-details",
    "/sell-book"
})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 10
)
public class CustomerServlet extends HttpServlet {
    
    private UserDAO userDAO;
    private OrderDAO orderDAO;
    private CategoryDAO categoryDAO;
    private SellRequestDAO sellRequestDAO;
    
    private static final String UPLOAD_DIR = "uploads/sell-requests";
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        orderDAO = new OrderDAO();
        categoryDAO = new CategoryDAO();
        sellRequestDAO = new SellRequestDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getServletPath();
        
        switch (action) {
            case "/profile":
                showProfile(request, response);
                break;
            case "/my-orders":
                showOrders(request, response);
                break;
            case "/order-details":
                showOrderDetails(request, response);
                break;
            case "/sell-book":
                showSellBookForm(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/profile");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getServletPath();
        
        switch (action) {
            case "/profile/update":
                updateProfile(request, response);
                break;
            case "/profile/change-password":
                changePassword(request, response);
                break;
            case "/sell-book":
                submitSellRequest(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/profile");
        }
    }
    
    /**
     * Show user profile
     */
    private void showProfile(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int userId = (int) request.getSession().getAttribute("userId");
        User user = userDAO.getUserById(userId);
        
        request.setAttribute("user", user);
        
        // Get order count
        List<Order> orders = orderDAO.getOrdersByUser(userId);
        request.setAttribute("orderCount", orders.size());
        
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }
    
    /**
     * Update user profile
     */
    private void updateProfile(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int userId = (int) request.getSession().getAttribute("userId");
        User user = userDAO.getUserById(userId);
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/logout");
            return;
        }
        
        // Update fields
        user.setFullName(request.getParameter("fullName"));
        user.setPhone(request.getParameter("phone"));
        user.setAddress(request.getParameter("address"));
        user.setCity(request.getParameter("city"));
        user.setState(request.getParameter("state"));
        user.setPincode(request.getParameter("pincode"));
        
        if (userDAO.updateUser(user)) {
            // Update session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userName", user.getFullName());
            
            request.setAttribute("success", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile. Please try again.");
        }
        
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }
    
    /**
     * Change user password
     */
    private void changePassword(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int userId = (int) request.getSession().getAttribute("userId");
        
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        User user = userDAO.getUserById(userId);
        request.setAttribute("user", user);
        
        // Validate
        if (currentPassword == null || currentPassword.isEmpty() ||
            newPassword == null || newPassword.isEmpty() ||
            confirmPassword == null || confirmPassword.isEmpty()) {
            
            request.setAttribute("passwordError", "Please fill in all password fields");
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("passwordError", "New passwords do not match");
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }
        
        if (newPassword.length() < 6) {
            request.setAttribute("passwordError", "Password must be at least 6 characters");
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }
        
        if (userDAO.updatePassword(userId, currentPassword, newPassword)) {
            request.setAttribute("passwordSuccess", "Password changed successfully!");
        } else {
            request.setAttribute("passwordError", "Current password is incorrect");
        }
        
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }
    
    /**
     * Show user orders
     */
    private void showOrders(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int userId = (int) request.getSession().getAttribute("userId");
        
        List<Order> orders = orderDAO.getOrdersByUser(userId);
        request.setAttribute("orders", orders);
        
        request.getRequestDispatcher("/WEB-INF/views/my-orders.jsp").forward(request, response);
    }
    
    /**
     * Show order details
     */
    private void showOrderDetails(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int userId = (int) request.getSession().getAttribute("userId");
        String orderIdParam = request.getParameter("id");
        
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/my-orders");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdParam);
            Order order = orderDAO.getOrderById(orderId);
            
            // Verify order belongs to user
            if (order != null && order.getUserId() == userId) {
                request.setAttribute("order", order);
                request.getRequestDispatcher("/WEB-INF/views/order-details.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/my-orders");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/my-orders");
        }
    }
    
    /**
     * Show sell book form
     */
    private void showSellBookForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int userId = (int) request.getSession().getAttribute("userId");
        
        // Get user's previous sell requests
        List<SellRequest> myRequests = sellRequestDAO.getSellRequestsByUserId(userId);
        request.setAttribute("sellRequests", myRequests);
        
        // Get categories for the form
        request.setAttribute("categories", categoryDAO.getAllCategories());
        
        request.getRequestDispatcher("/WEB-INF/views/sell-book.jsp").forward(request, response);
    }
    
    /**
     * Submit sell book request
     */
    private void submitSellRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int userId = (int) request.getSession().getAttribute("userId");
        
        // Get form fields - matching JSP field names
        String bookTitle = request.getParameter("title");
        String bookAuthor = request.getParameter("author");
        String bookCondition = request.getParameter("condition");
        String expectedPriceStr = request.getParameter("expectedPrice");
        String description = request.getParameter("description");
        
        // Validate
        if (bookTitle == null || bookTitle.trim().isEmpty() ||
            bookAuthor == null || bookAuthor.trim().isEmpty() ||
            bookCondition == null || bookCondition.trim().isEmpty() ||
            expectedPriceStr == null || expectedPriceStr.trim().isEmpty()) {
            
            request.setAttribute("error", "Please fill in all required fields");
            showSellBookForm(request, response);
            return;
        }
        
        try {
            double expectedPrice = Double.parseDouble(expectedPriceStr);
            
            // Handle file upload
            String bookImage = null;
            Part filePart = request.getPart("images");
            if (filePart != null && filePart.getSize() > 0) {
                bookImage = uploadFile(filePart, request);
            }
            
            // Create sell request
            SellRequest sellRequest = new SellRequest();
            sellRequest.setUserId(userId);
            sellRequest.setBookTitle(bookTitle.trim());
            sellRequest.setBookAuthor(bookAuthor.trim());
            sellRequest.setBookCondition(bookCondition);
            sellRequest.setExpectedPrice(expectedPrice);
            sellRequest.setDescription(description != null ? description.trim() : "");
            sellRequest.setBookImage(bookImage);
            sellRequest.setStatus("PENDING");
            
            // Save to database
            int requestId = sellRequestDAO.createSellRequest(sellRequest);
            
            if (requestId > 0) {
                request.setAttribute("success", "Your sell request has been submitted successfully! We will review and contact you soon.");
            } else {
                request.setAttribute("error", "Failed to submit sell request. Please try again.");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Please enter a valid price");
        }
        
        showSellBookForm(request, response);
    }
    
    /**
     * Handle file upload - uses Cloudinary for cloud storage
     */
    private String uploadFile(Part filePart, HttpServletRequest request) throws IOException {
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        
        // Try Cloudinary first (for cloud deployment)
        if (CloudinaryUtil.isConfigured()) {
            try (InputStream input = filePart.getInputStream()) {
                String cloudinaryUrl = CloudinaryUtil.uploadImage(input, fileName);
                if (cloudinaryUrl != null) {
                    return cloudinaryUrl;
                }
            }
        }
        
        // Fallback to local storage (for local development)
        String extension = fileName.substring(fileName.lastIndexOf("."));
        String uniqueFileName = UUID.randomUUID().toString() + extension;
        
        String uploadPath = request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        String filePath = uploadPath + File.separator + uniqueFileName;
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
        }
        
        return UPLOAD_DIR + "/" + uniqueFileName;
    }
}
