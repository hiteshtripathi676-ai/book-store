<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Book - Mayur Collection and Bookstore Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-brown: #8B4513;
            --dark-brown: #5D2E0F;
            --golden: #DAA520;
            --light-golden: #F4D03F;
            --cream: #FFF8DC;
            --light-cream: #FFFEF7;
            --sidebar-bg: linear-gradient(180deg, #5D2E0F 0%, #8B4513 100%);
        }
        
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f1e8 0%, #e8dcc8 100%);
            min-height: 100vh;
        }
        
        .admin-wrapper { display: flex; min-height: 100vh; }
        
        .sidebar {
            width: 260px;
            background: var(--sidebar-bg);
            color: white;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            z-index: 1000;
            box-shadow: 4px 0 15px rgba(0,0,0,0.1);
        }
        
        .sidebar-header {
            padding: 25px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            background: rgba(0,0,0,0.1);
        }
        
        .sidebar-brand {
            color: var(--golden);
            font-family: 'Playfair Display', serif;
            font-size: 1.4rem;
            font-weight: 700;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .sidebar-brand:hover { color: var(--light-golden); }
        
        .sidebar-nav { padding: 20px 0; }
        
        .nav-section-title {
            color: rgba(255,255,255,0.5);
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 15px 20px 8px;
            font-weight: 600;
        }
        
        .sidebar .nav-link {
            color: rgba(255,255,255,0.8);
            padding: 12px 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
        }
        
        .sidebar .nav-link:hover {
            background: rgba(255,255,255,0.1);
            color: var(--golden);
            border-left-color: var(--golden);
        }
        
        .sidebar .nav-link.active {
            background: rgba(218,165,32,0.2);
            color: var(--golden);
            border-left-color: var(--golden);
        }
        
        .main-content { flex: 1; margin-left: 260px; min-height: 100vh; }
        
        .top-header {
            background: linear-gradient(135deg, var(--primary-brown), var(--dark-brown));
            padding: 20px 30px;
            color: white;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .top-header h4 {
            font-family: 'Playfair Display', serif;
            font-weight: 600;
            margin: 0;
        }
        
        .btn-back {
            background: rgba(255,255,255,0.15);
            border: 1px solid rgba(255,255,255,0.3);
            color: white;
            padding: 8px 20px;
            border-radius: 25px;
            transition: all 0.3s ease;
        }
        
        .btn-back:hover {
            background: var(--golden);
            border-color: var(--golden);
            color: var(--dark-brown);
        }
        
        .form-container { padding: 30px; }
        
        .edit-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(139,69,19,0.1);
            overflow: hidden;
            border: 1px solid rgba(218,165,32,0.2);
        }
        
        .card-header-styled {
            background: linear-gradient(135deg, var(--cream), #fff);
            padding: 25px 30px;
            border-bottom: 2px solid var(--golden);
        }
        
        .card-header-styled h5 {
            color: var(--dark-brown);
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .card-header-styled h5 i { color: var(--golden); }
        
        .card-body-styled { padding: 30px; }
        
        .form-label {
            color: var(--dark-brown);
            font-weight: 500;
            margin-bottom: 8px;
            font-size: 0.9rem;
        }
        
        .form-control, .form-select {
            border: 2px solid #e0d5c5;
            border-radius: 10px;
            padding: 12px 15px;
            transition: all 0.3s ease;
            background: var(--light-cream);
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--golden);
            box-shadow: 0 0 0 3px rgba(218,165,32,0.2);
            background: white;
        }
        
        .form-text { color: #888; font-size: 0.8rem; }
        
        .image-upload-container {
            background: linear-gradient(145deg, var(--cream), #fff);
            border: 3px dashed var(--golden);
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            min-height: 300px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        
        .image-upload-container:hover {
            background: linear-gradient(145deg, #fff, var(--cream));
            border-color: var(--primary-brown);
            transform: translateY(-2px);
        }
        
        .image-upload-container.has-image {
            border-style: solid;
            padding: 15px;
        }
        
        .image-upload-container img {
            max-width: 100%;
            max-height: 250px;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }
        
        .upload-icon {
            font-size: 4rem;
            color: var(--golden);
            margin-bottom: 15px;
        }
        
        .upload-text { color: var(--primary-brown); font-weight: 500; margin-bottom: 5px; }
        .upload-hint { color: #888; font-size: 0.85rem; }
        
        .section-divider {
            border: 0;
            height: 2px;
            background: linear-gradient(90deg, transparent, var(--golden), transparent);
            margin: 30px 0;
        }
        
        .section-title {
            color: var(--dark-brown);
            font-family: 'Playfair Display', serif;
            font-size: 1.2rem;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--cream);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .section-title i { color: var(--golden); }
        
        .btn-save {
            background: linear-gradient(135deg, var(--golden), #c49b17);
            border: none;
            color: white;
            padding: 14px 35px;
            border-radius: 30px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(218,165,32,0.3);
        }
        
        .btn-save:hover {
            background: linear-gradient(135deg, var(--primary-brown), var(--dark-brown));
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(139,69,19,0.3);
            color: white;
        }
        
        .btn-cancel {
            background: transparent;
            border: 2px solid var(--primary-brown);
            color: var(--primary-brown);
            padding: 12px 30px;
            border-radius: 30px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn-cancel:hover { background: var(--primary-brown); color: white; }
        
        .form-check-input:checked { background-color: var(--golden); border-color: var(--golden); }
        .form-check-label { color: var(--dark-brown); }
        
        .current-image-info {
            background: linear-gradient(135deg, var(--cream), #fff);
            border: 1px solid rgba(218,165,32,0.3);
            border-radius: 10px;
            padding: 15px;
            margin-top: 15px;
        }
        
        .current-image-info small { color: #888; }
        .current-image-info p { color: var(--primary-brown); font-size: 0.85rem; word-break: break-all; }
        
        .alert-custom { border-radius: 12px; border: none; padding: 15px 20px; }
        .alert-danger.alert-custom { background: linear-gradient(135deg, #fee2e2, #fecaca); color: #991b1b; }
        .alert-success.alert-custom { background: linear-gradient(135deg, #d1fae5, #a7f3d0); color: #065f46; }
        
        @media (max-width: 992px) {
            .sidebar { transform: translateX(-100%); }
            .main-content { margin-left: 0; }
        }
    </style>
</head>
<body>
    <div class="admin-wrapper">
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
                        <a href="${pageContext.request.contextPath}/admin/books" class="nav-link active">
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

        <div class="main-content">
            <header class="top-header d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center">
                    <h4><i class="fas fa-edit me-2" style="color: #DAA520;"></i> Edit Book</h4>
                </div>
                <div class="header-actions d-flex align-items-center">
                    <a href="${pageContext.request.contextPath}/admin/books" class="btn btn-back me-3">
                        <i class="fas fa-arrow-left me-2"></i>Back to Books
                    </a>
                    <span class="me-3">${sessionScope.user.fullName}</span>
                    <i class="fas fa-user-circle fa-2x" style="color: #DAA520;"></i>
                </div>
            </header>

            <div class="form-container">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-custom alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="edit-card">
                    <div class="card-header-styled">
                        <h5><i class="fas fa-book"></i> Edit Book: ${book.title}</h5>
                    </div>
                    <div class="card-body-styled">
                        <form action="${pageContext.request.contextPath}/admin/edit-book" method="post" 
                              enctype="multipart/form-data" id="editBookForm">
                            <input type="hidden" name="bookId" value="${book.bookId}">
                            
                            <div class="row">
                                <div class="col-lg-8">
                                    <div class="section-title"><i class="fas fa-info-circle"></i> Basic Information</div>
                                    
                                    <div class="row g-3 mb-4">
                                        <div class="col-md-8">
                                            <label for="title" class="form-label">Book Title *</label>
                                            <input type="text" class="form-control" id="title" name="title" 
                                                   value="${book.title}" required placeholder="Enter book title">
                                        </div>
                                        <div class="col-md-4">
                                            <label for="bookType" class="form-label">Book Type *</label>
                                            <select class="form-select" id="bookType" name="bookType" required>
                                                <option value="NEW" ${book.bookType == 'NEW' ? 'selected' : ''}>New Book</option>
                                                <option value="OLD" ${book.bookType == 'OLD' ? 'selected' : ''}>Pre-owned</option>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="author" class="form-label">Author *</label>
                                            <input type="text" class="form-control" id="author" name="author" 
                                                   value="${book.author}" required placeholder="Author name">
                                        </div>
                                        <div class="col-md-6">
                                            <label for="isbn" class="form-label">ISBN</label>
                                            <input type="text" class="form-control" id="isbn" name="isbn" 
                                                   value="${book.isbn}" placeholder="e.g., 978-3-16-148410-0">
                                        </div>
                                        <div class="col-md-6">
                                            <label for="categoryId" class="form-label">Category *</label>
                                            <select class="form-select" id="categoryId" name="categoryId" required>
                                                <option value="">Select Category</option>
                                                <c:forEach var="cat" items="${categories}">
                                                    <option value="${cat.categoryId}" ${book.categoryId == cat.categoryId ? 'selected' : ''}>${cat.categoryName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="publisher" class="form-label">Publisher</label>
                                            <input type="text" class="form-control" id="publisher" name="publisher" 
                                                   value="${book.publisher}" placeholder="Publisher name">
                                        </div>
                                    </div>
                                    
                                    <hr class="section-divider">
                                    
                                    <div class="section-title"><i class="fas fa-rupee-sign"></i> Pricing & Stock</div>
                                    
                                    <div class="row g-3 mb-4">
                                        <div class="col-md-4">
                                            <label for="price" class="form-label">Selling Price (₹) *</label>
                                            <input type="number" class="form-control" id="price" name="price" 
                                                   value="${book.price}" min="1" step="0.01" required>
                                        </div>
                                        <div class="col-md-4">
                                            <label for="originalPrice" class="form-label">Original Price (₹)</label>
                                            <input type="number" class="form-control" id="originalPrice" name="originalPrice" 
                                                   value="${book.originalPrice}" min="1" step="0.01">
                                            <small class="form-text">For showing discount</small>
                                        </div>
                                        <div class="col-md-4">
                                            <label for="stockQuantity" class="form-label">Stock Quantity *</label>
                                            <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" 
                                                   value="${book.stockQuantity}" min="0" required>
                                        </div>
                                        <div class="col-md-4">
                                            <label for="lowStockThreshold" class="form-label">Low Stock Alert</label>
                                            <input type="number" class="form-control" id="lowStockThreshold" name="lowStockThreshold" 
                                                   value="${book.lowStockThreshold}" min="1">
                                        </div>
                                        <div class="col-md-4">
                                            <label for="publicationYear" class="form-label">Publication Year</label>
                                            <input type="number" class="form-control" id="publicationYear" name="publicationYear" 
                                                   value="${book.publicationYear}" min="1800" max="2026">
                                        </div>
                                        <div class="col-md-4">
                                            <label for="language" class="form-label">Language</label>
                                            <input type="text" class="form-control" id="language" name="language" 
                                                   value="${book.language}" placeholder="e.g., English">
                                        </div>
                                    </div>
                                    
                                    <hr class="section-divider">
                                    
                                    <div class="section-title"><i class="fas fa-align-left"></i> Description</div>
                                    
                                    <div class="mb-4">
                                        <label for="description" class="form-label">Book Description</label>
                                        <textarea class="form-control" id="description" name="description" 
                                                  rows="4" placeholder="Enter book description...">${book.description}</textarea>
                                    </div>
                                    
                                    <hr class="section-divider">
                                    
                                    <div class="section-title"><i class="fas fa-cog"></i> Options</div>
                                    
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label for="isAvailable" class="form-label">Status</label>
                                            <select class="form-select" id="isAvailable" name="isAvailable">
                                                <option value="true" ${book.available ? 'selected' : ''}>Active (Available)</option>
                                                <option value="false" ${!book.available ? 'selected' : ''}>Inactive (Hidden)</option>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Payment Options</label>
                                            <div class="form-check mt-2">
                                                <input class="form-check-input" type="checkbox" id="codAvailable" 
                                                       name="codAvailable" value="true" ${book.codAvailable ? 'checked' : ''}>
                                                <label class="form-check-label" for="codAvailable">
                                                    <i class="fas fa-money-bill-wave me-1" style="color: #DAA520;"></i>
                                                    Allow Cash on Delivery
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-lg-4">
                                    <div class="section-title"><i class="fas fa-image"></i> Cover Image</div>
                                    
                                    <div class="image-upload-container ${not empty book.coverImage ? 'has-image' : ''}" 
                                         onclick="document.getElementById('coverImage').click()">
                                        <c:choose>
                                            <c:when test="${not empty book.coverImage}">
                                                <img id="imagePreview" src="${pageContext.request.contextPath}/${book.coverImage}" 
                                                     alt="Book cover" onerror="this.src='https://placehold.co/200x280/8B4513/FFFFFF?text=Book'">
                                            </c:when>
                                            <c:otherwise>
                                                <div id="uploadPlaceholder">
                                                    <i class="fas fa-cloud-upload-alt upload-icon"></i>
                                                    <p class="upload-text">Click to Upload Image</p>
                                                    <p class="upload-hint">JPG, PNG (Max 5MB)</p>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    
                                    <input type="file" id="coverImage" name="coverImage" accept="image/*" class="d-none">
                                    
                                    <c:if test="${not empty book.coverImage}">
                                        <div class="current-image-info">
                                            <small><i class="fas fa-image me-1"></i> Current Image:</small>
                                            <p class="mb-0 mt-1">${book.coverImage}</p>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                            
                            <hr class="section-divider">
                            
                            <div class="d-flex justify-content-between align-items-center pt-3">
                                <a href="${pageContext.request.contextPath}/admin/books" class="btn btn-cancel">
                                    <i class="fas fa-times me-2"></i>Cancel
                                </a>
                                <button type="submit" class="btn btn-save">
                                    <i class="fas fa-save me-2"></i>Save Changes
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('coverImage').addEventListener('change', function() {
            if (this.files && this.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const container = document.querySelector('.image-upload-container');
                    container.classList.add('has-image');
                    container.innerHTML = '<img id="imagePreview" src="' + e.target.result + '" alt="Book cover preview">';
                };
                reader.readAsDataURL(this.files[0]);
            }
        });
    </script>
</body>
</html>
