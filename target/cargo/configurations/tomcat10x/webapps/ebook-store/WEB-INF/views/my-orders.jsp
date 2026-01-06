<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="context-path" content="${pageContext.request.contextPath}">
    <title>My Orders - Mayur Collection and Bookstore</title>
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
        .navbar-book .nav-link { color: rgba(255,255,255,0.9) !important; font-size: 1.1rem; padding: 0.8rem 1.2rem !important; }
        .navbar-book .nav-link:hover { color: var(--golden) !important; }
        
        .order-card {
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(93, 46, 15, 0.1);
            overflow: hidden;
            transition: all 0.3s ease;
        }
        
        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 50px rgba(93, 46, 15, 0.15);
        }
        
        .order-card .card-header {
            background: linear-gradient(135deg, var(--cream) 0%, #F5E6D3 100%);
            border-bottom: 2px solid #E8D5B5;
        }
        
        .sidebar-card {
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(93, 46, 15, 0.1);
            overflow: hidden;
        }
        
        .sidebar-card .user-icon { color: var(--golden); }
        .sidebar-card h5 { color: var(--dark-brown); }
        
        .list-group-item { border-color: #E8D5B5; color: var(--dark-brown); }
        .list-group-item:hover { background: var(--cream); color: var(--primary-brown); }
        .list-group-item.active { background: linear-gradient(135deg, var(--golden) 0%, #B8860B 100%); border-color: var(--golden); color: var(--dark-brown); }
        
        .btn-primary, .btn-outline-primary:hover {
            background: linear-gradient(135deg, var(--golden) 0%, #B8860B 100%);
            border: none;
            color: var(--dark-brown);
            font-weight: 600;
        }
        
        .btn-outline-primary {
            border-color: var(--golden);
            color: var(--primary-brown);
        }
        
        .text-primary { color: var(--primary-brown) !important; }
        
        .page-title { color: var(--dark-brown); font-weight: 700; }
        
        .footer-book { background: linear-gradient(135deg, var(--dark-brown) 0%, #3D1E0A 100%); }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-book sticky-top">
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/books">Books</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                            <i class="fas fa-shopping-cart"></i>
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="profileDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle me-1"></i> ${sessionScope.user.fullName}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile"><i class="fas fa-user me-2"></i>My Profile</a></li>
                            <li><a class="dropdown-item active" href="${pageContext.request.contextPath}/my-orders"><i class="fas fa-box me-2"></i>My Orders</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/sell-book"><i class="fas fa-book me-2"></i>Sell Books</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Orders Content -->
    <div class="container py-5">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-lg-3 mb-4">
                <div class="card sidebar-card">
                    <div class="card-body text-center py-4">
                        <div class="mb-3">
                            <i class="fas fa-user-circle fa-5x user-icon"></i>
                        </div>
                        <h5 class="mb-1">${sessionScope.user.fullName}</h5>
                        <p class="text-muted mb-3">${sessionScope.user.email}</p>
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="${pageContext.request.contextPath}/profile" class="list-group-item list-group-item-action">
                            <i class="fas fa-user me-2"></i>Profile Settings
                        </a>
                        <a href="${pageContext.request.contextPath}/my-orders" class="list-group-item list-group-item-action active">
                            <i class="fas fa-box me-2"></i>My Orders
                        </a>
                        <a href="${pageContext.request.contextPath}/sell-book" class="list-group-item list-group-item-action">
                            <i class="fas fa-book me-2"></i>Sell Books
                        </a>
                    </div>
                </div>
            </div>

            <!-- Orders List -->
            <div class="col-lg-9">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3 class="page-title mb-0"><i class="fas fa-box me-2" style="color: var(--golden);"></i>My Orders</h3>
                    <span class="text-muted">${orders.size()} orders</span>
                </div>

                <c:choose>
                    <c:when test="${empty orders}">
                        <div class="card order-card">
                            <div class="card-body text-center py-5">
                                <i class="fas fa-box-open fa-4x mb-3" style="color: var(--golden);"></i>
                                <h4 style="color: var(--dark-brown);">No Orders Yet</h4>
                                <p class="text-muted mb-4">You haven't placed any orders yet. Start shopping now!</p>
                                <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">
                                    <i class="fas fa-shopping-bag me-2"></i>Browse Books
                                </a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="order" items="${orders}">
                            <div class="card order-card mb-4">
                                <div class="card-header d-flex flex-wrap justify-content-between align-items-center py-3">
                                    <div>
                                        <span class="fw-bold me-3" style="color: var(--dark-brown);">Order #${order.orderId}</span>
                                        <span class="text-muted">
                                            <i class="fas fa-calendar me-1"></i>
                                            <fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy"/>
                                        </span>
                                    </div>
                                    <div>
                                        <c:choose>
                                            <c:when test="${order.orderStatus == 'PENDING'}">
                                                <span class="badge bg-warning text-dark"><i class="fas fa-clock me-1"></i>Pending</span>
                                            </c:when>
                                            <c:when test="${order.orderStatus == 'PROCESSING'}">
                                                <span class="badge bg-info"><i class="fas fa-cog me-1"></i>Processing</span>
                                            </c:when>
                                            <c:when test="${order.orderStatus == 'SHIPPED'}">
                                                <span class="badge bg-primary"><i class="fas fa-shipping-fast me-1"></i>Shipped</span>
                                            </c:when>
                                            <c:when test="${order.orderStatus == 'DELIVERED'}">
                                                <span class="badge bg-success"><i class="fas fa-check-circle me-1"></i>Delivered</span>
                                            </c:when>
                                            <c:when test="${order.orderStatus == 'CANCELLED'}">
                                                <span class="badge bg-danger"><i class="fas fa-times-circle me-1"></i>Cancelled</span>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-8">
                                            <c:forEach var="item" items="${order.orderItems}" varStatus="loop">
                                                <c:if test="${loop.index < 3}">
                                                    <div class="d-flex align-items-center mb-3">
                                                        <div class="flex-grow-1">
                                                            <h6 class="mb-0">${item.bookTitle}</h6>
                                                            <small class="text-muted">Qty: ${item.quantity} × ₹<fmt:formatNumber value="${item.priceAtPurchase}" pattern="#,##0.00"/></small>
                                                        </div>
                                                        <span class="fw-bold">₹<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/></span>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${order.orderItems.size() > 3}">
                                                <small class="text-muted">+ ${order.orderItems.size() - 3} more item(s)</small>
                                            </c:if>
                                        </div>
                                        <div class="col-md-4 text-md-end mt-3 mt-md-0">
                                            <p class="mb-1 text-muted">Total Amount</p>
                                            <h4 class="text-primary mb-3">₹<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></h4>
                                            <a href="${pageContext.request.contextPath}/my-orders/${order.orderId}" class="btn btn-outline-primary btn-sm">
                                                <i class="fas fa-eye me-1"></i>View Details
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer-book text-white py-4 mt-5">
        <div class="container text-center">
            <p class="mb-0">&copy; 2024 Mayur Collection and Bookstore. All Rights Reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
