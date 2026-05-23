<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<% if (session.getAttribute("loggedAdmin") == null) { response.sendRedirect(request.getContextPath() + "/admin/login"); return; } %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Workers | RK GROUP Admin</title>
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
    <style>
        .rk-table { width:100%; border-collapse:collapse; }
        .rk-table thead th { background:#2c2c2c; color:#c8a45c !important; font-size:0.78rem; letter-spacing:1px; text-transform:uppercase; padding:14px 16px; border-bottom:1px solid #333; font-weight:600; }
        .rk-table tbody tr { border-bottom:1px solid #2a2a2a; }
        .rk-table tbody tr:hover { background:rgba(200,164,92,0.04); }
        .rk-table tbody td { padding:13px 16px; color:#ffffff !important; font-size:0.88rem; vertical-align:middle; border:none !important; }
        .rk-table tbody td strong, .rk-table tbody td b, .rk-table tbody td span:not([class*="badge"]):not([style*="rgba"]) { color:#ffffff !important; }
        .rk-table tbody td a { color:#c8a45c !important; }
        .rk-table tbody td small { color:#888 !important; }
        .rk-badge-green  { background:rgba(76,175,120,0.15);  color:#4caf78 !important; border:1px solid #4caf78;  padding:4px 12px; border-radius:20px; font-size:0.78rem; font-weight:600; white-space:nowrap; }
        .rk-badge-red    { background:rgba(224,82,82,0.15);   color:#e05252 !important; border:1px solid #e05252;  padding:4px 12px; border-radius:20px; font-size:0.78rem; font-weight:600; white-space:nowrap; }
        .rk-badge-yellow { background:rgba(240,168,48,0.15);  color:#f0a830 !important; border:1px solid #f0a830;  padding:4px 12px; border-radius:20px; font-size:0.78rem; font-weight:600; white-space:nowrap; }
        .rk-badge-blue   { background:rgba(74,163,200,0.15);  color:#4aa3c8 !important; border:1px solid #4aa3c8;  padding:4px 12px; border-radius:20px; font-size:0.78rem; font-weight:600; white-space:nowrap; }
        .rk-badge-purple { background:rgba(160,120,220,0.15); color:#c080f0 !important; border:1px solid #c080f0;  padding:4px 12px; border-radius:20px; font-size:0.78rem; font-weight:600; white-space:nowrap; }
        .btn-rk-edit   { background:rgba(74,163,200,0.15); color:#4aa3c8 !important; border:1px solid #4aa3c8; padding:5px 10px; border-radius:5px; cursor:pointer; font-size:0.82rem; }
        .btn-rk-delete { background:rgba(224,82,82,0.15);  color:#e05252 !important; border:1px solid #e05252; padding:5px 10px; border-radius:5px; cursor:pointer; font-size:0.82rem; }
        .btn-rk-edit:hover   { background:#4aa3c8; color:#fff !important; }
        .btn-rk-delete:hover { background:#e05252; color:#fff !important; }
        #tableSearch { background:#2c2c2c; border:1px solid #3a3a3a; color:#f0ece4; border-radius:6px; padding:7px 12px; font-size:0.88rem; width:200px; }
    </style>
</head>
<body>
<div class="admin-wrapper">
    <aside class="sidebar">
        <div class="sidebar-brand"><h6><i class="bi bi-gem me-2"></i>RK GROUP</h6><small>Admin Panel</small></div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/gallery"><i class="bi bi-images"></i> Gallery</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/products"><i class="bi bi-box-seam"></i> Products</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/inquiries"><i class="bi bi-chat-dots"></i> Inquiries</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/bookings"><i class="bi bi-calendar-check"></i> Bookings</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/sites"><i class="bi bi-building"></i> Work Sites</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/workers" class="active"><i class="bi bi-people"></i> Workers</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
        </ul>
    </aside>
    <div class="main-content">
        <div class="topbar">
            <h5><i class="bi bi-people me-2" style="color:var(--primary);"></i>Worker Management</h5>
            <a href="${pageContext.request.contextPath}/admin/logout" class="btn-logout"><i class="bi bi-box-arrow-right me-1"></i>Logout</a>
        </div>
        <div class="page-content">
            <div class="page-header">
                <h4>All <span>Workers</span></h4>
                <div class="d-flex gap-2">
                    <input type="text" id="tableSearch" class="form-control form-control-sm"
                           placeholder="Search..." style="background:var(--dark-3);border-color:#3a3a3a;color:var(--light);width:180px;">
                    <button class="btn-admin-primary" data-bs-toggle="modal" data-bs-target="#addWorkerModal">
                        <i class="bi bi-person-plus me-1"></i>Add Worker
                    </button>
                </div>
            </div>
            <div style="background:#222;border:1px solid #333;border-radius:8px;overflow:hidden;">
                <table class="rk-table">
                    <thead>
                        <tr><th>#</th><th>Name</th><th>Phone</th><th>Skill</th><th>Daily Salary</th><th>Assigned Site</th><th>Joined</th><th>Status</th><th>Actions</th></tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty workers}">
                                <c:forEach var="w" items="${workers}" varStatus="s">
                                    <tr>
                                        <td style="color:#f0ece4;">${s.count}</td>
                                        <td><strong style="color:#f0ece4;">${w.name}</strong></td>
                                        <td><a href="tel:${w.phone}" style="color:var(--primary);">${w.phone}</a></td>
                                        <td><span style="background:rgba(200,164,92,0.1);color:var(--primary);padding:3px 10px;border-radius:20px;font-size:0.8rem;">${w.skill}</span></td>
                                        <td style="color:var(--success);font-weight:600;">₹${w.dailySalary}/day</td>
                                        <td style="font-size:0.85rem;color:#ffffff;">${not empty w.siteName ? w.siteName : '<span style="color:var(--muted);">Unassigned</span>'}</td>
                                        <td style="font-size:0.82rem;color:#f0ece4;">${w.joinedDate}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${w.active}"><span class="rk-badge-green">Active</span></c:when>
                                                <c:otherwise><span class="rk-badge-red">Inactive</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="d-flex gap-1">
                                                <button class="btn-rk-edit btn-open-edit"
                                                        data-bs-toggle="modal" data-bs-target="#editWorkerModal"
                                                        data-id="${w.id}" data-name="${w.name}"
                                                        data-phone="${w.phone}" data-skill="${w.skill}"
                                                        data-dailysalary="${w.dailySalary}" data-siteid="${w.siteId}"
                                                        data-attendancenote="${w.attendanceNote}"
                                                        data-isactive="${w.active ? '1' : '0'}">
                                                    <i class="bi bi-pencil"></i>
                                                </button>
                                                <form action="${pageContext.request.contextPath}/admin/workers" method="post" style="display:inline;">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="id" value="${w.id}">
                                                    <button type="submit" class="btn-rk-delete delete-btn"><i class="bi bi-trash"></i></button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr><td colspan="9" style="text-align:center;padding:40px;color:var(--muted);">No workers added yet.</td></tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Add Worker Modal -->
<div class="modal fade" id="addWorkerModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="background:var(--dark-2);border:1px solid var(--dark-3);color:var(--light);">
            <div class="modal-header" style="border-color:var(--dark-3);">
                <h5 class="modal-title" style="color:var(--primary);"><i class="bi bi-person-plus me-2"></i>Add Worker</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/workers" method="post" class="needs-validation" novalidate>
                <input type="hidden" name="action" value="add">
                <div class="modal-body admin-form-card" style="border:none;">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Full Name *</label>
                            <input type="text" class="form-control" name="name" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Phone *</label>
                            <input type="tel" class="form-control" name="phone" maxlength="10" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Skill / Trade</label>
                            <input type="text" class="form-control" name="skill" placeholder="e.g. Carpenter, Painter">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Daily Salary (₹)</label>
                            <input type="number" class="form-control" name="dailySalary" min="0" step="0.01">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Assign to Site</label>
                            <select class="form-select" name="siteId">
                                <option value="">— Not Assigned —</option>
                                <c:forEach var="site" items="${allSites}">
                                    <option value="${site.id}">${site.siteName} (${site.status})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Joining Date</label>
                            <input type="date" class="form-control" name="joinedDate">
                        </div>
                        <div class="col-12">
                            <label class="form-label">Attendance / Notes</label>
                            <textarea class="form-control" name="attendanceNote" rows="2"></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="border-color:var(--dark-3);">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn-admin-primary">Add Worker</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Worker Modal -->
<div class="modal fade" id="editWorkerModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="background:var(--dark-2);border:1px solid var(--dark-3);color:var(--light);">
            <div class="modal-header" style="border-color:var(--dark-3);">
                <h5 class="modal-title" style="color:var(--primary);"><i class="bi bi-pencil me-2"></i>Edit Worker</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form id="editForm" action="${pageContext.request.contextPath}/admin/workers" method="post">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="id">
                <div class="modal-body admin-form-card" style="border:none;">
                    <div class="row g-3">
                        <div class="col-md-6"><label class="form-label">Name</label><input type="text" class="form-control" name="name" required></div>
                        <div class="col-md-6"><label class="form-label">Phone</label><input type="tel" class="form-control" name="phone" maxlength="10"></div>
                        <div class="col-md-6"><label class="form-label">Skill</label><input type="text" class="form-control" name="skill"></div>
                        <div class="col-md-6"><label class="form-label">Daily Salary (₹)</label><input type="number" class="form-control" name="dailysalary" min="0" step="0.01"></div>
                        <div class="col-md-6">
                            <label class="form-label">Assign to Site</label>
                            <select class="form-select" name="siteId">
                                <option value="">— Not Assigned —</option>
                                <c:forEach var="site" items="${allSites}">
                                    <option value="${site.id}">${site.siteName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Active?</label>
                            <select class="form-select" name="isActive">
                                <option value="1">Yes</option><option value="0">No</option>
                            </select>
                        </div>
                        <div class="col-12"><label class="form-label">Notes</label><textarea class="form-control" name="attendancenote" rows="2"></textarea></div>
                    </div>
                </div>
                <div class="modal-footer" style="border-color:var(--dark-3);">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn-admin-primary">Update Worker</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/admin.js"></script>
</body>
</html>
