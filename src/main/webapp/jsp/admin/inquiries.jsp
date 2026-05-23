<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<% if (session.getAttribute("loggedAdmin") == null) { response.sendRedirect(request.getContextPath() + "/admin/login"); return; } %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inquiries | RK GROUP Admin</title>
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
        .rk-badge-green  { background:rgba(76,175,120,0.15);  color:#4caf78 !important; border:1px solid #4caf78;  padding:4px 12px; border-radius:20px; font-size:0.78rem; font-weight:600; }
        .rk-badge-yellow { background:rgba(240,168,48,0.15);  color:#f0a830 !important; border:1px solid #f0a830;  padding:4px 12px; border-radius:20px; font-size:0.78rem; font-weight:600; }
        .rk-badge-purple { background:rgba(160,120,220,0.15); color:#c080f0 !important; border:1px solid #c080f0;  padding:4px 12px; border-radius:20px; font-size:0.78rem; font-weight:600; }
        .btn-wa     { background:#25D366; color:#fff !important; border:none; padding:5px 10px; border-radius:6px; font-size:0.76rem; font-weight:600; text-decoration:none; display:inline-flex; align-items:center; gap:4px; }
        .btn-call   { background:rgba(74,163,200,0.15); color:#4aa3c8 !important; border:1px solid #4aa3c8; padding:5px 10px; border-radius:6px; font-size:0.76rem; font-weight:600; text-decoration:none; display:inline-flex; align-items:center; gap:4px; }
        .btn-reply  { background:rgba(200,164,92,0.15); color:#c8a45c !important; border:1px solid #c8a45c; padding:5px 10px; border-radius:6px; font-size:0.76rem; font-weight:600; cursor:pointer; display:inline-flex; align-items:center; gap:4px; }
        #tableSearch { background:#2c2c2c; border:1px solid #3a3a3a; color:#f0ece4; border-radius:6px; padding:7px 12px; font-size:0.88rem; width:220px; }
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
            <li><a href="${pageContext.request.contextPath}/admin/inquiries" class="active"><i class="bi bi-chat-dots"></i> Inquiries</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/bookings"><i class="bi bi-calendar-check"></i> Bookings</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/sites"><i class="bi bi-building"></i> Work Sites</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/workers"><i class="bi bi-people"></i> Workers</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
        </ul>
    </aside>

    <div class="main-content">
        <div class="topbar">
            <h5><i class="bi bi-chat-dots me-2" style="color:#c8a45c;"></i>Customer Inquiries</h5>
            <a href="${pageContext.request.contextPath}/admin/logout" class="btn-logout"><i class="bi bi-box-arrow-right me-1"></i>Logout</a>
        </div>

        <div class="page-content">
            <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:24px;flex-wrap:wrap;gap:12px;">
                <h4 style="color:#f0ece4;margin:0;">All <span style="color:#c8a45c;">Inquiries</span></h4>
                <input type="text" id="tableSearch" placeholder="Search inquiries...">
            </div>

            <div style="background:#222;border:1px solid #333;border-radius:8px;overflow:hidden;">
                <table class="rk-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Customer</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>Product / Message</th>
                            <th>Status</th>
                            <th>Date</th>
                            <th>Contact & Reply</th>
                        </tr>
                    </thead>
                    <tbody id="inquiryTableBody">
                        <c:choose>
                            <c:when test="${not empty inquiries}">
                                <c:forEach var="inq" items="${inquiries}" varStatus="s">
                                    <tr>
                                        <td>${s.count}</td>
                                        <td>
                                            <strong>${inq.name}</strong>
                                        </td>
                                        <td style="color:#ffffff;">${inq.phone}</td>
                                        <td style="color:#ffffff;font-size:0.82rem;">
                                            ${not empty inq.email ? inq.email : '—'}
                                        </td>
                                        <td style="font-size:0.82rem;max-width:200px;">
                                            <c:if test="${not empty inq.productName}">
                                                <span style="color:#c8a45c;font-size:0.76rem;display:block;margin-bottom:2px;">
                                                    <i class="bi bi-box-seam me-1"></i>${inq.productName}
                                                </span>
                                            </c:if>
                                            <span style="color:#ffffff;">
                                                ${not empty inq.message ? (inq.message.length() > 50 ? inq.message.substring(0,50).concat('...') : inq.message) : '—'}
                                            </span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${inq.status eq 'new'}">    <span class="rk-badge-purple">New</span></c:when>
                                                <c:when test="${inq.status eq 'read'}">   <span class="rk-badge-yellow">Read</span></c:when>
                                                <c:otherwise>                             <span class="rk-badge-green">Replied</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="color:#ffffff;font-size:0.8rem;">${inq.createdAt}</td>
                                        <td>
                                            <div style="display:flex;flex-direction:column;gap:5px;">
                                                <%-- WhatsApp Direct Reply --%>
                                                <a href="https://wa.me/91${inq.phone}?text=Dear%20${inq.name}%2C%20Thank%20you%20for%20contacting%20RK%20GROUP%20FURNITURES%20%26%20INTERIOR.%20We%20have%20received%20your%20inquiry%20and%20would%20like%20to%20discuss%20your%20requirements.%20When%20would%20be%20a%20good%20time%20to%20connect%3F"
                                                   class="btn-wa" target="_blank">
                                                    <i class="bi bi-whatsapp"></i> WhatsApp
                                                </a>
                                                <%-- Direct Call --%>
                                                <a href="tel:${inq.phone}" class="btn-call">
                                                    <i class="bi bi-telephone"></i> Call
                                                </a>
                                                <%-- Reply modal - data-* attributes use karo (EL in onclick crash karta hai JSP mein) --%>
                                                <button class="btn-reply rk-reply-btn"
                                                        data-id="${inq.id}"
                                                        data-name="${inq.name}"
                                                        data-phone="${inq.phone}"
                                                        data-email="${not empty inq.email ? inq.email : ''}"
                                                        data-status="${inq.status}"
                                                        data-product="${not empty inq.productName ? inq.productName : ''}"
                                                        data-message="${not empty inq.message ? inq.message : ''}">
                                                    <i class="bi bi-reply"></i> Reply
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr><td colspan="8" style="text-align:center;padding:50px;color:#666;">
                                    <i class="bi bi-chat-dots" style="font-size:2.5rem;display:block;margin-bottom:12px;opacity:0.3;"></i>
                                    No inquiries yet.
                                </td></tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- ====== REPLY MODAL ====== -->
<div class="modal fade" id="replyModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content" style="background:#222;border:1px solid #333;color:#f0ece4;">
            <div class="modal-header" style="border-color:#333;">
                <h5 class="modal-title" style="color:#c8a45c;"><i class="bi bi-reply me-2"></i>Inquiry Reply</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body" style="padding:24px;">

                <!-- Customer Detail Box -->
                <div style="background:#2c2c2c;border:1px solid #3a3a3a;border-radius:10px;padding:16px;margin-bottom:20px;">
                    <div class="row g-2">
                        <div class="col-sm-4">
                            <small style="color:#888;display:block;font-size:0.75rem;text-transform:uppercase;letter-spacing:1px;">Customer</small>
                            <span id="rName" style="color:#fff;font-weight:600;"></span>
                        </div>
                        <div class="col-sm-4">
                            <small style="color:#888;display:block;font-size:0.75rem;text-transform:uppercase;letter-spacing:1px;">Phone</small>
                            <span id="rPhone" style="color:#c8a45c;font-weight:600;"></span>
                        </div>
                        <div class="col-sm-4">
                            <small style="color:#888;display:block;font-size:0.75rem;text-transform:uppercase;letter-spacing:1px;">Email</small>
                            <span id="rEmail" style="color:#fff;font-size:0.88rem;"></span>
                        </div>
                        <div class="col-12 mt-2" id="rProductRow" style="display:none;">
                            <small style="color:#888;font-size:0.75rem;text-transform:uppercase;letter-spacing:1px;">Product Inquiry</small>
                            <span id="rProduct" style="color:#c8a45c;display:block;font-size:0.88rem;"></span>
                        </div>
                        <div class="col-12 mt-1">
                            <small style="color:#888;font-size:0.75rem;text-transform:uppercase;letter-spacing:1px;">Their Message</small>
                            <p id="rMessage" style="color:#fff;font-size:0.88rem;margin:4px 0 0;background:#1a1a1a;padding:10px;border-radius:6px;"></p>
                        </div>
                    </div>
                </div>

                <!-- 3 Reply Options -->
                <h6 style="color:#c8a45c;margin-bottom:14px;font-size:0.88rem;text-transform:uppercase;letter-spacing:1px;">
                    <i class="bi bi-send me-2"></i>Reply to Customer
                </h6>

                <div class="row g-3 mb-4">
                    <!-- Option 1: WhatsApp -->
                    <div class="col-md-4">
                        <div style="background:#2c2c2c;border:1px solid rgba(37,211,102,0.3);border-radius:10px;padding:16px;text-align:center;">
                            <i class="bi bi-whatsapp" style="font-size:2rem;color:#25D366;display:block;margin-bottom:8px;"></i>
                            <h6 style="color:#fff;font-size:0.88rem;margin-bottom:8px;">WhatsApp</h6>
                            <p style="color:#888;font-size:0.78rem;margin-bottom:12px;">Send a direct WhatsApp message</p>
                            <a id="waReplyBtn" href="#" target="_blank"
                               style="background:#25D366;color:#fff;padding:8px 16px;border-radius:6px;font-size:0.82rem;font-weight:600;text-decoration:none;display:inline-block;">
                                <i class="bi bi-whatsapp me-1"></i>Send WhatsApp
                            </a>
                        </div>
                    </div>

                    <!-- Option 2: Call -->
                    <div class="col-md-4">
                        <div style="background:#2c2c2c;border:1px solid rgba(74,163,200,0.3);border-radius:10px;padding:16px;text-align:center;">
                            <i class="bi bi-telephone" style="font-size:2rem;color:#4aa3c8;display:block;margin-bottom:8px;"></i>
                            <h6 style="color:#fff;font-size:0.88rem;margin-bottom:8px;">Phone Call</h6>
                            <p style="color:#888;font-size:0.78rem;margin-bottom:12px;">Call directly for quick assistance</p>
                            <a id="callReplyBtn" href="#"
                               style="background:rgba(74,163,200,0.2);color:#4aa3c8;border:1px solid #4aa3c8;padding:8px 16px;border-radius:6px;font-size:0.82rem;font-weight:600;text-decoration:none;display:inline-block;">
                                <i class="bi bi-telephone me-1"></i>Call Now
                            </a>
                        </div>
                    </div>

                    <!-- Option 3: Email -->
                    <div class="col-md-4">
                        <div style="background:#2c2c2c;border:1px solid rgba(200,164,92,0.3);border-radius:10px;padding:16px;text-align:center;">
                            <i class="bi bi-envelope" style="font-size:2rem;color:#c8a45c;display:block;margin-bottom:8px;"></i>
                            <h6 style="color:#fff;font-size:0.88rem;margin-bottom:8px;">Email</h6>
                            <p style="color:#888;font-size:0.78rem;margin-bottom:12px;">Reply via email professionally</p>
                            <a id="emailReplyBtn" href="#"
                               style="background:rgba(200,164,92,0.15);color:#c8a45c;border:1px solid #c8a45c;padding:8px 16px;border-radius:6px;font-size:0.82rem;font-weight:600;text-decoration:none;display:inline-block;">
                                <i class="bi bi-envelope me-1"></i>Send Email
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Status Update -->
                <div style="background:#2c2c2c;border:1px solid #3a3a3a;border-radius:10px;padding:16px;">
                    <h6 style="color:#c8a45c;margin-bottom:12px;font-size:0.85rem;">
                        <i class="bi bi-arrow-repeat me-2"></i>Update Inquiry Status
                    </h6>
                    <form action="${pageContext.request.contextPath}/admin/inquiries" method="post" style="display:flex;gap:10px;align-items:flex-end;flex-wrap:wrap;">
                        <input type="hidden" name="id" id="rInqId">
                        <div style="flex:1;min-width:140px;">
                            <label style="color:#888;font-size:0.8rem;display:block;margin-bottom:6px;">New Status</label>
                            <select name="status" id="rStatus"
                                    style="background:#1a1a1a;border:1px solid #3a3a3a;color:#f0ece4;padding:9px 12px;border-radius:6px;width:100%;font-size:0.88rem;">
                                <option value="new">New</option>
                                <option value="read">Read</option>
                                <option value="replied">Replied</option>
                            </select>
                        </div>
                        <button type="submit"
                                style="background:#c8a45c;color:#1a1a1a;border:none;padding:9px 20px;border-radius:6px;font-weight:600;font-size:0.88rem;cursor:pointer;white-space:nowrap;">
                            <i class="bi bi-check2 me-1"></i>Save Status
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Open reply modal using data-* attributes
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.rk-reply-btn').forEach(function(btn) {
        btn.addEventListener('click', function() {
            openReplyModal(
                this.dataset.id,
                this.dataset.name,
                this.dataset.phone,
                this.dataset.email,
                this.dataset.status,
                this.dataset.product,
                this.dataset.message
            );
        });
    });
});

function openReplyModal(id, name, phone, email, status, product, message) {
    // Populate customer details in modal
    document.getElementById('rName').textContent    = name;
    document.getElementById('rPhone').textContent   = phone;
    document.getElementById('rEmail').textContent   = email || '—';
    document.getElementById('rMessage').textContent = message || '—';
    document.getElementById('rInqId').value         = id;
    document.getElementById('rStatus').value        = status;

    // Product row show/hide
    if (product && product.trim() !== '') {
        document.getElementById('rProduct').textContent  = product;
        document.getElementById('rProductRow').style.display = 'block';
    } else {
        document.getElementById('rProductRow').style.display = 'none';
    }

    // WhatsApp message
    var waMsg = 'Dear ' + name + ', Thank you for contacting RK GROUP FURNITURES & INTERIOR. '
              + 'We have received your inquiry'
              + (product ? ' regarding ' + product + '. ' : '. ')
              + 'Our team would be happy to assist you with the details. When would be a convenient time to connect?';

    document.getElementById('waReplyBtn').href    = 'https://wa.me/91' + phone + '?text=' + encodeURIComponent(waMsg);
    document.getElementById('callReplyBtn').href  = 'tel:' + phone;

    // Email link
    var emailSubject = 'Re: Your Inquiry - RK GROUP FURNITURES & INTERIOR';
    var emailBody    = 'Dear ' + name + ',\n\nThank you for your inquiry'
                     + (product ? ' about ' + product : '') + '.\n\n'
                     + 'We would be happy to assist you.\n\n'
                     + 'Best Regards,\nRahul Vishwakarma\nRK GROUP FURNITURES & INTERIOR\nPhone: 7772897077';
    document.getElementById('emailReplyBtn').href = email
        ? 'mailto:' + email + '?subject=' + encodeURIComponent(emailSubject) + '&body=' + encodeURIComponent(emailBody)
        : 'mailto:rahulvishwakarma111999@gmail.com';

    new bootstrap.Modal(document.getElementById('replyModal')).show();
}

// Table search
document.getElementById('tableSearch').addEventListener('input', function() {
    var q = this.value.toLowerCase();
    document.querySelectorAll('#inquiryTableBody tr').forEach(function(row) {
        row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
});
</script>
</body>
</html>
