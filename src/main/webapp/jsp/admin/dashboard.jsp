<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    // Security check: if not logged in, redirect to login
    if (session.getAttribute("loggedAdmin") == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }
    model.Admin admin = (model.Admin) session.getAttribute("loggedAdmin");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | RK GROUP Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet">

    <style>
        /* ===== FORCE WHITE TEXT IN ALL TABLES ===== */
        table tbody tr td { color: #ffffff !important; }
        table tbody tr td span:not([class*="badge"]) { color: #ffffff !important; }
        table tbody tr td strong { color: #ffffff !important; }
        table tbody tr td b { color: #ffffff !important; }
        /* Links gold rehne do */
        table tbody tr td a { color: #c8a45c !important; }
        /* Muted small text */
        table tbody tr td small { color: #888888 !important; }
        /* Skill badge - gold */
        table tbody tr td span[style*="rgba(200"] { color: #c8a45c !important; }
    </style>
</head>
<body>
<div class="admin-wrapper">

    <!-- ====== SIDEBAR ====== -->
    <aside class="sidebar">
        <div class="sidebar-brand">
            <h6><i class="bi bi-gem me-2"></i>RK GROUP</h6>
            <small>FURNITURES &amp; INTERIOR</small>
        </div>
        <ul class="sidebar-menu">
            <li><span class="menu-section">Main</span></li>
            <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active">
                <i class="bi bi-speedometer2"></i> Dashboard
            </a></li>
            <li><a href="${pageContext.request.contextPath}/" target="_blank">
                <i class="bi bi-eye"></i> View Website
            </a></li>

            <li><span class="menu-section">Content</span></li>
            <li><a href="${pageContext.request.contextPath}/admin/gallery">
                <i class="bi bi-images"></i> Gallery
            </a></li>
            <li><a href="${pageContext.request.contextPath}/admin/products">
                <i class="bi bi-box-seam"></i> Products
            </a></li>

            <li><span class="menu-section">Customer</span></li>
            <li><a href="${pageContext.request.contextPath}/admin/inquiries">
                <i class="bi bi-chat-dots"></i> Inquiries
                <c:if test="${newInquiries > 0}"><span class="notif-dot"></span></c:if>
            </a></li>
            <li><a href="${pageContext.request.contextPath}/admin/bookings">
                <i class="bi bi-calendar-check"></i> Bookings
                <c:if test="${pendingBookings > 0}"><span class="notif-dot"></span></c:if>
            </a></li>

            <li><span class="menu-section">Operations</span></li>
            <li><a href="${pageContext.request.contextPath}/admin/sites">
                <i class="bi bi-building"></i> Work Sites
            </a></li>
            <li><a href="${pageContext.request.contextPath}/admin/workers">
                <i class="bi bi-people"></i> Workers
            </a></li>

            <li><span class="menu-section">Account</span></li>
            <li><a href="${pageContext.request.contextPath}/admin/logout">
                <i class="bi bi-box-arrow-right"></i> Logout
            </a></li>
        </ul>
    </aside>

    <!-- ====== MAIN CONTENT ====== -->
    <div class="main-content">

        <!-- Top Bar -->
        <div class="topbar">
            <div class="d-flex align-items-center gap-3">
                <button id="sidebarToggle" style="background:none;border:none;color:var(--muted);font-size:1.2rem;cursor:pointer;display:none;" class="d-lg-none">
                    <i class="bi bi-list"></i>
                </button>
                <h5><i class="bi bi-speedometer2 me-2" style="color:var(--primary);"></i>Dashboard</h5>
            </div>
            <div class="d-flex align-items-center gap-3">
                <span class="admin-name"><i class="bi bi-person-circle me-1"></i><%= admin.getFullName() %></span>
                <a href="${pageContext.request.contextPath}/admin/logout" class="btn-logout">
                    <i class="bi bi-box-arrow-right me-1"></i>Logout
                </a>
            </div>
        </div>

        <!-- Page Content -->
        <div class="page-content">

            <!-- Welcome Banner -->
            <div style="background:linear-gradient(135deg,rgba(200,164,92,0.1),rgba(200,164,92,0.04));border:1px solid rgba(200,164,92,0.2);border-radius:10px;padding:24px 28px;margin-bottom:28px;">
                <h5 style="margin:0;color:var(--light);">Welcome back, <span style="color:var(--primary);"><%= admin.getFullName() %></span> 👋</h5>
                <p style="color:var(--muted);margin:6px 0 0;font-size:0.88rem;">
                    Here's a quick overview of RK GROUP FURNITURES &amp; INTERIOR
                </p>
            </div>

            <!-- Stat Cards Row 1 -->
            <div class="row g-3 mb-3">
                <div class="col-xl-2 col-md-4 col-sm-6">
                    <a href="${pageContext.request.contextPath}/admin/inquiries" style="text-decoration:none;">
                        <div class="stat-card">
                            <div class="stat-icon purple"><i class="bi bi-chat-dots-fill"></i></div>
                            <div>
                                <div class="stat-number">${newInquiries}</div>
                                <div class="stat-label">New Inquiries</div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-xl-2 col-md-4 col-sm-6">
                    <a href="${pageContext.request.contextPath}/admin/bookings" style="text-decoration:none;">
                        <div class="stat-card">
                            <div class="stat-icon orange"><i class="bi bi-calendar-event-fill"></i></div>
                            <div>
                                <div class="stat-number">${pendingBookings}</div>
                                <div class="stat-label">Pending Bookings</div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-xl-2 col-md-4 col-sm-6">
                    <a href="${pageContext.request.contextPath}/admin/products" style="text-decoration:none;">
                        <div class="stat-card">
                            <div class="stat-icon gold"><i class="bi bi-box-seam-fill"></i></div>
                            <div>
                                <div class="stat-number">${totalProducts}</div>
                                <div class="stat-label">Active Products</div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-xl-2 col-md-4 col-sm-6">
                    <a href="${pageContext.request.contextPath}/admin/gallery" style="text-decoration:none;">
                        <div class="stat-card">
                            <div class="stat-icon blue"><i class="bi bi-images"></i></div>
                            <div>
                                <div class="stat-number">${totalGallery}</div>
                                <div class="stat-label">Gallery Items</div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-xl-2 col-md-4 col-sm-6">
                    <a href="${pageContext.request.contextPath}/admin/sites" style="text-decoration:none;">
                        <div class="stat-card">
                            <div class="stat-icon green"><i class="bi bi-building-fill-check"></i></div>
                            <div>
                                <div class="stat-number">${activeSites}</div>
                                <div class="stat-label">Active Sites</div>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-xl-2 col-md-4 col-sm-6">
                    <a href="${pageContext.request.contextPath}/admin/workers" style="text-decoration:none;">
                        <div class="stat-card">
                            <div class="stat-icon red"><i class="bi bi-people-fill"></i></div>
                            <div>
                                <div class="stat-number">${totalWorkers}</div>
                                <div class="stat-label">Total Workers</div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>

            <!-- Quick Action Cards -->
            <h6 style="color:var(--muted);letter-spacing:1px;text-transform:uppercase;font-size:0.78rem;margin:28px 0 16px;">Quick Actions</h6>
            <div class="row g-3 mb-4">
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/admin/gallery" style="text-decoration:none;">
                        <div style="background:var(--dark-2);border:1px solid var(--dark-4);border-radius:var(--radius);padding:20px;text-align:center;transition:all 0.25s;" onmouseover="this.style.borderColor='rgba(200,164,92,0.4)'" onmouseout="this.style.borderColor='var(--dark-4)'">
                            <i class="bi bi-cloud-upload" style="font-size:1.8rem;color:var(--primary);"></i>
                            <p style="color:var(--light);margin:10px 0 0;font-size:0.9rem;font-weight:500;">Upload Gallery</p>
                        </div>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/admin/products" style="text-decoration:none;">
                        <div style="background:var(--dark-2);border:1px solid var(--dark-4);border-radius:var(--radius);padding:20px;text-align:center;transition:all 0.25s;" onmouseover="this.style.borderColor='rgba(200,164,92,0.4)'" onmouseout="this.style.borderColor='var(--dark-4)'">
                            <i class="bi bi-plus-circle" style="font-size:1.8rem;color:var(--success);"></i>
                            <p style="color:var(--light);margin:10px 0 0;font-size:0.9rem;font-weight:500;">Add Product</p>
                        </div>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/admin/sites" style="text-decoration:none;">
                        <div style="background:var(--dark-2);border:1px solid var(--dark-4);border-radius:var(--radius);padding:20px;text-align:center;transition:all 0.25s;" onmouseover="this.style.borderColor='rgba(200,164,92,0.4)'" onmouseout="this.style.borderColor='var(--dark-4)'">
                            <i class="bi bi-building-add" style="font-size:1.8rem;color:var(--info);"></i>
                            <p style="color:var(--light);margin:10px 0 0;font-size:0.9rem;font-weight:500;">Add Work Site</p>
                        </div>
                    </a>
                </div>
                <div class="col-md-3 col-sm-6">
                    <a href="${pageContext.request.contextPath}/admin/workers" style="text-decoration:none;">
                        <div style="background:var(--dark-2);border:1px solid var(--dark-4);border-radius:var(--radius);padding:20px;text-align:center;transition:all 0.25s;" onmouseover="this.style.borderColor='rgba(200,164,92,0.4)'" onmouseout="this.style.borderColor='var(--dark-4)'">
                            <i class="bi bi-person-plus" style="font-size:1.8rem;color:var(--warning);"></i>
                            <p style="color:var(--light);margin:10px 0 0;font-size:0.9rem;font-weight:500;">Add Worker</p>
                        </div>
                    </a>
                </div>
            </div>

            <!-- Business Info Card -->
            <div style="background:var(--dark-2);border:1px solid var(--dark-4);border-radius:var(--radius);padding:24px;">
                <h6 style="color:var(--primary);margin-bottom:18px;"><i class="bi bi-info-circle me-2"></i>Business Info</h6>
                <div class="row g-3">
                    <div class="col-md-3 col-sm-6">
                        <small style="color:var(--muted);font-size:0.78rem;display:block;">OWNER</small>
                        <span style="color:var(--light);font-size:0.92rem;font-weight:500;">Rahul Vishwakarma</span>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <small style="color:var(--muted);font-size:0.78rem;display:block;">PHONE</small>
                        <a href="tel:7772897077" style="color:var(--primary);font-size:0.92rem;font-weight:500;">7772897077</a>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <small style="color:var(--muted);font-size:0.78rem;display:block;">EMAIL</small>
                        <span style="color:var(--light);font-size:0.88rem;">rahulvishwakarma111999@gmail.com</span>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <small style="color:var(--muted);font-size:0.78rem;display:block;">LOCATION</small>
                        <a href="https://maps.app.goo.gl/g78BgUACNh3cK3iz8?g_st=aw" target="_blank" style="color:var(--primary);font-size:0.88rem;">View on Maps →</a>
                    </div>
                </div>
            </div>

        </div><!-- end page-content -->
    </div><!-- end main-content -->
</div><!-- end admin-wrapper -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/admin.js"></script>
</body>
</html>
