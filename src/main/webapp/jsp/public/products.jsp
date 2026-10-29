<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-N3S6BBWZFW"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-N3S6BBWZFW');
</script>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products | RK GROUP FURNITURES &amp; INTERIOR</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <style>
        .product-card {
            background: var(--white);
            border: 1px solid var(--mid-gray);
            border-radius: var(--radius-lg);
            overflow: hidden;
            transition: var(--transition);
            box-shadow: var(--shadow-sm);
            height: 100%; display: flex; flex-direction: column;
        }
        .product-card:hover { transform: translateY(-6px); box-shadow: var(--shadow-lg); border-color: rgba(184,134,11,0.3); }
        .product-card img { width:100%; height:210px; object-fit:cover; transition:transform 0.5s ease; display:block; }
        .product-card:hover img { transform: scale(1.05); }
        .product-card .card-body { padding:16px 18px; flex:1; display:flex; flex-direction:column; }
        .search-input {
            background: rgba(255,255,255,0.1);
            border: 1.5px solid rgba(255,255,255,0.2);
            color: #fff;
            border-radius: 50px 0 0 50px;
            padding: 10px 20px;
            font-size: 0.9rem;
            width: 100%;
            transition: var(--transition);
        }
        .search-input::placeholder { color: rgba(255,255,255,0.5); }
        .search-input:focus { outline: none; border-color: var(--gold-light); background: rgba(255,255,255,0.15); }
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/images/rk-logo.png" alt="RK Group Logo" class="brand-logo">RK GROUP<span>FURNITURES &amp; INTERIOR</span></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav ms-auto align-items-center gap-1">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about.jsp">About</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/gallery">Gallery</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/products">Products</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/jsp/public/contact.jsp">Contact</a></li>
                <li class="nav-item ms-2"><a class="btn btn-gold btn-sm" href="${pageContext.request.contextPath}/booking"><i class="bi bi-calendar-check me-1"></i>Book Visit</a></li>
                <li class="nav-item ms-1"><a href="${pageContext.request.contextPath}/admin/login" style="color:#888;padding:6px 10px;display:flex;align-items:center;"><i class="bi bi-lock" style="font-size:1rem;"></i></a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- PAGE HEADER -->
<div class="page-header-banner">
    <div class="container">
        <span class="section-tag" style="color:rgba(201,168,76,0.9);border-color:rgba(201,168,76,0.25);background:rgba(201,168,76,0.08);">Our Catalog</span>
        <h1 class="section-title mt-2" style="color:#fff;">Our <span style="color:var(--gold-light);">Products</span></h1>
        <p style="color:rgba(255,255,255,0.55);margin-top:8px;">Browse our furniture and interior product catalog. Contact us for pricing and customization.</p>
        <div class="mt-4" style="max-width:420px;">
            <div class="d-flex">
                <input type="text" id="productSearch" class="search-input"
                       placeholder="Search products..." value="${searchQuery}">
                <button class="btn btn-gold" style="border-radius:0 50px 50px 0;padding:10px 20px;" onclick="doSearch()">
                    <i class="bi bi-search"></i>
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Success/Error from inquiry -->
<c:if test="${not empty inquirySuccess}">
    <div class="container mt-4">
        <div class="alert-success-rk"><i class="bi bi-check-circle me-2"></i>Inquiry sent! We will contact you shortly.</div>
    </div>
</c:if>

<!-- PRODUCTS GRID -->
<section class="section section-light" style="padding-top:50px;">
    <div class="container">
        <c:choose>
            <c:when test="${not empty products}">
                <c:if test="${not empty searchQuery}">
                    <p style="color:var(--text-muted);margin-bottom:24px;">
                        Search results for: <strong style="color:var(--primary);">"${searchQuery}"</strong>
                        (${products.size()} found)
                        <a href="${pageContext.request.contextPath}/products" style="margin-left:10px;font-size:0.85rem;">Clear ×</a>
                    </p>
                </c:if>
                <div class="row g-4">
                    <c:forEach var="prod" items="${products}">
                        <div class="col-lg-3 col-md-4 col-sm-6 reveal">
                            <div class="product-card">
                                <div style="position:relative;overflow:hidden;">
                                    <c:choose>
                                        <c:when test="${not empty prod.imageFilename}">
                                            <!-- Direct Cloudinary URL -->
                                            <img src="${prod.imageFilename}" alt="${prod.name}">
                                        </c:when>
                                        <c:otherwise>
                                            <div style="height:210px;background:var(--light-gray);display:flex;align-items:center;justify-content:center;">
                                                <i class="bi bi-box-seam" style="font-size:3rem;color:var(--text-muted);opacity:0.3;"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <span style="position:absolute;top:10px;right:10px;"
                                          class="${prod.stockStatus eq 'in_stock' ? 'badge-instock' : prod.stockStatus eq 'out_of_stock' ? 'badge-outstock' : 'badge-onorder'}">
                                        ${prod.stockStatus eq 'in_stock' ? 'In Stock' : prod.stockStatus eq 'out_of_stock' ? 'Out of Stock' : 'On Order'}
                                    </span>
                                </div>
                                <div class="card-body">
                                    <small style="color:var(--primary);font-size:0.78rem;font-weight:600;">${prod.categoryName}</small>
                                    <h6 style="color:var(--text-dark);margin-top:4px;margin-bottom:6px;font-weight:600;">${prod.name}</h6>
                                    <p style="color:var(--text-muted);font-size:0.85rem;flex:1;">${prod.description}</p>
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
                <div class="text-center py-5 reveal">
                    <i class="bi bi-box-seam" style="font-size:4rem;color:var(--text-muted);opacity:0.25;"></i>
                    <h5 style="color:var(--text-muted);margin-top:16px;">No products found.</h5>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- CTA -->
<div class="cta-section reveal">
    <div class="container">
        <h3 style="color:#fff;margin-bottom:12px;">Need a Custom Order?</h3>
        <p>We craft furniture to your exact measurements and design preferences.</p>
        <a href="${pageContext.request.contextPath}/booking" class="btn btn-gold btn-lg mt-2">Get Free Quotation</a>
    </div>
</div>

<!-- FOOTER -->
<footer class="footer">
    <div class="container">
        <div class="footer-bottom d-flex justify-content-between align-items-center flex-wrap gap-2">
            <p style="margin:0;font-size:0.82rem;">&copy; 2024 RK GROUP FURNITURES &amp; INTERIOR. All Rights Reserved.</p>
            <a href="${pageContext.request.contextPath}/admin/login" style="color:#333;font-size:0.72rem;">&bull; Admin</a>
        </div>
    </div>
</footer>

<!-- INQUIRY MODAL -->
<div class="modal fade" id="inquiryModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius:var(--radius-lg);border:1px solid var(--mid-gray);">
            <div class="modal-header" style="border-color:var(--mid-gray);">
                <h5 class="modal-title" style="color:var(--primary);font-family:'Playfair Display',serif;">
                    <i class="bi bi-chat-dots me-2"></i>Send Inquiry
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/products" method="post">
                <input type="hidden" name="action" value="inquiry">
                <input type="hidden" name="productId" id="modalProductId">
                <div class="modal-body p-4">
                    <div style="background:var(--off-white);border:1px solid var(--mid-gray);border-radius:var(--radius);padding:12px 16px;margin-bottom:20px;">
                        <small style="color:var(--text-muted);">Product:</small>
                        <p id="modalProductName" style="color:var(--primary);font-weight:600;margin:2px 0 0;"></p>
                    </div>
                    <div class="mb-3">
                        <label style="color:var(--text-mid);font-size:0.88rem;font-weight:500;display:block;margin-bottom:6px;">Your Name *</label>
                        <input type="text" class="form-control" name="name" required style="border:1.5px solid var(--mid-gray);border-radius:var(--radius);padding:11px 14px;">
                    </div>
                    <div class="mb-3">
                        <label style="color:var(--text-mid);font-size:0.88rem;font-weight:500;display:block;margin-bottom:6px;">Phone *</label>
                        <input type="tel" class="form-control" name="phone" maxlength="10" required style="border:1.5px solid var(--mid-gray);border-radius:var(--radius);padding:11px 14px;">
                    </div>
                    <div class="mb-3">
                        <label style="color:var(--text-mid);font-size:0.88rem;font-weight:500;display:block;margin-bottom:6px;">Email</label>
                        <input type="email" class="form-control" name="email" style="border:1.5px solid var(--mid-gray);border-radius:var(--radius);padding:11px 14px;">
                    </div>
                    <div class="mb-3">
                        <label style="color:var(--text-mid);font-size:0.88rem;font-weight:500;display:block;margin-bottom:6px;">Message</label>
                        <textarea class="form-control" name="message" rows="3" style="border:1.5px solid var(--mid-gray);border-radius:var(--radius);padding:11px 14px;"></textarea>
                    </div>
                </div>
                <div class="modal-footer" style="border-color:var(--mid-gray);">
                    <button type="button" class="btn btn-light btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-gold">Send Inquiry</button>
                </div>
            </form>
        </div>
    </div>
</div>

<a href="https://wa.me/917772897077" class="whatsapp-float" target="_blank"><i class="bi bi-whatsapp"></i></a>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.getElementById('inquiryModal').addEventListener('show.bs.modal', function(e) {
    var btn = e.relatedTarget;
    document.getElementById('modalProductId').value = btn.getAttribute('data-productid');
    document.getElementById('modalProductName').textContent = btn.getAttribute('data-productname');
});
function doSearch() {
    var q = document.getElementById('productSearch').value.trim();
    if (q) window.location.href = '${pageContext.request.contextPath}/products?search=' + encodeURIComponent(q);
}
document.getElementById('productSearch').addEventListener('keypress', function(e) {
    if (e.key === 'Enter') doSearch();
});
</script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
