<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sell Request Details - Admin - Mayur Collection and Bookstore</title>
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
        
        .btn-success {
            background: linear-gradient(135deg, #28A745 0%, #1E7E34 100%);
            border: none;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--golden);
            box-shadow: 0 0 0 3px rgba(218, 165, 32, 0.15);
        }
        
        .form-label { color: var(--dark-brown); font-weight: 500; }
        
        .breadcrumb-item a { color: var(--primary-brown); }
        .breadcrumb-item a:hover { color: var(--golden); }
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
                    <h2><i class="fas fa-file-alt me-2 text-primary"></i>Sell Request #${sellRequest.requestId}</h2>
                    <a href="${pageContext.request.contextPath}/admin/sell-requests" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to List
                    </a>
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

                <div class="row">
                    <!-- Request Details -->
                    <div class="col-lg-8">
                        <div class="card shadow-sm mb-4">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0"><i class="fas fa-book me-2"></i>Book Information</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="text-muted small">Book Title</label>
                                        <h5>${sellRequest.bookTitle}</h5>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="text-muted small">Author</label>
                                        <h5>${sellRequest.bookAuthor}</h5>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="text-muted small">Condition</label>
                                        <p class="mb-0"><span class="badge bg-secondary fs-6">${sellRequest.conditionDisplay}</span></p>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="text-muted small">Expected Price</label>
                                        <h5 class="text-success">₹<fmt:formatNumber value="${sellRequest.expectedPrice}" pattern="#,##0.00"/></h5>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="text-muted small">Status</label>
                                        <p class="mb-0">
                                            <c:choose>
                                                <c:when test="${sellRequest.status == 'PENDING'}">
                                                    <span class="badge bg-warning text-dark fs-6">Pending Review</span>
                                                </c:when>
                                                <c:when test="${sellRequest.status == 'APPROVED'}">
                                                    <span class="badge bg-success fs-6">Approved</span>
                                                </c:when>
                                                <c:when test="${sellRequest.status == 'REJECTED'}">
                                                    <span class="badge bg-danger fs-6">Rejected</span>
                                                </c:when>
                                            </c:choose>
                                        </p>
                                    </div>
                                    <div class="col-12 mb-3">
                                        <label class="text-muted small">Description</label>
                                        <p class="border rounded p-3 bg-light">${sellRequest.description}</p>
                                    </div>
                                    <c:if test="${not empty sellRequest.bookImage}">
                                        <div class="col-12">
                                            <label class="text-muted small">Book Image</label><br>
                                            <img src="${pageContext.request.contextPath}/${sellRequest.bookImage}" 
                                                 alt="Book" class="img-thumbnail" style="max-height: 300px;">
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <!-- Admin Remarks -->
                        <c:if test="${not empty sellRequest.adminRemarks}">
                            <div class="card shadow-sm">
                                <div class="card-header bg-info text-white">
                                    <h5 class="mb-0"><i class="fas fa-comment me-2"></i>Admin Remarks</h5>
                                </div>
                                <div class="card-body">
                                    <p class="mb-0">${sellRequest.adminRemarks}</p>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <!-- Seller Information & Actions -->
                    <div class="col-lg-4">
                        <!-- Seller Contact Info -->
                        <div class="card shadow-sm mb-4">
                            <div class="card-header bg-success text-white">
                                <h5 class="mb-0"><i class="fas fa-user me-2"></i>Seller Information</h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <label class="text-muted small">Name</label>
                                    <h6>${sellRequest.sellerName}</h6>
                                </div>
                                <div class="mb-3">
                                    <label class="text-muted small">Email</label>
                                    <p class="mb-0">
                                        <a href="mailto:${sellRequest.sellerEmail}" class="text-decoration-none">
                                            <i class="fas fa-envelope text-primary me-2"></i>${sellRequest.sellerEmail}
                                        </a>
                                    </p>
                                </div>
                                <c:if test="${not empty sellRequest.sellerPhone}">
                                    <div class="mb-3">
                                        <label class="text-muted small">Phone</label>
                                        <p class="mb-0">
                                            <a href="tel:${sellRequest.sellerPhone}" class="text-decoration-none">
                                                <i class="fas fa-phone text-success me-2"></i>${sellRequest.sellerPhone}
                                            </a>
                                        </p>
                                    </div>
                                </c:if>
                                <div>
                                    <label class="text-muted small">Submitted On</label>
                                    <p class="mb-0"><fmt:formatDate value="${sellRequest.createdAt}" pattern="dd MMM yyyy, hh:mm a"/></p>
                                </div>
                            </div>
                        </div>

                        <!-- Actions -->
                        <c:if test="${sellRequest.status == 'PENDING'}">
                            <div class="card shadow-sm border-warning">
                                <div class="card-header bg-warning text-dark">
                                    <h5 class="mb-0"><i class="fas fa-tasks me-2"></i>Actions</h5>
                                </div>
                                <div class="card-body">
                                    <form action="${pageContext.request.contextPath}/admin/update-sell-request" method="post">
                                        <input type="hidden" name="requestId" value="${sellRequest.requestId}">
                                        
                                        <div class="mb-3">
                                            <label class="form-label">Remarks (Optional)</label>
                                            <textarea name="remarks" class="form-control" rows="3" 
                                                      placeholder="Add your comments here..."></textarea>
                                        </div>
                                        
                                        <div class="d-grid gap-2">
                                            <button type="submit" name="status" value="APPROVED" 
                                                    class="btn btn-success" 
                                                    onclick="return confirm('Are you sure you want to approve this request?')">
                                                <i class="fas fa-check me-2"></i>Approve
                                            </button>
                                            <button type="submit" name="status" value="REJECTED" 
                                                    class="btn btn-danger" 
                                                    onclick="return confirm('Are you sure you want to reject this request?')">
                                                <i class="fas fa-times me-2"></i>Reject
                                            </button>
                                        </div>
                                    </form>
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
        document.getElementById('sidebarToggle').addEventListener('click', function() {
            document.querySelector('.sidebar').classList.toggle('collapsed');
            document.querySelector('.main-content').classList.toggle('expanded');
        });
    </script>
</body>
</html>
