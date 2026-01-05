package com.ebook.model;

import java.sql.Timestamp;

/**
 * SellRequest Model class for customers selling old books
 */
public class SellRequest {
    
    private int requestId;
    private int userId;
    private String bookTitle;
    private String bookAuthor;
    private String bookCondition; // LIKE_NEW, GOOD, FAIR, POOR
    private double expectedPrice;
    private String description;
    private String bookImage;
    private String status; // PENDING, APPROVED, REJECTED, SOLD
    private String adminRemarks;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // For display purposes
    private String sellerName;
    private String sellerEmail;
    private String sellerPhone;
    
    // Default constructor
    public SellRequest() {
        this.status = "PENDING";
    }
    
    // Getters and Setters
    public int getRequestId() {
        return requestId;
    }
    
    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
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
    
    public String getBookCondition() {
        return bookCondition;
    }
    
    public void setBookCondition(String bookCondition) {
        this.bookCondition = bookCondition;
    }
    
    public double getExpectedPrice() {
        return expectedPrice;
    }
    
    public void setExpectedPrice(double expectedPrice) {
        this.expectedPrice = expectedPrice;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getBookImage() {
        return bookImage;
    }
    
    public void setBookImage(String bookImage) {
        this.bookImage = bookImage;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getAdminRemarks() {
        return adminRemarks;
    }
    
    public void setAdminRemarks(String adminRemarks) {
        this.adminRemarks = adminRemarks;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public String getSellerName() {
        return sellerName;
    }
    
    public void setSellerName(String sellerName) {
        this.sellerName = sellerName;
    }
    
    public String getSellerEmail() {
        return sellerEmail;
    }
    
    public void setSellerEmail(String sellerEmail) {
        this.sellerEmail = sellerEmail;
    }
    
    public String getSellerPhone() {
        return sellerPhone;
    }
    
    public void setSellerPhone(String sellerPhone) {
        this.sellerPhone = sellerPhone;
    }
    
    // Helper methods
    public String getConditionDisplay() {
        switch (bookCondition) {
            case "LIKE_NEW": return "Like New";
            case "GOOD": return "Good";
            case "FAIR": return "Fair";
            case "POOR": return "Poor";
            default: return bookCondition;
        }
    }
    
    public String getStatusBadgeClass() {
        switch (status) {
            case "PENDING": return "badge-warning";
            case "APPROVED": return "badge-success";
            case "REJECTED": return "badge-danger";
            case "SOLD": return "badge-info";
            default: return "badge-secondary";
        }
    }
    
    @Override
    public String toString() {
        return "SellRequest{" +
                "requestId=" + requestId +
                ", bookTitle='" + bookTitle + '\'' +
                ", bookAuthor='" + bookAuthor + '\'' +
                ", expectedPrice=" + expectedPrice +
                ", status='" + status + '\'' +
                '}';
    }
}
