package com.ebook.dao;

import com.ebook.model.CartItem;
import com.ebook.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Cart operations
 */
public class CartDAO {
    
    private Connection connection;
    
    public CartDAO() {
        this.connection = DBConnection.getInstance().getConnection();
    }
    
    /**
     * Add item to cart
     */
    public boolean addToCart(int userId, int bookId, int quantity) {
        // First check if item already exists in cart
        String checkSql = "SELECT cart_id, quantity FROM cart WHERE user_id = ? AND book_id = ?";
        
        try (PreparedStatement checkStmt = connection.prepareStatement(checkSql)) {
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, bookId);
            ResultSet rs = checkStmt.executeQuery();
            
            if (rs.next()) {
                // Item exists, update quantity
                int cartId = rs.getInt("cart_id");
                int existingQty = rs.getInt("quantity");
                return updateCartItemQuantity(cartId, existingQty + quantity);
            } else {
                // Insert new item
                String insertSql = "INSERT INTO cart (user_id, book_id, quantity) VALUES (?, ?, ?)";
                try (PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {
                    insertStmt.setInt(1, userId);
                    insertStmt.setInt(2, bookId);
                    insertStmt.setInt(3, quantity);
                    return insertStmt.executeUpdate() > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Update cart item quantity
     */
    public boolean updateCartItemQuantity(int cartId, int quantity) {
        String sql = "UPDATE cart SET quantity = ? WHERE cart_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, quantity);
            pstmt.setInt(2, cartId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Remove item from cart
     */
    public boolean removeFromCart(int cartId) {
        String sql = "DELETE FROM cart WHERE cart_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, cartId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Remove item from cart by user and book
     */
    public boolean removeFromCart(int userId, int bookId) {
        String sql = "DELETE FROM cart WHERE user_id = ? AND book_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, bookId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Get all cart items for a user
     */
    public List<CartItem> getCartItems(int userId) {
        List<CartItem> cartItems = new ArrayList<>();
        String sql = "SELECT c.*, b.title, b.author, b.cover_image, b.price, b.stock_quantity " +
                     "FROM cart c " +
                     "JOIN books b ON c.book_id = b.book_id " +
                     "WHERE c.user_id = ? ORDER BY c.added_at DESC";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                CartItem item = new CartItem();
                item.setCartId(rs.getInt("cart_id"));
                item.setUserId(rs.getInt("user_id"));
                item.setBookId(rs.getInt("book_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setAddedAt(rs.getTimestamp("added_at"));
                item.setBookTitle(rs.getString("title"));
                item.setBookAuthor(rs.getString("author"));
                item.setBookCoverImage(rs.getString("cover_image"));
                item.setBookPrice(rs.getDouble("price"));
                item.setStockQuantity(rs.getInt("stock_quantity"));
                cartItems.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }
    
    /**
     * Get cart item count for a user
     */
    public int getCartItemCount(int userId) {
        String sql = "SELECT SUM(quantity) FROM cart WHERE user_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    /**
     * Get cart total for a user
     */
    public double getCartTotal(int userId) {
        String sql = "SELECT SUM(b.price * c.quantity) as total FROM cart c " +
                     "JOIN books b ON c.book_id = b.book_id " +
                     "WHERE c.user_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }
    
    /**
     * Clear all cart items for a user
     */
    public boolean clearCart(int userId) {
        String sql = "DELETE FROM cart WHERE user_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            return pstmt.executeUpdate() >= 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Check if item is in cart
     */
    public boolean isInCart(int userId, int bookId) {
        String sql = "SELECT COUNT(*) FROM cart WHERE user_id = ? AND book_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, bookId);
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
     * Get cart item by cart ID
     */
    public CartItem getCartItemById(int cartId) {
        String sql = "SELECT c.*, b.title, b.author, b.cover_image, b.price, b.stock_quantity " +
                     "FROM cart c " +
                     "JOIN books b ON c.book_id = b.book_id " +
                     "WHERE c.cart_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, cartId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                CartItem item = new CartItem();
                item.setCartId(rs.getInt("cart_id"));
                item.setUserId(rs.getInt("user_id"));
                item.setBookId(rs.getInt("book_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setAddedAt(rs.getTimestamp("added_at"));
                item.setBookTitle(rs.getString("title"));
                item.setBookAuthor(rs.getString("author"));
                item.setBookCoverImage(rs.getString("cover_image"));
                item.setBookPrice(rs.getDouble("price"));
                item.setStockQuantity(rs.getInt("stock_quantity"));
                return item;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
