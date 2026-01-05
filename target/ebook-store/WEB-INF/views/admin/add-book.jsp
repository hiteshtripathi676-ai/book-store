<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Book - Admin</title>
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
        h1, h2, h3, h4, h5, h6, .card-title { font-family: 'Playfair Display', serif; }
        
        .admin-card {
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(93, 46, 15, 0.1);
            overflow: hidden;
        }
        
        .admin-card .card-header {
            background: linear-gradient(135deg, var(--primary-brown) 0%, var(--dark-brown) 100%);
            border: none;
            padding: 1.25rem 1.5rem;
        }
        
        .admin-card .card-header h5 {
            color: #fff;
            font-weight: 600;
            margin: 0;
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
        
        .form-control:focus, .form-select:focus {
            border-color: var(--golden);
            box-shadow: 0 0 0 3px rgba(218, 165, 32, 0.15);
        }
        
        .form-label { color: var(--dark-brown); font-weight: 500; }
        
        .breadcrumb-item a { color: var(--primary-brown); }
        .breadcrumb-item a:hover { color: var(--golden); }
        .breadcrumb-item.active { color: #8B7355; }
        
        .section-title {
            color: var(--dark-brown);
            font-weight: 600;
            border-bottom: 2px solid var(--golden);
            padding-bottom: 0.5rem;
            margin-bottom: 1rem;
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
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/books">Books</a></li>
                        <li class="breadcrumb-item active">Add New Book</li>
                    </ol>
                </nav>

                <div class="card admin-card">
                    <div class="card-header">
                        <h5><i class="fas fa-plus me-2"></i>Add New Book</h5>
                    </div>
                    <div class="card-body">
                        <!-- Error Message -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/admin/add-book" method="post" enctype="multipart/form-data">
                            <div class="row">
                                <!-- Basic Information -->
                                <div class="col-md-8">
                                    <h6 class="section-title"><i class="fas fa-info-circle me-2"></i>Basic Information</h6>
                                    
                                    <div class="row g-3">
                                        <div class="col-12">
                                            <label for="title" class="form-label">Book Title <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" id="title" name="title" required>
                                        </div>
                                        
                                        <div class="col-md-6">
                                            <label for="author" class="form-label">Author <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" id="author" name="author" required>
                                        </div>
                                        
                                        <div class="col-md-6">
                                            <label for="isbn" class="form-label">ISBN</label>
                                            <input type="text" class="form-control" id="isbn" name="isbn">
                                        </div>
                                        
                                        <div class="col-12">
                                            <label for="description" class="form-label">Description</label>
                                            <textarea class="form-control" id="description" name="description" rows="4"></textarea>
                                        </div>
                                        
                                        <div class="col-md-6">
                                            <label for="categoryId" class="form-label">Category <span class="text-danger">*</span></label>
                                            <select class="form-select" id="categoryId" name="categoryId" required>
                                                <option value="">Select Category</option>
                                                <c:forEach var="category" items="${categories}">
                                                    <option value="${category.categoryId}">${category.categoryName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        
                                        <div class="col-md-6">
                                            <label for="bookType" class="form-label">Book Type <span class="text-danger">*</span></label>
                                            <select class="form-select" id="bookType" name="bookType" required>
                                                <option value="NEW">New Book</option>
                                                <option value="OLD">Pre-Owned / Old Book</option>
                                            </select>
                                        </div>
                                        
                                        <div class="col-md-6">
                                            <label for="publisher" class="form-label">Publisher</label>
                                            <input type="text" class="form-control" id="publisher" name="publisher">
                                        </div>
                                        
                                        <div class="col-md-3">
                                            <label for="publicationYear" class="form-label">Publication Year</label>
                                            <input type="number" class="form-control" id="publicationYear" name="publicationYear" 
                                                   min="1900" max="2030">
                                        </div>
                                        
                                        <div class="col-md-3">
                                            <label for="pages" class="form-label">Pages</label>
                                            <input type="number" class="form-control" id="pages" name="pages" min="1">
                                        </div>
                                        
                                        <div class="col-md-6">
                                            <label for="language" class="form-label">Language</label>
                                            <select class="form-select" id="language" name="language">
                                                <option value="English" selected>English</option>
                                                <option value="Hindi">Hindi</option>
                                                <option value="Tamil">Tamil</option>
                                                <option value="Telugu">Telugu</option>
                                                <option value="Kannada">Kannada</option>
                                                <option value="Malayalam">Malayalam</option>
                                                <option value="Bengali">Bengali</option>
                                                <option value="Marathi">Marathi</option>
                                                <option value="Gujarati">Gujarati</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <!-- Cover Image & Pricing -->
                                <div class="col-md-4">
                                    <h6 class="text-muted mb-3"><i class="fas fa-image me-2"></i>Cover Image</h6>
                                    
                                    <div class="mb-3">
                                        <div class="card">
                                            <div class="card-body text-center">
                                                <img id="imagePreview" src="https://via.placeholder.com/200x280?text=Book+Cover" 
                                                     class="img-fluid mb-3" style="max-height: 200px;">
                                                <input type="file" class="form-control" id="coverImage" name="coverImage" 
                                                       accept="image/*" onchange="previewImage(this)">
                                                <small class="text-muted">Max size: 10MB. Formats: JPG, PNG, GIF</small>
                                            </div>
                                        </div>
                                    </div>

                                    <h6 class="text-muted mb-3 mt-4"><i class="fas fa-rupee-sign me-2"></i>Pricing & Stock</h6>
                                    
                                    <div class="mb-3">
                                        <label for="price" class="form-label">Selling Price (₹) <span class="text-danger">*</span></label>
                                        <input type="number" class="form-control" id="price" name="price" 
                                               step="0.01" min="0" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="originalPrice" class="form-label">Original Price (₹)</label>
                                        <input type="number" class="form-control" id="originalPrice" name="originalPrice" 
                                               step="0.01" min="0">
                                        <small class="text-muted">For showing discount</small>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="stockQuantity" class="form-label">Stock Quantity <span class="text-danger">*</span></label>
                                        <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" 
                                               min="0" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="lowStockThreshold" class="form-label">Low Stock Alert Threshold</label>
                                        <input type="number" class="form-control" id="lowStockThreshold" name="lowStockThreshold" 
                                               min="1" value="5">
                                        <small class="text-muted">Alert when stock falls below this</small>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label class="form-label">Payment Options</label>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="codAvailable" name="codAvailable" 
                                                   value="true" checked>
                                            <label class="form-check-label" for="codAvailable">
                                                <i class="fas fa-money-bill-wave text-success me-1"></i>
                                                Allow Cash on Delivery
                                            </label>
                                        </div>
                                        <small class="text-muted">Uncheck to disable COD for this book</small>
                                    </div>
                                </div>
                            </div>

                            <hr class="my-4">

                            <div class="d-flex justify-content-end gap-2">
                                <a href="${pageContext.request.contextPath}/admin/books" class="btn btn-secondary">
                                    <i class="fas fa-times me-2"></i>Cancel
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Save Book
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Preview image before upload
        function previewImage(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('imagePreview').src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        // Sidebar toggle
        document.getElementById('sidebarToggle').addEventListener('click', function() {
            document.querySelector('.sidebar').classList.toggle('collapsed');
            document.querySelector('.main-content').classList.toggle('expanded');
        });
    </script>
</body>
</html>
