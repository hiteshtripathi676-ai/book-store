package com.ebook.dao;

import com.ebook.model.Order;
import com.ebook.model.OrderItem;
import com.ebook.model.CartItem;
import com.ebook.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

/**
 * Data Access Object for Order operations
 */
public class OrderDAO {
    
    private Connection connection;
    
    public OrderDAO() {
        this.connection = DBConnection.getInstance().getConnection();
    }
    
    /**
     * Create a new order from cart items
     */
    public int createOrder(Order order, List<CartItem> cartItems) {
        String orderSql = "INSERT INTO orders (user_id, total_amount, shipping_address, shipping_city, " +
                          "shipping_state, shipping_pincode, payment_method, notes) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        String itemSql = "INSERT INTO order_items (order_id, book_id, quantity, price_at_purchase) VALUES (?, ?, ?, ?)";
        
        String updateStockSql = "UPDATE books SET stock_quantity = stock_quantity - ? WHERE book_id = ?";
        
        try {
            connection.setAutoCommit(false);
            
            // Insert order
            try (PreparedStatement orderStmt = connection.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                orderStmt.setInt(1, order.getUserId());
                orderStmt.setDouble(2, order.getTotalAmount());
                orderStmt.setString(3, order.getShippingAddress());
                orderStmt.setString(4, order.getShippingCity());
                orderStmt.setString(5, order.getShippingState());
                orderStmt.setString(6, order.getShippingPincode());
                orderStmt.setString(7, order.getPaymentMethod());
                orderStmt.setString(8, order.getNotes());
                
                orderStmt.executeUpdate();
                
                ResultSet rs = orderStmt.getGeneratedKeys();
                if (rs.next()) {
                    int orderId = rs.getInt(1);
                    
                    // Insert order items and update stock
                    try (PreparedStatement itemStmt = connection.prepareStatement(itemSql);
                         PreparedStatement stockStmt = connection.prepareStatement(updateStockSql)) {
                        
                        for (CartItem cartItem : cartItems) {
                            // Add order item
                            itemStmt.setInt(1, orderId);
                            itemStmt.setInt(2, cartItem.getBookId());
                            itemStmt.setInt(3, cartItem.getQuantity());
                            itemStmt.setDouble(4, cartItem.getBookPrice());
                            itemStmt.addBatch();
                            
                            // Update stock
                            stockStmt.setInt(1, cartItem.getQuantity());
                            stockStmt.setInt(2, cartItem.getBookId());
                            stockStmt.addBatch();
                        }
                        
                        itemStmt.executeBatch();
                        stockStmt.executeBatch();
                    }
                    
                    // Clear cart
                    String clearCartSql = "DELETE FROM cart WHERE user_id = ?";
                    try (PreparedStatement clearStmt = connection.prepareStatement(clearCartSql)) {
                        clearStmt.setInt(1, order.getUserId());
                        clearStmt.executeUpdate();
                    }
                    
                    connection.commit();
                    return orderId;
                }
            }
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return -1;
    }
    
    /**
     * Get order by ID
     */
    public Order getOrderById(int orderId) {
        String sql = "SELECT o.*, u.full_name, u.email FROM orders o " +
                     "JOIN users u ON o.user_id = u.user_id " +
                     "WHERE o.order_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, orderId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Order order = extractOrderFromResultSet(rs);
                order.setOrderItems(getOrderItems(orderId));
                return order;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Get order items for an order
     */
    public List<OrderItem> getOrderItems(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT oi.*, b.title, b.author, b.cover_image FROM order_items oi " +
                     "JOIN books b ON oi.book_id = b.book_id " +
                     "WHERE oi.order_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, orderId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setItemId(rs.getInt("item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setBookId(rs.getInt("book_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPriceAtPurchase(rs.getDouble("price_at_purchase"));
                item.setBookTitle(rs.getString("title"));
                item.setBookAuthor(rs.getString("author"));
                item.setBookCoverImage(rs.getString("cover_image"));
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }
    
    /**
     * Get all orders for a user
     */
    public List<Order> getOrdersByUser(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, u.full_name, u.email FROM orders o " +
                     "JOIN users u ON o.user_id = u.user_id " +
                     "WHERE o.user_id = ? ORDER BY o.order_date DESC";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Order order = extractOrderFromResultSet(rs);
                order.setOrderItems(getOrderItems(order.getOrderId()));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
    
    /**
     * Get all orders (for admin)
     */
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, u.full_name, u.email FROM orders o " +
                     "JOIN users u ON o.user_id = u.user_id " +
                     "ORDER BY o.order_date DESC";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Order order = extractOrderFromResultSet(rs);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
    
    /**
     * Update order status
     */
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET order_status = ? WHERE order_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, orderId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Update payment status
     */
    public boolean updatePaymentStatus(int orderId, String status) {
        String sql = "UPDATE orders SET payment_status = ? WHERE order_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, orderId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Get total orders count
     */
    public int getTotalOrdersCount() {
        String sql = "SELECT COUNT(*) FROM orders";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    /**
     * Get total revenue
     */
    public double getTotalRevenue() {
        String sql = "SELECT SUM(total_amount) FROM orders WHERE order_status != 'CANCELLED'";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }
    
    /**
     * Get monthly sales data for analytics
     */
    public List<Map<String, Object>> getMonthlySales() {
        List<Map<String, Object>> salesData = new ArrayList<>();
        String sql = "SELECT YEAR(order_date) as year, MONTH(order_date) as month, " +
                     "MONTHNAME(order_date) as month_name, COUNT(*) as orders, " +
                     "SUM(total_amount) as revenue FROM orders " +
                     "WHERE order_status != 'CANCELLED' " +
                     "GROUP BY YEAR(order_date), MONTH(order_date), MONTHNAME(order_date) " +
                     "ORDER BY year DESC, month DESC LIMIT 12";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Map<String, Object> data = new HashMap<>();
                data.put("year", rs.getInt("year"));
                data.put("month", rs.getInt("month"));
                data.put("monthName", rs.getString("month_name"));
                data.put("orders", rs.getInt("orders"));
                data.put("revenue", rs.getDouble("revenue"));
                salesData.add(data);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return salesData;
    }
    
    /**
     * Get popular authors for analytics
     */
    public List<Map<String, Object>> getPopularAuthors() {
        List<Map<String, Object>> authorsData = new ArrayList<>();
        String sql = "SELECT b.author, COUNT(oi.item_id) as order_count, " +
                     "SUM(oi.quantity) as books_sold, SUM(oi.quantity * oi.price_at_purchase) as revenue " +
                     "FROM order_items oi " +
                     "JOIN books b ON oi.book_id = b.book_id " +
                     "JOIN orders o ON oi.order_id = o.order_id " +
                     "WHERE o.order_status != 'CANCELLED' " +
                     "GROUP BY b.author ORDER BY books_sold DESC LIMIT 10";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Map<String, Object> data = new HashMap<>();
                data.put("author", rs.getString("author"));
                data.put("orderCount", rs.getInt("order_count"));
                data.put("booksSold", rs.getInt("books_sold"));
                data.put("revenue", rs.getDouble("revenue"));
                authorsData.add(data);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return authorsData;
    }
    
    /**
     * Get recent orders (for dashboard)
     */
    public List<Order> getRecentOrders(int limit) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, u.full_name, u.email FROM orders o " +
                     "JOIN users u ON o.user_id = u.user_id " +
                     "ORDER BY o.order_date DESC LIMIT ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, limit);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
    
    /**
     * Helper method to extract Order from ResultSet
     */
    private Order extractOrderFromResultSet(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("order_id"));
        order.setUserId(rs.getInt("user_id"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        order.setTotalAmount(rs.getDouble("total_amount"));
        order.setShippingAddress(rs.getString("shipping_address"));
        order.setShippingCity(rs.getString("shipping_city"));
        order.setShippingState(rs.getString("shipping_state"));
        order.setShippingPincode(rs.getString("shipping_pincode"));
        order.setPaymentMethod(rs.getString("payment_method"));
        order.setPaymentStatus(rs.getString("payment_status"));
        order.setOrderStatus(rs.getString("order_status"));
        order.setTrackingNumber(rs.getString("tracking_number"));
        order.setNotes(rs.getString("notes"));
        order.setCreatedAt(rs.getTimestamp("created_at"));
        order.setUpdatedAt(rs.getTimestamp("updated_at"));
        
        try {
            order.setCustomerName(rs.getString("full_name"));
            order.setCustomerEmail(rs.getString("email"));
        } catch (SQLException e) {
            // Columns not present
        }
        
        return order;
    }
    
    /**
     * Get total books sold across all orders
     */
    public int getTotalBooksSold() {
        String sql = "SELECT COALESCE(SUM(quantity), 0) as total FROM order_items oi " +
                     "JOIN orders o ON oi.order_id = o.order_id " +
                     "WHERE o.order_status != 'CANCELLED'";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    /**
     * Get sales by category
     */
    public List<Map<String, Object>> getCategorySales() {
        List<Map<String, Object>> sales = new ArrayList<>();
        String sql = "SELECT c.category_name, SUM(o.total_amount) as totalSales, " +
                     "COUNT(DISTINCT o.order_id) as orderCount " +
                     "FROM orders o " +
                     "JOIN order_items oi ON o.order_id = oi.order_id " +
                     "JOIN books b ON oi.book_id = b.book_id " +
                     "JOIN categories c ON b.category_id = c.category_id " +
                     "WHERE o.order_status != 'CANCELLED' " +
                     "GROUP BY c.category_id, c.category_name " +
                     "ORDER BY totalSales DESC LIMIT 10";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Map<String, Object> sale = new HashMap<>();
                sale.put("categoryName", rs.getString("category_name"));
                sale.put("totalSales", rs.getDouble("totalSales"));
                sale.put("orderCount", rs.getInt("orderCount"));
                sales.add(sale);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sales;
    }
    
    /**
     * Get order count by status
     */
    public int getOrderCountByStatus(String status) {
        String sql = "SELECT COUNT(*) as count FROM orders WHERE order_status = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, status);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}

