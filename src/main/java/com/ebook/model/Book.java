package com.ebook.model;

import java.sql.Timestamp;

/**
 * Book Model class representing books in the system
 */
public class Book {
    
    private int bookId;
    private String title;
    private String author;
    private String description;
    private double price;
    private double originalPrice;
    private int categoryId;
    private String categoryName; // For display purposes
    private String bookType; // NEW or OLD
    private String coverImage;
    private String isbn;
    private String publisher;
    private int publicationYear;
    private int pages;
    private String language;
    private int stockQuantity;
    private int lowStockThreshold;
    private boolean isAvailable;
    private int sellerId;
    private String sellerName; // For display purposes
    private boolean codAvailable; // Cash on Delivery availability
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Default constructor
    public Book() {
        this.language = "English";
        this.lowStockThreshold = 5;
        this.isAvailable = true;
        this.codAvailable = true;
    }
    
    // Constructor for basic book creation
    public Book(String title, String author, double price, String bookType, int stockQuantity) {
        this();
        this.title = title;
        this.author = author;
        this.price = price;
        this.bookType = bookType;
        this.stockQuantity = stockQuantity;
    }
    
    // Full constructor
    public Book(int bookId, String title, String author, String description, double price,
                double originalPrice, int categoryId, String bookType, String coverImage,
                String isbn, String publisher, int publicationYear, int pages, String language,
                int stockQuantity, int lowStockThreshold, boolean isAvailable, int sellerId,
                Timestamp createdAt, Timestamp updatedAt) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
        this.description = description;
        this.price = price;
        this.originalPrice = originalPrice;
        this.categoryId = categoryId;
        this.bookType = bookType;
        this.coverImage = coverImage;
        this.isbn = isbn;
        this.publisher = publisher;
        this.publicationYear = publicationYear;
        this.pages = pages;
        this.language = language;
        this.stockQuantity = stockQuantity;
        this.lowStockThreshold = lowStockThreshold;
        this.isAvailable = isAvailable;
        this.sellerId = sellerId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    // Getters and Setters
    public int getBookId() {
        return bookId;
    }
    
    public void setBookId(int bookId) {
        this.bookId = bookId;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getAuthor() {
        return author;
    }
    
    public void setAuthor(String author) {
        this.author = author;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public double getPrice() {
        return price;
    }
    
    public void setPrice(double price) {
        this.price = price;
    }
    
    public double getOriginalPrice() {
        return originalPrice;
    }
    
    public void setOriginalPrice(double originalPrice) {
        this.originalPrice = originalPrice;
    }
    
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
    
    public String getBookType() {
        return bookType;
    }
    
    public void setBookType(String bookType) {
        this.bookType = bookType;
    }
    
    public String getCoverImage() {
        return coverImage;
    }
    
    public void setCoverImage(String coverImage) {
        this.coverImage = coverImage;
    }
    
    public String getIsbn() {
        return isbn;
    }
    
    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }
    
    public String getPublisher() {
        return publisher;
    }
    
    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }
    
    public int getPublicationYear() {
        return publicationYear;
    }
    
    public void setPublicationYear(int publicationYear) {
        this.publicationYear = publicationYear;
    }
    
    public int getPages() {
        return pages;
    }
    
    public void setPages(int pages) {
        this.pages = pages;
    }
    
    public String getLanguage() {
        return language;
    }
    
    public void setLanguage(String language) {
        this.language = language;
    }
    
    public int getStockQuantity() {
        return stockQuantity;
    }
    
    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }
    
    public int getLowStockThreshold() {
        return lowStockThreshold;
    }
    
    public void setLowStockThreshold(int lowStockThreshold) {
        this.lowStockThreshold = lowStockThreshold;
    }
    
    public boolean isAvailable() {
        return isAvailable;
    }
    
    public void setAvailable(boolean isAvailable) {
        this.isAvailable = isAvailable;
    }
    
    public int getSellerId() {
        return sellerId;
    }
    
    public void setSellerId(int sellerId) {
        this.sellerId = sellerId;
    }
    
    public String getSellerName() {
        return sellerName;
    }
    
    public void setSellerName(String sellerName) {
        this.sellerName = sellerName;
    }
    
    public boolean isCodAvailable() {
        return codAvailable;
    }
    
    public void setCodAvailable(boolean codAvailable) {
        this.codAvailable = codAvailable;
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
    
    // Helper methods
    public boolean isNewBook() {
        return "NEW".equalsIgnoreCase(this.bookType);
    }
    
    public boolean isOldBook() {
        return "OLD".equalsIgnoreCase(this.bookType);
    }
    
    public boolean isLowStock() {
        return stockQuantity <= lowStockThreshold;
    }
    
    public boolean isOutOfStock() {
        return stockQuantity <= 0;
    }
    
    public double getDiscount() {
        if (originalPrice > 0 && originalPrice > price) {
            return ((originalPrice - price) / originalPrice) * 100;
        }
        return 0;
    }
    
    public String getDiscountPercentage() {
        double discount = getDiscount();
        if (discount > 0) {
            return String.format("%.0f%% OFF", discount);
        }
        return "";
    }
    
    @Override
    public String toString() {
        return "Book{" +
                "bookId=" + bookId +
                ", title='" + title + '\'' +
                ", author='" + author + '\'' +
                ", price=" + price +
                ", bookType='" + bookType + '\'' +
                ", stockQuantity=" + stockQuantity +
                '}';
    }
}
