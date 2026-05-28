<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<% if (session.getAttribute("loggedAdmin") == null) { response.sendRedirect(request.getContextPath() + "/admin/login"); return; } %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback | RK GROUP Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet">
    <style>
        .rk-table { width:100%; border-collapse:collapse; }
        .rk-table thead th { background:#2c2c2c; color:#c8a45c !important; font-size:0.78rem; letter-spacing:1px; text-transform:uppercase; padding:14px 16px; border-bottom:1px solid #333; font-weight:600; }
        .rk-table tbody tr { border-bottom:1px solid #2a2a2a; }
        .rk-table tbody tr:hover { background:rgba(200,164,92,0.04); }
        .rk-table tbody td { padding:13px 16px; color:#ffffff !important; font-size:0.88rem; vertical-align:middle; border:none !important; }
        .rk-table tbody td strong { color:#ffffff !important; }
        .rk-table tbody td small { color:#888 !important; }
        .btn-rk-delete { background:rgba(224,82,82,0.15); color:#e05252 !important; border:1px solid #e05252; padding:5px 12px; border-radius:5px; cursor:pointer; font-size:0.8rem; }
        .btn-rk-delete:hover { background:#e05252; color:#fff !important; }
        #tableSearch { background:#2c2c2c; border:1px solid #3a3a3a; color:#f0ece4; border-radius:6px; padding:7px 12px; font-size:0.88rem; width:220px; }
        .star-gold { color:#c8a45c; }
        .star-empty { color:#444; }
        .avg-box { background:rgba(200,164,92,0.1); border:1px solid rgba(200,164,92,0.25); border-radius:10px; padding:20px 28px; display:inline-flex; align-items:center; gap:16px; }
    </style>
</head>
<body>
<div class="admin-wrapper">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <div class="sidebar-brand"><h6><i class="bi bi-gem me-2"></i>RK GROUP</h6><small>Admin Panel</small></div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/gallery"><i class="bi bi-images"></i> Gallery</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/products"><i class="bi bi-box-seam"></i> Products</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/inquiries"><i class="bi bi-chat-dots"></i> Inquiries</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/bookings"><i class="bi bi-calendar-check"></i> Bookings</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/feedback" class="active"><i class="bi bi-star"></i> Feedback</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/sites"><i class="bi bi-building"></i> Work Sites</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/workers"><i class="bi bi-people"></i> Workers</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
        </ul>
    </aside>

    <div class="main-content">
        <div class="topbar">
            <h5><i class="bi bi-star me-2" style="color:#c8a45c;"></i>Customer Feedback</h5>
            <a href="${pageContext.request.contextPath}/admin/logout" class="btn-logout"><i class="bi bi-box-arrow-right me-1"></i>Logout</a>
        </div>

        <div class="page-content">

            <!-- Summary -->
            <div class="mb-4">
                <div class="avg-box">
                    <div>
                        <div style="font-family:'Playfair Display',serif;font-size:2.8rem;font-weight:700;color:#c8a45c;line-height:1;">
                            ${String.format("%.1f", avgRating)}
                        </div>
                        <div style="color:#888;font-size:0.8rem;margin-top:4px;">Average Rating</div>
                    </div>
                    <div>
                        <div style="font-size:1.8rem;color:#c8a45c;letter-spacing:3px;">★★★★★</div>
                        <div style="color:#888;font-size:0.8rem;">${feedbackList.size()} total reviews</div>
                    </div>
                    <div style="margin-left:16px;">
                        <a href="${pageContext.request.contextPath}/feedback" target="_blank"
                           style="background:rgba(200,164,92,0.1);border:1px solid rgba(200,164,92,0.25);color:#c8a45c;padding:8px 18px;border-radius:8px;font-size:0.85rem;text-decoration:none;display:inline-flex;align-items:center;gap:6px;">
                            <i class="bi bi-eye"></i> View Public Page
                        </a>
                    </div>
                </div>
            </div>

            <!-- Page Header -->
            <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:24px;flex-wrap:wrap;gap:12px;">
                <h4 style="color:#f0ece4;margin:0;">All <span style="color:#c8a45c;">Reviews</span></h4>
                <input type="text" id="tableSearch" placeholder="Search feedback...">
            </div>

            <!-- Table -->
            <div style="background:#222;border:1px solid #333;border-radius:8px;overflow:hidden;">
                <table class="rk-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Customer</th>
                            <th>Phone</th>
                            <th>Location</th>
                            <th>Rating</th>
                            <th>Review</th>
                            <th>Date</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="feedbackTableBody">
                        <c:choose>
                            <c:when test="${not empty feedbackList}">
                                <c:forEach var="fb" items="${feedbackList}" varStatus="s">
                                    <tr>
                                        <td>${s.count}</td>
                                        <td><strong>${fb.name}</strong></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty fb.phone}">
                                                    <a href="tel:${fb.phone}" style="color:#c8a45c;">${fb.phone}</a>
                                                </c:when>
                                                <c:otherwise><span style="color:#555;">—</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${not empty fb.location ? fb.location : '—'}</td>
                                        <td>
                                            <%-- Show stars based on rating --%>
                                            <span style="font-size:1rem;letter-spacing:2px;">
                                                <c:forEach begin="1" end="5" var="star">
                                                    <c:choose>
                                                        <c:when test="${star <= fb.rating}"><span class="star-gold">★</span></c:when>
                                                        <c:otherwise><span class="star-empty">★</span></c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </span>
                                            <small style="color:#888;margin-left:4px;">(${fb.rating}/5)</small>
                                        </td>
                                        <td style="max-width:240px;font-size:0.85rem;">
                                            ${fb.message.length() > 60 ? fb.message.substring(0,60).concat('...') : fb.message}
                                        </td>
                                        <td><small>${fb.createdAt.substring(0,10)}</small></td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/admin/feedback" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="${fb.id}">
                                                <button type="submit" class="btn-rk-delete"
                                                        onclick="return confirm('Delete this review permanently?')">
                                                    <i class="bi bi-trash"></i> Delete
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="8" style="text-align:center;padding:50px;color:#555;">
                                        <i class="bi bi-star" style="font-size:2.5rem;display:block;margin-bottom:12px;opacity:0.3;"></i>
                                        No feedback received yet.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Live search
document.getElementById('tableSearch').addEventListener('input', function() {
    var q = this.value.toLowerCase();
    document.querySelectorAll('#feedbackTableBody tr').forEach(function(row) {
        row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
});
</script>
</body>
</html>
