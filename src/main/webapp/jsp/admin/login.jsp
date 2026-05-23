<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login | RK GROUP</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet">
    <style>
        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--dark);
            background-image: radial-gradient(circle at 20% 50%, rgba(200,164,92,0.05) 0%, transparent 60%),
                              radial-gradient(circle at 80% 20%, rgba(200,164,92,0.03) 0%, transparent 50%);
        }
        .login-box {
            width: 100%;
            max-width: 420px;
            background: var(--dark-2);
            border: 1px solid rgba(200,164,92,0.2);
            border-radius: 14px;
            padding: 44px 38px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.5);
        }
        .login-box .form-control {
            background: var(--dark-3);
            border: 1px solid #3a3a3a;
            color: var(--light);
            padding: 12px 16px;
            border-radius: 8px;
            transition: all 0.25s;
        }
        .login-box .form-control:focus {
            background: var(--dark-3);
            border-color: var(--primary);
            color: var(--light);
            box-shadow: 0 0 0 0.15rem rgba(200,164,92,0.2);
        }
        .login-box label { color: var(--muted); font-size: 0.88rem; margin-bottom: 6px; }
    </style>
</head>
<body>
<div class="login-box">
    <!-- Logo -->
    <div class="text-center mb-4">
        <div style="width:64px;height:64px;background:rgba(200,164,92,0.1);border:2px solid rgba(200,164,92,0.3);border-radius:50%;display:flex;align-items:center;justify-content:center;margin:0 auto 16px;">
            <i class="bi bi-gem" style="font-size:1.8rem;color:var(--primary);"></i>
        </div>
        <h4 style="font-family:'Playfair Display',serif;color:var(--primary);margin-bottom:4px;">RK GROUP</h4>
        <p style="color:var(--muted);font-size:0.78rem;letter-spacing:2px;text-transform:uppercase;margin:0;">Admin Panel</p>
    </div>

    <!-- Error message -->
    <c:if test="${not empty error}">
        <div style="background:rgba(224,82,82,0.1);border:1px solid var(--danger);color:var(--danger);padding:12px 16px;border-radius:8px;font-size:0.88rem;margin-bottom:20px;">
            <i class="bi bi-exclamation-triangle me-2"></i>${error}
        </div>
    </c:if>

    <!-- Login Form -->
    <form action="${pageContext.request.contextPath}/admin/login" method="post">
        <div class="mb-3">
            <label>Username</label>
            <div class="input-group">
                <span style="background:var(--dark-3);border:1px solid #3a3a3a;border-right:none;padding:0 14px;display:flex;align-items:center;border-radius:8px 0 0 8px;">
                    <i class="bi bi-person" style="color:var(--muted);"></i>
                </span>
                <input type="text" class="form-control" name="username"
                       placeholder="Enter username"  required
                       style="border-left:none;border-radius:0 8px 8px 0;">
            </div>
        </div>
        <div class="mb-4">
            <label>Password</label>
            <div class="input-group">
                <span style="background:var(--dark-3);border:1px solid #3a3a3a;border-right:none;padding:0 14px;display:flex;align-items:center;border-radius:8px 0 0 8px;">
                    <i class="bi bi-lock" style="color:var(--muted);"></i>
                </span>
                <input type="password" class="form-control" name="password"
                       id="passwordField" placeholder="Enter password" required
                       style="border-left:none;border-right:none;border-radius:0;">
                <!-- Toggle password visibility -->
                <button type="button"
                        style="background:var(--dark-3);border:1px solid #3a3a3a;border-left:none;padding:0 14px;cursor:pointer;border-radius:0 8px 8px 0;"
                        onclick="togglePass()">
                    <i class="bi bi-eye" id="eyeIcon" style="color:var(--muted);"></i>
                </button>
            </div>
        </div>
        <button type="submit" class="btn-admin-primary w-100 py-3" style="border-radius:8px;font-size:0.95rem;">
            <i class="bi bi-box-arrow-in-right me-2"></i>Login to Admin Panel
        </button>
    </form>

    <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/" style="color:var(--muted);font-size:0.82rem;text-decoration:none;">
            <i class="bi bi-arrow-left me-1"></i>Back to Website
        </a>
    </div>

   
<script>
function togglePass() {
    var field = document.getElementById('passwordField');
    var icon  = document.getElementById('eyeIcon');
    if (field.type === 'password') {
        field.type = 'text';
        icon.className = 'bi bi-eye-slash';
    } else {
        field.type = 'password';
        icon.className = 'bi bi-eye';
    }
}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
