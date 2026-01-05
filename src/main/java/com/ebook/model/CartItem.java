package com.ebook.model;

import java.sql.Timestamp;

/**
 * CartItem Model class representing items in shopping cart
 */
public class CartItem {
    
    private int cartId;
    private int userId;
    private int bookId;
    private int quantity;
    private Timestamp addedAt;
    
    // Book details for display
    private String bookTitle;
    private String bookAuthor;
    private String bookCoverImage;
    private double bookPrice;
    private int stockQuantity;
    
    // Default constructor
    public CartItem() {
        this.quantity = 1;
    }
    
    // Constructor with essential fields
    public CartItem(int userId, int bookId, int quantity) {
        this.userId = userId;
        this.bookId = bookId;
        this.quantity = quantity;
    }
    
    // Getters and Setters
    public int getCartId() {
        return cartId;
    }
    
    public void setCartId(int cartId) {
        this.cartId = cartId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public int getBookId() {
        return bookId;
    }
    
    public void setBookId(int bookId) {
        this.bookId = bookId;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public Timestamp getAddedAt() {
        return addedAt;
    }
    
    public void setAddedAt(Timestamp addedAt) {
        this.addedAt = addedAt;
    }
    
    public String getBookTitle() {
        return bookTitle;
    }
    
    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }
    
    public String getBookAuthor() {
        return bookAuthor;
    }
    
    public void setBookAuthor(String bookAuthor) {
        this.bookAuthor = bookAuthor;
    }
    
    public String getBookCoverImage() {
        return bookCoverImage;
    }
    
    public void setBookCoverImage(String bookCoverImage) {
        this.bookCoverImage = bookCoverImage;
    }
    
    public double getBookPrice() {
        return bookPrice;
    }
    
    public void setBookPrice(double bookPrice) {
        this.bookPrice = bookPrice;
    }
    
    public int getStockQuantity() {
        return stockQuantity;
    }
    
    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }
    
    // Helper methods
    public double getSubtotal() {
        return bookPrice * quantity;
    }
    
    public boolean isValidQuantity() {
        return quantity > 0 && quantity <= stockQuantity;
    }
    
    @Override
    public String toString() {
        return "CartItem{" +
                "cartId=" + cartId +
                ", bookTitle='" + bookTitle + '\'' +
                ", quantity=" + quantity +
                ", subtotal=" + getSubtotal() +
                '}';
    }
}
