<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Low Stock Alerts - Admin Dashboard</title>
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
                        <a href="${pageContext.request.contextPath}/admin/low-stock" class="nav-link active">
                            <i class="fas fa-exclamation-triangle"></i> Low Stock
                            <c:if test="${lowStockBooks.size() > 0}">
                                <span class="badge bg-danger">${lowStockBooks.size()}</span>
                            </c:if>
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
                    <h4 class="mb-0">Low Stock Alerts</h4>
                </div>
                <div class="header-actions d-flex align-items-center">
                    <span class="me-3">${sessionScope.user.fullName}</span>
                    <i class="fas fa-user-circle fa-2x text-primary"></i>
                </div>
            </header>

            <!-- Content -->
            <div class="p-4">
                <!-- Alert Banner -->
                <c:if test="${lowStockBooks.size() > 0}">
                    <div class="alert alert-warning d-flex align-items-center mb-4" role="alert">
                        <i class="fas fa-exclamation-triangle fa-2x me-3"></i>
                        <div>
                            <h5 class="mb-1">Low Stock Warning</h5>
                            <p class="mb-0">You have <strong>${lowStockBooks.size()}</strong> book(s) with low stock levels. Consider restocking soon!</p>
                        </div>
                    </div>
                </c:if>

                <!-- Low Stock Books -->
                <div class="admin-card">
                    <div class="card-header">
                        <h5 class="card-title">Books with Low Stock (< 5 units)</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty lowStockBooks}">
                                <div class="text-center py-5">
                                    <i class="fas fa-check-circle fa-4x text-success mb-3"></i>
                                    <h4>All Stock Levels OK</h4>
                                    <p class="text-muted">No books are currently running low on stock.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="row g-4">
                                    <c:forEach var="book" items="${lowStockBooks}">
                                        <div class="col-md-6 col-lg-4">
                                            <div class="card border-${book.stockQuantity == 0 ? 'danger' : 'warning'} h-100">
                                                <div class="row g-0">
                                                    <div class="col-4">
                                                        <img src="${pageContext.request.contextPath}/${book.coverImage}" 
                                                             class="img-fluid rounded-start h-100" 
                                                             alt="${book.title}"
                                                             style="object-fit: cover;"
                                                             onerror="this.src='https://via.placeholder.com/200x280/8B4513/ffffff?text=📚'">
                                                    </div>
                                                    <div class="col-8">
                                                        <div class="card-body">
                                                            <h6 class="card-title mb-1 text-truncate">${book.title}</h6>
                                                            <p class="text-muted small mb-2">${book.author}</p>
                                                            <p class="mb-2">
                                                                <c:choose>
                                                                    <c:when test="${book.stockQuantity == 0}">
                                                                        <span class="badge bg-danger fs-6">OUT OF STOCK</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-warning text-dark fs-6">${book.stockQuantity} left</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </p>
                                                            <div class="d-flex gap-2">
                                                                <a href="${pageContext.request.contextPath}/admin/edit-book?id=${book.bookId}" 
                                                                   class="btn btn-sm btn-primary">
                                                                    <i class="fas fa-edit me-1"></i>Edit
                                                                </a>
                                                                <button class="btn btn-sm btn-outline-success" 
                                                                        data-bs-toggle="modal" 
                                                                        data-bs-target="#restockModal"
                                                                        data-book-id="${book.bookId}"
                                                                        data-book-title="${book.title}"
                                                                        data-current-stock="${book.stockQuantity}">
                                                                    <i class="fas fa-plus me-1"></i>Restock
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Stock Alerts History -->
                <div class="admin-card mt-4">
                    <div class="card-header">
                        <h5 class="card-title">Recent Stock Alerts</h5>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${empty stockAlerts}">
                                <div class="text-center py-4">
                                    <p class="text-muted mb-0">No stock alerts recorded yet.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table admin-table mb-0">
                                        <thead>
                                            <tr>
                                                <th>Book</th>
                                                <th>Alert Type</th>
                                                <th>Stock at Alert</th>
                                                <th>Date</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="alert" items="${stockAlerts}">
                                                <tr>
                                                    <td><strong>${alert.bookTitle}</strong></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${alert.stockLevel == 0}">
                                                                <span class="badge bg-danger">Out of Stock</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-warning text-dark">Low Stock</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>${alert.stockLevel} units</td>
                                                    <td><fmt:formatDate value="${alert.createdAt}" pattern="dd MMM yyyy, HH:mm"/></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${alert.resolved}">
                                                                <span class="badge bg-success">Resolved</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-secondary">Pending</span>
                                                            </c:otherwise>
                                                        </c:choose>
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

    <!-- Restock Modal -->
    <div class="modal fade" id="restockModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-plus-circle me-2"></i>Restock Book</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/restock" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="bookId" id="restockBookId">
                        <div class="mb-3">
                            <label class="form-label">Book</label>
                            <p id="restockBookTitle" class="form-control-plaintext fw-bold"></p>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Current Stock</label>
                            <p id="restockCurrentStock" class="form-control-plaintext"></p>
                        </div>
                        <div class="mb-3">
                            <label for="addQuantity" class="form-label">Add Quantity</label>
                            <input type="number" class="form-control" id="addQuantity" name="addQuantity" min="1" value="10" required>
                            <small class="form-text text-muted">Enter the number of units to add to stock</small>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-check me-2"></i>Update Stock
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="sidebar-overlay"></div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        // Handle restock modal
        document.getElementById('restockModal').addEventListener('show.bs.modal', function(event) {
            const button = event.relatedTarget;
            const bookId = button.getAttribute('data-book-id');
            const bookTitle = button.getAttribute('data-book-title');
            const currentStock = button.getAttribute('data-current-stock');
            
            document.getElementById('restockBookId').value = bookId;
            document.getElementById('restockBookTitle').textContent = bookTitle;
            document.getElementById('restockCurrentStock').textContent = currentStock + ' units';
        });
    </script>
</body>
</html>
