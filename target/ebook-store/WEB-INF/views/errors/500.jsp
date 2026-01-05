<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - Server Error | Mayur Collection and Bookstore</title>
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
            color: #dc3545;
            line-height: 1;
        }
        .error-message {
            font-size: 1.5rem;
            color: #6c757d;
            margin-bottom: 2rem;
        }
        .error-icon {
            font-size: 6rem;
            color: #dc3545;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="error-container">
            <div class="error-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <h1 class="error-code">500</h1>
            <p class="error-message">Internal Server Error</p>
            <p class="text-muted mb-4">Something went wrong on our end. We're working to fix it. Please try again later.</p>
            <div class="d-flex gap-3 justify-content-center flex-wrap">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-lg">
                    <i class="fas fa-home me-2"></i>Go Home
                </a>
                <button onclick="location.reload()" class="btn btn-outline-primary btn-lg">
                    <i class="fas fa-redo me-2"></i>Try Again
                </button>
            </div>
        </div>
    </div>
</body>
</html>
