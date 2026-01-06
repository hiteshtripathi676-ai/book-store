<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Mayur Collection and Bookstore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet">
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
        
        h1, h2, h3, h4, h5, .card-title { font-family: 'Playfair Display', serif; }
        
        /* Stat Cards with Book Theme */
        .stat-card {
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(93, 46, 15, 0.1);
            overflow: hidden;
            transition: all 0.4s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 50px rgba(93, 46, 15, 0.15);
        }
        
        .stat-card.books { border-top: 4px solid var(--primary-brown); }
        .stat-card.orders { border-top: 4px solid #28A745; }
        .stat-card.revenue { border-top: 4px solid var(--golden); }
        .stat-card.alerts { border-top: 4px solid #DC3545; }
        
        .stat-card .card-body { padding: 1.5rem; }
        
        .stat-card .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }
        
        .stat-card.books .stat-icon { background: rgba(139, 69, 19, 0.15); color: var(--primary-brown); }
        .stat-card.orders .stat-icon { background: rgba(40, 167, 69, 0.15); color: #28A745; }
        .stat-card.revenue .stat-icon { background: rgba(218, 165, 32, 0.15); color: var(--golden); }
        .stat-card.alerts .stat-icon { background: rgba(220, 53, 69, 0.15); color: #DC3545; }
        
        .stat-card .stat-value {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            font-weight: 700;
            color: var(--dark-brown);
        }
        
        .stat-card .stat-label {
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 1px;
            color: #8B7355;
        }
        
        .stat-card .card-footer {
            background: linear-gradient(135deg, var(--cream) 0%, #F5E6D3 100%);
            border: none;
            padding: 0.75rem 1.5rem;
        }
        
        .stat-card .card-footer a {
            color: var(--primary-brown);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.85rem;
        }
        
        .stat-card .card-footer a:hover { color: var(--golden); }
        
        /* Dashboard Cards */
        .dashboard-card {
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(93, 46, 15, 0.1);
            overflow: hidden;
        }
        
        .dashboard-card .card-header {
            background: linear-gradient(135deg, var(--cream) 0%, #F5E6D3 100%);
            border-bottom: 2px solid #E8D5B5;
            padding: 1rem 1.5rem;
        }
        
        .dashboard-card .card-header h5 {
            color: var(--dark-brown);
            font-weight: 600;
            margin: 0;
        }
        
        .dashboard-card .card-header i { color: var(--golden); }
        
        .btn-outline-primary {
            border-color: var(--golden);
            color: var(--primary-brown);
        }
        
        .btn-outline-primary:hover {
            background: var(--golden);
            border-color: var(--golden);
            color: var(--dark-brown);
        }
        
        /* Tables */
        .table thead th {
            background: var(--cream);
            color: var(--dark-brown);
            font-weight: 600;
            border-bottom: 2px solid #E8D5B5;
        }
        
        .table tbody tr:hover { background: rgba(218, 165, 32, 0.08); }
        
        .table a { color: var(--primary-brown); }
        .table a:hover { color: var(--golden); }
        
        /* Page Title */
        .page-title {
            color: var(--dark-brown);
            font-weight: 700;
            position: relative;
            display: inline-block;
        }
        
        .page-title::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 0;
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, var(--golden), transparent);
        }
    </style>
</head>
<body>
    <div class="d-flex">
        <!-- Sidebar -->
        <nav class="sidebar">
            <div class="sidebar-header">
                <a class="sidebar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-book-open"></i>Mayur Admin
                </a>
            </div>
            <ul class="nav flex-column p-3">
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">
                        <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/books">
                        <i class="fas fa-book me-2"></i>Books
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">
                        <i class="fas fa-shopping-bag me-2"></i>Orders
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link position-relative" href="${pageContext.request.contextPath}/admin/sell-requests">
                        <i class="fas fa-hand-holding-usd me-2"></i>Sell Requests
                        <c:if test="${pendingSellRequests > 0}">
                            <span class="badge bg-warning text-dark">${pendingSellRequests}</span>
                        </c:if>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link position-relative" href="${pageContext.request.contextPath}/admin/low-stock">
                        <i class="fas fa-exclamation-triangle me-2"></i>Low Stock Alerts
                        <c:if test="${lowStockCount > 0}">
                            <span class="badge bg-danger">${lowStockCount}</span>
                        </c:if>
                    </a>
                </li>
                <li class="nav-item mt-3">
                    <hr style="border-color: rgba(218, 165, 32, 0.3);">
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">
                        <i class="fas fa-store me-2"></i>View Store
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">
                        <i class="fas fa-sign-out-alt me-2"></i>Logout
                    </a>
                </li>
            </ul>
        </nav>

        <!-- Main Content -->
        <main class="main-content flex-grow-1">
            <!-- Top Navbar -->
            <nav class="top-header d-flex justify-content-between align-items-center">
                <button class="btn btn-link text-white" id="sidebarToggle">
                    <i class="fas fa-bars"></i>
                </button>
                <span class="text-white">
                    <i class="fas fa-user-circle me-2"></i>Welcome, ${sessionScope.userName}
                </span>
            </nav>

            <div class="container-fluid p-4">
                <h2 class="page-title mb-4">Dashboard</h2>

                <!-- Stats Cards -->
                <div class="row g-4 mb-4">
                    <div class="col-xl-3 col-md-6">
                        <div class="card stat-card books">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <p class="stat-label mb-1">Total Books</p>
                                        <h2 class="stat-value mb-0">${totalBooks}</h2>
                                    </div>
                                    <div class="stat-icon">
                                        <i class="fas fa-book"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <a href="${pageContext.request.contextPath}/admin/books">
                                    View Details <i class="fas fa-arrow-right ms-1"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="card stat-card orders">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <p class="stat-label mb-1">Total Orders</p>
                                        <h2 class="stat-value mb-0">${totalOrders}</h2>
                                    </div>
                                    <div class="stat-icon">
                                        <i class="fas fa-shopping-bag"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <a href="${pageContext.request.contextPath}/admin/orders">
                                    View Details <i class="fas fa-arrow-right ms-1"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="card stat-card revenue">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <p class="stat-label mb-1">Total Revenue</p>
                                        <h2 class="stat-value mb-0">₹<fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/></h2>
                                    </div>
                                    <div class="stat-icon">
                                        <i class="fas fa-rupee-sign"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <a href="${pageContext.request.contextPath}/admin/orders">
                                    View Orders <i class="fas fa-arrow-right ms-1"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="card stat-card alerts">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <p class="stat-label mb-1">Low Stock Items</p>
                                        <h2 class="stat-value mb-0">${lowStockCount}</h2>
                                    </div>
                                    <div class="stat-icon">
                                        <i class="fas fa-exclamation-triangle"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <a href="${pageContext.request.contextPath}/admin/low-stock">
                                    View Alerts <i class="fas fa-arrow-right ms-1"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row g-4">
                    <!-- Recent Orders -->
                    <div class="col-xl-8">
                        <div class="card dashboard-card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5><i class="fas fa-clock me-2"></i>Recent Orders</h5>
                                <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-sm btn-outline-primary">View All</a>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th>Order ID</th>
                                                <th>Customer</th>
                                                <th>Amount</th>
                                                <th>Status</th>
                                                <th>Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="order" items="${recentOrders}">
                                                <tr>
                                                    <td><a href="${pageContext.request.contextPath}/admin/order-details?id=${order.orderId}">#${order.orderId}</a></td>
                                                    <td>${order.customerName}</td>
                                                    <td>₹<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></td>
                                                    <td>
                                                        <span class="badge ${order.statusBadgeClass}">${order.orderStatus}</span>
                                                    </td>
                                                    <td><fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy"/></td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty recentOrders}">
                                                <tr>
                                                    <td colspan="5" class="text-center py-4 text-muted">No orders yet</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Low Stock Alerts -->
                    <div class="col-xl-4">
                        <div class="card dashboard-card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5><i class="fas fa-exclamation-triangle me-2" style="color: #DC3545;"></i>Low Stock</h5>
                                <a href="${pageContext.request.contextPath}/admin/low-stock" class="btn btn-sm btn-outline-primary">View All</a>
                            </div>
                            <div class="card-body p-0">
                                <ul class="list-group list-group-flush">
                                    <c:forEach var="book" items="${lowStockBooks}" begin="0" end="4">
                                        <li class="list-group-item d-flex justify-content-between align-items-center" style="background: var(--light-cream);">
                                            <div>
                                                <h6 class="mb-0 text-truncate" style="max-width: 180px; color: var(--dark-brown);">${book.title}</h6>
                                                <small style="color: #8B7355;">${book.author}</small>
                                            </div>
                                            <span class="badge ${book.stockQuantity == 0 ? 'bg-danger' : 'bg-warning text-dark'}">
                                                ${book.stockQuantity} left
                                            </span>
                                        </li>
                                    </c:forEach>
                                    <c:if test="${empty lowStockBooks}">
                                        <li class="list-group-item text-center py-4" style="background: var(--light-cream); color: #8B7355;">
                                            <i class="fas fa-check-circle me-2" style="color: #28A745;"></i>All stocks are healthy
                                        </li>
                                    </c:if>
                                </ul>
                            </div>
                        </div>

                        <!-- Quick Actions -->
                        <div class="card dashboard-card mt-4">
                            <div class="card-header">
                                <h5><i class="fas fa-bolt me-2"></i>Quick Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <a href="${pageContext.request.contextPath}/admin/add-book" class="btn" style="background: linear-gradient(135deg, var(--golden) 0%, #B8860B 100%); color: var(--dark-brown); font-weight: 600;">
                                        <i class="fas fa-plus me-2"></i>Add New Book
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-outline-primary">
                                        <i class="fas fa-shopping-bag me-2"></i>Manage Orders
                                    </a>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Sell Requests Notifications -->
                        <c:if test="${pendingSellRequests > 0}">
                            <div class="card dashboard-card mt-4" style="border: 2px solid var(--golden);">
                                <div class="card-header d-flex justify-content-between align-items-center" style="background: linear-gradient(135deg, var(--golden) 0%, #F4D03F 100%);">
                                    <h5 style="color: var(--dark-brown);"><i class="fas fa-bell me-2"></i>Sell Requests</h5>
                                    <span class="badge" style="background: var(--dark-brown);">${pendingSellRequests} pending</span>
                                </div>
                                <div class="card-body p-0">
                                    <ul class="list-group list-group-flush">
                                        <c:forEach var="request" items="${recentSellRequests}">
                                            <li class="list-group-item" style="background: var(--light-cream);">
                                                <div class="d-flex justify-content-between align-items-start">
                                                    <div>
                                                        <h6 class="mb-1" style="color: var(--dark-brown);">${request.bookTitle}</h6>
                                                    <small style="color: #8B7355;">By ${request.sellerName}</small><br>
                                                        <small class="fw-bold" style="color: var(--golden);">₹${request.expectedPrice}</small>
                                                    </div>
                                                    <span class="badge bg-warning text-dark">PENDING</span>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Sidebar toggle
        document.getElementById('sidebarToggle').addEventListener('click', function() {
            document.querySelector('.sidebar').classList.toggle('collapsed');
            document.querySelector('.main-content').classList.toggle('expanded');
        });
    </script>
</body>
</html>
