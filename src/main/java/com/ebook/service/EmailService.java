package com.ebook.service;

import com.ebook.model.Order;
import com.ebook.model.OrderItem;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;
import java.text.SimpleDateFormat;

/**
 * Email Service for sending order notifications
 */
public class EmailService {
    
    // Email configuration - Update these with actual SMTP settings
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String FROM_EMAIL = "sonymatiyadav@gmail.com";
    private static final String FROM_PASSWORD = "bxbpnmhxqseuropa"; // App password without spaces
    private static final String ADMIN_EMAIL = "sonymatiyadav@gmail.com";
    
    /**
     * Send order confirmation email to customer
     */
    public static boolean sendOrderConfirmation(Order order, String customerEmail, String customerName) {
        try {
            Session session = createEmailSession();
            
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "Mayur Collection and Bookstore"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(customerEmail));
            message.setSubject("Order Confirmation - Order #" + order.getOrderId());
            
            String emailContent = buildCustomerEmailContent(order, customerName);
            message.setContent(emailContent, "text/html; charset=utf-8");
            
            Transport.send(message);
            System.out.println("Order confirmation email sent to: " + customerEmail);
            return true;
            
        } catch (Exception e) {
            System.err.println("Failed to send order confirmation email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Send order notification email to admin
     */
    public static boolean sendAdminOrderNotification(Order order, String customerName, String customerEmail) {
        try {
            Session session = createEmailSession();
            
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "Mayur Collection and Bookstore"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(ADMIN_EMAIL));
            message.setSubject("New Order Received - Order #" + order.getOrderId());
            
            String emailContent = buildAdminEmailContent(order, customerName, customerEmail);
            message.setContent(emailContent, "text/html; charset=utf-8");
            
            Transport.send(message);
            System.out.println("Admin notification email sent for Order #" + order.getOrderId());
            return true;
            
        } catch (Exception e) {
            System.err.println("Failed to send admin notification email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Create email session with SMTP configuration
     */
    private static Session createEmailSession() {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.ssl.trust", SMTP_HOST);
        
        return Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, FROM_PASSWORD);
            }
        });
    }
    
    /**
     * Build HTML email content for customer
     */
    private static String buildCustomerEmailContent(Order order, String customerName) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
        String orderDate = dateFormat.format(order.getOrderDate());
        
        StringBuilder html = new StringBuilder();
        html.append("<!DOCTYPE html>")
            .append("<html><head><style>")
            .append("body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }")
            .append(".container { max-width: 600px; margin: 0 auto; padding: 20px; }")
            .append(".header { background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%); color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }")
            .append(".content { background: #f8f9fa; padding: 30px; }")
            .append(".order-box { background: white; padding: 20px; border-radius: 8px; margin: 20px 0; border-left: 4px solid #0d6efd; }")
            .append(".item { padding: 10px 0; border-bottom: 1px solid #dee2e6; }")
            .append(".total { font-size: 18px; font-weight: bold; color: #0d6efd; padding-top: 15px; }")
            .append(".footer { text-align: center; padding: 20px; color: #6c757d; font-size: 14px; }")
            .append("</style></head><body>")
            .append("<div class='container'>")
            .append("<div class='header'>")
            .append("<h1 style='margin: 0;'>📚 Order Confirmed!</h1>")
            .append("</div>")
            .append("<div class='content'>")
            .append("<p>Dear ").append(customerName).append(",</p>")
            .append("<p>Thank you for your order! We've received your order and will process it shortly.</p>")
            .append("<div class='order-box'>")
            .append("<h3 style='color: #0d6efd; margin-top: 0;'>Order Details</h3>")
            .append("<p><strong>Order Number:</strong> #").append(order.getOrderId()).append("</p>")
            .append("<p><strong>Order Date:</strong> ").append(orderDate).append("</p>")
            .append("<p><strong>Payment Method:</strong> ").append(order.getPaymentMethod()).append("</p>")
            .append("<p><strong>Shipping Address:</strong><br>")
            .append(order.getShippingAddress()).append("<br>")
            .append(order.getShippingCity()).append(", ").append(order.getShippingState())
            .append(" - ").append(order.getShippingPincode()).append("</p>")
            .append("</div>");
        
        // Order items
        if (order.getOrderItems() != null && !order.getOrderItems().isEmpty()) {
            html.append("<div class='order-box'>")
                .append("<h3 style='color: #0d6efd; margin-top: 0;'>Items Ordered</h3>");
            
            for (OrderItem item : order.getOrderItems()) {
                html.append("<div class='item'>")
                    .append("<strong>").append(item.getBookTitle()).append("</strong><br>")
                    .append("Quantity: ").append(item.getQuantity())
                    .append(" × ₹").append(String.format("%.2f", item.getPriceAtPurchase()))
                    .append(" = ₹").append(String.format("%.2f", item.getSubtotal()))
                    .append("</div>");
            }
            
            html.append("<div class='total'>Total Amount: ₹").append(String.format("%.2f", order.getTotalAmount())).append("</div>")
                .append("</div>");
        }
        
        html.append("<p>We'll send you another email once your order has been shipped.</p>")
            .append("<p>If you have any questions, please don't hesitate to contact us.</p>")
            .append("<p>Happy Reading! 📖</p>")
            .append("</div>")
            .append("<div class='footer'>")
            .append("<p>© 2026 Mayur Collection and Bookstore. All rights reserved.</p>")
            .append("<p>This is an automated email. Please do not reply.</p>")
            .append("</div>")
            .append("</div></body></html>");
        
        return html.toString();
    }
    
    /**
     * Build HTML email content for admin
     */
    private static String buildAdminEmailContent(Order order, String customerName, String customerEmail) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
        String orderDate = dateFormat.format(order.getOrderDate());
        
        StringBuilder html = new StringBuilder();
        html.append("<!DOCTYPE html>")
            .append("<html><head><style>")
            .append("body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }")
            .append(".container { max-width: 600px; margin: 0 auto; padding: 20px; }")
            .append(".header { background: linear-gradient(135deg, #198754 0%, #157347 100%); color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }")
            .append(".content { background: #f8f9fa; padding: 30px; }")
            .append(".order-box { background: white; padding: 20px; border-radius: 8px; margin: 20px 0; border-left: 4px solid #198754; }")
            .append(".alert { background: #fff3cd; border-left: 4px solid #ffc107; padding: 15px; border-radius: 5px; margin: 15px 0; }")
            .append(".item { padding: 10px 0; border-bottom: 1px solid #dee2e6; }")
            .append(".total { font-size: 18px; font-weight: bold; color: #198754; padding-top: 15px; }")
            .append("</style></head><body>")
            .append("<div class='container'>")
            .append("<div class='header'>")
            .append("<h1 style='margin: 0;'>🔔 New Order Alert!</h1>")
            .append("</div>")
            .append("<div class='content'>")
            .append("<p>A new order has been placed on the Mayur Collection and Bookstore.</p>");
        
        // Action required for COD orders
        if ("COD".equalsIgnoreCase(order.getPaymentMethod())) {
            html.append("<div class='alert'>")
                .append("<strong>⚠️ Action Required:</strong> This is a Cash on Delivery (COD) order. Please process and ship the order.")
                .append("</div>");
        }
        
        html.append("<div class='order-box'>")
            .append("<h3 style='color: #198754; margin-top: 0;'>Order Information</h3>")
            .append("<p><strong>Order Number:</strong> #").append(order.getOrderId()).append("</p>")
            .append("<p><strong>Order Date:</strong> ").append(orderDate).append("</p>")
            .append("<p><strong>Payment Method:</strong> ").append(order.getPaymentMethod()).append("</p>")
            .append("<p><strong>Payment Status:</strong> ").append(order.getPaymentStatus()).append("</p>")
            .append("</div>")
            .append("<div class='order-box'>")
            .append("<h3 style='color: #198754; margin-top: 0;'>Customer Information</h3>")
            .append("<p><strong>Name:</strong> ").append(customerName).append("</p>")
            .append("<p><strong>Email:</strong> ").append(customerEmail).append("</p>")
            .append("<p><strong>Shipping Address:</strong><br>")
            .append(order.getShippingAddress()).append("<br>")
            .append(order.getShippingCity()).append(", ").append(order.getShippingState())
            .append(" - ").append(order.getShippingPincode()).append("</p>")
            .append("</div>");
        
        // Order items
        if (order.getOrderItems() != null && !order.getOrderItems().isEmpty()) {
            html.append("<div class='order-box'>")
                .append("<h3 style='color: #198754; margin-top: 0;'>Order Items</h3>");
            
            for (OrderItem item : order.getOrderItems()) {
                html.append("<div class='item'>")
                    .append("<strong>").append(item.getBookTitle()).append("</strong><br>")
                    .append("Quantity: ").append(item.getQuantity())
                    .append(" × ₹").append(String.format("%.2f", item.getPriceAtPurchase()))
                    .append(" = ₹").append(String.format("%.2f", item.getSubtotal()))
                    .append("</div>");
            }
            
            html.append("<div class='total'>Total Amount: ₹").append(String.format("%.2f", order.getTotalAmount())).append("</div>")
                .append("</div>");
        }
        
        if (order.getNotes() != null && !order.getNotes().trim().isEmpty()) {
            html.append("<div class='order-box'>")
                .append("<h3 style='color: #198754; margin-top: 0;'>Customer Notes</h3>")
                .append("<p>").append(order.getNotes()).append("</p>")
                .append("</div>");
        }
        
        html.append("<p style='margin-top: 30px;'><strong>Action Required:</strong> Please log in to the admin panel to process this order.</p>")
            .append("</div>")
            .append("</div></body></html>");
        
        return html.toString();
    }
}
