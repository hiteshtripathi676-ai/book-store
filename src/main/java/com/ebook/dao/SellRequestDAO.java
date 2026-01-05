package com.ebook.dao;

import com.ebook.model.SellRequest;
import com.ebook.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class for Sell Request operations
 */
public class SellRequestDAO {
    
    /**
     * Create a new sell request
     */
    public int createSellRequest(SellRequest request) {
        String sql = "INSERT INTO sell_requests (user_id, book_title, book_author, book_condition, " +
                     "expected_price, description, book_image, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, request.getUserId());
            stmt.setString(2, request.getBookTitle());
            stmt.setString(3, request.getBookAuthor());
            stmt.setString(4, request.getBookCondition());
            stmt.setDouble(5, request.getExpectedPrice());
            stmt.setString(6, request.getDescription());
            stmt.setString(7, request.getBookImage());
            stmt.setString(8, "PENDING");
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    /**
     * Get all sell requests (for admin)
     */
    public List<SellRequest> getAllSellRequests() {
        List<SellRequest> requests = new ArrayList<>();
        String sql = "SELECT sr.*, u.full_name as user_name, u.email as user_email, u.phone as user_phone " +
                     "FROM sell_requests sr " +
                     "JOIN users u ON sr.user_id = u.user_id " +
                     "ORDER BY sr.created_at DESC";
        
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                requests.add(extractFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }
    
    /**
     * Get pending sell requests count (for admin dashboard)
     */
    public int getPendingSellRequestsCount() {
        String sql = "SELECT COUNT(*) FROM sell_requests WHERE status = 'PENDING'";
        
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    /**
     * Get recent pending sell requests (for admin dashboard notifications)
     */
    public List<SellRequest> getRecentPendingRequests(int limit) {
        List<SellRequest> requests = new ArrayList<>();
        String sql = "SELECT sr.*, u.full_name as user_name, u.email as user_email, u.phone as user_phone " +
                     "FROM sell_requests sr " +
                     "JOIN users u ON sr.user_id = u.user_id " +
                     "WHERE sr.status = 'PENDING' " +
                     "ORDER BY sr.created_at DESC LIMIT ?";
        
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    requests.add(extractFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }
    
    /**
     * Get sell requests by user ID
     */
    public List<SellRequest> getSellRequestsByUserId(int userId) {
        List<SellRequest> requests = new ArrayList<>();
        String sql = "SELECT * FROM sell_requests WHERE user_id = ? ORDER BY created_at DESC";
        
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    requests.add(extractFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }
    
    /**
     * Update sell request status (for admin)
     */
    public boolean updateStatus(int requestId, String status, String adminRemarks) {
        String sql = "UPDATE sell_requests SET status = ?, admin_remarks = ?, updated_at = CURRENT_TIMESTAMP WHERE request_id = ?";
        
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setString(2, adminRemarks);
            stmt.setInt(3, requestId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Get sell request by ID
     */
    public SellRequest getSellRequestById(int requestId) {
        String sql = "SELECT sr.*, u.full_name as user_name, u.email as user_email, u.phone as user_phone " +
                     "FROM sell_requests sr " +
                     "JOIN users u ON sr.user_id = u.user_id " +
                     "WHERE sr.request_id = ?";
        
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, requestId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Extract SellRequest from ResultSet
     */
    private SellRequest extractFromResultSet(ResultSet rs) throws SQLException {
        SellRequest request = new SellRequest();
        request.setRequestId(rs.getInt("request_id"));
        request.setUserId(rs.getInt("user_id"));
        request.setBookTitle(rs.getString("book_title"));
        request.setBookAuthor(rs.getString("book_author"));
        request.setBookCondition(rs.getString("book_condition"));
        request.setExpectedPrice(rs.getDouble("expected_price"));
        request.setDescription(rs.getString("description"));
        request.setBookImage(rs.getString("book_image"));
        request.setStatus(rs.getString("status"));
        request.setAdminRemarks(rs.getString("admin_remarks"));
        request.setCreatedAt(rs.getTimestamp("created_at"));
        request.setUpdatedAt(rs.getTimestamp("updated_at"));
        
        // Try to get user info if available
        try {
            request.setSellerName(rs.getString("user_name"));
            request.setSellerEmail(rs.getString("user_email"));
            request.setSellerPhone(rs.getString("user_phone"));
        } catch (SQLException e) {
            // Ignore if columns not present
        }
        
        return request;
    }
}
