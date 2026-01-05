<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mayur Collection and Bookstore - Your Online Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark sticky-top" style="background: linear-gradient(135deg, #5D2E0F 0%, #8B4513 100%); border-bottom: 3px solid #DAA520; padding: 1.2rem 2rem; min-height: 70px;">
        <div class="container-fluid px-4">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home" style="color: #FFF8DC !important; text-shadow: 2px 2px 4px rgba(0,0,0,0.3); font-size: 2rem;">
                <i class="fas fa-book-open me-2" style="color: #DAA520;"></i>Mayur Collection and Bookstore
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto ms-4">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/home" style="font-size: 1.1rem; padding: 0.8rem 1.2rem;">Home</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" style="font-size: 1.1rem; padding: 0.8rem 1.2rem;">Categories</a>
                        <ul class="dropdown-menu">
                            <c:forEach var="category" items="${categories}">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/books?category=${category.categoryId}">${category.categoryName}</a></li>
                            </c:forEach>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/books?type=NEW" style="font-size: 1.1rem; padding: 0.8rem 1.2rem;">New Books</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/books?type=OLD" style="font-size: 1.1rem; padding: 0.8rem 1.2rem;">Old Books</a>
                    </li>
                </ul>
                
                <!-- Search Form -->
                <form class="d-flex me-4" action="${pageContext.request.contextPath}/search" method="get">
                    <div class="input-group">
                        <input class="form-control" type="search" name="q" placeholder="Search books..." aria-label="Search" style="min-width: 250px;">
                        <button class="btn btn-light" type="submit"><i class="fas fa-search"></i></button>
                    </div>
                </form>
                
                <!-- User Menu -->
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${not empty sessionScope.userId}">
                            <li class="nav-item">
                                <a class="nav-link position-relative" href="${pageContext.request.contextPath}/cart" style="font-size: 1.1rem; padding: 0.8rem 1.2rem;">
                                    <i class="fas fa-shopping-cart"></i>
                                    <c:if test="${cartCount > 0}">
                                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger cart-badge">
                                            ${cartCount}
                                        </span>
                                    </c:if>
                                </a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" style="font-size: 1.1rem; padding: 0.8rem 1.2rem;">
                                    <i class="fas fa-user-circle me-1"></i>${sessionScope.userName}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <c:if test="${sessionScope.userRole == 'ADMIN'}">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                    </c:if>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile"><i class="fas fa-user me-2"></i>My Profile</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/my-orders"><i class="fas fa-box me-2"></i>My Orders</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/sell-book"><i class="fas fa-hand-holding-usd me-2"></i>Sell Old Books</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login" style="font-size: 1.1rem; padding: 0.8rem 1.2rem;">
                                    <i class="fas fa-sign-in-alt me-1"></i>Login
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/register" style="font-size: 1.1rem; padding: 0.8rem 1.2rem;">
                                    <i class="fas fa-user-plus me-1"></i>Register
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section text-white py-5" style="background: linear-gradient(135deg, rgba(93, 46, 15, 0.95) 0%, rgba(139, 69, 19, 0.9) 100%), url('https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=1920') center/cover; min-height: 450px;">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-4 fw-bold mb-4" style="text-shadow: 3px 3px 6px rgba(0,0,0,0.4); color: #FFF8DC;">📚 Discover Your Next Great Read</h1>
                    <p class="lead mb-4" style="color: #FFF8DC;">Explore thousands of books across various genres. Buy new books or find great deals on pre-owned titles.</p>
                    <div class="d-flex gap-3">
                        <a href="${pageContext.request.contextPath}/books" class="btn btn-lg" style="background: linear-gradient(135deg, #DAA520, #B8860B); color: white; border: none; border-radius: 25px; padding: 12px 30px; font-weight: 600; box-shadow: 0 4px 15px rgba(218, 165, 32, 0.4);">
                            <i class="fas fa-book me-2"></i>Browse Books
                        </a>
                        <a href="${pageContext.request.contextPath}/sell-book" class="btn btn-lg" style="background: transparent; border: 2px solid #DAA520; color: #DAA520; border-radius: 25px; padding: 12px 30px; font-weight: 600;">
                            <i class="fas fa-hand-holding-usd me-2"></i>Sell Books
                        </a>
                    </div>
                </div>
                <div class="col-lg-6 text-center">
                    <div style="font-size: 12rem; opacity: 0.3;">📖</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features-section py-5" style="background: linear-gradient(135deg, #8B4513 0%, #5D2E0F 100%);">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-card-new text-center p-4 h-100" style="background: linear-gradient(145deg, #FFF8DC, #F5F1E8); border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); transition: all 0.3s ease; cursor: pointer; border: 2px solid #DAA520;"
                         onmouseover="this.style.transform='translateY(-10px) scale(1.03)'; this.style.boxShadow='0 15px 40px rgba(0,0,0,0.3)'"
                         onmouseout="this.style.transform='translateY(0) scale(1)'; this.style.boxShadow='0 10px 30px rgba(0,0,0,0.2)'">
                        <div class="feature-icon mb-3" style="width: 80px; height: 80px; margin: 0 auto; background: linear-gradient(135deg, #8B4513 0%, #DAA520 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; box-shadow: 0 5px 15px rgba(139,69,19,0.4);">
                            <i class="fas fa-shipping-fast fa-2x text-white"></i>
                        </div>
                        <h4 class="fw-bold mb-2" style="color: #8B4513;">Free Delivery</h4>
                        <p class="text-muted mb-0">Fast & free shipping on orders above ₹499</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card-new text-center p-4 h-100" style="background: linear-gradient(145deg, #FFF8DC, #F5F1E8); border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); transition: all 0.3s ease; cursor: pointer; border: 2px solid #DAA520;"
                         onmouseover="this.style.transform='translateY(-10px) scale(1.03)'; this.style.boxShadow='0 15px 40px rgba(0,0,0,0.3)'"
                         onmouseout="this.style.transform='translateY(0) scale(1)'; this.style.boxShadow='0 10px 30px rgba(0,0,0,0.2)'">
                        <div class="feature-icon mb-3" style="width: 80px; height: 80px; margin: 0 auto; background: linear-gradient(135deg, #DAA520 0%, #B8860B 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; box-shadow: 0 5px 15px rgba(218,165,32,0.4);">
                            <i class="fas fa-undo-alt fa-2x text-white"></i>
                        </div>
                        <h4 class="fw-bold mb-2" style="color: #8B4513;">Easy Returns</h4>
                        <p class="text-muted mb-0">Hassle-free 7-day return policy</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card-new text-center p-4 h-100" style="background: linear-gradient(145deg, #FFF8DC, #F5F1E8); border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); transition: all 0.3s ease; cursor: pointer; border: 2px solid #DAA520;"
                         onmouseover="this.style.transform='translateY(-10px) scale(1.03)'; this.style.boxShadow='0 15px 40px rgba(0,0,0,0.3)'"
                         onmouseout="this.style.transform='translateY(0) scale(1)'; this.style.boxShadow='0 10px 30px rgba(0,0,0,0.2)'">
                        <div class="feature-icon mb-3" style="width: 80px; height: 80px; margin: 0 auto; background: linear-gradient(135deg, #5D2E0F 0%, #8B4513 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; box-shadow: 0 5px 15px rgba(93,46,15,0.4);">
                            <i class="fas fa-lock fa-2x text-white"></i>
                        </div>
                        <h4 class="fw-bold mb-2" style="color: #8B4513;">Secure Payment</h4>
                        <p class="text-muted mb-0">100% secure & encrypted checkout</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- New Books Section -->
    <section class="books-section py-5" style="background: url('https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=1920') center/cover fixed; position: relative;">
        <div style="position: absolute; top: 0; left: 0; right: 0; bottom: 0; background: rgba(245, 241, 232, 0.95);"></div>
        <div class="container" style="position: relative; z-index: 1;">
            <div class="section-header d-flex justify-content-between align-items-center mb-4">
                <h2 class="section-title" style="color: #5D2E0F; font-family: Georgia, serif;">
                    <i class="fas fa-star me-2" style="color: #DAA520;"></i>New Arrivals
                </h2>
                <a href="${pageContext.request.contextPath}/books?type=NEW" class="btn" style="background: linear-gradient(135deg, #8B4513, #5D2E0F); color: white; border-radius: 25px; padding: 10px 25px;">View All</a>
            </div>
            <div class="row g-4">
                <c:forEach var="book" items="${newBooks}" begin="0" end="3">
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="card book-card h-100" style="border: 2px solid #D2B48C; background: linear-gradient(145deg, #FFF, #FFF8DC); border-radius: 15px; box-shadow: 0 8px 25px rgba(139,69,19,0.15); transition: all 0.4s ease;" 
                             onmouseover="this.style.transform='translateY(-12px) rotateZ(1deg)'; this.style.boxShadow='0 15px 40px rgba(139,69,19,0.25)'; this.style.borderColor='#DAA520'"
                             onmouseout="this.style.transform='translateY(0) rotateZ(0)'; this.style.boxShadow='0 8px 25px rgba(139,69,19,0.15)'; this.style.borderColor='#D2B48C'">
                            <div class="book-image-container" style="height: 250px; overflow: hidden; display: flex; align-items: center; justify-content: center; background: linear-gradient(135deg, #8B4513 0%, #5D2E0F 100%);">
                                <c:choose>
                                    <c:when test="${not empty book.coverImage}">
                                        <img src="${pageContext.request.contextPath}/${book.coverImage}" class="card-img-top book-cover" alt="${book.title}" style="width: 100%; height: 100%; object-fit: cover;"
                                             onerror="this.style.display='none'; this.parentElement.innerHTML='<div style=\\'color: #FFF8DC; text-align: center; padding: 20px;\\'><i class=\\'fas fa-book fa-4x\\'></i><p style=\\'margin-top: 10px; font-family: Georgia;\\'>'+this.alt+'</p></div>';">
                                    </c:when>
                                    <c:otherwise>
                                        <div style="color: #FFF8DC; text-align: center; padding: 20px;">
                                            <i class="fas fa-book fa-4x"></i>
                                            <p style="margin-top: 10px; font-family: Georgia, serif;">${book.title}</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${book.originalPrice > book.price}">
                                    <span class="badge bg-danger position-absolute top-0 end-0 m-2">${book.discountPercentage}</span>
                                </c:if>
                                <span class="badge bg-success position-absolute top-0 start-0 m-2">NEW</span>
                            </div>
                            <div class="card-body">
                                <h6 class="card-title text-truncate">${book.title}</h6>
                                <p class="card-text text-muted small mb-2">by ${book.author}</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <span class="h5 mb-0" style="color: #8B4513;">₹${book.price}</span>
                                        <c:if test="${book.originalPrice > book.price}">
                                            <small class="text-muted text-decoration-line-through ms-2">₹${book.originalPrice}</small>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer border-0 pt-0" style="background: transparent;">
                                <div class="d-grid gap-2">
                                    <a href="${pageContext.request.contextPath}/book-details?id=${book.bookId}" class="btn btn-sm" style="border: 2px solid #8B4513; color: #8B4513; border-radius: 20px;">View Details</a>
                                    <button class="btn btn-sm add-to-cart-btn" data-book-id="${book.bookId}" style="background: linear-gradient(135deg, #8B4513, #5D2E0F); color: white; border-radius: 20px;">
                                        <i class="fas fa-cart-plus me-1"></i>Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty newBooks}">
                    <div class="col-12 text-center py-5">
                        <i class="fas fa-book-open fa-3x text-muted mb-3"></i>
                        <p class="text-muted">No new books available at the moment.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </section>

    <!-- Old Books Section -->
    <section class="books-section py-5" style="background: linear-gradient(135deg, rgba(93, 46, 15, 0.1) 0%, rgba(218, 165, 32, 0.1) 100%);">
        <div class="container">
            <div class="section-header d-flex justify-content-between align-items-center mb-4">
                <h2 class="section-title" style="color: #5D2E0F; font-family: Georgia, serif;">
                    <i class="fas fa-tags me-2" style="color: #DAA520;"></i>Pre-Owned Books
                </h2>
                <a href="${pageContext.request.contextPath}/books?type=OLD" class="btn" style="background: linear-gradient(135deg, #DAA520, #B8860B); color: white; border-radius: 25px; padding: 10px 25px;">View All</a>
            </div>
            <div class="row g-4">
                <c:forEach var="book" items="${oldBooks}" begin="0" end="3">
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="card book-card h-100" style="border: 2px solid #D2B48C; background: linear-gradient(145deg, #FFF, #FFF8DC); border-radius: 15px; box-shadow: 0 8px 25px rgba(139,69,19,0.15); transition: all 0.4s ease;"
                             onmouseover="this.style.transform='translateY(-12px) rotateZ(1deg)'; this.style.boxShadow='0 15px 40px rgba(139,69,19,0.25)'; this.style.borderColor='#DAA520'"
                             onmouseout="this.style.transform='translateY(0) rotateZ(0)'; this.style.boxShadow='0 8px 25px rgba(139,69,19,0.15)'; this.style.borderColor='#D2B48C'">
                            <div class="book-image-container" style="height: 250px; overflow: hidden; display: flex; align-items: center; justify-content: center; background: linear-gradient(135deg, #DAA520 0%, #B8860B 100%); position: relative;">
                                <c:choose>
                                    <c:when test="${not empty book.coverImage}">
                                        <img src="${pageContext.request.contextPath}/${book.coverImage}" class="card-img-top book-cover" alt="${book.title}" style="width: 100%; height: 100%; object-fit: cover;"
                                             onerror="this.style.display='none'; this.parentElement.innerHTML='<div style=\\'color: white; text-align: center; padding: 20px;\\'><i class=\\'fas fa-book fa-4x\\'></i><p style=\\'margin-top: 10px; font-family: Georgia;\\'>'+this.alt+'</p></div>';">
                                    </c:when>
                                    <c:otherwise>
                                        <div style="color: white; text-align: center; padding: 20px;">
                                            <i class="fas fa-book fa-4x"></i>
                                            <p style="margin-top: 10px; font-family: Georgia, serif;">${book.title}</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <span class="badge position-absolute top-0 start-0 m-2" style="background: linear-gradient(135deg, #5D2E0F, #8B4513); color: white;">PRE-OWNED</span>
                            </div>
                            <div class="card-body">
                                <h6 class="card-title text-truncate" style="color: #5D2E0F; font-family: Georgia, serif;">${book.title}</h6>
                                <p class="card-text text-muted small mb-2">by ${book.author}</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <span class="h5 mb-0" style="color: #8B4513;">₹${book.price}</span>
                                        <c:if test="${book.originalPrice > book.price}">
                                            <small class="text-muted text-decoration-line-through ms-2">₹${book.originalPrice}</small>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer bg-white border-0 pt-0">
                                <div class="d-grid gap-2">
                                    <a href="${pageContext.request.contextPath}/book-details?id=${book.bookId}" class="btn btn-outline-primary btn-sm">View Details</a>
                                    <button class="btn btn-primary btn-sm add-to-cart-btn" data-book-id="${book.bookId}">
                                        <i class="fas fa-cart-plus me-1"></i>Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty oldBooks}">
                    <div class="col-12 text-center py-5">
                        <i class="fas fa-book-open fa-3x text-muted mb-3"></i>
                        <p class="text-muted">No pre-owned books available at the moment.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </section>

    <!-- Sell Books CTA -->
    <section class="cta-section py-5 text-white" style="background: linear-gradient(135deg, rgba(93, 46, 15, 0.95) 0%, rgba(139, 69, 19, 0.9) 100%), url('https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=1920') center/cover;">
        <div class="container text-center">
            <h2 class="mb-3" style="color: #FFF8DC; text-shadow: 2px 2px 4px rgba(0,0,0,0.3);">📚 Have Books You No Longer Need?</h2>
            <p class="lead mb-4" style="color: #FFF8DC;">Sell your old books and earn money. It's easy and quick!</p>
            <a href="${pageContext.request.contextPath}/sell-book" class="btn btn-lg" style="background: linear-gradient(135deg, #DAA520, #B8860B); color: white; border: none; border-radius: 30px; padding: 15px 40px; font-weight: 600; font-size: 1.2rem; box-shadow: 0 5px 20px rgba(218,165,32,0.4);">
                <i class="fas fa-hand-holding-usd me-2"></i>Start Selling
            </a>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer py-5" style="background: linear-gradient(135deg, #2C1810 0%, #1a1a1a 100%); border-top: 4px solid #DAA520;">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4">
                    <h5 class="mb-3" style="color: #DAA520;"><i class="fas fa-book-open me-2"></i>Mayur Collection and Bookstore</h5>
                    <p class="text-muted">Your one-stop destination for all your reading needs. Buy new books, find great deals on pre-owned titles, or sell your old books.</p>
                </div>
                <div class="col-lg-2">
                    <h6 class="mb-3" style="color: #DAA520;">Quick Links</h6>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}/home" class="text-muted text-decoration-none">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/books" class="text-muted text-decoration-none">All Books</a></li>
                        <li><a href="${pageContext.request.contextPath}/books?type=NEW" class="text-muted text-decoration-none">New Books</a></li>
                        <li><a href="${pageContext.request.contextPath}/books?type=OLD" class="text-muted text-decoration-none">Old Books</a></li>
                    </ul>
                </div>
                <div class="col-lg-2">
                    <h6 class="mb-3" style="color: #DAA520;">My Account</h6>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}/profile" class="text-muted text-decoration-none">Profile</a></li>
                        <li><a href="${pageContext.request.contextPath}/my-orders" class="text-muted text-decoration-none">Orders</a></li>
                        <li><a href="${pageContext.request.contextPath}/cart" class="text-muted text-decoration-none">Cart</a></li>
                        <li><a href="${pageContext.request.contextPath}/sell-book" class="text-muted text-decoration-none">Sell Books</a></li>
                    </ul>
                </div>
                <div class="col-lg-4">
                    <h6 class="mb-3" style="color: #DAA520;">Contact Us</h6>
                    <ul class="list-unstyled text-muted">
                        <li><i class="fas fa-map-marker-alt me-2" style="color: #DAA520;"></i>123 Book Street, Reading City</li>
                        <li><i class="fas fa-phone me-2" style="color: #DAA520;"></i>+91 9876543210</li>
                        <li><i class="fas fa-envelope me-2"></i>support@ebookstore.com</li>
                    </ul>
                    <div class="social-links mt-3">
                        <a href="#" class="text-white me-3"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="text-white"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
            <hr class="my-4">
            <div class="text-center text-muted">
                <p class="mb-0">&copy; 2026 Mayur Collection and Bookstore. All rights reserved. | College Project</p>
            </div>
        </div>
    </footer>

    <!-- Toast Notification -->
    <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
        <div id="cartToast" class="toast" role="alert">
            <div class="toast-header bg-success text-white">
                <i class="fas fa-check-circle me-2"></i>
                <strong class="me-auto">Success</strong>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
            </div>
            <div class="toast-body" id="toastMessage">
                Item added to cart!
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        // Add to cart functionality
        document.querySelectorAll('.add-to-cart-btn').forEach(button => {
            button.addEventListener('click', function() {
                const bookId = this.dataset.bookId;
                
                fetch('${pageContext.request.contextPath}/cart/add', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    body: 'bookId=' + bookId + '&quantity=1'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.redirect) {
                        window.location.href = data.redirect;
                        return;
                    }
                    
                    const toast = new bootstrap.Toast(document.getElementById('cartToast'));
                    document.getElementById('toastMessage').textContent = data.message;
                    
                    if (data.success) {
                        document.querySelector('.toast-header').className = 'toast-header bg-success text-white';
                        // Update cart badge
                        const badge = document.querySelector('.cart-badge');
                        if (badge) {
                            badge.textContent = data.cartCount;
                        }
                    } else {
                        document.querySelector('.toast-header').className = 'toast-header bg-danger text-white';
                    }
                    
                    toast.show();
                })
                .catch(error => {
                    console.error('Error:', error);
                });
            });
        });
    </script>
</body>
</html>
