<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Page Not Found | Mayur Collection and Bookstore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .error-container {
            text-align: center;
            padding: 2rem;
        }
        .error-code {
            font-size: 8rem;
            font-weight: 700;
            color: #0d6efd;
            line-height: 1;
        }
        .error-message {
            font-size: 1.5rem;
            color: #6c757d;
            margin-bottom: 2rem;
        }
        .error-icon {
            font-size: 6rem;
            color: #0d6efd;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="error-container">
            <div class="error-icon">
                <i class="fas fa-book-open"></i>
            </div>
            <h1 class="error-code">404</h1>
            <p class="error-message">Oops! The page you're looking for doesn't exist.</p>
            <p class="text-muted mb-4">It seems like you've wandered off the beaten path. Let's get you back on track!</p>
            <div class="d-flex gap-3 justify-content-center flex-wrap">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-lg">
                    <i class="fas fa-home me-2"></i>Go Home
                </a>
                <a href="${pageContext.request.contextPath}/books" class="btn btn-outline-primary btn-lg">
                    <i class="fas fa-book me-2"></i>Browse Books
                </a>
            </div>
        </div>
    </div>
</body>
</html>
