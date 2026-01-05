package com.ebook.servlet;

import com.ebook.dao.CartDAO;
import com.ebook.dao.BookDAO;
import com.ebook.dao.OrderDAO;
import com.ebook.dao.UserDAO;
import com.ebook.model.CartItem;
import com.ebook.model.Book;
import com.ebook.model.Order;
import com.ebook.model.User;
import com.ebook.service.EmailService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Servlet for handling shopping cart operations
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/cart", "/cart/add", "/cart/remove", "/cart/update", "/checkout", "/order-success"})
public class CartServlet extends HttpServlet {
    
    private CartDAO cartDAO;
    private BookDAO bookDAO;
    private OrderDAO orderDAO;
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        cartDAO = new CartDAO();
        bookDAO = new BookDAO();
        orderDAO = new OrderDAO();
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getServletPath();
        
        // Check if user is logged in for cart operations
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            if (!action.equals("/order-success")) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
        }
        
        switch (action) {
            case "/cart":
                showCart(request, response);
                break;
            case "/cart/remove":
                removeFromCart(request, response);
                break;
            case "/checkout":
                showCheckout(request, response);
                break;
            case "/order-success":
                showOrderSuccess(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getServletPath();
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            // For AJAX requests, send JSON response
            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Please login first\", \"redirect\": \"" + request.getContextPath() + "/login\"}");
                return;
            }
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        switch (action) {
            case "/cart/add":
                addToCart(request, response);
                break;
            case "/cart/update":
                updateCartItem(request, response);
                break;
            case "/checkout":
                processCheckout(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
    
    /**
     * Show shopping cart
     */
    private void showCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int userId = (int) request.getSession().getAttribute("userId");
        
        List<CartItem> cartItems = cartDAO.getCartItems(userId);
        double cartTotal = cartDAO.getCartTotal(userId);
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", cartTotal);
        request.setAttribute("cartCount", cartItems.size());
        
        request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
    }
    
    /**
     * Add item to cart (AJAX)
     */
    private void addToCart(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        try {
            int userId = (int) request.getSession().getAttribute("userId");
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int quantity = request.getParameter("quantity") != null 
                          ? Integer.parseInt(request.getParameter("quantity")) : 1;
            
            // Check if book exists and has stock
            Book book = bookDAO.getBookById(bookId);
            if (book == null) {
                out.write("{\"success\": false, \"message\": \"Book not found\"}");
                return;
            }
            
            if (book.getStockQuantity() < quantity) {
                out.write("{\"success\": false, \"message\": \"Not enough stock available\"}");
                return;
            }
            
            if (cartDAO.addToCart(userId, bookId, quantity)) {
                int cartCount = cartDAO.getCartItemCount(userId);
                out.write("{\"success\": true, \"message\": \"Book added to cart!\", \"cartCount\": " + cartCount + "}");
            } else {
                out.write("{\"success\": false, \"message\": \"Failed to add to cart\"}");
            }
            
        } catch (NumberFormatException e) {
            out.write("{\"success\": false, \"message\": \"Invalid input\"}");
        }
    }
    
    /**
     * Remove item from cart
     */
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        int userId = (int) request.getSession().getAttribute("userId");
        String cartIdParam = request.getParameter("id");
        
        if (cartIdParam != null && !cartIdParam.isEmpty()) {
            try {
                int cartId = Integer.parseInt(cartIdParam);
                cartDAO.removeFromCart(cartId);
            } catch (NumberFormatException e) {
                // Ignore
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/cart");
    }
    
    /**
     * Update cart item quantity (AJAX)
     */
    private void updateCartItem(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        try {
            int cartId = Integer.parseInt(request.getParameter("cartId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            if (quantity <= 0) {
                cartDAO.removeFromCart(cartId);
                out.write("{\"success\": true, \"message\": \"Item removed\", \"removed\": true}");
            } else {
                // Check stock
                CartItem item = cartDAO.getCartItemById(cartId);
                if (item != null && quantity > item.getStockQuantity()) {
                    out.write("{\"success\": false, \"message\": \"Not enough stock. Available: " + item.getStockQuantity() + "\"}");
                    return;
                }
                
                if (cartDAO.updateCartItemQuantity(cartId, quantity)) {
                    int userId = (int) request.getSession().getAttribute("userId");
                    double cartTotal = cartDAO.getCartTotal(userId);
                    out.write("{\"success\": true, \"message\": \"Cart updated\", \"cartTotal\": " + cartTotal + "}");
                } else {
                    out.write("{\"success\": false, \"message\": \"Failed to update cart\"}");
                }
            }
            
        } catch (NumberFormatException e) {
            out.write("{\"success\": false, \"message\": \"Invalid input\"}");
        }
    }
    
    /**
     * Show checkout page
     */
    private void showCheckout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int userId = (int) request.getSession().getAttribute("userId");
        
        List<CartItem> cartItems = cartDAO.getCartItems(userId);
        
        if (cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        double cartTotal = cartDAO.getCartTotal(userId);
        
        // Check if COD is available for all items in cart
        boolean codAvailable = true;
        for (CartItem item : cartItems) {
            Book book = bookDAO.getBookById(item.getBookId());
            if (book != null && !book.isCodAvailable()) {
                codAvailable = false;
                break;
            }
        }
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", cartTotal);
        request.setAttribute("codAvailable", codAvailable);
        
        // Get user info for pre-filling address
        User user = (User) request.getSession().getAttribute("user");
        request.setAttribute("user", user);
        
        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
    }
    
    /**
     * Process checkout and create order
     */
    private void processCheckout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int userId = (int) request.getSession().getAttribute("userId");
        
        List<CartItem> cartItems = cartDAO.getCartItems(userId);
        
        if (cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Get shipping details
        String shippingAddress = request.getParameter("shippingAddress");
        String shippingCity = request.getParameter("shippingCity");
        String shippingState = request.getParameter("shippingState");
        String shippingPincode = request.getParameter("shippingPincode");
        String paymentMethod = request.getParameter("paymentMethod");
        String notes = request.getParameter("notes");
        
        // Validate
        if (shippingAddress == null || shippingAddress.trim().isEmpty() ||
            shippingCity == null || shippingCity.trim().isEmpty() ||
            shippingState == null || shippingState.trim().isEmpty() ||
            shippingPincode == null || shippingPincode.trim().isEmpty()) {
            
            request.setAttribute("error", "Please fill in all shipping details");
            showCheckout(request, response);
            return;
        }
        
        // Calculate total
        double cartTotal = cartDAO.getCartTotal(userId);
        
        // Create order
        Order order = new Order();
        order.setUserId(userId);
        order.setTotalAmount(cartTotal);
        order.setShippingAddress(shippingAddress.trim());
        order.setShippingCity(shippingCity.trim());
        order.setShippingState(shippingState.trim());
        order.setShippingPincode(shippingPincode.trim());
        order.setPaymentMethod(paymentMethod != null ? paymentMethod : "COD");
        order.setNotes(notes);
        
        int orderId = orderDAO.createOrder(order, cartItems);
        
        if (orderId > 0) {
            // Set the order ID for email
            order.setOrderId(orderId);
            
            // Get customer details for email
            User customer = userDAO.getUserById(userId);
            if (customer != null) {
                // Send confirmation email to customer in background thread
                new Thread(() -> {
                    EmailService.sendOrderConfirmation(order, customer.getEmail(), customer.getFullName());
                }).start();
                
                // Send notification email to admin in background thread
                new Thread(() -> {
                    EmailService.sendAdminOrderNotification(order, customer.getFullName(), customer.getEmail());
                }).start();
            }
            
            response.sendRedirect(request.getContextPath() + "/order-success?id=" + orderId);
        } else {
            request.setAttribute("error", "Failed to place order. Please try again.");
            showCheckout(request, response);
        }
    }
    
    /**
     * Show order success page
     */
    private void showOrderSuccess(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String orderIdParam = request.getParameter("id");
        
        if (orderIdParam != null && !orderIdParam.isEmpty()) {
            try {
                int orderId = Integer.parseInt(orderIdParam);
                Order order = orderDAO.getOrderById(orderId);
                request.setAttribute("order", order);
            } catch (NumberFormatException e) {
                // Ignore
            }
        }
        
        request.getRequestDispatcher("/WEB-INF/views/order-success.jsp").forward(request, response);
    }
}
