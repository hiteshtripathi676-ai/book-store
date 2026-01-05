package com.ebook.model;

import java.sql.Timestamp;

/**
 * Category Model class representing book categories
 */
public class Category {
    
    private int categoryId;
    private String categoryName;
    private String description;
    private Timestamp createdAt;
    private int bookCount; // For display purposes
    
    // Default constructor
    public Category() {
    }
    
    // Constructor with essential fields
    public Category(String categoryName, String description) {
        this.categoryName = categoryName;
        this.description = description;
    }
    
    // Getters and Setters
    public int getCategoryId() {
        return categoryId;
    }
    
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    
    public String getCategoryName() {
        return categoryName;
    }
    
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public int getBookCount() {
        return bookCount;
    }
    
    public void setBookCount(int bookCount) {
        this.bookCount = bookCount;
    }
    
    @Override
    public String toString() {
        return "Category{" +
                "categoryId=" + categoryId +
                ", categoryName='" + categoryName + '\'' +
                '}';
    }
}
