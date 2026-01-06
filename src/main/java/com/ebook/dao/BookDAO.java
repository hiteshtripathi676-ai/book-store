package com.ebook.dao;

import com.ebook.model.Book;
import com.ebook.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Book operations
 */
public class BookDAO {
    
    public BookDAO() {
        // No stored connection - will use fresh connections
    }
    
    /**
     * Add a new book
     */
    public boolean addBook(Book book) {
        String sql = "INSERT INTO books (title, author, description, price, original_price, category_id, " +
                     "book_type, cover_image, isbn, publisher, publication_year, pages, language, " +
                     "stock_quantity, low_stock_threshold, seller_id, cod_available) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection connection = DBConnection.getNewConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, book.getTitle());
            pstmt.setString(2, book.getAuthor());
            pstmt.setString(3, book.getDescription());
            pstmt.setDouble(4, book.getPrice());
            pstmt.setDouble(5, book.getOriginalPrice());
            pstmt.setInt(6, book.getCategoryId());
            pstmt.setString(7, book.getBookType());
            pstmt.setString(8, book.getCoverImage());
            pstmt.setString(9, book.getIsbn());
            pstmt.setString(10, book.getPublisher());
            pstmt.setInt(11, book.getPublicationYear());
            pstmt.setInt(12, book.getPages());
            pstmt.setString(13, book.getLanguage());
            pstmt.setInt(14, book.getStockQuantity());
            pstmt.setInt(15, book.getLowStockThreshold());
            // Set seller_id to NULL if it's 0 (admin adding book without seller)
            if (book.getSellerId() > 0) {
                pstmt.setInt(16, book.getSellerId());
            } else {
                pstmt.setNull(16, Types.INTEGER);
            }
            pstmt.setBoolean(17, book.isCodAvailable());
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    book.setBookId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Update an existing book
     */
    public boolean updateBook(Book book) {
        String sql = "UPDATE books SET title = ?, author = ?, description = ?, price = ?, original_price = ?, " +
                     "category_id = ?, book_type = ?, cover_image = ?, isbn = ?, publisher = ?, " +
                     "publication_year = ?, pages = ?, language = ?, stock_quantity = ?, " +
                     "low_stock_threshold = ?, is_available = ?, cod_available = ? WHERE book_id = ?";
        
        try (Connection connection = DBConnection.getNewConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, book.getTitle());
            pstmt.setString(2, book.getAuthor());
            pstmt.setString(3, book.getDescription());
            pstmt.setDouble(4, book.getPrice());
            pstmt.setDouble(5, book.getOriginalPrice());
            pstmt.setInt(6, book.getCategoryId());
            pstmt.setString(7, book.getBookType());
            pstmt.setString(8, book.getCoverImage());
            pstmt.setString(9, book.getIsbn());
            pstmt.setString(10, book.getPublisher());
            pstmt.setInt(11, book.getPublicationYear());
            pstmt.setInt(12, book.getPages());
            pstmt.setString(13, book.getLanguage());
            pstmt.setInt(14, book.getStockQuantity());
            pstmt.setInt(15, book.getLowStockThreshold());
            pstmt.setBoolean(16, book.isAvailable());
            pstmt.setBoolean(17, book.isCodAvailable());
            pstmt.setInt(18, book.getBookId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Delete a book
     */
    public boolean deleteBook(int bookId) {
        String sql = "DELETE FROM books WHERE book_id = ?";
        
        try (Connection connection = DBConnection.getNewConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, bookId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Get book by ID
     */
    public Book getBookById(int bookId) {
        String sql = "SELECT b.*, c.category_name FROM books b " +
                     "LEFT JOIN categories c ON b.category_id = c.category_id " +
                     "WHERE b.book_id = ?";
        
        try (Connection connection = DBConnection.getNewConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, bookId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return extractBookFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Get all books
     */
    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.*, c.category_name FROM books b " +
                     "LEFT JOIN categories c ON b.category_id = c.category_id " +
                     "WHERE b.is_available = TRUE ORDER BY b.created_at DESC";
        
        try (Connection connection = DBConnection.getNewConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                books.add(extractBookFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    /**
     * Get books by type (NEW or OLD)
     */
    public List<Book> getBooksByType(String bookType) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.*, c.category_name FROM books b " +
                     "LEFT JOIN categories c ON b.category_id = c.category_id " +
                     "WHERE b.book_type = ? AND b.is_available = TRUE AND b.stock_quantity > 0 " +
                     "ORDER BY b.created_at DESC";
        
        try (Connection connection = DBConnection.getNewConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, bookType);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                books.add(extractBookFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    /**
     * Get books by category
     */
    public List<Book> getBooksByCategory(int categoryId) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.*, c.category_name FROM books b " +
                     "LEFT JOIN categories c ON b.category_id = c.category_id " +
                     "WHERE b.category_id = ? AND b.is_available = TRUE ORDER BY b.created_at DESC";
        
        try (Connection connection = DBConnection.getNewConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, categoryId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                books.add(extractBookFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    /**
     * Search books by title, author, or category
     */
    public List<Book> searchBooks(String query) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.*, c.category_name FROM books b " +
                     "LEFT JOIN categories c ON b.category_id = c.category_id " +
                     "WHERE b.is_available = TRUE AND " +
                     "(b.title LIKE ? OR b.author LIKE ? OR c.category_name LIKE ?) " +
                     "ORDER BY b.created_at DESC";
        
        try (Connection connection = DBConnection.getNewConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql)) {
            String searchPattern = "%" + query + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            pstmt.setString(3, searchPattern);
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                books.add(extractBookFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    /**
     * Get featured/latest books for home page
     */
    public List<Book> getFeaturedBooks(int limit) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.*, c.category_name FROM books b " +
                     "LEFT JOIN categories c ON b.category_id = c.category_id " +
                     "WHERE b.is_available = TRUE AND b.stock_quantity > 0 " +
                     "ORDER BY b.created_at DESC LIMIT ?";
        
        try (Connection connection = DBConnection.getNewConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, limit);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                books.add(extractBookFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    /**
     * Get low stock books for admin alerts
     */
    public List<Book> getLowStockBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.*, c.category_name FROM books b " +
                     "LEFT JOIN categories c ON b.category_id = c.category_id " +
                     "WHERE b.stock_quantity <= b.low_stock_threshold AND b.is_available = TRUE " +
                     "ORDER BY b.stock_quantity ASC";
        
        try (Connection connection = DBConnection.getNewConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                books.add(extractBookFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    /**
     * Update book stock quantity
     */
    public boolean updateStock(int bookId, int quantity) {
        String sql = "UPDATE books SET stock_quantity = stock_quantity + ? WHERE book_id = ?";
        
        try (Connection connection = DBConnection.getNewConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, quantity);
            pstmt.setInt(2, bookId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Get total book count
     */
    public int getTotalBookCount() {
        String sql = "SELECT COUNT(*) FROM books WHERE is_available = TRUE";
        
        try (Connection connection = DBConnection.getNewConnection();
             Statement stmt = connection.createStatement();
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
     * Get books with pagination
     */
    public List<Book> getBooksWithPagination(int offset, int limit) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.*, c.category_name FROM books b " +
                     "LEFT JOIN categories c ON b.category_id = c.category_id " +
                     "WHERE b.is_available = TRUE ORDER BY b.created_at DESC LIMIT ? OFFSET ?";
        
        try (Connection connection = DBConnection.getNewConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, limit);
            pstmt.setInt(2, offset);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                books.add(extractBookFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    /**
     * Get all books for admin (including unavailable)
     */
    public List<Book> getAllBooksForAdmin() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.*, c.category_name FROM books b " +
                     "LEFT JOIN categories c ON b.category_id = c.category_id " +
                     "ORDER BY b.created_at DESC";
        
        try (Connection connection = DBConnection.getNewConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                books.add(extractBookFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    /**
     * Helper method to extract Book from ResultSet
     */
    private Book extractBookFromResultSet(ResultSet rs) throws SQLException {
        Book book = new Book();
        book.setBookId(rs.getInt("book_id"));
        book.setTitle(rs.getString("title"));
        book.setAuthor(rs.getString("author"));
        book.setDescription(rs.getString("description"));
        book.setPrice(rs.getDouble("price"));
        book.setOriginalPrice(rs.getDouble("original_price"));
        book.setCategoryId(rs.getInt("category_id"));
        book.setBookType(rs.getString("book_type"));
        book.setCoverImage(rs.getString("cover_image"));
        book.setIsbn(rs.getString("isbn"));
        book.setPublisher(rs.getString("publisher"));
        book.setPublicationYear(rs.getInt("publication_year"));
        book.setPages(rs.getInt("pages"));
        book.setLanguage(rs.getString("language"));
        book.setStockQuantity(rs.getInt("stock_quantity"));
        book.setLowStockThreshold(rs.getInt("low_stock_threshold"));
        book.setAvailable(rs.getBoolean("is_available"));
        book.setSellerId(rs.getInt("seller_id"));
        book.setCreatedAt(rs.getTimestamp("created_at"));
        book.setUpdatedAt(rs.getTimestamp("updated_at"));
        
        // Try to get cod_available
        try {
            book.setCodAvailable(rs.getBoolean("cod_available"));
        } catch (SQLException ex) {
            book.setCodAvailable(true); // Default to true
        }
        
        // Try to get category name if joined
        try {
            book.setCategoryName(rs.getString("category_name"));
        } catch (SQLException e) {
            // Column not present in result set
        }
        
        return book;
    }
}
