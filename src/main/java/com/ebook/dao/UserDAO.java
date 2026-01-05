package com.ebook.dao;

import com.ebook.model.User;
import com.ebook.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for User operations
 */
public class UserDAO {
    
    private Connection connection;
    
    public UserDAO() {
        this.connection = DBConnection.getInstance().getConnection();
    }
    
    /**
     * Register a new user
     */
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (full_name, email, password, phone, address, city, state, pincode, role) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, user.getFullName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getPhone());
            pstmt.setString(5, user.getAddress());
            pstmt.setString(6, user.getCity());
            pstmt.setString(7, user.getState());
            pstmt.setString(8, user.getPincode());
            pstmt.setString(9, user.getRole() != null ? user.getRole() : "CUSTOMER");
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    user.setUserId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Authenticate user login
     */
    public User loginUser(String email, String password, String role) {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ? AND role = ? AND is_active = TRUE";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            pstmt.setString(3, role);
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Get user by ID
     */
    public User getUserById(int userId) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Get user by email
     */
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Check if email already exists
     */
    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Update user profile
     */
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET full_name = ?, phone = ?, address = ?, city = ?, state = ?, pincode = ?, " +
                     "profile_image = ? WHERE user_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, user.getFullName());
            pstmt.setString(2, user.getPhone());
            pstmt.setString(3, user.getAddress());
            pstmt.setString(4, user.getCity());
            pstmt.setString(5, user.getState());
            pstmt.setString(6, user.getPincode());
            pstmt.setString(7, user.getProfileImage());
            pstmt.setInt(8, user.getUserId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Update user password
     */
    public boolean updatePassword(int userId, String oldPassword, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE user_id = ? AND password = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, newPassword);
            pstmt.setInt(2, userId);
            pstmt.setString(3, oldPassword);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Get all customers (for admin)
     */
    public List<User> getAllCustomers() {
        List<User> customers = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = 'CUSTOMER' ORDER BY created_at DESC";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                customers.add(extractUserFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }
    
    /**
     * Get total customer count
     */
    public int getCustomerCount() {
        String sql = "SELECT COUNT(*) FROM users WHERE role = 'CUSTOMER'";
        
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
     * Deactivate user account
     */
    public boolean deactivateUser(int userId) {
        String sql = "UPDATE users SET is_active = FALSE WHERE user_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Activate user account
     */
    public boolean activateUser(int userId) {
        String sql = "UPDATE users SET is_active = TRUE WHERE user_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Helper method to extract User from ResultSet
     */
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setPassword(rs.getString("password"));
        user.setPhone(rs.getString("phone"));
        user.setAddress(rs.getString("address"));
        user.setCity(rs.getString("city"));
        user.setState(rs.getString("state"));
        user.setPincode(rs.getString("pincode"));
        user.setRole(rs.getString("role"));
        user.setProfileImage(rs.getString("profile_image"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        user.setUpdatedAt(rs.getTimestamp("updated_at"));
        user.setActive(rs.getBoolean("is_active"));
        return user;
    }
}
