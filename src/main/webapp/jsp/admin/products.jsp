<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    if (session.getAttribute("loggedAdmin") == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login"); return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products | RK GROUP Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet">
    <style>
        /* DIRECT OVERRIDE - Bootstrap se bhi strong */
        .rk-table { width:100%; border-collapse:collapse; }
        .rk-table thead th {
            background:#2c2c2c;
            color:#c8a45c !important;
            font-size:0.78rem;
            letter-spacing:1px;
            text-transform:uppercase;
            padding:14px 16px;
            border-bottom:1px solid #333;
            font-weight:600;
        }
        .rk-table tbody tr { border-bottom:1px solid #2a2a2a; }
        .rk-table tbody tr:hover { background:rgba(200,164,92,0.04); }
        .rk-table tbody td {
            padding:13px 16px;
            color:#ffffff !important;
            font-size:0.88rem;
            vertical-align:middle;
            border:none !important;
        }
        .rk-table tbody td * { color:#ffffff !important; }
        .rk-table tbody td a { color:#c8a45c !important; }
        .rk-table tbody td small { color:#888 !important; }
        /* Badges */
        .rk-badge-green  { background:rgba(76,175,120,0.15);  color:#4caf78 !important; border:1px solid #4caf78;  padding:4px 12px; border-radius:20px; font-size:0.78rem; font-weight:600; white-space:nowrap; }
        .rk-badge-red    { background:rgba(224,82,82,0.15);   color:#e05252 !important; border:1px solid #e05252;  padding:4px 12px; border-radius:20px; font-size:0.78rem; font-weight:600; white-space:nowrap; }
        .rk-badge-yellow { background:rgba(240,168,48,0.15);  color:#f0a830 !important; border:1px solid #f0a830;  padding:4px 12px; border-radius:20px; font-size:0.78rem; font-weight:600; white-space:nowrap; }
        .rk-badge-blue   { background:rgba(74,163,200,0.15);  color:#4aa3c8 !important; border:1px solid #4aa3c8;  padding:4px 12px; border-radius:20px; font-size:0.78rem; font-weight:600; white-space:nowrap; }
        /* Action buttons */
        .btn-rk-edit   { background:rgba(74,163,200,0.15);  color:#4aa3c8 !important; border:1px solid #4aa3c8; padding:5px 10px; border-radius:5px; cursor:pointer; font-size:0.82rem; }
        .btn-rk-delete { background:rgba(224,82,82,0.15);   color:#e05252 !important; border:1px solid #e05252; padding:5px 10px; border-radius:5px; cursor:pointer; font-size:0.82rem; }
        .btn-rk-edit:hover   { background:#4aa3c8; color:#fff !important; }
        .btn-rk-delete:hover { background:#e05252; color:#fff !important; }
        /* Search input */
        #tableSearch { background:#2c2c2c; border:1px solid #3a3a3a; color:#f0ece4; border-radius:6px; padding:7px 12px; font-size:0.88rem; width:200px; }
        #tableSearch:focus { outline:none; border-color:#c8a45c; }
    </style>
</head>
<body>
<div class="admin-wrapper">

    <aside class="sidebar">
        <div class="sidebar-brand"><h6><i class="bi bi-gem me-2"></i>RK GROUP</h6><small>Admin Panel</small></div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/gallery"><i class="bi bi-images"></i> Gallery</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/products" class="active"><i class="bi bi-box-seam"></i> Products</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/inquiries"><i class="bi bi-chat-dots"></i> Inquiries</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/bookings"><i class="bi bi-calendar-check"></i> Bookings</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/sites"><i class="bi bi-building"></i> Work Sites</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/workers"><i class="bi bi-people"></i> Workers</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
        </ul>
    </aside>

    <div class="main-content">
        <div class="topbar">
            <h5><i class="bi bi-box-seam me-2" style="color:#c8a45c;"></i>Products Management</h5>
            <a href="${pageContext.request.contextPath}/admin/logout" class="btn-logout"><i class="bi bi-box-arrow-right me-1"></i>Logout</a>
        </div>

        <div class="page-content">

            <c:if test="${not empty sessionScope.flashMsg}">
                <div style="background:rgba(76,175,120,0.1);border:1px solid #4caf78;color:#4caf78;padding:12px 18px;border-radius:8px;margin-bottom:20px;">
                    <i class="bi bi-check-circle me-2"></i>${sessionScope.flashMsg}
                </div>
                <% session.removeAttribute("flashMsg"); %>
            </c:if>

            <!-- Page Header -->
            <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:24px;flex-wrap:wrap;gap:12px;">
                <h4 style="color:#f0ece4;margin:0;">Products <span style="color:#c8a45c;">List</span></h4>
                <div style="display:flex;gap:10px;align-items:center;">
                    <input type="text" id="tableSearch" placeholder="Search products...">
                    <button class="btn-admin-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">
                        <i class="bi bi-plus-lg me-1"></i>Add Product
                    </button>
                </div>
            </div>

            <!-- Table -->
            <div style="background:#222;border:1px solid #333;border-radius:8px;overflow:hidden;">
                <table class="rk-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Image</th>
                            <th>Product Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="productTableBody">
                        <c:choose>
                            <c:when test="${not empty products}">
                                <c:forEach var="p" items="${products}" varStatus="s">
                                    <tr>
                                        <td>${s.count}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty p.imageFilename}">
                                                    <img src="${pageContext.request.contextPath}/uploads/${p.imageFilename}"
                                                         style="width:52px;height:44px;object-fit:cover;border-radius:5px;border:1px solid #333;" alt="${p.name}">
                                                </c:when>
                                                <c:otherwise>
                                                    <div style="width:52px;height:44px;background:#2c2c2c;border-radius:5px;display:flex;align-items:center;justify-content:center;">
                                                        <i class="bi bi-image" style="color:#666;"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span style="font-weight:600;color:#ffffff;display:block;">${p.name}</span>
                                            <small style="color:#888;">
                                                ${p.description.length() > 45 ? p.description.substring(0,45).concat('...') : p.description}
                                            </small>
                                        </td>
                                        <td style="color:#ffffff;">${p.categoryName}</td>
                                        <td style="color:#4caf78;font-weight:700;">₹${String.format("%,.0f", p.price)}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${p.stockStatus == 'in_stock'}"><span class="rk-badge-green">In Stock</span></c:when>
                                                <c:when test="${p.stockStatus == 'out_of_stock'}"><span class="rk-badge-red">Out of Stock</span></c:when>
                                                <c:otherwise><span class="rk-badge-yellow">On Order</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${p.active}"><span class="rk-badge-green">Active</span></c:when>
                                                <c:otherwise><span class="rk-badge-red">Inactive</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div style="display:flex;gap:6px;align-items:center;">
                                                <%-- Edit button --%>
                                                <button class="btn-rk-edit btn-open-edit"
                                                        data-bs-toggle="modal" data-bs-target="#editProductModal"
                                                        data-id="${p.id}"
                                                        data-name="${p.name}"
                                                        data-description="${p.description}"
                                                        data-price="${p.price}"
                                                        data-categoryid="${p.categoryId}"
                                                        data-stockstatus="${p.stockStatus}"
                                                        data-isactive="${p.active ? '1' : '0'}">
                                                    <i class="bi bi-pencil"></i>
                                                </button>

                                                <c:choose>
                                                    <c:when test="${p.active}">
                                                        <%-- Active product: Deactivate karo (soft delete) --%>
                                                        <form action="${pageContext.request.contextPath}/admin/products" method="post" style="display:inline;">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="id" value="${p.id}">
                                                            <button type="submit" class="btn-rk-delete"
                                                                    style="background:rgba(240,168,48,0.15);color:#f0a830;border:1px solid #f0a830;"
                                                                    onclick="return confirm('Product ko inactive karein?')"
                                                                    title="Inactive karo">
                                                                <i class="bi bi-eye-slash"></i>
                                                            </button>
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <%-- Inactive product: Permanently DELETE karo --%>
                                                        <form action="${pageContext.request.contextPath}/admin/products" method="post" style="display:inline;">
                                                            <input type="hidden" name="action" value="permanentDelete">
                                                            <input type="hidden" name="id" value="${p.id}">
                                                            <button type="submit"
                                                                    style="background:rgba(224,82,82,0.3);color:#e05252;border:1px solid #e05252;padding:5px 10px;border-radius:5px;cursor:pointer;font-size:0.78rem;font-weight:700;"
                                                                    onclick="return confirm('PERMANENTLY delete karein? Wapis nahi aayega!')"
                                                                    title="Permanently Delete">
                                                                <i class="bi bi-trash-fill"></i> Del
                                                            </button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr><td colspan="8" style="text-align:center;padding:50px;color:#666;">
                                    <i class="bi bi-box-seam" style="font-size:2.5rem;display:block;margin-bottom:12px;"></i>
                                    No products yet. Click "Add Product" to get started.
                                </td></tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div><!-- end page-content -->
    </div><!-- end main-content -->
</div><!-- end admin-wrapper -->

<!-- ====== ADD PRODUCT MODAL ====== -->
<div class="modal fade" id="addProductModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content" style="background:#222;border:1px solid #333;color:#f0ece4;">
            <div class="modal-header" style="border-color:#333;">
                <h5 class="modal-title" style="color:#c8a45c;"><i class="bi bi-plus-circle me-2"></i>Add New Product</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/products" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="add">
                <div class="modal-body admin-form-card" style="border:none;padding:24px;">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Product Name *</label>
                            <input type="text" class="form-control" name="name" required placeholder="e.g. Teak Wood Door">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Price (₹) *</label>
                            <input type="number" class="form-control" name="price" required placeholder="0.00" min="0" step="0.01">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Category</label>
                            <select class="form-select" name="categoryId">
                                <option value="6">Doors</option>
                                <option value="7">Sofas</option>
                                <option value="8">Wardrobes</option>
                                <option value="9">Beds</option>
                                <option value="10">Windows</option>
                                <option value="11">Interior Panels</option>
                            </select>
                        </div>
                        <div class="col-md-8">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" name="description" rows="3" placeholder="Product details, material, size..."></textarea>
                        </div>
                        <div class="col-md-4">
                            <div class="mb-3">
                                <label class="form-label">Stock Status</label>
                                <select class="form-select" name="stockStatus">
                                    <option value="in_stock">In Stock</option>
                                    <option value="out_of_stock">Out of Stock</option>
                                    <option value="on_order">On Order</option>
                                </select>
                            </div>
                            <label class="form-label">Product Image</label>
                            <input type="file" class="form-control image-upload" name="image" accept="image/*">
                            <img id="imgPreview" src="#" alt="Preview" style="display:none;max-height:80px;margin-top:8px;border-radius:5px;">
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="border-color:#333;">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn-admin-primary">Save Product</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- ====== EDIT PRODUCT MODAL ====== -->
<div class="modal fade" id="editProductModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content" style="background:#222;border:1px solid #333;color:#f0ece4;">
            <div class="modal-header" style="border-color:#333;">
                <h5 class="modal-title" style="color:#c8a45c;"><i class="bi bi-pencil me-2"></i>Edit Product</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form id="editForm" action="${pageContext.request.contextPath}/admin/products" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="id" id="editId">
                <div class="modal-body admin-form-card" style="border:none;padding:24px;">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Product Name *</label>
                            <input type="text" class="form-control" name="name" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Price (₹) *</label>
                            <input type="number" class="form-control" name="price" required min="0" step="0.01">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Category</label>
                            <select class="form-select" name="categoryId">
                                <option value="6">Doors</option>
                                <option value="7">Sofas</option>
                                <option value="8">Wardrobes</option>
                                <option value="9">Beds</option>
                                <option value="10">Windows</option>
                                <option value="11">Interior Panels</option>
                            </select>
                        </div>
                        <div class="col-md-8">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" name="description" rows="3"></textarea>
                        </div>
                        <div class="col-md-4">
                            <div class="mb-3">
                                <label class="form-label">Stock Status</label>
                                <select class="form-select" name="stockStatus">
                                    <option value="in_stock">In Stock</option>
                                    <option value="out_of_stock">Out of Stock</option>
                                    <option value="on_order">On Order</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Active?</label>
                                <select class="form-select" name="isActive">
                                    <option value="1">Yes</option>
                                    <option value="0">No</option>
                                </select>
                            </div>
                            <label class="form-label">New Image (optional)</label>
                            <input type="file" class="form-control image-upload" name="image" accept="image/*">
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="border-color:#333;">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn-admin-primary">Update Product</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/admin.js"></script>
<script>
// Live table search
document.getElementById('tableSearch').addEventListener('input', function() {
    var q = this.value.toLowerCase();
    document.querySelectorAll('#productTableBody tr').forEach(function(row) {
        row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
});
</script>
</body>
</html>
