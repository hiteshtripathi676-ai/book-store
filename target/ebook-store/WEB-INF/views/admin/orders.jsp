<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders - Admin Dashboard</title>
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
        h1, h2, h3, h4, h5, h6 { font-family: 'Playfair Display', serif; }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--golden);
            box-shadow: 0 0 0 3px rgba(218, 165, 32, 0.15);
        }
        
        .form-label { color: var(--dark-brown); font-weight: 500; }
        
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
                        <a href="${pageContext.request.contextPath}/admin/orders" class="nav-link active">
                            <i class="fas fa-shopping-cart"></i> Orders
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
                    <h4 class="mb-0">Manage Orders</h4>
                </div>
                <div class="header-actions d-flex align-items-center">
                    <span class="me-3">${sessionScope.user.fullName}</span>
                    <i class="fas fa-user-circle fa-2x text-primary"></i>
                </div>
            </header>

            <!-- Content -->
            <div class="p-4">
                <!-- Filters -->
                <div class="admin-card mb-4">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/orders" method="get" class="row g-3 align-items-end">
                            <div class="col-md-3">
                                <label class="form-label">Order Status</label>
                                <select class="form-select" name="status">
                                    <option value="">All Status</option>
                                    <option value="PENDING" ${param.status == 'PENDING' ? 'selected' : ''}>Pending</option>
                                    <option value="PROCESSING" ${param.status == 'PROCESSING' ? 'selected' : ''}>Processing</option>
                                    <option value="SHIPPED" ${param.status == 'SHIPPED' ? 'selected' : ''}>Shipped</option>
                                    <option value="DELIVERED" ${param.status == 'DELIVERED' ? 'selected' : ''}>Delivered</option>
                                    <option value="CANCELLED" ${param.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Date Range</label>
                                <select class="form-select" name="dateRange">
                                    <option value="">All Time</option>
                                    <option value="today" ${param.dateRange == 'today' ? 'selected' : ''}>Today</option>
                                    <option value="week" ${param.dateRange == 'week' ? 'selected' : ''}>This Week</option>
                                    <option value="month" ${param.dateRange == 'month' ? 'selected' : ''}>This Month</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Search</label>
                                <input type="text" class="form-control" name="search" placeholder="Order ID or Customer" value="${param.search}">
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fas fa-filter me-2"></i>Filter
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Orders Table -->
                <div class="admin-card">
                    <div class="card-header">
                        <h5 class="card-title">Orders (${orders.size()})</h5>
                        <button class="btn btn-sm btn-outline-primary" onclick="window.print()">
                            <i class="fas fa-print me-1"></i>Print
                        </button>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${empty orders}">
                                <div class="text-center py-5">
                                    <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                                    <p class="text-muted">No orders found</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table admin-table mb-0">
                                        <thead>
                                            <tr>
                                                <th>Order ID</th>
                                                <th>Customer</th>
                                                <th>Items</th>
                                                <th>Total</th>
                                                <th>Payment</th>
                                                <th>Status</th>
                                                <th>Date</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="order" items="${orders}">
                                                <tr>
                                                    <td><strong>#${order.orderId}</strong></td>
                                                    <td>
                                                        <strong>${order.customerName}</strong><br>
                                                        <small class="text-muted">${order.customerEmail}</small>
                                                    </td>
                                                    <td>${order.orderItems != null ? order.orderItems.size() : 0} items</td>
                                                    <td><strong>₹<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></strong></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${order.paymentMethod == 'COD'}">
                                                                <span class="badge bg-secondary">COD</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-info">${order.paymentMethod}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${order.orderStatus == 'PENDING'}">
                                                                <span class="status-badge status-pending">Pending</span>
                                                            </c:when>
                                                            <c:when test="${order.orderStatus == 'PROCESSING'}">
                                                                <span class="status-badge status-processing">Processing</span>
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
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/admin/orders/${order.orderId}" 
                                                           class="table-action-btn btn btn-outline-primary" title="View">
                                                            <i class="fas fa-eye"></i>
                                                        </a>
                                                        <button class="table-action-btn btn btn-outline-success" 
                                                                data-bs-toggle="modal" 
                                                                data-bs-target="#updateStatusModal"
                                                                data-order-id="${order.orderId}"
                                                                data-current-status="${order.orderStatus}"
                                                                title="Update Status">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Update Status Modal -->
    <div class="modal fade" id="updateStatusModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Update Order Status</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/orders/update-status" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="orderId" id="modalOrderId">
                        <div class="mb-3">
                            <label class="form-label">Order #<span id="modalOrderDisplay"></span></label>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">New Status</label>
                            <select class="form-select" name="status" id="modalStatus" required>
                                <option value="PENDING">Pending</option>
                                <option value="PROCESSING">Processing</option>
                                <option value="SHIPPED">Shipped</option>
                                <option value="DELIVERED">Delivered</option>
                                <option value="CANCELLED">Cancelled</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Update Status</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="sidebar-overlay"></div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        // Handle update status modal
        document.getElementById('updateStatusModal').addEventListener('show.bs.modal', function(event) {
            const button = event.relatedTarget;
            const orderId = button.getAttribute('data-order-id');
            const currentStatus = button.getAttribute('data-current-status');
            
            document.getElementById('modalOrderId').value = orderId;
            document.getElementById('modalOrderDisplay').textContent = orderId;
            document.getElementById('modalStatus').value = currentStatus;
        });
    </script>
</body>
</html>
