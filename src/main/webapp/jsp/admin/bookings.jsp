<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<% if (session.getAttribute("loggedAdmin") == null) { response.sendRedirect(request.getContextPath() + "/admin/login"); return; } %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bookings | RK GROUP Admin</title>
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
        .rk-badge-red    { background:rgba(224,82,82,0.15);   color:#e05252 !important; border:1px solid #e05252;  padding:4px 12px; border-radius:20px; font-size:0.78rem; font-weight:600; }
        .rk-badge-blue   { background:rgba(74,163,200,0.15);  color:#4aa3c8 !important; border:1px solid #4aa3c8;  padding:4px 12px; border-radius:20px; font-size:0.78rem; font-weight:600; }
        /* Contact buttons */
        .btn-wa   { background:#25D366; color:#fff !important; border:none; padding:6px 12px; border-radius:6px; font-size:0.78rem; font-weight:600; text-decoration:none; display:inline-flex; align-items:center; gap:4px; }
        .btn-call { background:rgba(74,163,200,0.15); color:#4aa3c8 !important; border:1px solid #4aa3c8; padding:6px 12px; border-radius:6px; font-size:0.78rem; font-weight:600; text-decoration:none; display:inline-flex; align-items:center; gap:4px; }
        .btn-update { background:rgba(200,164,92,0.15); color:#c8a45c !important; border:1px solid #c8a45c; padding:6px 12px; border-radius:6px; font-size:0.78rem; font-weight:600; cursor:pointer; display:inline-flex; align-items:center; gap:4px; }
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
            <li><a href="${pageContext.request.contextPath}/admin/bookings" class="active"><i class="bi bi-calendar-check"></i> Bookings</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/sites"><i class="bi bi-building"></i> Work Sites</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/workers"><i class="bi bi-people"></i> Workers</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
        </ul>
    </aside>

    <div class="main-content">
        <div class="topbar">
            <h5><i class="bi bi-calendar-check me-2" style="color:#c8a45c;"></i>Site Visit Bookings</h5>
            <a href="${pageContext.request.contextPath}/admin/logout" class="btn-logout"><i class="bi bi-box-arrow-right me-1"></i>Logout</a>
        </div>

        <div class="page-content">
            <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:24px;flex-wrap:wrap;gap:12px;">
                <h4 style="color:#f0ece4;margin:0;">All <span style="color:#c8a45c;">Bookings</span></h4>
                <input type="text" id="tableSearch" placeholder="Search bookings...">
            </div>

            <div style="background:#222;border:1px solid #333;border-radius:8px;overflow:hidden;">
                <table class="rk-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Customer</th>
                            <th>Phone</th>
                            <th>Visit Date</th>
                            <th>Address</th>
                            <th>Message</th>
                            <th>Status</th>
                            <th>Contact & Update</th>
                        </tr>
                    </thead>
                    <tbody id="bookingTableBody">
                        <c:choose>
                            <c:when test="${not empty bookings}">
                                <c:forEach var="b" items="${bookings}" varStatus="s">
                                    <tr>
                                        <td>${s.count}</td>
                                        <td>
                                            <strong>${b.customerName}</strong>
                                            <br><small>${b.createdAt}</small>
                                            <c:if test="${not empty b.adminNotes}">
                                                <br><small style="color:#c8a45c;"><i class="bi bi-chat-left-text me-1"></i>${b.adminNotes}</small>
                                            </c:if>
                                        </td>
                                        <td style="color:#ffffff;">${b.phone}</td>
                                        <td style="color:#f0a830;font-weight:600;">${b.visitDate}</td>
                                        <td style="color:#ffffff;font-size:0.82rem;">${b.address}</td>
                                        <td style="color:#ffffff;font-size:0.82rem;max-width:160px;">
                                            ${not empty b.message ? (b.message.length() > 40 ? b.message.substring(0,40).concat('...') : b.message) : '—'}
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${b.status eq 'pending'}">  <span class="rk-badge-yellow">Pending</span></c:when>
                                                <c:when test="${b.status eq 'approved'}"> <span class="rk-badge-green">Approved</span></c:when>
                                                <c:when test="${b.status eq 'rejected'}"> <span class="rk-badge-red">Rejected</span></c:when>
                                                <c:otherwise>                             <span class="rk-badge-blue">Completed</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div style="display:flex;flex-direction:column;gap:6px;">
                                                <%-- Direct WhatsApp message button --%>
                                                <a href="https://wa.me/91${b.phone}?text=Dear%20${b.customerName}%2C%20Thank%20you%20for%20booking%20a%20site%20visit%20with%20RK%20GROUP%20FURNITURES%20%26%20INTERIOR.%20Your%20visit%20request%20for%20${b.visitDate}%20has%20been%20${b.status eq 'approved' ? 'confirmed.%20We%20look%20forward%20to%20meeting%20you.' : 'received.%20We%20will%20confirm%20the%20schedule%20shortly.'}"
                                                   class="btn-wa" target="_blank">
                                                    <i class="bi bi-whatsapp"></i> WhatsApp
                                                </a>
                                                <%-- Direct Call button --%>
                                                <a href="tel:${b.phone}" class="btn-call">
                                                    <i class="bi bi-telephone"></i> Call
                                                </a>
                                                <%-- Update status button --%>
                                                <button class="btn-update"
                                                        onclick="openUpdateModal('${b.id}','${b.status}','${b.adminNotes != null ? b.adminNotes : ''}','${b.customerName}','${b.phone}')">
                                                    <i class="bi bi-pencil-square"></i> Update
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr><td colspan="8" style="text-align:center;padding:50px;color:#666;">
                                    <i class="bi bi-calendar-x" style="font-size:2.5rem;display:block;margin-bottom:12px;"></i>
                                    No bookings yet.
                                </td></tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- ====== UPDATE BOOKING MODAL ====== -->
<div class="modal fade" id="updateBookingModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="background:#222;border:1px solid #333;color:#f0ece4;">
            <div class="modal-header" style="border-color:#333;">
                <h5 class="modal-title" style="color:#c8a45c;"><i class="bi bi-pencil-square me-2"></i>Update Booking</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/bookings" method="post">
                <%-- FIXED: id field hamesha present rahega --%>
                <input type="hidden" name="id" id="modalBookingId">
                <div class="modal-body admin-form-card" style="border:none;padding:24px;">

                    <%-- Customer info display --%>
                    <div style="background:#2c2c2c;border:1px solid #3a3a3a;border-radius:8px;padding:14px;margin-bottom:20px;">
                        <p style="color:#888;font-size:0.78rem;margin-bottom:6px;text-transform:uppercase;letter-spacing:1px;">Customer Name</p>
                        <p style="color:#fff;font-weight:600;margin:0;" id="modalCustomerName">—</p>
                        <p style="color:#c8a45c;font-size:0.88rem;margin:4px 0 0;" id="modalCustomerPhone">—</p>
                    </div>

                    <div class="mb-3">
                        <label class="form-label" style="color:#888;font-size:0.85rem;">Status Update</label>
                        <select class="form-select" name="status" id="modalStatus"
                                style="background:#2c2c2c;border-color:#3a3a3a;color:#f0ece4;">
                            <option value="pending">Pending</option>
                            <option value="approved">Approved</option>
                            <option value="rejected">Rejected</option>
                            <option value="completed">Completed</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label" style="color:#888;font-size:0.85rem;">Admin Note / Customer Message</label>
                        <textarea class="form-control" name="adminNotes" id="modalNotes" rows="3"
                                  style="background:#2c2c2c;border-color:#3a3a3a;color:#f0ece4;"
                                  placeholder="e.g. Visit confirmed for 3:00 PM on the scheduled date..."></textarea>
                    </div>

                    <%-- Quick WhatsApp reply from inside modal --%>
                    <div style="background:rgba(37,211,102,0.07);border:1px solid rgba(37,211,102,0.2);border-radius:8px;padding:12px;">
                        <p style="color:#25D366;font-size:0.8rem;margin-bottom:8px;"><i class="bi bi-whatsapp me-1"></i>Send a WhatsApp message to the customer:</p>
                        <a id="modalWaLink" href="#" target="_blank"
                           style="background:#25D366;color:#fff;padding:7px 16px;border-radius:6px;font-size:0.82rem;font-weight:600;text-decoration:none;display:inline-flex;align-items:center;gap:6px;">
                            <i class="bi bi-whatsapp"></i> Send WhatsApp Message
                        </a>
                    </div>
                </div>
                <div class="modal-footer" style="border-color:#333;">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn-admin-primary">
                        <i class="bi bi-check2 me-1"></i>Save Update
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Modal populate karo
function openUpdateModal(id, status, notes, name, phone) {
    document.getElementById('modalBookingId').value  = id;
    document.getElementById('modalStatus').value     = status;
    document.getElementById('modalNotes').value      = notes;
    document.getElementById('modalCustomerName').textContent  = name;
    document.getElementById('modalCustomerPhone').textContent = phone;

    // WhatsApp link update karo
    var msg = 'Dear ' + name + ', This is a message from RK GROUP FURNITURES & INTERIOR. Your site visit booking status has been updated to: ' + status + '. Please feel free to contact us for any queries.';
    document.getElementById('modalWaLink').href = 'https://wa.me/91' + phone + '?text=' + encodeURIComponent(msg);

    var modal = new bootstrap.Modal(document.getElementById('updateBookingModal'));
    modal.show();
}

// Table search
document.getElementById('tableSearch').addEventListener('input', function() {
    var q = this.value.toLowerCase();
    document.querySelectorAll('#bookingTableBody tr').forEach(function(row) {
        row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
});
</script>
</body>
</html>
