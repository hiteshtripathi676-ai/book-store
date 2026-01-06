package com.ebook.servlet;

import com.ebook.dao.BookDAO;
import com.ebook.dao.CategoryDAO;
import com.ebook.dao.OrderDAO;
import com.ebook.dao.SellRequestDAO;
import com.ebook.model.Book;
import com.ebook.model.Category;
import com.ebook.model.Order;
import com.ebook.model.SellRequest;
import com.ebook.model.User;
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
import java.util.Map;
import java.util.UUID;

/**
 * Servlet for Admin functionalities
 * Handles book management, order viewing, and analytics
 */
@WebServlet(name = "AdminServlet", urlPatterns = {
    "/admin/dashboard", 
    "/admin/books", 
    "/admin/add-book", 
    "/admin/edit-book",
    "/admin/delete-book",
    "/admin/orders",
    "/admin/order-details",
    "/admin/update-order",
    "/admin/customers",
    "/admin/low-stock",
    "/admin/sell-requests",
    "/admin/sell-request-details",
    "/admin/update-sell-request"
})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1 MB
    maxFileSize = 1024 * 1024 * 10,       // 10 MB
    maxRequestSize = 1024 * 1024 * 50     // 50 MB
)
public class AdminServlet extends HttpServlet {
    
    private BookDAO bookDAO;
    private CategoryDAO categoryDAO;
    private OrderDAO orderDAO;
    private SellRequestDAO sellRequestDAO;
    
    private static final String UPLOAD_DIR = "images/books";
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
        categoryDAO = new CategoryDAO();
        orderDAO = new OrderDAO();
        sellRequestDAO = new SellRequestDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check admin authentication
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getServletPath();
        
        switch (action) {
            case "/admin/dashboard":
                showDashboard(request, response);
                break;
            case "/admin/books":
                showBooks(request, response);
                break;
            case "/admin/add-book":
                showAddBookForm(request, response);
                break;
            case "/admin/edit-book":
                showEditBookForm(request, response);
                break;
            case "/admin/delete-book":
                deleteBook(request, response);
                break;
            case "/admin/orders":
                showOrders(request, response);
                break;
            case "/admin/order-details":
                showOrderDetails(request, response);
                break;
            case "/admin/customers":
                showCustomers(request, response);
                break;
            case "/admin/low-stock":
                showLowStockBooks(request, response);
                break;
            case "/admin/sell-requests":
                showSellRequests(request, response);
                break;
            case "/admin/sell-request-details":
                showSellRequestDetails(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check admin authentication
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getServletPath();
        
        switch (action) {
            case "/admin/add-book":
                addBook(request, response);
                break;
            case "/admin/edit-book":
                updateBook(request, response);
                break;
            case "/admin/update-order":
                updateOrderStatus(request, response);
                break;
            case "/admin/update-sell-request":
                updateSellRequestStatus(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        }
    }
    
    /**
     * Check if user is admin
     */
    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;
        
        String role = (String) session.getAttribute("userRole");
        return "ADMIN".equalsIgnoreCase(role);
    }
    
    /**
     * Show admin dashboard
     */
    private void showDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get statistics
        int totalBooks = bookDAO.getTotalBookCount();
        int totalOrders = orderDAO.getTotalOrdersCount();
        double totalRevenue = orderDAO.getTotalRevenue();
        
        request.setAttribute("totalBooks", totalBooks);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalRevenue", totalRevenue);
        
        // Get recent orders
        List<Order> recentOrders = orderDAO.getRecentOrders(5);
        request.setAttribute("recentOrders", recentOrders);
        
        // Get low stock alerts
        List<Book> lowStockBooks = bookDAO.getLowStockBooks();
        request.setAttribute("lowStockBooks", lowStockBooks);
        request.setAttribute("lowStockCount", lowStockBooks.size());
        
        // Get pending sell requests for notifications
        int pendingSellRequests = sellRequestDAO.getPendingSellRequestsCount();
        List<SellRequest> recentSellRequests = sellRequestDAO.getRecentPendingRequests(5);
        request.setAttribute("pendingSellRequests", pendingSellRequests);
        request.setAttribute("recentSellRequests", recentSellRequests);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
    
    /**
     * Show all books for admin
     */
    private void showBooks(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Book> books = bookDAO.getAllBooksForAdmin();
        request.setAttribute("books", books);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/books.jsp").forward(request, response);
    }
    
    /**
     * Show add book form
     */
    private void showAddBookForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/add-book.jsp").forward(request, response);
    }
    
    /**
     * Show edit book form
     */
    private void showEditBookForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String bookIdParam = request.getParameter("id");
        
        if (bookIdParam == null || bookIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/books");
            return;
        }
        
        try {
            int bookId = Integer.parseInt(bookIdParam);
            Book book = bookDAO.getBookById(bookId);
            
            if (book != null) {
                request.setAttribute("book", book);
                
                List<Category> categories = categoryDAO.getAllCategories();
                request.setAttribute("categories", categories);
                
                request.getRequestDispatcher("/WEB-INF/views/admin/edit-book.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/books");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/books");
        }
    }
    
    /**
     * Add new book with file upload
     */
    private void addBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Get form data
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            double originalPrice = request.getParameter("originalPrice") != null && 
                                   !request.getParameter("originalPrice").isEmpty() 
                                   ? Double.parseDouble(request.getParameter("originalPrice")) : price;
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String bookType = request.getParameter("bookType");
            String isbn = request.getParameter("isbn");
            String publisher = request.getParameter("publisher");
            int publicationYear = request.getParameter("publicationYear") != null && 
                                  !request.getParameter("publicationYear").isEmpty()
                                  ? Integer.parseInt(request.getParameter("publicationYear")) : 0;
            int pages = request.getParameter("pages") != null && !request.getParameter("pages").isEmpty()
                       ? Integer.parseInt(request.getParameter("pages")) : 0;
            String language = request.getParameter("language");
            int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
            int lowStockThreshold = request.getParameter("lowStockThreshold") != null && 
                                    !request.getParameter("lowStockThreshold").isEmpty()
                                    ? Integer.parseInt(request.getParameter("lowStockThreshold")) : 5;
            
            // Handle file upload
            String coverImage = null;
            Part filePart = request.getPart("coverImage");
            
            if (filePart != null && filePart.getSize() > 0) {
                coverImage = uploadFile(filePart, request);
            }
            
            // Create book object
            Book book = new Book();
            book.setTitle(title);
            book.setAuthor(author);
            book.setDescription(description);
            book.setPrice(price);
            book.setOriginalPrice(originalPrice);
            book.setCategoryId(categoryId);
            book.setBookType(bookType);
            book.setCoverImage(coverImage);
            book.setIsbn(isbn);
            book.setPublisher(publisher);
            book.setPublicationYear(publicationYear);
            book.setPages(pages);
            book.setLanguage(language != null && !language.isEmpty() ? language : "English");
            book.setStockQuantity(stockQuantity);
            book.setLowStockThreshold(lowStockThreshold);
            
            // Handle COD availability
            String codAvailableParam = request.getParameter("codAvailable");
            book.setCodAvailable(codAvailableParam != null && "true".equals(codAvailableParam));
            
            if (bookDAO.addBook(book)) {
                request.getSession().setAttribute("successMessage", "Book added successfully!");
                response.sendRedirect(request.getContextPath() + "/admin/books");
            } else {
                request.setAttribute("error", "Failed to add book. Please try again.");
                showAddBookForm(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            showAddBookForm(request, response);
        }
    }
    
    /**
     * Update existing book
     */
    private void updateBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            Book existingBook = bookDAO.getBookById(bookId);
            
            if (existingBook == null) {
                response.sendRedirect(request.getContextPath() + "/admin/books");
                return;
            }
            
            // Get form data
            existingBook.setTitle(request.getParameter("title"));
            existingBook.setAuthor(request.getParameter("author"));
            existingBook.setDescription(request.getParameter("description"));
            existingBook.setPrice(Double.parseDouble(request.getParameter("price")));
            
            String originalPriceStr = request.getParameter("originalPrice");
            existingBook.setOriginalPrice(originalPriceStr != null && !originalPriceStr.isEmpty() 
                                          ? Double.parseDouble(originalPriceStr) : existingBook.getPrice());
            
            existingBook.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
            existingBook.setBookType(request.getParameter("bookType"));
            existingBook.setIsbn(request.getParameter("isbn"));
            existingBook.setPublisher(request.getParameter("publisher"));
            
            String pubYearStr = request.getParameter("publicationYear");
            existingBook.setPublicationYear(pubYearStr != null && !pubYearStr.isEmpty() 
                                            ? Integer.parseInt(pubYearStr) : 0);
            
            String pagesStr = request.getParameter("pages");
            existingBook.setPages(pagesStr != null && !pagesStr.isEmpty() ? Integer.parseInt(pagesStr) : 0);
            
            existingBook.setLanguage(request.getParameter("language"));
            existingBook.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
            
            String lowStockStr = request.getParameter("lowStockThreshold");
            existingBook.setLowStockThreshold(lowStockStr != null && !lowStockStr.isEmpty() 
                                              ? Integer.parseInt(lowStockStr) : 5);
            
            existingBook.setAvailable("on".equals(request.getParameter("isAvailable")) || 
                                      "true".equals(request.getParameter("isAvailable")));
            
            // Handle COD availability
            String codAvailableParam = request.getParameter("codAvailable");
            existingBook.setCodAvailable(codAvailableParam != null && "true".equals(codAvailableParam));
            
            // Handle file upload
            Part filePart = request.getPart("coverImage");
            System.out.println("DEBUG: filePart = " + filePart);
            if (filePart != null) {
                System.out.println("DEBUG: filePart.getSize() = " + filePart.getSize());
                System.out.println("DEBUG: filePart.getSubmittedFileName() = " + filePart.getSubmittedFileName());
            }
            if (filePart != null && filePart.getSize() > 0) {
                String newImage = uploadFile(filePart, request);
                System.out.println("DEBUG: newImage = " + newImage);
                existingBook.setCoverImage(newImage);
            }
            
            System.out.println("DEBUG: existingBook.getCoverImage() = " + existingBook.getCoverImage());
            
            if (bookDAO.updateBook(existingBook)) {
                request.getSession().setAttribute("successMessage", "Book updated successfully!");
                response.sendRedirect(request.getContextPath() + "/admin/books");
            } else {
                request.setAttribute("error", "Failed to update book. Please try again.");
                request.setAttribute("book", existingBook);
                showEditBookForm(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            showEditBookForm(request, response);
        }
    }
    
    /**
     * Delete a book
     */
    private void deleteBook(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        String bookIdParam = request.getParameter("id");
        
        if (bookIdParam != null && !bookIdParam.isEmpty()) {
            try {
                int bookId = Integer.parseInt(bookIdParam);
                if (bookDAO.deleteBook(bookId)) {
                    request.getSession().setAttribute("successMessage", "Book deleted successfully!");
                } else {
                    request.getSession().setAttribute("errorMessage", "Failed to delete book.");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMessage", "Invalid book ID.");
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/books");
    }
    
    /**
     * Show all orders
     */
    private void showOrders(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Order> orders = orderDAO.getAllOrders();
        request.setAttribute("orders", orders);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/orders.jsp").forward(request, response);
    }
    
    /**
     * Show order details
     */
    private void showOrderDetails(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String orderIdParam = request.getParameter("id");
        
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdParam);
            Order order = orderDAO.getOrderById(orderId);
            
            if (order != null) {
                request.setAttribute("order", order);
                request.getRequestDispatcher("/WEB-INF/views/admin/order-details.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/orders");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }
    }
    
    /**
     * Update order status
     */
    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        String orderIdParam = request.getParameter("orderId");
        String orderStatus = request.getParameter("orderStatus");
        String paymentStatus = request.getParameter("paymentStatus");
        
        if (orderIdParam != null && !orderIdParam.isEmpty()) {
            try {
                int orderId = Integer.parseInt(orderIdParam);
                
                if (orderStatus != null && !orderStatus.isEmpty()) {
                    orderDAO.updateOrderStatus(orderId, orderStatus);
                }
                
                if (paymentStatus != null && !paymentStatus.isEmpty()) {
                    orderDAO.updatePaymentStatus(orderId, paymentStatus);
                }
                
                request.getSession().setAttribute("successMessage", "Order updated successfully!");
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMessage", "Invalid order ID.");
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
    
    /**
     * Show all customers
     */
    private void showCustomers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // This would use UserDAO.getAllCustomers()
        request.getRequestDispatcher("/WEB-INF/views/admin/customers.jsp").forward(request, response);
    }
    
    /**
     * Show low stock books
     */
    private void showLowStockBooks(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Book> lowStockBooks = bookDAO.getLowStockBooks();
        request.setAttribute("lowStockBooks", lowStockBooks);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/low-stock.jsp").forward(request, response);
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
        
        // Create upload directory
        String uploadPath = request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        // Save file
        String filePath = uploadPath + File.separator + uniqueFileName;
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
        }
        
        return UPLOAD_DIR + "/" + uniqueFileName;
    }
    
    /**
     * Show all sell requests
     */
    private void showSellRequests(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<SellRequest> sellRequests = sellRequestDAO.getAllSellRequests();
        request.setAttribute("sellRequests", sellRequests);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/sell-requests.jsp").forward(request, response);
    }
    
    /**
     * Show sell request details
     */
    private void showSellRequestDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String requestIdParam = request.getParameter("id");
        if (requestIdParam == null || requestIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/sell-requests");
            return;
        }
        
        try {
            int requestId = Integer.parseInt(requestIdParam);
            SellRequest sellRequest = sellRequestDAO.getSellRequestById(requestId);
            
            if (sellRequest != null) {
                request.setAttribute("sellRequest", sellRequest);
                request.getRequestDispatcher("/WEB-INF/views/admin/sell-request-details.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/sell-requests");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/sell-requests");
        }
    }
    
    /**
     * Update sell request status (approve/reject)
     */
    private void updateSellRequestStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String requestIdParam = request.getParameter("requestId");
        String status = request.getParameter("status");
        String remarks = request.getParameter("remarks");
        
        if (requestIdParam == null || status == null) {
            response.sendRedirect(request.getContextPath() + "/admin/sell-requests");
            return;
        }
        
        try {
            int requestId = Integer.parseInt(requestIdParam);
            
            if (sellRequestDAO.updateStatus(requestId, status, remarks)) {
                request.getSession().setAttribute("success", "Sell request updated successfully!");
            } else {
                request.getSession().setAttribute("error", "Failed to update sell request.");
            }
            
            response.sendRedirect(request.getContextPath() + "/admin/sell-request-details?id=" + requestId);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/sell-requests");
        }
    }
}
