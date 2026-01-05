<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Mayur Collection and Bookstore</title>
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
            position: relative;
            overflow-x: hidden;
        }
        
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%238B4513' fill-opacity='0.03'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
            pointer-events: none;
            z-index: 0;
        }
        
        .navbar {
            background: linear-gradient(135deg, var(--dark-brown) 0%, var(--primary-brown) 100%) !important;
            box-shadow: 0 4px 20px rgba(93, 46, 15, 0.3);
            padding: 1.2rem 2rem;
            min-height: 70px;
            position: relative;
            z-index: 100;
        }
        
        .navbar-brand {
            font-family: 'Playfair Display', serif !important;
            font-size: 2rem !important;
            font-weight: 700 !important;
            color: var(--golden) !important;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .navbar-brand i {
            color: var(--light-golden);
        }
        
        .login-container {
            position: relative;
            z-index: 1;
            padding: 3rem 0;
        }
        
        .login-card {
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border: none;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(93, 46, 15, 0.15), 
                        0 8px 25px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 25px 70px rgba(93, 46, 15, 0.2), 
                        0 12px 30px rgba(0,0,0,0.12);
        }
        
        .login-header {
            background: linear-gradient(135deg, var(--dark-brown) 0%, var(--primary-brown) 100%);
            padding: 2.5rem 2rem;
            text-align: center;
            position: relative;
        }
        
        .login-header::after {
            content: '';
            position: absolute;
            bottom: -20px;
            left: 50%;
            transform: translateX(-50%);
            width: 0;
            height: 0;
            border-left: 25px solid transparent;
            border-right: 25px solid transparent;
            border-top: 20px solid var(--primary-brown);
        }
        
        .login-header h4 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            font-weight: 700;
            color: var(--golden);
            margin-bottom: 0.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .login-header p {
            color: var(--cream);
            opacity: 0.9;
            margin: 0;
        }
        
        .login-header .book-icon {
            font-size: 3rem;
            color: var(--light-golden);
            margin-bottom: 1rem;
            display: block;
        }
        
        .login-body {
            padding: 3rem 2.5rem 2rem;
        }
        
        .form-label {
            font-weight: 600;
            color: var(--dark-brown);
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
        }
        
        .form-control {
            border: 2px solid #E8D5B5;
            border-radius: 12px;
            padding: 0.8rem 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: var(--light-cream);
        }
        
        .form-control:focus {
            border-color: var(--golden);
            box-shadow: 0 0 0 4px rgba(218, 165, 32, 0.15);
            background: #FFFFFF;
        }
        
        .form-control::placeholder {
            color: #B8A78A;
        }
        
        .input-group-text {
            background: linear-gradient(135deg, var(--cream) 0%, #F5E6D3 100%);
            border: 2px solid #E8D5B5;
            border-right: none;
            border-radius: 12px 0 0 12px;
            color: var(--primary-brown);
        }
        
        .input-group .form-control {
            border-left: none;
            border-radius: 0 12px 12px 0;
        }
        
        .input-group .form-control:focus {
            border-left: none;
        }
        
        .input-group:focus-within .input-group-text {
            border-color: var(--golden);
        }
        
        /* Role Selection Buttons */
        .role-selection {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        
        .role-btn {
            flex: 1;
            padding: 1rem;
            border: 2px solid #E8D5B5;
            border-radius: 12px;
            background: var(--light-cream);
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
        }
        
        .role-btn:hover {
            border-color: var(--golden);
            background: var(--cream);
        }
        
        .role-btn.active {
            border-color: var(--golden);
            background: linear-gradient(135deg, var(--cream) 0%, #F5E6D3 100%);
            box-shadow: 0 4px 15px rgba(218, 165, 32, 0.3);
        }
        
        .role-btn i {
            font-size: 1.5rem;
            color: var(--primary-brown);
            display: block;
            margin-bottom: 0.5rem;
        }
        
        .role-btn.active i {
            color: var(--golden);
        }
        
        .role-btn span {
            font-weight: 600;
            color: var(--dark-brown);
        }
        
        .btn-check:checked + .role-btn {
            border-color: var(--golden);
            background: linear-gradient(135deg, var(--cream) 0%, #F5E6D3 100%);
            box-shadow: 0 4px 15px rgba(218, 165, 32, 0.3);
        }
        
        .btn-check:checked + .role-btn i {
            color: var(--golden);
        }
        
        .btn-login {
            background: linear-gradient(135deg, var(--golden) 0%, #C4941A 100%);
            border: none;
            border-radius: 12px;
            padding: 1rem 2rem;
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--dark-brown);
            box-shadow: 0 6px 20px rgba(218, 165, 32, 0.4);
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .btn-login:hover {
            background: linear-gradient(135deg, var(--light-golden) 0%, var(--golden) 100%);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(218, 165, 32, 0.5);
            color: var(--dark-brown);
        }
        
        .btn-toggle-password {
            border: 2px solid #E8D5B5;
            border-left: none;
            border-radius: 0 12px 12px 0;
            background: var(--light-cream);
            color: var(--primary-brown);
            transition: all 0.3s ease;
        }
        
        .btn-toggle-password:hover {
            background: var(--cream);
            color: var(--golden);
        }
        
        .form-check-input:checked {
            background-color: var(--golden);
            border-color: var(--golden);
        }
        
        .form-check-label {
            color: var(--dark-brown);
        }
        
        .forgot-link {
            color: var(--primary-brown);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        
        .forgot-link:hover {
            color: var(--golden);
        }
        
        .login-footer {
            background: linear-gradient(135deg, var(--cream) 0%, #F5E6D3 100%);
            padding: 1.5rem 2rem;
            text-align: center;
            border-top: 2px solid #E8D5B5;
        }
        
        .login-footer a {
            color: var(--golden);
            font-weight: 600;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        
        .login-footer a:hover {
            color: var(--primary-brown);
        }
        
        /* Demo Credentials Card */
        .demo-card {
            background: linear-gradient(180deg, #FFFFFF 0%, var(--light-cream) 100%);
            border: 2px solid var(--golden);
            border-radius: 16px;
            margin-top: 1.5rem;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(93, 46, 15, 0.1);
        }
        
        .demo-header {
            background: linear-gradient(135deg, var(--golden) 0%, #C4941A 100%);
            color: var(--dark-brown);
            padding: 1rem 1.5rem;
            font-weight: 600;
        }
        
        .demo-body {
            padding: 1.5rem;
        }
        
        .demo-section {
            padding: 1rem;
            background: var(--cream);
            border-radius: 10px;
            margin-bottom: 0.5rem;
        }
        
        .demo-section:last-child {
            margin-bottom: 0;
        }
        
        .demo-section strong {
            color: var(--primary-brown);
            display: block;
            margin-bottom: 0.5rem;
        }
        
        .demo-section small {
            color: #6B5B4F;
        }
        
        /* Alert Styles */
        .alert-success {
            background: linear-gradient(135deg, #D4EDDA 0%, #C3E6CB 100%);
            border: 2px solid #28A745;
            border-radius: 12px;
            color: #155724;
        }
        
        .alert-danger {
            background: linear-gradient(135deg, #F8D7DA 0%, #F5C6CB 100%);
            border: 2px solid #DC3545;
            border-radius: 12px;
            color: #721C24;
        }
        
        /* Decorative Books */
        .floating-book {
            position: fixed;
            opacity: 0.1;
            font-size: 4rem;
            color: var(--primary-brown);
            z-index: 0;
            animation: float 6s ease-in-out infinite;
        }
        
        .floating-book:nth-child(1) { top: 10%; left: 5%; animation-delay: 0s; }
        .floating-book:nth-child(2) { top: 60%; left: 8%; animation-delay: 1s; }
        .floating-book:nth-child(3) { top: 20%; right: 5%; animation-delay: 2s; }
        .floating-book:nth-child(4) { top: 70%; right: 8%; animation-delay: 3s; }
        
        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(-5deg); }
            50% { transform: translateY(-20px) rotate(5deg); }
        }
        
        /* Divider */
        .divider {
            display: flex;
            align-items: center;
            margin: 1.5rem 0;
        }
        
        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            height: 2px;
            background: linear-gradient(90deg, transparent, #E8D5B5, transparent);
        }
        
        .divider i {
            padding: 0 1rem;
            color: var(--golden);
            font-size: 1.2rem;
        }
    </style>
</head>
<body>
    <!-- Floating Decorative Books -->
    <i class="fas fa-book floating-book"></i>
    <i class="fas fa-book-open floating-book"></i>
    <i class="fas fa-book floating-book"></i>
    <i class="fas fa-book-open floating-book"></i>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <i class="fas fa-book-open me-2"></i>Mayur Collection and Bookstore
            </a>
        </div>
    </nav>

    <div class="container login-container">
        <div class="row justify-content-center">
            <div class="col-md-5 col-lg-4">
                <div class="login-card">
                    <div class="login-header">
                        <i class="fas fa-book-reader book-icon"></i>
                        <h4>Welcome Back!</h4>
                        <p>Sign in to continue your reading journey</p>
                    </div>
                    
                    <div class="login-body">
                        <!-- Success Message -->
                        <c:if test="${not empty success}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle me-2"></i>${success}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        
                        <!-- Error Message -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/login" method="post">
                            <!-- Role Selection -->
                            <div class="mb-4">
                                <label class="form-label">Login As</label>
                                <div class="role-selection">
                                    <input type="radio" class="btn-check" name="role" id="roleCustomer" value="CUSTOMER" 
                                           ${role != 'ADMIN' ? 'checked' : ''}>
                                    <label class="role-btn" for="roleCustomer">
                                        <i class="fas fa-user"></i>
                                        <span>Customer</span>
                                    </label>
                                    
                                    <input type="radio" class="btn-check" name="role" id="roleAdmin" value="ADMIN"
                                           ${role == 'ADMIN' ? 'checked' : ''}>
                                    <label class="role-btn" for="roleAdmin">
                                        <i class="fas fa-user-shield"></i>
                                        <span>Admin</span>
                                    </label>
                                </div>
                            </div>

                            <div class="divider">
                                <i class="fas fa-feather-alt"></i>
                            </div>

                            <!-- Email -->
                            <div class="mb-3">
                                <label for="email" class="form-label">Email Address</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                    <input type="email" class="form-control" id="email" name="email" 
                                           value="${email}" placeholder="Enter your email" required>
                                </div>
                            </div>

                            <!-- Password -->
                            <div class="mb-4">
                                <label for="password" class="form-label">Password</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                    <input type="password" class="form-control" id="password" name="password" 
                                           placeholder="Enter your password" required style="border-radius: 0;">
                                    <button class="btn btn-toggle-password" type="button" id="togglePassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>

                            <!-- Remember Me & Forgot Password -->
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="remember" name="remember">
                                    <label class="form-check-label" for="remember">Remember me</label>
                                </div>
                                <a href="#" class="forgot-link">Forgot Password?</a>
                            </div>

                            <!-- Submit Button -->
                            <div class="d-grid">
                                <button type="submit" class="btn btn-login">
                                    <i class="fas fa-sign-in-alt me-2"></i>Login
                                </button>
                            </div>
                        </form>
                    </div>
                    
                    <div class="login-footer">
                        <p class="mb-0">Don't have an account? 
                            <a href="${pageContext.request.contextPath}/register">Register Here</a>
                        </p>
                    </div>
                </div>

                <!-- Demo Credentials -->
                <div class="demo-card">
                    <div class="demo-header">
                        <i class="fas fa-info-circle me-2"></i>Demo Credentials
                    </div>
                    <div class="demo-body">
                        <div class="row">
                            <div class="col-6">
                                <div class="demo-section">
                                    <strong><i class="fas fa-user-shield me-1"></i>Admin</strong>
                                    <small>
                                        admin@ebook.com<br>
                                        admin123
                                    </small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="demo-section">
                                    <strong><i class="fas fa-user me-1"></i>Customer</strong>
                                    <small>
                                        Register new account<br>
                                        to test features
                                    </small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const password = document.getElementById('password');
            const icon = this.querySelector('i');
            
            if (password.type === 'password') {
                password.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                password.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
    </script>
</body>
</html>
