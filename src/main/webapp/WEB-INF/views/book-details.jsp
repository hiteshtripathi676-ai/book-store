<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="context-path" content="${pageContext.request.contextPath}">
    <title>${book.title} - Mayur Collection and Bookstore</title>
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
        .nav-link:hover { color: var(--golden) !important; }
        
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
        
        /* Breadcrumb */
        .breadcrumb-section {
            background: linear-gradient(135deg, var(--cream) 0%, #F5E6D3 100%);
            padding: 1rem 0;
            border-bottom: 2px solid #E8D5B5;
        }
        
        .breadcrumb-item a {
            color: var(--primary-brown);
            text-decoration: none;
        }
        
        .breadcrumb-item a:hover { color: var(--golden); }
        .breadcrumb-item.active { color: var(--dark-brown); font-weight: 600; }
        
        /* Book Image */
        .book-image-wrapper {
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border-radius: 20px;
            padding: 1.5rem;
            box-shadow: 0 15px 50px rgba(93, 46, 15, 0.15);
        }
        
        .book-detail-image {
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        
        .badge.bg-warning {
            background: linear-gradient(135deg, var(--golden) 0%, #C4941A 100%) !important;
            color: var(--dark-brown) !important;
        }
        
        /* Book Info */
        .book-title {
            font-family: 'Playfair Display', serif;
            color: var(--dark-brown);
            font-weight: 700;
            font-size: 2.5rem;
        }
        
        .book-author {
            color: #8B7355;
            font-size: 1.1rem;
        }
        
        .rating-stars i {
            color: var(--golden);
            font-size: 1.1rem;
        }
        
        .book-price {
            font-family: 'Playfair Display', serif;
            color: var(--golden) !important;
        }
        
        .meta-card {
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 5px 20px rgba(93, 46, 15, 0.08);
        }
        
        .meta-card small { color: #8B7355; }
        .meta-card strong { color: var(--dark-brown); }
        
        /* Quantity Controls */
        .qty-controls {
            background: var(--light-cream);
            border-radius: 12px;
            padding: 0.5rem;
            display: inline-flex;
            align-items: center;
            border: 2px solid #E8D5B5;
        }
        
        .qty-btn {
            background: var(--cream);
            border: none;
            color: var(--primary-brown);
            width: 40px;
            height: 40px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .qty-btn:hover {
            background: var(--golden);
            color: var(--dark-brown);
        }
        
        .qty-input {
            width: 60px;
            text-align: center;
            border: none;
            background: transparent;
            font-weight: 600;
            color: var(--dark-brown);
        }
        
        /* Buttons */
        .btn-primary {
            background: linear-gradient(135deg, var(--golden) 0%, #C4941A 100%);
            border: none;
            color: var(--dark-brown);
            font-weight: 600;
            border-radius: 12px;
            padding: 1rem 2rem;
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
            font-weight: 600;
            border-radius: 12px;
            padding: 1rem 2rem;
        }
        
        .btn-outline-primary:hover {
            background: var(--golden);
            border-color: var(--golden);
            color: var(--dark-brown);
        }
        
        /* Features */
        .feature-box {
            background: linear-gradient(135deg, var(--primary-brown) 0%, var(--dark-brown) 100%);
            border-radius: 12px;
            padding: 1.5rem;
            text-align: center;
            transition: all 0.3s ease;
        }
        
        .feature-box:hover { transform: translateY(-5px); }
        .feature-box i { color: var(--golden); }
        .feature-box .small { color: var(--cream); }
        
        /* Tabs */
        .detail-card {
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(93, 46, 15, 0.1);
            overflow: hidden;
        }
        
        .detail-card .card-header {
            background: linear-gradient(135deg, var(--cream) 0%, #F5E6D3 100%);
            border-bottom: 2px solid #E8D5B5;
        }
        
        .nav-tabs .nav-link {
            color: var(--primary-brown);
            border: none;
            font-weight: 600;
            padding: 1rem 1.5rem;
        }
        
        .nav-tabs .nav-link.active {
            color: var(--golden);
            background: transparent;
            border-bottom: 3px solid var(--golden);
        }
        
        .nav-tabs .nav-link:hover {
            border-color: transparent;
            color: var(--golden);
        }
        
        .table th { color: var(--dark-brown); background: var(--cream); }
        .table td { color: #5D4E37; }
        
        /* Related Books */
        .section-title {
            font-family: 'Playfair Display', serif;
            color: var(--dark-brown);
            font-weight: 700;
            position: relative;
            display: inline-block;
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 0;
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, var(--golden), transparent);
        }
        
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
            height: 200px;
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
        }
        
        .book-card .card-title {
            font-family: 'Playfair Display', serif;
            font-weight: 600;
            color: var(--dark-brown);
        }
        
        .book-card .text-primary {
            color: var(--golden) !important;
        }
        
        /* Footer */
        .footer {
            background: linear-gradient(135deg, var(--dark-brown) 0%, var(--primary-brown) 100%) !important;
            color: var(--cream);
        }
        
        /* Alert */
        .alert-warning {
            background: linear-gradient(135deg, #FFF3CD 0%, #FFE69C 100%);
            border: 2px solid var(--golden);
            border-radius: 12px;
            color: var(--dark-brown);
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/books">Books</a>
                    </li>
                </ul>
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

    <!-- Breadcrumb -->
    <nav class="breadcrumb-section">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/books">Books</a></li>
                    <li class="breadcrumb-item active" aria-current="page">${book.title}</li>
                </ol>
            </nav>
        </div>
    </nav>

    <!-- Book Details -->
    <div class="container py-5">
        <div class="row">
            <!-- Book Image -->
            <div class="col-lg-5 mb-4">
                <div class="book-image-wrapper position-relative">
                    <c:choose>
                        <c:when test="${not empty book.coverImage}">
                            <c:choose>
                                <c:when test="${book.coverImage.startsWith('http')}">
                                    <img src="${book.coverImage}" 
                                         alt="${book.title}" 
                                         class="img-fluid rounded book-detail-image w-100"
                                         onerror="this.src='https://via.placeholder.com/400x560/8B4513/ffffff?text=📚'">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/${book.coverImage}" 
                                         alt="${book.title}" 
                                         class="img-fluid rounded book-detail-image w-100"
                                         onerror="this.src='https://via.placeholder.com/400x560/8B4513/ffffff?text=📚'">
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <img src="https://via.placeholder.com/400x560/8B4513/DAA520?text=${book.title}" 
                                 alt="${book.title}" 
                                 class="img-fluid rounded book-detail-image w-100">
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${book.bookType == 'OLD'}">
                        <span class="position-absolute top-0 start-0 m-3 badge bg-warning fs-6">
                            <i class="fas fa-history me-1"></i>Pre-owned
                        </span>
                    </c:if>
                    <c:if test="${book.stockQuantity < 5 && book.stockQuantity > 0}">
                        <span class="position-absolute top-0 end-0 m-3 badge bg-danger">
                            Only ${book.stockQuantity} left!
                        </span>
                    </c:if>
                </div>
            </div>

            <!-- Book Info -->
            <div class="col-lg-7">
                <h1 class="book-title mb-2">${book.title}</h1>
                <p class="book-author mb-3">
                    <i class="fas fa-user-edit me-1"></i>by <strong>${book.author}</strong>
                </p>

                <!-- Rating -->
                <div class="rating-stars mb-3">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                    <span class="text-muted ms-2">(4.5/5 based on 128 reviews)</span>
                </div>

                <!-- Price -->
                <div class="mb-4">
                    <c:if test="${book.bookType == 'OLD' && book.originalPrice != null}">
                        <span class="text-muted text-decoration-line-through fs-5">₹<fmt:formatNumber value="${book.originalPrice}" pattern="#,##0.00"/></span>
                    </c:if>
                    <span class="book-price fs-2 fw-bold ms-2">₹<fmt:formatNumber value="${book.price}" pattern="#,##0.00"/></span>
                    <c:if test="${book.bookType == 'OLD' && book.originalPrice != null}">
                        <c:set var="discount" value="${((book.originalPrice - book.price) / book.originalPrice) * 100}"/>
                        <span class="badge bg-success fs-6 ms-2">${Math.round(discount)}% OFF</span>
                    </c:if>
                </div>

                <!-- Book Meta -->
                <div class="meta-card mb-4">
                    <div class="row">
                        <div class="col-6 col-md-4 mb-3">
                            <small class="d-block">Category</small>
                            <strong>${book.categoryName}</strong>
                        </div>
                        <div class="col-6 col-md-4 mb-3">
                            <small class="d-block">Type</small>
                            <strong>
                                <c:choose>
                                    <c:when test="${book.bookType == 'NEW'}">
                                        <i class="fas fa-certificate text-success me-1"></i>Brand New
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-history text-warning me-1"></i>Pre-owned
                                    </c:otherwise>
                                </c:choose>
                            </strong>
                        </div>
                        <div class="col-6 col-md-4 mb-3">
                            <small class="d-block">Availability</small>
                            <c:choose>
                                <c:when test="${book.stockQuantity > 0}">
                                    <strong class="text-success"><i class="fas fa-check-circle me-1"></i>In Stock</strong>
                                </c:when>
                                <c:otherwise>
                                    <strong class="text-danger"><i class="fas fa-times-circle me-1"></i>Out of Stock</strong>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <c:if test="${not empty book.isbn}">
                            <div class="col-6 col-md-4 mb-3">
                                <small class="d-block">ISBN</small>
                                <strong>${book.isbn}</strong>
                            </div>
                        </c:if>
                        <c:if test="${not empty book.publisher}">
                            <div class="col-6 col-md-4 mb-3">
                                <small class="d-block">Publisher</small>
                                <strong>${book.publisher}</strong>
                            </div>
                        </c:if>
                        <c:if test="${not empty book.publicationYear}">
                            <div class="col-6 col-md-4 mb-3">
                                <small class="d-block">Year</small>
                                <strong>${book.publicationYear}</strong>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Quantity and Add to Cart -->
                <c:if test="${book.stockQuantity > 0}">
                    <div class="d-flex align-items-center mb-4">
                        <label class="me-3 fw-bold" style="color: var(--dark-brown);">Quantity:</label>
                        <div class="qty-controls">
                            <button class="qty-btn qty-btn-minus" type="button">
                                <i class="fas fa-minus"></i>
                            </button>
                            <input type="number" id="quantity" class="qty-input" value="1" min="1" max="${book.stockQuantity}">
                            <button class="qty-btn qty-btn-plus" type="button">
                                <i class="fas fa-plus"></i>
                            </button>
                        </div>
                    </div>

                    <div class="d-flex gap-3 flex-wrap">
                        <button class="btn btn-primary btn-lg" onclick="addToCart(${book.bookId}, document.getElementById('quantity').value)">
                            <i class="fas fa-cart-plus me-2"></i>Add to Cart
                        </button>
                        <button class="btn btn-outline-primary btn-lg" onclick="addToCart(${book.bookId}, document.getElementById('quantity').value); window.location='${pageContext.request.contextPath}/cart'">
                            <i class="fas fa-bolt me-2"></i>Buy Now
                        </button>
                    </div>
                </c:if>

                <!-- Out of Stock Message -->
                <c:if test="${book.stockQuantity <= 0}">
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        This book is currently out of stock. Please check back later.
                    </div>
                </c:if>

                <!-- Features -->
                <div class="mt-4 pt-4 border-top">
                    <div class="row g-3">
                        <div class="col-4 text-center">
                            <div class="feature-box">
                                <i class="fas fa-shipping-fast fa-2x mb-2"></i>
                                <div class="small fw-bold">Free Delivery</div>
                            </div>
                        </div>
                        <div class="col-4 text-center">
                            <div class="feature-box">
                                <i class="fas fa-undo-alt fa-2x mb-2"></i>
                                <div class="small fw-bold">Easy Returns</div>
                            </div>
                        </div>
                        <div class="col-4 text-center">
                            <div class="feature-box">
                                <i class="fas fa-lock fa-2x mb-2"></i>
                                <div class="small fw-bold">Secure Payment</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Description -->
        <div class="row mt-5">
            <div class="col-12">
                <div class="card detail-card">
                    <div class="card-header">
                        <ul class="nav nav-tabs card-header-tabs" id="bookTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="description-tab" data-bs-toggle="tab" data-bs-target="#description" type="button" role="tab">
                                    Description
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="details-tab" data-bs-toggle="tab" data-bs-target="#details" type="button" role="tab">
                                    Details
                                </button>
                            </li>
                        </ul>
                    </div>
                    <div class="card-body p-4">
                        <div class="tab-content" id="bookTabsContent">
                            <div class="tab-pane fade show active" id="description" role="tabpanel">
                                <c:choose>
                                    <c:when test="${not empty book.description}">
                                        <p>${book.description}</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-muted">No description available for this book.</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="tab-pane fade" id="details" role="tabpanel">
                                <table class="table table-striped">
                                    <tbody>
                                        <tr>
                                            <th style="width: 200px;">Title</th>
                                            <td>${book.title}</td>
                                        </tr>
                                        <tr>
                                            <th>Author</th>
                                            <td>${book.author}</td>
                                        </tr>
                                        <c:if test="${not empty book.isbn}">
                                            <tr>
                                                <th>ISBN</th>
                                                <td>${book.isbn}</td>
                                            </tr>
                                        </c:if>
                                        <c:if test="${not empty book.publisher}">
                                            <tr>
                                                <th>Publisher</th>
                                                <td>${book.publisher}</td>
                                            </tr>
                                        </c:if>
                                        <c:if test="${not empty book.publicationYear}">
                                            <tr>
                                                <th>Publication Year</th>
                                                <td>${book.publicationYear}</td>
                                            </tr>
                                        </c:if>
                                        <tr>
                                            <th>Category</th>
                                            <td>${book.categoryName}</td>
                                        </tr>
                                        <tr>
                                            <th>Condition</th>
                                            <td>${book.bookType == 'NEW' ? 'Brand New' : 'Pre-owned'}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Related Books -->
        <c:if test="${not empty relatedBooks}">
            <div class="mt-5">
                <h3 class="section-title mb-4">Related Books</h3>
                <div class="row g-4">
                    <c:forEach var="relBook" items="${relatedBooks}" end="3">
                        <div class="col-6 col-md-3">
                            <div class="card book-card h-100 shadow-sm">
                                <div class="book-image-container">
                                    <c:choose>
                                        <c:when test="${not empty relBook.coverImage}">
                                            <c:choose>
                                                <c:when test="${relBook.coverImage.startsWith('http')}">
                                                    <img src="${relBook.coverImage}" 
                                                         class="book-cover" 
                                                         alt="${relBook.title}"
                                                         onerror="this.src='https://via.placeholder.com/200x280/8B4513/ffffff?text=📚'">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/${relBook.coverImage}" 
                                                         class="book-cover" 
                                                         alt="${relBook.title}"
                                                         onerror="this.src='https://via.placeholder.com/200x280/8B4513/ffffff?text=📚'">
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <img src="https://via.placeholder.com/200x280/8B4513/DAA520?text=${relBook.title}" 
                                                 class="book-cover" 
                                                 alt="${relBook.title}">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="card-body">
                                    <h6 class="card-title text-truncate">${relBook.title}</h6>
                                    <p class="text-muted small mb-2">${relBook.author}</p>
                                    <p class="text-primary fw-bold mb-2">₹<fmt:formatNumber value="${relBook.price}" pattern="#,##0.00"/></p>
                                    <a href="${pageContext.request.contextPath}/book-details?id=${relBook.bookId}" class="btn btn-outline-primary btn-sm w-100">View Details</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>
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
        // Quantity controls
        document.addEventListener('DOMContentLoaded', function() {
            const qtyInput = document.getElementById('quantity');
            const btnMinus = document.querySelector('.qty-btn-minus');
            const btnPlus = document.querySelector('.qty-btn-plus');
            
            if (btnMinus) {
                btnMinus.addEventListener('click', function() {
                    const currentValue = parseInt(qtyInput.value);
                    if (currentValue > 1) {
                        qtyInput.value = currentValue - 1;
                    }
                });
            }
            
            if (btnPlus) {
                btnPlus.addEventListener('click', function() {
                    const currentValue = parseInt(qtyInput.value);
                    const maxValue = parseInt(qtyInput.max);
                    if (currentValue < maxValue) {
                        qtyInput.value = currentValue + 1;
                    }
                });
            }
        });
    </script>
</body>
</html>
