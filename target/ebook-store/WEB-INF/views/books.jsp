<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="context-path" content="${pageContext.request.contextPath}">
    <title>Browse Books - Mayur Collection and Bookstore</title>
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
        
        * {
            font-family: 'Poppins', sans-serif;
        }
        
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
        
        .navbar-brand i {
            color: var(--light-golden);
        }
        
        .nav-link {
            color: var(--cream) !important;
            font-weight: 500;
            font-size: 1.1rem;
            padding: 0.8rem 1.2rem !important;
            transition: color 0.3s ease;
        }
        
        .nav-link:hover, .nav-link.active {
            color: var(--golden) !important;
        }
        
        .search-form input {
            background: rgba(255,255,255,0.15);
            border: 2px solid rgba(218, 165, 32, 0.3);
            color: white;
            border-radius: 25px 0 0 25px;
        }
        
        .search-form input::placeholder {
            color: rgba(255,255,255,0.7);
        }
        
        .search-form input:focus {
            background: rgba(255,255,255,0.25);
            border-color: var(--golden);
            box-shadow: none;
            color: white;
        }
        
        .search-form .btn {
            background: var(--golden);
            border: none;
            color: var(--dark-brown);
            border-radius: 0 25px 25px 0;
        }
        
        .search-form .btn:hover {
            background: var(--light-golden);
        }
        
        .dropdown-menu {
            background: var(--light-cream);
            border: 2px solid #E8D5B5;
            border-radius: 12px;
        }
        
        .dropdown-item:hover {
            background: var(--cream);
            color: var(--primary-brown);
        }
        
        .cart-badge {
            background: var(--golden) !important;
            color: var(--dark-brown) !important;
        }
        
        /* Page Header */
        .page-header {
            background: linear-gradient(135deg, var(--dark-brown) 0%, var(--primary-brown) 100%);
            padding: 2.5rem 0;
            position: relative;
            overflow: hidden;
        }
        
        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23DAA520' fill-opacity='0.1'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
            pointer-events: none;
        }
        
        .page-header h2 {
            font-family: 'Playfair Display', serif;
            color: var(--golden);
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .page-header p {
            color: var(--cream);
            opacity: 0.9;
        }
        
        /* Filter Sidebar */
        .filter-sidebar {
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(93, 46, 15, 0.1);
            overflow: hidden;
        }
        
        .filter-sidebar .card-header {
            background: linear-gradient(135deg, var(--dark-brown) 0%, var(--primary-brown) 100%);
            color: var(--golden);
            font-family: 'Playfair Display', serif;
            border: none;
            padding: 1rem 1.25rem;
        }
        
        .filter-sidebar .card-body {
            padding: 1.5rem;
        }
        
        .filter-sidebar h6 {
            color: var(--dark-brown);
            font-weight: 600;
            position: relative;
            padding-bottom: 0.5rem;
        }
        
        .filter-sidebar h6::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 30px;
            height: 2px;
            background: var(--golden);
        }
        
        .form-check-input:checked {
            background-color: var(--golden);
            border-color: var(--golden);
        }
        
        .form-check-label {
            color: #5D4E37;
        }
        
        .form-control, .form-select {
            border: 2px solid #E8D5B5;
            border-radius: 8px;
            background: var(--light-cream);
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--golden);
            box-shadow: 0 0 0 3px rgba(218, 165, 32, 0.15);
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--golden) 0%, #C4941A 100%);
            border: none;
            color: var(--dark-brown);
            font-weight: 600;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, var(--light-golden) 0%, var(--golden) 100%);
            color: var(--dark-brown);
            transform: translateY(-2px);
        }
        
        .btn-outline-secondary {
            border-color: #C4A77D;
            color: var(--primary-brown);
            border-radius: 10px;
        }
        
        .btn-outline-secondary:hover {
            background: var(--cream);
            border-color: var(--golden);
            color: var(--dark-brown);
        }
        
        /* Book Cards */
        .book-card {
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border: none;
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(93, 46, 15, 0.1);
            transition: all 0.4s ease;
            overflow: hidden;
        }
        
        .book-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 40px rgba(93, 46, 15, 0.2);
        }
        
        .book-image-container {
            height: 220px;
            background: linear-gradient(135deg, var(--cream) 0%, #F5E6D3 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        
        .book-cover {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
        
        .book-card:hover .book-cover {
            transform: scale(1.05);
        }
        
        .book-card .badge {
            font-size: 0.7rem;
            padding: 0.4em 0.8em;
        }
        
        .badge.bg-warning {
            background: linear-gradient(135deg, var(--golden) 0%, #C4941A 100%) !important;
            color: var(--dark-brown) !important;
        }
        
        .badge.bg-danger {
            background: linear-gradient(135deg, #DC3545 0%, #B02A37 100%) !important;
        }
        
        .book-card .card-body {
            padding: 1.25rem;
        }
        
        .book-card .card-title {
            font-family: 'Playfair Display', serif;
            font-weight: 600;
            color: var(--dark-brown);
            font-size: 1rem;
            line-height: 1.3;
        }
        
        .text-truncate-2 {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .book-card .text-muted {
            color: #8B7355 !important;
        }
        
        .book-card .text-primary {
            color: var(--golden) !important;
            font-family: 'Playfair Display', serif;
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
        
        /* View Toggle Buttons */
        .btn-group .btn-outline-secondary.active {
            background: var(--golden);
            border-color: var(--golden);
            color: var(--dark-brown);
        }
        
        /* Pagination */
        .pagination .page-link {
            color: var(--primary-brown);
            border: 2px solid #E8D5B5;
            border-radius: 8px;
            margin: 0 3px;
            background: var(--light-cream);
        }
        
        .pagination .page-link:hover {
            background: var(--cream);
            border-color: var(--golden);
            color: var(--dark-brown);
        }
        
        .pagination .page-item.active .page-link {
            background: linear-gradient(135deg, var(--golden) 0%, #C4941A 100%);
            border-color: var(--golden);
            color: var(--dark-brown);
        }
        
        .pagination .page-item.disabled .page-link {
            background: #F5E6D3;
            border-color: #E8D5B5;
            color: #B8A78A;
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(93, 46, 15, 0.1);
        }
        
        .empty-state i {
            color: var(--golden);
            opacity: 0.5;
        }
        
        .empty-state h4 {
            font-family: 'Playfair Display', serif;
            color: var(--dark-brown);
        }
        
        /* Footer */
        .footer {
            background: linear-gradient(135deg, var(--dark-brown) 0%, var(--primary-brown) 100%) !important;
            color: var(--cream);
        }
        
        /* Toast Notifications */
        .toast-container {
            z-index: 9999 !important;
        }
        
        .toast {
            background: var(--light-cream);
            border: 2px solid #E8D5B5;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(93, 46, 15, 0.2);
        }
        
        .toast-header {
            background: var(--cream);
            border-bottom: 1px solid #E8D5B5;
            color: var(--dark-brown);
        }
        
        .toast-body {
            color: var(--dark-brown);
        }
        
        /* Spinner Overlay */
        .spinner-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(93, 46, 15, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9998;
        }
        
        .spinner-overlay .spinner-border {
            color: var(--golden) !important;
            width: 4rem;
            height: 4rem;
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/books">Books</a>
                    </li>
                </ul>
                <!-- Search Form -->
                <form class="d-flex me-4 search-form" action="${pageContext.request.contextPath}/search" method="get">
                    <input class="form-control" type="search" name="q" placeholder="Search books..." value="${param.q}" style="min-width: 250px;">
                    <button class="btn btn-light" type="submit"><i class="fas fa-search"></i></button>
                </form>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                            <i class="fas fa-shopping-cart"></i>
                            <span class="badge bg-danger cart-badge ${cartCount > 0 ? '' : 'd-none'}">${cartCount}</span>
                        </a>
                    </li>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="profileDropdown" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user-circle me-1"></i> ${sessionScope.user.fullName}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile"><i class="fas fa-user me-2"></i>My Profile</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/my-orders"><i class="fas fa-box me-2"></i>My Orders</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login">Login</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <h2><i class="fas fa-books me-2"></i>Browse Books</h2>
            <p class="mb-0">Explore our collection of new and pre-owned books</p>
        </div>
    </section>

    <!-- Books Content -->
    <div class="container py-5">
        <div class="row">
            <!-- Filters Sidebar -->
            <div class="col-lg-3 mb-4">
                <div class="card shadow-sm filter-sidebar">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-filter me-2"></i>Filters</h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/books" method="get" id="filterForm">
                            <!-- Book Type -->
                            <div class="mb-4">
                                <h6 class="fw-bold mb-3">Book Type</h6>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="type" id="typeAll" value="" ${empty param.type ? 'checked' : ''}>
                                    <label class="form-check-label" for="typeAll">All Books</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="type" id="typeNew" value="NEW" ${param.type == 'NEW' ? 'checked' : ''}>
                                    <label class="form-check-label" for="typeNew">New Books</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="type" id="typeOld" value="OLD" ${param.type == 'OLD' ? 'checked' : ''}>
                                    <label class="form-check-label" for="typeOld">Pre-owned Books</label>
                                </div>
                            </div>

                            <!-- Categories -->
                            <div class="mb-4">
                                <h6 class="fw-bold mb-3">Categories</h6>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="category" 
                                           value="" id="catAll"
                                           ${empty param.category ? 'checked' : ''}>
                                    <label class="form-check-label" for="catAll">
                                        All Categories
                                    </label>
                                </div>
                                <c:forEach var="category" items="${categories}">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="category" 
                                               value="${category.categoryId}" id="cat${category.categoryId}"
                                               ${param.category == String.valueOf(category.categoryId) ? 'checked' : ''}>
                                        <label class="form-check-label" for="cat${category.categoryId}">
                                            ${category.categoryName} <span class="text-muted">(${category.bookCount})</span>
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Price Range -->
                            <div class="mb-4">
                                <h6 class="fw-bold mb-3">Price Range</h6>
                                <div class="row g-2">
                                    <div class="col-6">
                                        <input type="number" class="form-control form-control-sm" name="minPrice" placeholder="Min" value="${param.minPrice}">
                                    </div>
                                    <div class="col-6">
                                        <input type="number" class="form-control form-control-sm" name="maxPrice" placeholder="Max" value="${param.maxPrice}">
                                    </div>
                                </div>
                            </div>

                            <!-- Sort By -->
                            <div class="mb-4">
                                <h6 class="fw-bold mb-3">Sort By</h6>
                                <select class="form-select form-select-sm" name="sort">
                                    <option value="newest" ${param.sort == 'newest' ? 'selected' : ''}>Newest First</option>
                                    <option value="priceAsc" ${param.sort == 'priceAsc' ? 'selected' : ''}>Price: Low to High</option>
                                    <option value="priceDesc" ${param.sort == 'priceDesc' ? 'selected' : ''}>Price: High to Low</option>
                                    <option value="titleAsc" ${param.sort == 'titleAsc' ? 'selected' : ''}>Title: A to Z</option>
                                    <option value="titleDesc" ${param.sort == 'titleDesc' ? 'selected' : ''}>Title: Z to A</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-search me-2"></i>Apply Filters
                            </button>
                            <a href="${pageContext.request.contextPath}/books" class="btn btn-outline-secondary w-100 mt-2">
                                <i class="fas fa-times me-2"></i>Clear Filters
                            </a>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Books Grid -->
            <div class="col-lg-9">
                <!-- Results Info -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <p class="mb-0 text-muted">
                        Showing <strong>${books.size()}</strong> of <strong>${totalBooks}</strong> books
                        <c:if test="${not empty param.q}">
                            for "<strong>${param.q}</strong>"
                        </c:if>
                    </p>
                    <div class="btn-group" role="group">
                        <button type="button" class="btn btn-outline-secondary btn-sm active" id="gridView">
                            <i class="fas fa-th"></i>
                        </button>
                        <button type="button" class="btn btn-outline-secondary btn-sm" id="listView">
                            <i class="fas fa-list"></i>
                        </button>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${empty books}">
                        <div class="empty-state">
                            <i class="fas fa-book-open fa-4x mb-3"></i>
                            <h4>No Books Found</h4>
                            <p class="text-muted">Try adjusting your filters or search terms.</p>
                            <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">View All Books</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-4" id="booksGrid">
                            <c:forEach var="book" items="${books}">
                                <div class="col-6 col-md-4">
                                    <div class="card book-card h-100 shadow-sm">
                                        <div class="book-image-container position-relative">
                                            <c:choose>
                                                <c:when test="${not empty book.coverImage}">
                                                    <img src="${pageContext.request.contextPath}/${book.coverImage}" 
                                                         class="book-cover" 
                                                         alt="${book.title}"
                                                         onerror="this.src='https://via.placeholder.com/200x280/8B4513/ffffff?text=📚'">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="https://via.placeholder.com/200x280/8B4513/DAA520?text=${book.title}" 
                                                         class="book-cover" 
                                                         alt="${book.title}">
                                                </c:otherwise>
                                            </c:choose>
                                            <c:if test="${book.bookType == 'OLD'}">
                                                <span class="position-absolute top-0 end-0 m-2 badge bg-warning text-dark">Pre-owned</span>
                                            </c:if>
                                            <c:if test="${book.stockQuantity < 5 && book.stockQuantity > 0}">
                                                <span class="position-absolute bottom-0 start-0 m-2 badge bg-danger">Low Stock</span>
                                            </c:if>
                                        </div>
                                        <div class="card-body d-flex flex-column">
                                            <h6 class="card-title text-truncate-2">${book.title}</h6>
                                            <p class="text-muted small mb-2">${book.author}</p>
                                            <p class="text-muted small mb-2"><i class="fas fa-tag me-1"></i>${book.categoryName}</p>
                                            <div class="mt-auto">
                                                <p class="text-primary fw-bold mb-2">₹<fmt:formatNumber value="${book.price}" pattern="#,##0.00"/></p>
                                                <div class="d-flex gap-2">
                                                    <a href="${pageContext.request.contextPath}/book-details?id=${book.bookId}" class="btn btn-outline-primary btn-sm flex-grow-1">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <c:if test="${book.stockQuantity > 0}">
                                                        <button class="btn btn-primary btn-sm flex-grow-1" onclick="addToCart(${book.bookId})">
                                                            <i class="fas fa-cart-plus"></i>
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${book.stockQuantity <= 0}">
                                                        <button class="btn btn-secondary btn-sm flex-grow-1" disabled>
                                                            <i class="fas fa-times"></i> Out
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <nav class="mt-5">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/books?page=${currentPage - 1}&${queryString}">
                                            <i class="fas fa-chevron-left"></i>
                                        </a>
                                    </li>
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link" href="${pageContext.request.contextPath}/books?page=${i}&${queryString}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/books?page=${currentPage + 1}&${queryString}">
                                            <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer bg-dark text-white py-4 mt-5">
        <div class="container text-center">
            <p class="mb-0">&copy; 2024 Mayur Collection and Bookstore. All Rights Reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        // Auto-submit form on filter change
        document.querySelectorAll('#filterForm input[type="radio"], #filterForm input[type="checkbox"], #filterForm select').forEach(el => {
            el.addEventListener('change', () => {
                document.getElementById('filterForm').submit();
            });
        });
    </script>
</body>
</html>
