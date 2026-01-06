<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - Mayur Collection and Bookstore</title>
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
        .nav-link:hover, .nav-link.active { color: var(--golden) !important; }
        
        .dropdown-menu {
            background: var(--light-cream);
            border: 2px solid #E8D5B5;
            border-radius: 12px;
        }
        
        .dropdown-item:hover {
            background: var(--cream);
            color: var(--primary-brown);
        }
        
        .page-title {
            font-family: 'Playfair Display', serif;
            color: var(--dark-brown);
            font-weight: 700;
        }
        
        .page-title i { color: var(--golden); }
        
        /* Cart Card */
        .cart-card {
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(93, 46, 15, 0.1);
            overflow: hidden;
        }
        
        .cart-card .card-header {
            background: linear-gradient(135deg, var(--cream) 0%, #F5E6D3 100%);
            border-bottom: 2px solid #E8D5B5;
            color: var(--dark-brown);
            font-weight: 600;
        }
        
        .cart-item {
            transition: background 0.3s ease;
        }
        
        .cart-item:hover {
            background: var(--cream);
        }
        
        .cart-item img {
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        
        .cart-item h6 a {
            color: var(--dark-brown);
            font-family: 'Playfair Display', serif;
            font-weight: 600;
        }
        
        .cart-item h6 a:hover {
            color: var(--golden);
        }
        
        .cart-item .text-primary {
            color: var(--golden) !important;
        }
        
        /* Quantity Controls */
        .qty-btn {
            background: var(--cream);
            border: 2px solid #E8D5B5;
            color: var(--primary-brown);
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .qty-btn:hover {
            background: var(--golden);
            border-color: var(--golden);
            color: var(--dark-brown);
        }
        
        .qty-input {
            border: 2px solid #E8D5B5;
            border-radius: 8px;
            background: var(--light-cream);
            color: var(--dark-brown);
            font-weight: 600;
        }
        
        .qty-input:focus {
            border-color: var(--golden);
            box-shadow: 0 0 0 3px rgba(218, 165, 32, 0.15);
        }
        
        .btn-outline-danger {
            border-color: #DC3545;
            color: #DC3545;
            border-radius: 8px;
        }
        
        .btn-outline-danger:hover {
            background: #DC3545;
            border-color: #DC3545;
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
        
        .summary-card .card-body {
            padding: 1.5rem;
        }
        
        .summary-card .text-primary {
            color: var(--golden) !important;
        }
        
        .summary-card .text-success {
            color: #28A745 !important;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--golden) 0%, #C4941A 100%);
            border: none;
            color: var(--dark-brown);
            font-weight: 600;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(218, 165, 32, 0.4);
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, var(--light-golden) 0%, var(--golden) 100%);
            transform: translateY(-2px);
            color: var(--dark-brown);
        }
        
        .btn-outline-primary {
            border: 2px solid var(--golden);
            color: var(--primary-brown);
            border-radius: 10px;
        }
        
        .btn-outline-primary:hover {
            background: var(--golden);
            border-color: var(--golden);
            color: var(--dark-brown);
        }
        
        .alert-info {
            background: linear-gradient(135deg, #D6EAF8 0%, #AED6F1 100%);
            border: 2px solid #3498DB;
            border-radius: 10px;
            color: #21618C;
        }
        
        /* Payment Badges */
        .badge.bg-success {
            background: linear-gradient(135deg, #28A745 0%, #1E7E34 100%) !important;
        }
        
        .badge.bg-primary {
            background: linear-gradient(135deg, var(--golden) 0%, #C4941A 100%) !important;
            color: var(--dark-brown) !important;
        }
        
        /* Promo Card */
        .promo-card {
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border: 2px dashed var(--golden);
            border-radius: 12px;
        }
        
        .promo-card h6 {
            color: var(--dark-brown);
        }
        
        .promo-card .form-control {
            border: 2px solid #E8D5B5;
            border-radius: 8px 0 0 8px;
            background: var(--light-cream);
        }
        
        .promo-card .form-control:focus {
            border-color: var(--golden);
            box-shadow: none;
        }
        
        .promo-card .btn-outline-primary {
            border-radius: 0 8px 8px 0;
        }
        
        /* Empty Cart */
        .empty-cart {
            text-align: center;
            padding: 4rem 2rem;
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(93, 46, 15, 0.1);
        }
        
        .empty-cart i { color: var(--golden); opacity: 0.5; }
        .empty-cart h4 { font-family: 'Playfair Display', serif; color: var(--dark-brown); }
        
        /* Footer */
        .footer {
            background: linear-gradient(135deg, var(--dark-brown) 0%, var(--primary-brown) 100%) !important;
            color: var(--cream);
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg sticky-top">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <i class="fas fa-book-open me-2"></i>Mayur Collection and Bookstore
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto ms-4">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/books">All Books</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/cart">
                            <i class="fas fa-shopping-cart me-1"></i>Cart
                            <span class="badge bg-danger">${cartCount}</span>
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle me-1"></i>${sessionScope.userName}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile"><i class="fas fa-user me-2"></i>My Profile</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/my-orders"><i class="fas fa-box me-2"></i>My Orders</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container py-5">
        <h2 class="page-title mb-4"><i class="fas fa-shopping-cart me-2"></i>Your Shopping Cart</h2>

        <c:choose>
            <c:when test="${empty cartItems}">
                <!-- Empty Cart -->
                <div class="empty-cart">
                    <i class="fas fa-shopping-cart fa-5x mb-4"></i>
                    <h4>Your cart is empty</h4>
                    <p class="text-muted mb-4">Looks like you haven't added any books yet.</p>
                    <a href="${pageContext.request.contextPath}/books" class="btn btn-primary btn-lg">
                        <i class="fas fa-book me-2"></i>Browse Books
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row">
                    <!-- Cart Items -->
                    <div class="col-lg-8">
                        <div class="card cart-card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-book me-2"></i>Cart Items (${cartCount})</h5>
                            </div>
                            <div class="card-body p-0">
                                <c:forEach var="item" items="${cartItems}">
                                    <div class="cart-item d-flex p-3 border-bottom" data-cart-id="${item.cartId}">
                                        <!-- Book Image -->
                                        <div class="flex-shrink-0">
                                            <c:choose>
                                                <c:when test="${not empty item.bookCoverImage}">
                                                    <c:choose>
                                                        <c:when test="${item.bookCoverImage.startsWith('http')}">
                                                            <img src="${item.bookCoverImage}" 
                                                                 alt="${item.bookTitle}" style="width: 80px; height: 110px; object-fit: cover;">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${pageContext.request.contextPath}/${item.bookCoverImage}" 
                                                                 alt="${item.bookTitle}" style="width: 80px; height: 110px; object-fit: cover;">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="https://via.placeholder.com/80x110/8B4513/DAA520?text=📚" 
                                                         alt="${item.bookTitle}" style="width: 80px; height: 110px; object-fit: cover; border-radius: 8px;">
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        
                                        <!-- Book Details -->
                                        <div class="flex-grow-1 ms-3">
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <h6 class="mb-1">
                                                        <a href="${pageContext.request.contextPath}/book-details?id=${item.bookId}" 
                                                           class="text-decoration-none">${item.bookTitle}</a>
                                                    </h6>
                                                    <p class="text-muted small mb-2">by ${item.bookAuthor}</p>
                                                    <p class="text-primary fw-bold mb-0">₹${item.bookPrice}</p>
                                                </div>
                                                <div class="text-end">
                                                    <!-- Quantity Controls -->
                                                    <div class="d-flex align-items-center mb-2">
                                                        <button class="btn btn-sm qty-btn" 
                                                                data-action="decrease" data-cart-id="${item.cartId}">
                                                            <i class="fas fa-minus"></i>
                                                        </button>
                                                        <input type="number" class="form-control form-control-sm mx-2 text-center qty-input" 
                                                               value="${item.quantity}" min="1" max="${item.stockQuantity}" 
                                                               style="width: 60px;" data-cart-id="${item.cartId}">
                                                        <button class="btn btn-sm qty-btn" 
                                                                data-action="increase" data-cart-id="${item.cartId}">
                                                            <i class="fas fa-plus"></i>
                                                        </button>
                                                    </div>
                                                    <p class="fw-bold mb-2">Subtotal: ₹<span class="item-subtotal">
                                                        <fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/>
                                                    </span></p>
                                                    <a href="${pageContext.request.contextPath}/cart/remove?id=${item.cartId}" 
                                                       class="btn btn-sm btn-outline-danger">
                                                        <i class="fas fa-trash me-1"></i>Remove
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Continue Shopping -->
                        <div class="mt-3">
                            <a href="${pageContext.request.contextPath}/books" class="btn btn-outline-primary">
                                <i class="fas fa-arrow-left me-2"></i>Continue Shopping
                            </a>
                        </div>
                    </div>

                    <!-- Order Summary -->
                    <div class="col-lg-4">
                        <div class="card summary-card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-receipt me-2"></i>Order Summary</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Subtotal (${cartCount} items)</span>
                                    <span>₹<fmt:formatNumber value="${cartTotal}" pattern="#,##0.00"/></span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Shipping</span>
                                    <span class="text-success">
                                        <c:choose>
                                            <c:when test="${cartTotal >= 499}">FREE</c:when>
                                            <c:otherwise>₹50.00</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <hr>
                                <div class="d-flex justify-content-between mb-3">
                                    <strong>Total</strong>
                                    <strong class="text-primary fs-5">
                                        ₹<fmt:formatNumber value="${cartTotal < 499 ? cartTotal + 50 : cartTotal}" pattern="#,##0.00"/>
                                    </strong>
                                </div>
                                
                                <c:if test="${cartTotal < 499}">
                                    <div class="alert alert-info small mb-3">
                                        <i class="fas fa-info-circle me-2"></i>
                                        Add ₹<fmt:formatNumber value="${499 - cartTotal}" pattern="#,##0.00"/> more for FREE shipping!
                                    </div>
                                </c:if>

                                <div class="d-grid">
                                    <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary btn-lg">
                                        <i class="fas fa-lock me-2"></i>Proceed to Checkout
                                    </a>
                                </div>

                                <!-- Payment Methods -->
                                <div class="text-center mt-3">
                                    <small class="text-muted">We accept:</small>
                                    <div class="mt-2">
                                        <span class="badge bg-success me-2 p-2">
                                            <i class="fas fa-money-bill-wave me-1"></i>Cash on Delivery
                                        </span>
                                        <span class="badge bg-primary p-2">
                                            <i class="fas fa-mobile-alt me-1"></i>UPI Payment
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Promo Code -->
                        <div class="card promo-card mt-3">
                            <div class="card-body">
                                <h6><i class="fas fa-tag me-2" style="color: var(--golden);"></i>Have a Promo Code?</h6>
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Enter code">
                                    <button class="btn btn-outline-primary">Apply</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Footer -->
    <footer class="footer py-4 mt-5">
        <div class="container text-center">
            <p class="mb-0">&copy; 2026 Mayur Collection and Bookstore. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Quantity buttons
        document.querySelectorAll('.qty-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const cartId = this.dataset.cartId;
                const action = this.dataset.action;
                const input = document.querySelector(`.qty-input[data-cart-id="${cartId}"]`);
                let quantity = parseInt(input.value);
                
                if (action === 'increase') {
                    quantity++;
                } else if (action === 'decrease' && quantity > 1) {
                    quantity--;
                }
                
                input.value = quantity;
                updateCartItem(cartId, quantity);
            });
        });

        // Quantity input change
        document.querySelectorAll('.qty-input').forEach(input => {
            input.addEventListener('change', function() {
                const cartId = this.dataset.cartId;
                const quantity = parseInt(this.value);
                if (quantity >= 1) {
                    updateCartItem(cartId, quantity);
                }
            });
        });

        function updateCartItem(cartId, quantity) {
            fetch('${pageContext.request.contextPath}/cart/update', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'X-Requested-With': 'XMLHttpRequest'
                },
                body: 'cartId=' + cartId + '&quantity=' + quantity
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    if (data.removed) {
                        location.reload();
                    } else {
                        // Update totals - in a real app, update DOM dynamically
                        location.reload();
                    }
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
        }
    </script>
</body>
</html>
