<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products | RK GROUP FURNITURES &amp; INTERIOR</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/"><i class="bi bi-gem me-2" style="color:var(--primary)"></i>RK GROUP<span>FURNITURES &amp; INTERIOR</span></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav ms-auto align-items-center gap-1">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/gallery">Gallery</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/products">Products</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/jsp/public/contact.jsp">Contact</a></li>
                <li class="nav-item ms-2"><a class="btn btn-gold btn-sm px-3" href="${pageContext.request.contextPath}/booking">Book Visit</a></li>
                <li class="nav-item ms-1">
                    <a href="${pageContext.request.contextPath}/admin/login"
                       style="color:#444;padding:6px 10px;display:flex;align-items:center;"
                       title="Admin Login">
                        <i class="bi bi-lock" style="font-size:1rem;"></i>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div style="background:var(--dark-2);padding:60px 0 40px;border-bottom:1px solid rgba(200,164,92,0.1);">
    <div class="container">
        <h1 class="section-title">Our <span>Products</span></h1>
        <p style="color:var(--muted);">Browse our furniture and interior product catalog. Contact us for pricing and customization.</p>

        <!-- Search Bar -->
        <div class="mt-3" style="max-width:400px;">
            <div class="input-group">
                <input type="text" id="productSearch" class="form-control contact-form"
                       placeholder="Search products..." value="${searchQuery}"
                       style="background:var(--dark-3);border-color:#3a3a3a;color:var(--light);">
                <button class="btn btn-gold" onclick="doSearch()"><i class="bi bi-search"></i></button>
            </div>
        </div>
    </div>
</div>

<!-- Success/Error from inquiry -->
<c:if test="${not empty inquirySuccess}">
    <div class="container mt-3">
        <div class="alert-success-rk"><i class="bi bi-check-circle me-2"></i>Inquiry sent! We will contact you shortly.</div>
    </div>
</c:if>

<section class="section" style="padding-top:50px;">
    <div class="container">
        <c:choose>
            <c:when test="${not empty products}">
                <c:if test="${not empty searchQuery}">
                    <p style="color:var(--muted);margin-bottom:24px;">Search results for: <span style="color:var(--primary);">"${searchQuery}"</span> (${products.size()} found)</p>
                </c:if>
                <div class="row g-4">
                    <c:forEach var="prod" items="${products}">
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="rk-card h-100 d-flex flex-column">
                                <div style="position:relative;overflow:hidden;">
                                    <c:choose>
                                        <c:when test="${not empty prod.imageFilename}">
                                            <img src="${pageContext.request.contextPath}/uploads/${prod.imageFilename}"
                                                 alt="${prod.name}" style="width:100%;height:210px;object-fit:cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <div style="height:210px;background:var(--dark-3);display:flex;align-items:center;justify-content:center;">
                                                <i class="bi bi-box-seam" style="font-size:3rem;color:var(--muted);opacity:0.3;"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <!-- Stock badge -->
                                    <span style="position:absolute;top:10px;right:10px;"
                                          class="${prod.stockStatus == 'in_stock' ? 'badge-instock' : prod.stockStatus == 'out_of_stock' ? 'badge-outstock' : 'badge-onorder'}"
                                          style="padding:4px 10px;border-radius:20px;font-size:0.78rem;">
                                        ${prod.stockStatus == 'in_stock' ? 'In Stock' : prod.stockStatus == 'out_of_stock' ? 'Out of Stock' : 'On Order'}
                                    </span>
                                </div>
                                <div class="card-body p-3 d-flex flex-column">
                                    <small style="color:var(--primary);font-size:0.78rem;">${prod.categoryName}</small>
                                    <h6 class="card-title mt-1 mb-1">${prod.name}</h6>
                                    <p class="card-text flex-grow-1">${prod.description}</p>
                                    <div class="d-flex justify-content-between align-items-center mt-3">
                                        <span class="price-tag">₹${String.format("%,.0f", prod.price)}</span>
                                        <button class="btn btn-outline-gold btn-sm"
                                                data-bs-toggle="modal" data-bs-target="#inquiryModal"
                                                data-productid="${prod.id}" data-productname="${prod.name}">
                                            <i class="bi bi-chat-dots me-1"></i>Inquire
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5">
                    <i class="bi bi-box-seam" style="font-size:4rem;color:var(--muted);opacity:0.3;"></i>
                    <h5 style="color:var(--muted);margin-top:16px;">No products found.</h5>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- Inquiry Modal -->
<div class="modal fade" id="inquiryModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="background:var(--dark-2);border:1px solid var(--dark-3);color:var(--light);">
            <div class="modal-header" style="border-color:var(--dark-3);">
                <h5 class="modal-title" style="color:var(--primary);">Send Inquiry</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/products" method="post">
                <input type="hidden" name="action" value="inquiry">
                <input type="hidden" name="productId" id="modalProductId">
                <div class="modal-body contact-form">
                    <p id="modalProductName" style="color:var(--muted);font-size:0.88rem;margin-bottom:16px;"></p>
                    <div class="mb-3">
                        <label>Your Name *</label>
                        <input type="text" class="form-control" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label>Phone *</label>
                        <input type="tel" class="form-control" name="phone" maxlength="10" required>
                    </div>
                    <div class="mb-3">
                        <label>Email</label>
                        <input type="email" class="form-control" name="email">
                    </div>
                    <div class="mb-3">
                        <label>Message</label>
                        <textarea class="form-control" name="message" rows="3"></textarea>
                    </div>
                </div>
                <div class="modal-footer" style="border-color:var(--dark-3);">
                    <button type="submit" class="btn btn-gold">Send Inquiry</button>
                </div>
            </form>
        </div>
    </div>
</div>

<a href="https://wa.me/917772897077" class="whatsapp-float" target="_blank"><i class="bi bi-whatsapp"></i></a>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Populate inquiry modal with product info
document.getElementById('inquiryModal').addEventListener('show.bs.modal', function(e) {
    var btn = e.relatedTarget;
    document.getElementById('modalProductId').value   = btn.getAttribute('data-productid');
    document.getElementById('modalProductName').textContent = 'Product: ' + btn.getAttribute('data-productname');
});
function doSearch() {
    var q = document.getElementById('productSearch').value.trim();
    if (q) window.location.href = '${pageContext.request.contextPath}/products?search=' + encodeURIComponent(q);
}
// Allow Enter key in search box
document.getElementById('productSearch').addEventListener('keypress', function(e) {
    if (e.key === 'Enter') doSearch();
});
</script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
