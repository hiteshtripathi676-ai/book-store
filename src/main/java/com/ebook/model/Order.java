package com.ebook.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.ArrayList;

/**
 * Order Model class representing customer orders
 */
public class Order {
    
    private int orderId;
    private int userId;
    private Timestamp orderDate;
    private double totalAmount;
    private String shippingAddress;
    private String shippingCity;
    private String shippingState;
    private String shippingPincode;
    private String paymentMethod;
    private String paymentStatus;
    private String orderStatus;
    private String trackingNumber;
    private String notes;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // For display purposes
    private String customerName;
    private String customerEmail;
    private List<OrderItem> orderItems;
    
    // Default constructor
    public Order() {
        this.paymentStatus = "PENDING";
        this.orderStatus = "PLACED";
        this.paymentMethod = "COD";
        this.orderItems = new ArrayList<>();
    }
    
    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }
    
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public Timestamp getOrderDate() {
        return orderDate;
    }
    
    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }
    
    public double getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    public String getShippingAddress() {
        return shippingAddress;
    }
    
    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }
    
    public String getShippingCity() {
        return shippingCity;
    }
    
    public void setShippingCity(String shippingCity) {
        this.shippingCity = shippingCity;
    }
    
    public String getShippingState() {
        return shippingState;
    }
    
    public void setShippingState(String shippingState) {
        this.shippingState = shippingState;
    }
    
    public String getShippingPincode() {
        return shippingPincode;
    }
    
    public void setShippingPincode(String shippingPincode) {
        this.shippingPincode = shippingPincode;
    }
    
    public String getPaymentMethod() {
        return paymentMethod;
    }
    
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
    
    public String getPaymentStatus() {
        return paymentStatus;
    }
    
    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
    
    public String getOrderStatus() {
        return orderStatus;
    }
    
    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }
    
    public String getTrackingNumber() {
        return trackingNumber;
    }
    
    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
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
    
    public String getCustomerName() {
        return customerName;
    }
    
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }
    
    public String getCustomerEmail() {
        return customerEmail;
    }
    
    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }
    
    public List<OrderItem> getOrderItems() {
        return orderItems;
    }
    
    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }
    
    // Helper methods
    public String getFullShippingAddress() {
        StringBuilder sb = new StringBuilder();
        if (shippingAddress != null) sb.append(shippingAddress);
        if (shippingCity != null) sb.append(", ").append(shippingCity);
        if (shippingState != null) sb.append(", ").append(shippingState);
        if (shippingPincode != null) sb.append(" - ").append(shippingPincode);
        return sb.toString();
    }
    
    public int getTotalItems() {
        int total = 0;
        if (orderItems != null) {
            for (OrderItem item : orderItems) {
                total += item.getQuantity();
            }
        }
        return total;
    }
    
    public String getStatusBadgeClass() {
        switch (orderStatus) {
            case "PLACED": return "badge-info";
            case "CONFIRMED": return "badge-primary";
            case "SHIPPED": return "badge-warning";
            case "DELIVERED": return "badge-success";
            case "CANCELLED": return "badge-danger";
            default: return "badge-secondary";
        }
    }
    
    public String getPaymentStatusBadgeClass() {
        switch (paymentStatus) {
            case "COMPLETED": return "badge-success";
            case "PENDING": return "badge-warning";
            case "FAILED": return "badge-danger";
            case "REFUNDED": return "badge-info";
            default: return "badge-secondary";
        }
    }
    
    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", customerName='" + customerName + '\'' +
                ", totalAmount=" + totalAmount +
                ", orderStatus='" + orderStatus + '\'' +
                '}';
    }
}
