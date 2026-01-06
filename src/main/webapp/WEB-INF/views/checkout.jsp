<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="context-path" content="${pageContext.request.contextPath}">
    <title>Checkout - Mayur Collection and Bookstore</title>
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
        
        body {
            background: linear-gradient(135deg, var(--cream) 0%, #F5E6D3 50%, var(--light-cream) 100%);
            min-height: 100vh;
        }
        
        .navbar {
            background: linear-gradient(135deg, var(--dark-brown) 0%, var(--primary-brown) 100%) !important;
            box-shadow: 0 4px 20px rgba(93, 46, 15, 0.3);
            padding: 1.2rem 2rem;
            min-height: 70px;
        }
        
        .navbar-brand {
            font-family: 'Playfair Display', serif !important;
            font-size: 2rem !important;
            font-weight: 700 !important;
            color: var(--golden) !important;
        }
        
        .navbar-brand i { color: var(--light-golden); }
        .nav-link { color: var(--cream) !important; font-weight: 500; font-size: 1.1rem; padding: 0.8rem 1.2rem !important; }
        .nav-link:hover { color: var(--golden) !important; }
        
        .page-title {
            font-family: 'Playfair Display', serif;
            color: var(--dark-brown);
            font-weight: 700;
        }
        
        /* Cards */
        .checkout-card {
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(93, 46, 15, 0.1);
            overflow: hidden;
        }
        
        .checkout-card .card-header {
            background: linear-gradient(135deg, var(--cream) 0%, #F5E6D3 100%);
            border-bottom: 2px solid #E8D5B5;
            color: var(--dark-brown);
            font-family: 'Playfair Display', serif;
            padding: 1rem 1.5rem;
        }
        
        .checkout-card .card-header i { color: var(--golden); }
        
        .checkout-card .card-body { padding: 1.5rem; }
        
        /* Form Elements */
        .form-label {
            font-weight: 600;
            color: var(--dark-brown);
            font-size: 0.9rem;
        }
        
        .form-control, .form-select {
            border: 2px solid #E8D5B5;
            border-radius: 10px;
            background: var(--light-cream);
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--golden);
            box-shadow: 0 0 0 4px rgba(218, 165, 32, 0.15);
            background: #FFFFFF;
        }
        
        .form-control::placeholder { color: #B8A78A; }
        
        .form-control:read-only {
            background: var(--cream);
            color: #8B7355;
        }
        
        .form-check-input:checked {
            background-color: var(--golden);
            border-color: var(--golden);
        }
        
        .form-check-label {
            color: var(--dark-brown);
        }
        
        /* Payment Method */
        .payment-option {
            border: 2px solid #E8D5B5;
            border-radius: 12px;
            padding: 1rem;
            margin-bottom: 0.5rem;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .payment-option:hover {
            border-color: var(--golden);
            background: var(--cream);
        }
        
        .form-check-input:checked ~ .payment-option {
            border-color: var(--golden);
            background: linear-gradient(135deg, var(--cream) 0%, #F5E6D3 100%);
        }
        
        #upiDetails {
            border: 2px dashed var(--golden) !important;
            background: linear-gradient(135deg, var(--cream) 0%, #F5E6D3 100%) !important;
            border-radius: 12px !important;
        }
        
        /* Summary Card */
        .summary-card {
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(93, 46, 15, 0.1);
            overflow: hidden;
        }
        
        .summary-card .card-header {
            background: linear-gradient(135deg, var(--dark-brown) 0%, var(--primary-brown) 100%);
            color: var(--golden);
            font-family: 'Playfair Display', serif;
        }
        
        .summary-card .text-primary { color: var(--golden) !important; }
        
        .summary-card .text-success { color: #28A745 !important; }
        
        /* Buttons */
        .btn-primary {
            background: linear-gradient(135deg, var(--golden) 0%, #C4941A 100%);
            border: none;
            color: var(--dark-brown);
            font-weight: 600;
            border-radius: 12px;
            padding: 1rem 2rem;
            box-shadow: 0 6px 20px rgba(218, 165, 32, 0.4);
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, var(--light-golden) 0%, var(--golden) 100%);
            transform: translateY(-2px);
            color: var(--dark-brown);
        }
        
        /* Alerts */
        .alert-info {
            background: linear-gradient(135deg, #D6EAF8 0%, #AED6F1 100%);
            border: 2px solid #3498DB;
            border-radius: 10px;
            color: #21618C;
        }
        
        .alert-warning {
            background: linear-gradient(135deg, #FFF3CD 0%, #FFE69C 100%);
            border: 2px solid var(--golden);
            border-radius: 10px;
            color: var(--dark-brown);
        }
        
        /* Footer */
        .footer {
            background: linear-gradient(135deg, var(--dark-brown) 0%, var(--primary-brown) 100%) !important;
            color: var(--cream);
        }
        
        .invalid-feedback { color: #DC3545; }
        
        .was-validated .form-control:invalid,
        .was-validated .form-select:invalid {
            border-color: #DC3545;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <i class="fas fa-book-open me-2"></i>Mayur Collection and Bookstore
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                            <i class="fas fa-shopping-cart"></i> Back to Cart
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Checkout Content -->
    <div class="container py-5">
        <div class="row">
            <div class="col-12">
                <h2 class="page-title mb-4"><i class="fas fa-credit-card me-2" style="color: var(--golden);"></i>Checkout</h2>
            </div>
        </div>

        <div class="row">
            <!-- Checkout Form -->
            <div class="col-lg-8">
                <form action="${pageContext.request.contextPath}/checkout" method="post" class="needs-validation" novalidate>
                    <!-- Shipping Address -->
                    <div class="card checkout-card mb-4">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-map-marker-alt me-2"></i>Shipping Address</h5>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="firstName" class="form-label">First Name *</label>
                                    <input type="text" class="form-control" id="firstName" name="firstName" 
                                           value="${sessionScope.user.fullName}" required placeholder="Enter your first name">
                                    <div class="invalid-feedback">Please enter your first name.</div>
                                </div>
                                <div class="col-md-6">
                                    <label for="lastName" class="form-label">Last Name *</label>
                                    <input type="text" class="form-control" id="lastName" name="lastName" 
                                           required placeholder="Enter your last name">
                                    <div class="invalid-feedback">Please enter your last name.</div>
                                </div>
                                <div class="col-12">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" 
                                           value="${sessionScope.user.email}" readonly>
                                </div>
                                <div class="col-12">
                                    <label for="phone" class="form-label">Phone Number *</label>
                                    <input type="tel" class="form-control" id="phone" name="phone" 
                                           value="${sessionScope.user.phone}" required pattern="[0-9]{10}">
                                    <div class="invalid-feedback">Please enter a valid 10-digit phone number.</div>
                                </div>
                                <div class="col-12">
                                    <label for="address" class="form-label">Delivery Address *</label>
                                    <textarea class="form-control" id="address" name="shippingAddress" rows="3" required 
                                              placeholder="Enter your complete delivery address with house/flat number, street, locality...">${sessionScope.user.address}</textarea>
                                    <div class="invalid-feedback">Please enter your complete delivery address.</div>
                                </div>
                                <div class="col-md-6">
                                    <label for="city" class="form-label">City *</label>
                                    <input type="text" class="form-control" id="city" name="shippingCity" required 
                                           placeholder="Enter city name" value="${sessionScope.user.city}">
                                    <div class="invalid-feedback">Please enter your city.</div>
                                </div>
                                <div class="col-md-4">
                                    <label for="state" class="form-label">State *</label>
                                    <select class="form-select" id="state" name="shippingState" required>
                                        <option value="">Choose...</option>
                                        <option value="Andhra Pradesh">Andhra Pradesh</option>
                                        <option value="Delhi">Delhi</option>
                                        <option value="Gujarat">Gujarat</option>
                                        <option value="Karnataka">Karnataka</option>
                                        <option value="Kerala">Kerala</option>
                                        <option value="Maharashtra">Maharashtra</option>
                                        <option value="Punjab">Punjab</option>
                                        <option value="Rajasthan">Rajasthan</option>
                                        <option value="Tamil Nadu">Tamil Nadu</option>
                                        <option value="Telangana">Telangana</option>
                                        <option value="Uttar Pradesh">Uttar Pradesh</option>
                                        <option value="West Bengal">West Bengal</option>
                                    </select>
                                    <div class="invalid-feedback">Please select a state.</div>
                                </div>
                                <div class="col-md-2">
                                    <label for="pincode" class="form-label">Pincode *</label>
                                    <input type="text" class="form-control" id="pincode" name="shippingPincode" required pattern="[0-9]{6}"
                                           placeholder="6 digits" value="${sessionScope.user.pincode}">
                                    <div class="invalid-feedback">Please enter a valid 6-digit pincode.</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Payment Method -->
                    <div class="card checkout-card mb-4">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-credit-card me-2"></i>Payment Method</h5>
                        </div>
                        <div class="card-body">
                            <c:if test="${codAvailable}">
                                <div class="form-check mb-3">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="cod" value="COD" checked>
                                    <label class="form-check-label" for="cod">
                                        <i class="fas fa-money-bill-wave me-2 text-success"></i>
                                        <strong>Cash on Delivery</strong>
                                        <br><small class="text-muted">Pay when you receive your order</small>
                                    </label>
                                </div>
                            </c:if>
                            <c:if test="${not codAvailable}">
                                <div class="alert alert-warning mb-3">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    Cash on Delivery is not available for some items in your cart.
                                </div>
                            </c:if>
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="upi" value="UPI" ${not codAvailable ? 'checked' : ''}>
                                <label class="form-check-label" for="upi">
                                    <i class="fas fa-mobile-alt me-2" style="color: var(--golden);"></i>
                                    <strong>UPI Payment</strong>
                                    <br><small class="text-muted">Pay using any UPI app</small>
                                </label>
                            </div>
                            
                            <!-- UPI Details Section -->
                            <div id="upiDetails" class="p-3 mt-3" style="display: none;">
                                <h6 class="mb-3"><i class="fas fa-qrcode me-2" style="color: var(--golden);"></i>UPI Payment Details</h6>
                                <div class="text-center mb-3">
                                    <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=upi://pay?pa=1234567890@upi" 
                                         alt="UPI QR Code" class="img-fluid rounded border">
                                </div>
                                <div class="alert alert-info mb-0">
                                    <strong>UPI Number:</strong> <span class="user-select-all fw-bold">1234567890</span>
                                    <br><small>Scan the QR code or pay to the above UPI number</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary btn-lg w-100">
                        <i class="fas fa-lock me-2"></i>Place Order
                    </button>
                </form>
            </div>

            <!-- Order Summary -->
            <div class="col-lg-4">
                <div class="card summary-card sticky-top" style="top: 20px;">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-receipt me-2"></i>Order Summary</h5>
                    </div>
                    <div class="card-body">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="d-flex align-items-center mb-3">
                                <c:choose>
                                    <c:when test="${not empty item.bookCoverImage}">
                                        <c:choose>
                                            <c:when test="${item.bookCoverImage.startsWith('http')}">
                                                <img src="${item.bookCoverImage}" 
                                                     alt="${item.bookTitle}" 
                                                     class="rounded me-3"
                                                     style="width: 50px; height: 70px; object-fit: cover;"
                                                     onerror="this.src='https://via.placeholder.com/50x70/8B4513/ffffff?text=📚'">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/${item.bookCoverImage}" 
                                                     alt="${item.bookTitle}" 
                                                     class="rounded me-3"
                                                     style="width: 50px; height: 70px; object-fit: cover;"
                                                     onerror="this.src='https://via.placeholder.com/50x70/8B4513/ffffff?text=📚'">
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://via.placeholder.com/50x70/8B4513/DAA520?text=Book" 
                                             alt="${item.bookTitle}" 
                                             class="rounded me-3"
                                             style="width: 50px; height: 70px; object-fit: cover;">
                                    </c:otherwise>
                                </c:choose>
                                <div class="flex-grow-1">
                                    <h6 class="mb-0 text-truncate" style="max-width: 180px;">${item.bookTitle}</h6>
                                    <small class="text-muted">Qty: ${item.quantity}</small>
                                </div>
                                <span class="fw-bold">₹<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/></span>
                            </div>
                        </c:forEach>

                        <hr>

                        <div class="d-flex justify-content-between mb-2">
                            <span>Subtotal (${cartItems.size()} items)</span>
                            <span>₹<fmt:formatNumber value="${cartTotal}" pattern="#,##0.00"/></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Shipping</span>
                            <span class="text-success">Free</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Tax (GST 5%)</span>
                            <span>₹<fmt:formatNumber value="${cartTotal * 0.05}" pattern="#,##0.00"/></span>
                        </div>

                        <hr>

                        <div class="d-flex justify-content-between">
                            <strong>Total</strong>
                            <strong class="text-primary fs-5">₹<fmt:formatNumber value="${cartTotal * 1.05}" pattern="#,##0.00"/></strong>
                        </div>

                        <div class="alert alert-info mt-3 mb-0">
                            <small><i class="fas fa-shield-alt me-1"></i>Your transaction is secured with SSL encryption</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer py-4 mt-5">
        <div class="container text-center">
            <p class="mb-0">&copy; 2026 Mayur Collection and Bookstore. All Rights Reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        // Show/hide UPI details based on payment method selection
        document.addEventListener('DOMContentLoaded', function() {
            const upiRadio = document.getElementById('upi');
            const codRadio = document.getElementById('cod');
            const upiDetails = document.getElementById('upiDetails');
            
            function toggleUpiDetails() {
                if (upiRadio && upiRadio.checked) {
                    upiDetails.style.display = 'block';
                } else {
                    upiDetails.style.display = 'none';
                }
            }
            
            if (upiRadio) {
                upiRadio.addEventListener('change', toggleUpiDetails);
            }
            if (codRadio) {
                codRadio.addEventListener('change', toggleUpiDetails);
            }
            
            // Check initial state
            toggleUpiDetails();
            
            // Form validation
            const form = document.querySelector('.needs-validation');
            if (form) {
                form.addEventListener('submit', function(event) {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                });
            }
        });
    </script>
</body>
</html>
