package com.ebook.dao;

import com.ebook.model.Category;
import com.ebook.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Category operations
 */
public class CategoryDAO {
    
    public CategoryDAO() {
        // No stored connection - use fresh connections for each operation
    }
    
    /**
     * Add a new category
     */
    public boolean addCategory(Category category) {
        String sql = "INSERT INTO categories (category_name, description) VALUES (?, ?)";
        
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, category.getCategoryName());
            pstmt.setString(2, category.getDescription());
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    category.setCategoryId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Get all categories
     */
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT c.*, COUNT(b.book_id) as book_count FROM categories c " +
                     "LEFT JOIN books b ON c.category_id = b.category_id AND b.is_available = TRUE " +
                     "GROUP BY c.category_id ORDER BY c.category_name";
        
        try (Connection conn = DBConnection.getNewConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                category.setCreatedAt(rs.getTimestamp("created_at"));
                category.setBookCount(rs.getInt("book_count"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }
    
    /**
     * Get category by ID
     */
    public Category getCategoryById(int categoryId) {
        String sql = "SELECT * FROM categories WHERE category_id = ?";
        
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, categoryId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                category.setCreatedAt(rs.getTimestamp("created_at"));
                return category;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Update category
     */
    public boolean updateCategory(Category category) {
        String sql = "UPDATE categories SET category_name = ?, description = ? WHERE category_id = ?";
        
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, category.getCategoryName());
            pstmt.setString(2, category.getDescription());
            pstmt.setInt(3, category.getCategoryId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Delete category
     */
    public boolean deleteCategory(int categoryId) {
        String sql = "DELETE FROM categories WHERE category_id = ?";
        
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, categoryId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
