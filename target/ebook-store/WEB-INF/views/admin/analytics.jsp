<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Analytics - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
    </style>
</head>
<body>
    <div class="admin-wrapper">
        <!-- Sidebar -->
        <nav class="sidebar">
            <div class="sidebar-header">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-brand">
                    <i class="fas fa-book-open"></i> Mayur Admin
                </a>
            </div>
            <div class="sidebar-nav">
                <div class="nav-section-title">Main</div>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                    </li>
                </ul>
                <div class="nav-section-title">Inventory</div>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/books" class="nav-link">
                            <i class="fas fa-book"></i> Books
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/add-book" class="nav-link">
                            <i class="fas fa-plus-circle"></i> Add Book
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/low-stock" class="nav-link">
                            <i class="fas fa-exclamation-triangle"></i> Low Stock
                        </a>
                    </li>
                </ul>
                <div class="nav-section-title">Sales</div>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/orders" class="nav-link">
                            <i class="fas fa-shopping-cart"></i> Orders
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/analytics" class="nav-link active">
                            <i class="fas fa-chart-line"></i> Analytics
                        </a>
                    </li>
                </ul>
                <div class="nav-section-title">Account</div>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/logout" class="nav-link text-danger">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Top Header -->
            <header class="top-header d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center">
                    <button class="sidebar-toggle me-3">
                        <i class="fas fa-bars"></i>
                    </button>
                    <h4 class="mb-0">Sales Analytics</h4>
                </div>
                <div class="header-actions d-flex align-items-center">
                    <span class="me-3">${sessionScope.user.fullName}</span>
                    <i class="fas fa-user-circle fa-2x text-primary"></i>
                </div>
            </header>

            <!-- Content -->
            <div class="p-4">
                <!-- Stats Cards -->
                <div class="row g-4 mb-4">
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div class="stats-icon bg-primary-light me-3">
                                        <i class="fas fa-rupee-sign"></i>
                                    </div>
                                    <div>
                                        <p class="stat-label">Total Revenue</p>
                                        <h3 class="stat-value">₹<fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/></h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div class="stats-icon bg-success-light me-3">
                                        <i class="fas fa-shopping-bag"></i>
                                    </div>
                                    <div>
                                        <p class="stat-label">Total Orders</p>
                                        <h3 class="stat-value">${totalOrders}</h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div class="stats-icon bg-warning-light me-3">
                                        <i class="fas fa-book"></i>
                                    </div>
                                    <div>
                                        <p class="stat-label">Books Sold</p>
                                        <h3 class="stat-value">${booksSold}</h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div class="stats-icon bg-danger-light me-3">
                                        <i class="fas fa-calculator"></i>
                                    </div>
                                    <div>
                                        <p class="stat-label">Avg Order Value</p>
                                        <h3 class="stat-value">₹<fmt:formatNumber value="${avgOrderValue}" pattern="#,##0"/></h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row g-4">
                    <!-- Monthly Sales Chart -->
                    <div class="col-lg-8">
                        <div class="admin-card">
                            <div class="card-header">
                                <h5 class="card-title">Monthly Sales</h5>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="salesChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Popular Authors -->
                    <div class="col-lg-4">
                        <div class="admin-card h-100">
                            <div class="card-header">
                                <h5 class="card-title">Popular Authors</h5>
                            </div>
                            <div class="card-body">
                                <c:forEach var="author" items="${popularAuthors}" varStatus="loop">
                                    <div class="popular-author">
                                        <div class="author-rank">${loop.index + 1}</div>
                                        <div class="author-info">
                                            <p class="author-name">${author.author}</p>
                                            <p class="author-sales">${author.totalSold} books sold</p>
                                        </div>
                                        <span class="text-primary fw-bold">₹<fmt:formatNumber value="${author.revenue}" pattern="#,##0"/></span>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty popularAuthors}">
                                    <p class="text-muted text-center">No sales data available</p>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row g-4 mt-2">
                    <!-- Category Distribution -->
                    <div class="col-lg-6">
                        <div class="admin-card">
                            <div class="card-header">
                                <h5 class="card-title">Sales by Category</h5>
                            </div>
                            <div class="card-body">
                                <div class="chart-container" style="height: 300px;">
                                    <canvas id="categoryChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Order Status Distribution -->
                    <div class="col-lg-6">
                        <div class="admin-card">
                            <div class="card-header">
                                <h5 class="card-title">Order Status</h5>
                            </div>
                            <div class="card-body">
                                <div class="chart-container" style="height: 300px;">
                                    <canvas id="statusChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Transactions -->
                <div class="admin-card mt-4">
                    <div class="card-header">
                        <h5 class="card-title">Recent Transactions</h5>
                        <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-sm btn-outline-primary">View All</a>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table admin-table mb-0">
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Customer</th>
                                        <th>Amount</th>
                                        <th>Payment</th>
                                        <th>Status</th>
                                        <th>Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${recentOrders}" end="9">
                                        <tr>
                                            <td><strong>#${order.orderId}</strong></td>
                                            <td>${order.customerName}</td>
                                            <td><strong>₹<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></strong></td>
                                            <td><span class="badge bg-secondary">${order.paymentMethod}</span></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.orderStatus == 'PLACED'}">
                                                        <span class="status-badge status-pending">Placed</span>
                                                    </c:when>
                                                    <c:when test="${order.orderStatus == 'CONFIRMED'}">
                                                        <span class="status-badge status-processing">Confirmed</span>
                                                    </c:when>
                                                    <c:when test="${order.orderStatus == 'SHIPPED'}">
                                                        <span class="status-badge status-shipped">Shipped</span>
                                                    </c:when>
                                                    <c:when test="${order.orderStatus == 'DELIVERED'}">
                                                        <span class="status-badge status-delivered">Delivered</span>
                                                    </c:when>
                                                    <c:when test="${order.orderStatus == 'CANCELLED'}">
                                                        <span class="status-badge status-cancelled">Cancelled</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td><fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy"/></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="sidebar-overlay"></div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        // Monthly Sales Chart
        const salesCtx = document.getElementById('salesChart').getContext('2d');
        new Chart(salesCtx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                datasets: [{
                    label: 'Sales (₹)',
                    data: [
                        <c:forEach var="sale" items="${monthlySales}" varStatus="loop">
                            ${sale.totalSales}${!loop.last ? ',' : ''}
                        </c:forEach>
                    ],
                    borderColor: '#0d6efd',
                    backgroundColor: 'rgba(13, 110, 253, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return '₹' + value.toLocaleString();
                            }
                        }
                    }
                }
            }
        });

        // Category Chart
        const categoryCtx = document.getElementById('categoryChart').getContext('2d');
        new Chart(categoryCtx, {
            type: 'doughnut',
            data: {
                labels: [
                    <c:forEach var="cat" items="${categorySales}" varStatus="loop">
                        '${cat.categoryName}'${!loop.last ? ',' : ''}
                    </c:forEach>
                ],
                datasets: [{
                    data: [
                        <c:forEach var="cat" items="${categorySales}" varStatus="loop">
                            ${cat.totalSales}${!loop.last ? ',' : ''}
                        </c:forEach>
                    ],
                    backgroundColor: [
                        '#0d6efd', '#198754', '#ffc107', '#dc3545', '#6c757d',
                        '#0dcaf0', '#6610f2', '#fd7e14', '#20c997', '#d63384'
                    ]
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'right'
                    }
                }
            }
        });

        // Order Status Chart
        const statusCtx = document.getElementById('statusChart').getContext('2d');
        new Chart(statusCtx, {
            type: 'bar',
            data: {
                labels: ['Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled'],
                datasets: [{
                    label: 'Orders',
                    data: [${pendingCount}, ${processingCount}, ${shippedCount}, ${deliveredCount}, ${cancelledCount}],
                    backgroundColor: ['#ffc107', '#0dcaf0', '#0d6efd', '#198754', '#dc3545']
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>
