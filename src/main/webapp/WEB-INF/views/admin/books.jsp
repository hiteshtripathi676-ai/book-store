<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Books - Admin</title>
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
        
        .admin-card .card-header i { color: var(--golden); }
        
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
        
        .table thead th {
            background: var(--cream);
            color: var(--dark-brown);
            font-weight: 600;
            border-bottom: 2px solid #E8D5B5;
        }
        
        .table tbody tr:hover { background: rgba(218, 165, 32, 0.08); }
        
        .table a { color: var(--primary-brown); }
        .table a:hover { color: var(--golden); }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--golden);
            box-shadow: 0 0 0 3px rgba(218, 165, 32, 0.15);
        }
        
        .breadcrumb-item a { color: var(--primary-brown); }
        .breadcrumb-item a:hover { color: var(--golden); }
        .breadcrumb-item.active { color: #8B7355; }
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/books">
                        <i class="fas fa-book me-2"></i>Books
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">
                        <i class="fas fa-shopping-bag me-2"></i>Orders
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
                <!-- Breadcrumb -->
                <nav aria-label="breadcrumb" class="mb-4">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item active">Books</li>
                    </ol>
                </nav>

                <!-- Success/Error Messages -->
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${sessionScope.successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="successMessage" scope="session"/>
                </c:if>
                
                <c:if test="${not empty sessionScope.errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${sessionScope.errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="errorMessage" scope="session"/>
                </c:if>

                <div class="card admin-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5><i class="fas fa-book me-2"></i>All Books</h5>
                        <a href="${pageContext.request.contextPath}/admin/add-book" class="btn btn-primary">
                            <i class="fas fa-plus me-2"></i>Add New Book
                        </a>
                    </div>
                    <div class="card-body">
                        <!-- Search & Filter -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="searchBooks" placeholder="Search books...">
                                    <button class="btn btn-outline-primary"><i class="fas fa-search"></i></button>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <select class="form-select" id="filterType">
                                    <option value="">All Types</option>
                                    <option value="NEW">New Books</option>
                                    <option value="OLD">Pre-Owned Books</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <select class="form-select" id="filterStock">
                                    <option value="">All Stock</option>
                                    <option value="low">Low Stock</option>
                                    <option value="out">Out of Stock</option>
                                    <option value="available">In Stock</option>
                                </select>
                            </div>
                        </div>

                        <!-- Books Table -->
                        <div class="table-responsive">
                            <table class="table table-hover" id="booksTable">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Cover</th>
                                        <th>Title</th>
                                        <th>Author</th>
                                        <th>Category</th>
                                        <th>Type</th>
                                        <th>Price</th>
                                        <th>Stock</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="book" items="${books}">
                                        <tr data-type="${book.bookType}" data-stock="${book.stockQuantity}">
                                            <td>${book.bookId}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty book.coverImage}">
                                                        <img src="${pageContext.request.contextPath}/${book.coverImage}" 
                                                             alt="${book.title}" class="img-thumbnail" style="width: 50px; height: 70px; object-fit: cover;">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="https://via.placeholder.com/50x70?text=No+Image" 
                                                             alt="No Image" class="img-thumbnail">
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/book-details?id=${book.bookId}" class="text-decoration-none">
                                                    ${book.title}
                                                </a>
                                            </td>
                                            <td>${book.author}</td>
                                            <td><span class="badge bg-secondary">${book.categoryName}</span></td>
                                            <td>
                                                <span class="badge ${book.bookType == 'NEW' ? 'bg-success' : 'bg-warning text-dark'}">
                                                    ${book.bookType}
                                                </span>
                                            </td>
                                            <td>
                                                <strong>₹${book.price}</strong>
                                                <c:if test="${book.originalPrice > book.price}">
                                                    <br><small class="text-muted text-decoration-line-through">₹${book.originalPrice}</small>
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${book.stockQuantity == 0}">
                                                        <span class="badge bg-danger">Out of Stock</span>
                                                    </c:when>
                                                    <c:when test="${book.lowStock}">
                                                        <span class="badge bg-warning text-dark">${book.stockQuantity} (Low)</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-success">${book.stockQuantity}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <span class="badge ${book.available ? 'bg-success' : 'bg-secondary'}">
                                                    ${book.available ? 'Active' : 'Inactive'}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="btn-group btn-group-sm">
                                                    <a href="${pageContext.request.contextPath}/admin/edit-book?id=${book.bookId}" 
                                                       class="btn btn-outline-primary" title="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button type="button" class="btn btn-outline-danger" 
                                                            onclick="confirmDelete(${book.bookId}, '${book.title}')" title="Delete">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty books}">
                                        <tr>
                                            <td colspan="10" class="text-center py-4">
                                                <i class="fas fa-book fa-3x text-muted mb-3"></i>
                                                <p class="text-muted">No books found. <a href="${pageContext.request.contextPath}/admin/add-book">Add your first book</a></p>
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

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-exclamation-triangle text-danger me-2"></i>Confirm Delete</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete <strong id="bookTitleToDelete"></strong>?</p>
                    <p class="text-muted small">This action cannot be undone.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <a href="#" id="deleteLink" class="btn btn-danger">
                        <i class="fas fa-trash me-2"></i>Delete
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Sidebar toggle
        document.getElementById('sidebarToggle').addEventListener('click', function() {
            document.querySelector('.sidebar').classList.toggle('collapsed');
            document.querySelector('.main-content').classList.toggle('expanded');
        });

        // Delete confirmation
        function confirmDelete(bookId, bookTitle) {
            document.getElementById('bookTitleToDelete').textContent = bookTitle;
            document.getElementById('deleteLink').href = '${pageContext.request.contextPath}/admin/delete-book?id=' + bookId;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }

        // Search books
        document.getElementById('searchBooks').addEventListener('keyup', filterBooks);
        document.getElementById('filterType').addEventListener('change', filterBooks);
        document.getElementById('filterStock').addEventListener('change', filterBooks);

        function filterBooks() {
            const searchTerm = document.getElementById('searchBooks').value.toLowerCase();
            const typeFilter = document.getElementById('filterType').value;
            const stockFilter = document.getElementById('filterStock').value;
            
            const rows = document.querySelectorAll('#booksTable tbody tr');
            
            rows.forEach(row => {
                const title = row.cells[2]?.textContent.toLowerCase() || '';
                const author = row.cells[3]?.textContent.toLowerCase() || '';
                const type = row.dataset.type;
                const stock = parseInt(row.dataset.stock) || 0;
                
                let show = true;
                
                // Search filter
                if (searchTerm && !title.includes(searchTerm) && !author.includes(searchTerm)) {
                    show = false;
                }
                
                // Type filter
                if (typeFilter && type !== typeFilter) {
                    show = false;
                }
                
                // Stock filter
                if (stockFilter === 'low' && stock > 5) show = false;
                if (stockFilter === 'out' && stock !== 0) show = false;
                if (stockFilter === 'available' && stock === 0) show = false;
                
                row.style.display = show ? '' : 'none';
            });
        }
    </script>
</body>
</html>
