<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed - Mayur Collection and Bookstore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-brown: #8B4513;
            --dark-brown: #5D2E0F;
            --golden: #DAA520;
            --light-golden: #F4D03F;
            --cream: #FFF8DC;
            --light-cream: #FFFEF7;
        }
        
        * { font-family: 'Poppins', sans-serif; }
        h1, h2, h3, h4, h5, h6 { font-family: 'Playfair Display', serif; }
        
        body { background: linear-gradient(135deg, #f5f1e8 0%, #e8dcc8 100%); min-height: 100vh; }
        
        .navbar-book {
            background: linear-gradient(135deg, var(--dark-brown) 0%, var(--primary-brown) 100%) !important;
            box-shadow: 0 4px 20px rgba(93, 46, 15, 0.3);
            padding: 1.2rem 2rem;
            min-height: 70px;
        }
        
        .navbar-book .navbar-brand { color: var(--golden) !important; font-family: 'Playfair Display', serif; font-weight: 700; font-size: 2rem; }
        
        .success-animation {
            animation: scaleIn 0.5s ease-out;
        }
        @keyframes scaleIn {
            from { transform: scale(0); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }
        .checkmark {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #28A745 0%, #1E7E34 100%);
            margin: 0 auto 2rem;
        }
        .checkmark i {
            font-size: 3rem;
            color: white;
        }
        
        .success-card {
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border: none;
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(93, 46, 15, 0.15);
            overflow: hidden;
        }
        
        .order-info-box {
            background: var(--cream);
            border-radius: 12px;
        }
        
        .text-primary { color: var(--primary-brown) !important; }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--golden) 0%, #B8860B 100%);
            border: none;
            color: var(--dark-brown);
            font-weight: 600;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #F4D03F 0%, var(--golden) 100%);
            color: var(--dark-brown);
        }
        
        .btn-outline-primary {
            border-color: var(--golden);
            color: var(--primary-brown);
        }
        
        .btn-outline-primary:hover {
            background: var(--golden);
            border-color: var(--golden);
            color: var(--dark-brown);
        }
        
        .table thead { background: var(--cream); }
        .table thead th { color: var(--dark-brown); border-bottom: 2px solid #E8D5B5; }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-book">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <i class="fas fa-book-open me-2"></i>Mayur Collection and Bookstore
            </a>
        </div>
    </nav>

    <!-- Success Content -->
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card success-card">
                    <div class="card-body text-center py-5">
                        <div class="checkmark success-animation">
                            <i class="fas fa-check"></i>
                        </div>
                        
                        <h2 class="mb-3" style="color: #28A745;">Order Placed Successfully!</h2>
                        <p class="text-muted mb-4">Thank you for your order. We've received your order and will process it shortly.</p>
                        
                        <div class="order-info-box p-4 mb-4">
                            <div class="row">
                                <div class="col-md-6 mb-3 mb-md-0">
                                    <h6 class="text-muted mb-1">Order Number</h6>
                                    <h4 class="mb-0" style="color: var(--primary-brown);">#${order.orderId}</h4>
                                </div>
                                <div class="col-md-6">
                                    <h6 class="text-muted mb-1">Order Date</h6>
                                    <h5 class="mb-0" style="color: var(--dark-brown);">
                                        <fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy, hh:mm a"/>
                                    </h5>
                                </div>
                            </div>
                        </div>

                        <!-- Order Details -->
                        <div class="text-start mb-4">
                            <h5 class="mb-3" style="color: var(--dark-brown);"><i class="fas fa-box me-2" style="color: var(--golden);"></i>Order Details</h5>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Item</th>
                                            <th class="text-center">Qty</th>
                                            <th class="text-end">Price</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${order.orderItems}">
                                            <tr>
                                                <td>${item.bookTitle}</td>
                                                <td class="text-center">${item.quantity}</td>
                                                <td class="text-end">₹<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <tr class="table-light">
                                            <td colspan="2" class="text-end"><strong>Total:</strong></td>
                                            <td class="text-end"><strong>₹<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></strong></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>

                        <!-- Shipping Address -->
                        <div class="text-start mb-4">
                            <h5 class="mb-3"><i class="fas fa-map-marker-alt me-2"></i>Shipping Address</h5>
                            <p class="mb-0">${order.shippingAddress}</p>
                        </div>

                        <!-- Payment Info -->
                        <div class="text-start mb-4">
                            <h5 class="mb-3"><i class="fas fa-credit-card me-2"></i>Payment Method</h5>
                            <p class="mb-0">
                                <c:choose>
                                    <c:when test="${order.paymentMethod == 'COD'}">
                                        <i class="fas fa-money-bill-wave me-2"></i>Cash on Delivery
                                    </c:when>
                                    <c:when test="${order.paymentMethod == 'UPI'}">
                                        <i class="fas fa-mobile-alt me-2"></i>UPI
                                    </c:when>
                                    <c:when test="${order.paymentMethod == 'CARD'}">
                                        <i class="fas fa-credit-card me-2"></i>Credit/Debit Card
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-university me-2"></i>Net Banking
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>

                        <div class="alert alert-info">
                            <i class="fas fa-envelope me-2"></i>
                            A confirmation email has been sent to <strong>${sessionScope.user.email}</strong>
                        </div>

                        <div class="d-flex gap-3 justify-content-center flex-wrap">
                            <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-primary">
                                <i class="fas fa-list me-2"></i>View My Orders
                            </a>
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-primary">
                                <i class="fas fa-shopping-bag me-2"></i>Continue Shopping
                            </a>
                        </div>
                    </div>
                </div>

                <!-- What's Next -->
                <div class="card mt-4 border-0 shadow-sm">
                    <div class="card-body">
                        <h5 class="mb-4"><i class="fas fa-info-circle me-2 text-primary"></i>What's Next?</h5>
                        <div class="row g-4">
                            <div class="col-md-4 text-center">
                                <div class="bg-primary-light rounded-circle p-3 d-inline-flex mb-3">
                                    <i class="fas fa-box-open fa-2x text-primary"></i>
                                </div>
                                <h6>Order Processing</h6>
                                <small class="text-muted">Your order will be processed within 24 hours</small>
                            </div>
                            <div class="col-md-4 text-center">
                                <div class="bg-primary-light rounded-circle p-3 d-inline-flex mb-3">
                                    <i class="fas fa-shipping-fast fa-2x text-primary"></i>
                                </div>
                                <h6>Shipping</h6>
                                <small class="text-muted">Delivery within 5-7 business days</small>
                            </div>
                            <div class="col-md-4 text-center">
                                <div class="bg-primary-light rounded-circle p-3 d-inline-flex mb-3">
                                    <i class="fas fa-headset fa-2x text-primary"></i>
                                </div>
                                <h6>Support</h6>
                                <small class="text-muted">Need help? Contact our support team</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer bg-dark text-white py-4 mt-5">
        <div class="container text-center">
            <p class="mb-0">&copy; 2024 Mayur Collection and Bookstore. All Rights Reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
