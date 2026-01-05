<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="context-path" content="${pageContext.request.contextPath}">
    <title>Sell Your Books - Mayur Collection and Bookstore</title>
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
        h1, h2, h3, h4, h5, h6 { font-family: 'Playfair Display', serif; }
        
        body { background: linear-gradient(135deg, #f5f1e8 0%, #e8dcc8 100%); min-height: 100vh; }
        
        .navbar-book {
            background: linear-gradient(135deg, var(--dark-brown) 0%, var(--primary-brown) 100%) !important;
            box-shadow: 0 4px 20px rgba(93, 46, 15, 0.3);
            padding: 1.2rem 2rem;
            min-height: 70px;
        }
        
        .navbar-book .navbar-brand { color: var(--golden) !important; font-family: 'Playfair Display', serif; font-weight: 700; font-size: 2rem; }
        .navbar-book .nav-link { color: rgba(255,255,255,0.9) !important; font-size: 1.1rem; padding: 0.8rem 1.2rem !important; }
        .navbar-book .nav-link:hover { color: var(--golden) !important; }
        
        .page-header {
            background: linear-gradient(135deg, var(--primary-brown) 0%, var(--dark-brown) 100%);
        }
        
        .sell-card {
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(93, 46, 15, 0.1);
            overflow: hidden;
        }
        
        .sell-card .card-header {
            background: linear-gradient(135deg, var(--cream) 0%, #F5E6D3 100%);
            border-bottom: 2px solid #E8D5B5;
            padding: 1rem 1.5rem;
        }
        
        .sell-card .card-header h5 {
            color: var(--dark-brown);
            font-weight: 600;
            margin: 0;
        }
        
        .sell-card .card-header i { color: var(--golden); }
        
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
        
        .form-control:focus, .form-select:focus {
            border-color: var(--golden);
            box-shadow: 0 0 0 3px rgba(218, 165, 32, 0.15);
        }
        
        .form-label { color: var(--dark-brown); font-weight: 500; }
        
        .step-number {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, var(--golden) 0%, #B8860B 100%);
            color: var(--dark-brown);
            font-weight: 700;
        }
        
        .footer-book { background: linear-gradient(135deg, var(--dark-brown) 0%, #3D1E0A 100%); }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-book sticky-top">
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
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="profileDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle me-1"></i> ${sessionScope.user.fullName}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile"><i class="fas fa-user me-2"></i>My Profile</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/my-orders"><i class="fas fa-box me-2"></i>My Orders</a></li>
                            <li><a class="dropdown-item active" href="${pageContext.request.contextPath}/sell-book"><i class="fas fa-book me-2"></i>Sell Books</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <section class="page-header text-white py-4">
        <div class="container">
            <h2><i class="fas fa-hand-holding-usd me-2"></i>Sell Your Old Books</h2>
            <p class="mb-0">Turn your old books into cash! Submit your books for review and get paid.</p>
        </div>
    </section>

    <!-- Content -->
    <div class="container py-5">
        <div class="row">
            <!-- Sell Book Form -->
            <div class="col-lg-8">
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="card sell-card mb-4">
                    <div class="card-header">
                        <h5><i class="fas fa-plus-circle me-2"></i>Submit Book for Sale</h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/sell-book" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="title" class="form-label">Book Title *</label>
                                    <input type="text" class="form-control" id="title" name="title" required>
                                    <div class="invalid-feedback">Please enter the book title.</div>
                                </div>
                                <div class="col-md-6">
                                    <label for="author" class="form-label">Author *</label>
                                    <input type="text" class="form-control" id="author" name="author" required>
                                    <div class="invalid-feedback">Please enter the author name.</div>
                                </div>
                                <div class="col-md-6">
                                    <label for="isbn" class="form-label">ISBN (if available)</label>
                                    <input type="text" class="form-control" id="isbn" name="isbn" placeholder="e.g., 978-3-16-148410-0">
                                </div>
                                <div class="col-md-6">
                                    <label for="category" class="form-label">Category *</label>
                                    <select class="form-select" id="category" name="categoryId" required>
                                        <option value="">Select Category</option>
                                        <c:forEach var="cat" items="${categories}">
                                            <option value="${cat.categoryId}">${cat.categoryName}</option>
                                        </c:forEach>
                                    </select>
                                    <div class="invalid-feedback">Please select a category.</div>
                                </div>
                                <div class="col-md-4">
                                    <label for="originalPrice" class="form-label">Original Price (₹) *</label>
                                    <input type="number" class="form-control" id="originalPrice" name="originalPrice" min="1" step="0.01" required>
                                    <div class="invalid-feedback">Please enter the original price.</div>
                                </div>
                                <div class="col-md-4">
                                    <label for="expectedPrice" class="form-label">Expected Price (₹) *</label>
                                    <input type="number" class="form-control" id="expectedPrice" name="expectedPrice" min="1" step="0.01" required>
                                    <div class="invalid-feedback">Please enter your expected price.</div>
                                </div>
                                <div class="col-md-4">
                                    <label for="condition" class="form-label">Condition *</label>
                                    <select class="form-select" id="condition" name="condition" required>
                                        <option value="">Select Condition</option>
                                        <option value="LIKE_NEW">Like New</option>
                                        <option value="GOOD">Good</option>
                                        <option value="FAIR">Fair</option>
                                        <option value="ACCEPTABLE">Acceptable</option>
                                    </select>
                                    <div class="invalid-feedback">Please select the condition.</div>
                                </div>
                                <div class="col-12">
                                    <label for="description" class="form-label">Description *</label>
                                    <textarea class="form-control" id="description" name="description" rows="4" required
                                              placeholder="Describe the book condition, any highlights/notes, etc."></textarea>
                                    <div class="invalid-feedback">Please provide a description.</div>
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Book Images (Optional)</label>
                                    <input type="file" class="form-control" id="images" name="images" accept="image/*" multiple>
                                    <small class="text-muted">Upload clear images of the book cover and pages. Max 3 images.</small>
                                </div>
                                <div class="col-12">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-paper-plane me-2"></i>Submit for Review
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- My Sell Requests -->
                <div class="card shadow-sm">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="fas fa-history me-2"></i>My Sell Requests</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty sellRequests}">
                                <div class="text-center py-4">
                                    <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                                    <p class="text-muted mb-0">No sell requests yet. Submit a book above!</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Book</th>
                                                <th>Expected Price</th>
                                                <th>Status</th>
                                                <th>Submitted</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="request" items="${sellRequests}">
                                                <tr>
                                                    <td>
                                                        <strong>${request.bookTitle}</strong><br>
                                                        <small class="text-muted">by ${request.bookAuthor}</small>
                                                    </td>
                                                    <td>₹<fmt:formatNumber value="${request.expectedPrice}" pattern="#,##0.00"/></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${request.status == 'PENDING'}">
                                                                <span class="badge bg-warning text-dark">Pending Review</span>
                                                            </c:when>
                                                            <c:when test="${request.status == 'APPROVED'}">
                                                                <span class="badge bg-success">Approved</span>
                                                            </c:when>
                                                            <c:when test="${request.status == 'REJECTED'}">
                                                                <span class="badge bg-danger">Rejected</span>
                                                            </c:when>
                                                            <c:when test="${request.status == 'COMPLETED'}">
                                                                <span class="badge bg-primary">Completed</span>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                    <td><fmt:formatDate value="${request.createdAt}" pattern="dd MMM yyyy"/></td>
                                                    <td>
                                                        <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#requestModal${request.requestId}">
                                                            <i class="fas fa-eye"></i>
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

            <!-- Sidebar -->
            <div class="col-lg-4">
                <!-- How It Works -->
                <div class="card sell-card mb-4">
                    <div class="card-header">
                        <h5><i class="fas fa-question-circle me-2"></i>How It Works</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-flex mb-3">
                            <div class="bg-primary text-white rounded-circle p-2 me-3" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;">
                                <span class="fw-bold">1</span>
                            </div>
                            <div>
                                <h6 class="mb-1">Submit Book Details</h6>
                                <small class="text-muted">Fill out the form with your book information</small>
                            </div>
                        </div>
                        <div class="d-flex mb-3">
                            <div class="bg-primary text-white rounded-circle p-2 me-3" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;">
                                <span class="fw-bold">2</span>
                            </div>
                            <div>
                                <h6 class="mb-1">Wait for Review</h6>
                                <small class="text-muted">Our team reviews your submission</small>
                            </div>
                        </div>
                        <div class="d-flex mb-3">
                            <div class="bg-primary text-white rounded-circle p-2 me-3" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;">
                                <span class="fw-bold">3</span>
                            </div>
                            <div>
                                <h6 class="mb-1">Get Approved</h6>
                                <small class="text-muted">Receive approval with final price offer</small>
                            </div>
                        </div>
                        <div class="d-flex">
                            <div class="bg-success text-white rounded-circle p-2 me-3" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;">
                                <span class="fw-bold">4</span>
                            </div>
                            <div>
                                <h6 class="mb-1">Get Paid!</h6>
                                <small class="text-muted">Ship the book and receive payment</small>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tips -->
                <div class="card sell-card">
                    <div class="card-header">
                        <h5><i class="fas fa-lightbulb me-2"></i>Tips for Selling</h5>
                    </div>
                    <div class="card-body">
                        <ul class="list-unstyled mb-0">
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Take clear photos of your book</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Be honest about the condition</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Set a reasonable price</li>
                            <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Include ISBN for faster processing</li>
                            <li><i class="fas fa-check text-success me-2"></i>Describe any defects clearly</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer-book text-white py-4 mt-5">
        <div class="container text-center">
            <p class="mb-0">&copy; 2024 Mayur Collection and Bookstore. All Rights Reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
