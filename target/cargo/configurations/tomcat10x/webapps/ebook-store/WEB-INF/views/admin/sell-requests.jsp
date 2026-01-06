<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sell Requests - Admin - Mayur Collection and Bookstore</title>
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
        
        .admin-card {
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(93, 46, 15, 0.1);
            overflow: hidden;
        }
        
        .admin-card .card-header {
            background: linear-gradient(135deg, var(--cream) 0%, #F5E6D3 100%);
            border-bottom: 2px solid #E8D5B5;
            padding: 1rem 1.5rem;
        }
        
        .admin-card .card-header h5 {
            color: var(--dark-brown);
            font-weight: 600;
            margin: 0;
        }
        
        .table thead th {
            background: var(--cream);
            color: var(--dark-brown);
            font-weight: 600;
            border-bottom: 2px solid #E8D5B5;
        }
        
        .table tbody tr:hover { background: rgba(218, 165, 32, 0.08); }
        
        .btn-success {
            background: linear-gradient(135deg, #28A745 0%, #1E7E34 100%);
            border: none;
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
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/sell-requests">
                        <i class="fas fa-hand-holding-usd me-2"></i>Sell Requests
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/low-stock">
                        <i class="fas fa-exclamation-triangle me-2"></i>Low Stock Alerts
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
            <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm px-4">
                <button class="btn btn-link text-dark" id="sidebarToggle">
                    <i class="fas fa-bars"></i>
                </button>
                <span class="navbar-text ms-auto">
                    <i class="fas fa-user-circle me-2"></i>Welcome, ${sessionScope.userName}
                </span>
            </nav>

            <div class="container-fluid p-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-hand-holding-usd me-2 text-primary"></i>Sell Requests</h2>
                </div>

                <!-- Success/Error Messages -->
                <c:if test="${not empty sessionScope.success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${sessionScope.success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="success" scope="session"/>
                </c:if>
                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${sessionScope.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="error" scope="session"/>
                </c:if>

                <!-- Sell Requests Table -->
                <div class="card shadow-sm">
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Book Details</th>
                                        <th>Seller</th>
                                        <th>Contact</th>
                                        <th>Price</th>
                                        <th>Condition</th>
                                        <th>Status</th>
                                        <th>Date</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="request" items="${sellRequests}">
                                        <tr>
                                            <td>#${request.requestId}</td>
                                            <td>
                                                <strong>${request.bookTitle}</strong><br>
                                                <small class="text-muted">by ${request.bookAuthor}</small>
                                            </td>
                                            <td>${request.sellerName}</td>
                                            <td>
                                                <small>
                                                    <i class="fas fa-envelope text-primary me-1"></i>${request.sellerEmail}<br>
                                                    <c:if test="${not empty request.sellerPhone}">
                                                        <i class="fas fa-phone text-success me-1"></i>${request.sellerPhone}
                                                    </c:if>
                                                </small>
                                            </td>
                                            <td>₹<fmt:formatNumber value="${request.expectedPrice}" pattern="#,##0.00"/></td>
                                            <td><span class="badge bg-secondary">${request.conditionDisplay}</span></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${request.status == 'PENDING'}">
                                                        <span class="badge bg-warning text-dark">Pending</span>
                                                    </c:when>
                                                    <c:when test="${request.status == 'APPROVED'}">
                                                        <span class="badge bg-success">Approved</span>
                                                    </c:when>
                                                    <c:when test="${request.status == 'REJECTED'}">
                                                        <span class="badge bg-danger">Rejected</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td><fmt:formatDate value="${request.createdAt}" pattern="dd MMM yyyy"/></td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/sell-request-details?id=${request.requestId}" 
                                                   class="btn btn-sm btn-primary">
                                                    <i class="fas fa-eye"></i> View
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty sellRequests}">
                                        <tr>
                                            <td colspan="9" class="text-center py-5 text-muted">
                                                <i class="fas fa-inbox fa-3x mb-3"></i><br>
                                                No sell requests yet
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('sidebarToggle').addEventListener('click', function() {
            document.querySelector('.sidebar').classList.toggle('collapsed');
            document.querySelector('.main-content').classList.toggle('expanded');
        });
    </script>
</body>
</html>
