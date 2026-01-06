<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error | Mayur Collection and Bookstore</title>
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
        .error-icon {
            font-size: 6rem;
            color: #ffc107;
            margin-bottom: 1rem;
        }
        .error-message {
            font-size: 1.5rem;
            color: #6c757d;
            margin-bottom: 2rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="error-container">
            <div class="error-icon">
                <i class="fas fa-bug"></i>
            </div>
            <h1 class="display-4 text-danger">Something Went Wrong</h1>
            <p class="error-message">An unexpected error occurred.</p>
            <p class="text-muted mb-4">We apologize for the inconvenience. Please try again or contact support if the problem persists.</p>
            
            <% if (exception != null) { %>
            <div class="alert alert-danger text-start mt-4" role="alert">
                <strong>Error Details:</strong><br>
                <%= exception.getMessage() %>
            </div>
            <% } %>
            
            <div class="d-flex gap-3 justify-content-center flex-wrap mt-4">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-lg">
                    <i class="fas fa-home me-2"></i>Go Home
                </a>
                <button onclick="history.back()" class="btn btn-outline-primary btn-lg">
                    <i class="fas fa-arrow-left me-2"></i>Go Back
                </button>
            </div>
        </div>
    </div>
</body>
</html>
