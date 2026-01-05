package com.ebook.model;

/**
 * OrderItem Model class representing individual items in an order
 */
public class OrderItem {
    
    private int itemId;
    private int orderId;
    private int bookId;
    private int quantity;
    private double priceAtPurchase;
    
    // Book details for display
    private String bookTitle;
    private String bookAuthor;
    private String bookCoverImage;
    
    // Default constructor
    public OrderItem() {
    }
    
    // Constructor with essential fields
    public OrderItem(int orderId, int bookId, int quantity, double priceAtPurchase) {
        this.orderId = orderId;
        this.bookId = bookId;
        this.quantity = quantity;
        this.priceAtPurchase = priceAtPurchase;
    }
    
    // Getters and Setters
    public int getItemId() {
        return itemId;
    }
    
    public void setItemId(int itemId) {
        this.itemId = itemId;
    }
    
    public int getOrderId() {
        return orderId;
    }
    
    public void setOrderId(int orderId) {
        this.orderId = orderId;
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
    
    public double getPriceAtPurchase() {
        return priceAtPurchase;
    }
    
    public void setPriceAtPurchase(double priceAtPurchase) {
        this.priceAtPurchase = priceAtPurchase;
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
    
    // Helper methods
    public double getSubtotal() {
        return priceAtPurchase * quantity;
    }
    
    @Override
    public String toString() {
        return "OrderItem{" +
                "itemId=" + itemId +
                ", bookTitle='" + bookTitle + '\'' +
                ", quantity=" + quantity +
                ", priceAtPurchase=" + priceAtPurchase +
                ", subtotal=" + getSubtotal() +
                '}';
    }
}
