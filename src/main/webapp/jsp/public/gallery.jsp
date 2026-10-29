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
    <title>Gallery | RK GROUP FURNITURES &amp; INTERIOR</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <style>
        .gallery-card {
            background: var(--white);
            border: 1px solid var(--mid-gray);
            border-radius: var(--radius-lg);
            overflow: hidden;
            transition: var(--transition);
            box-shadow: var(--shadow-sm);
        }
        .gallery-card:hover { transform: translateY(-6px); box-shadow: var(--shadow-lg); border-color: rgba(184,134,11,0.3); }
        .gallery-card img, .gallery-card video {
            width: 100%; height: 250px; object-fit: cover;
            display: block; transition: transform 0.5s ease;
        }
        .gallery-card:hover img { transform: scale(1.05); }
        .gallery-card .card-body { padding: 16px 18px; }
        .cat-badge {
            background: rgba(184,134,11,0.08); color: var(--primary);
            border: 1px solid rgba(184,134,11,0.2);
            padding: 2px 12px; border-radius: 20px;
            font-size: 0.75rem; font-weight: 600; white-space: nowrap;
        }
        /* Sticky filter bar */
        .filter-bar {
            background: var(--white);
            border-bottom: 1px solid var(--mid-gray);
            padding: 16px 0;
            position: sticky; top: 70px; z-index: 100;
            box-shadow: var(--shadow-sm);
        }
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/gallery">Gallery</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products">Products</a></li>
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
        <span class="section-tag" style="color:rgba(201,168,76,0.9);border-color:rgba(201,168,76,0.25);background:rgba(201,168,76,0.08);">Portfolio</span>
        <h1 class="section-title mt-2" style="color:#fff;">Our <span style="color:var(--gold-light);">Work Gallery</span></h1>
        <p style="color:rgba(255,255,255,0.55);margin-top:8px;">Explore our completed projects — interiors, furniture, kitchens and more.</p>
    </div>
</div>

<!-- FILTER BUTTONS — sticky bar -->
<div class="filter-bar">
    <div class="container">
        <div class="d-flex gap-2 flex-wrap">
            <a href="${pageContext.request.contextPath}/gallery"
               class="filter-btn ${empty param.catId ? 'active' : ''}">All Work</a>
            <a href="${pageContext.request.contextPath}/gallery?catId=1"
               class="filter-btn ${param.catId eq '1' ? 'active' : ''}">Interior Design</a>
            <a href="${pageContext.request.contextPath}/gallery?catId=2"
               class="filter-btn ${param.catId eq '2' ? 'active' : ''}">Furniture</a>
            <a href="${pageContext.request.contextPath}/gallery?catId=3"
               class="filter-btn ${param.catId eq '3' ? 'active' : ''}">Modular Kitchen</a>
            <a href="${pageContext.request.contextPath}/gallery?catId=4"
               class="filter-btn ${param.catId eq '4' ? 'active' : ''}">Door Work</a>
            <a href="${pageContext.request.contextPath}/gallery?catId=5"
               class="filter-btn ${param.catId eq '5' ? 'active' : ''}">False Ceiling</a>
        </div>
    </div>
</div>

<!-- GALLERY GRID -->
<section class="section section-light" style="padding-top:40px;">
    <div class="container">
        <c:choose>
            <c:when test="${not empty galleryList}">
                <div class="row g-4">
                    <c:forEach var="item" items="${galleryList}">
                        <div class="col-lg-4 col-md-6 reveal">
                            <div class="gallery-card">
                                <div style="overflow:hidden;">
                                    <c:choose>
                                        <%-- Video media type --%>
                                        <c:when test="${item.mediaType eq 'video' and not empty item.imageUrl}">
                                            <div style="position:relative;height:250px;background:#000;overflow:hidden;">
                                                <video style="width:100%;height:250px;object-fit:cover;"
                                                       controls preload="metadata"
                                                       poster="${item.imageUrl.replace('/upload/', '/upload/so_0/')}">
                                                    <source src="${item.imageUrl}" type="video/mp4">
                                                </video>
                                                <div style="position:absolute;top:10px;left:10px;background:var(--primary);color:#fff;padding:3px 10px;border-radius:20px;font-size:0.72rem;font-weight:600;">
                                                    <i class="bi bi-camera-video me-1"></i>Video
                                                </div>
                                            </div>
                                        </c:when>
                                        <%-- Cloudinary image URL --%>
                                        <c:when test="${not empty item.imageUrl}">
                                            <img src="${item.imageUrl}" alt="${item.title}">
                                        </c:when>
                                        <%-- Old local image fallback --%>
                                        <c:when test="${not empty item.imageFilename}">
                                            <img src="${pageContext.request.contextPath}/uploads/${item.imageFilename}" alt="${item.title}">
                                        </c:when>
                                        <c:otherwise>
                                            <div style="height:250px;background:var(--light-gray);display:flex;align-items:center;justify-content:center;">
                                                <i class="bi bi-image" style="font-size:3rem;color:var(--text-muted);opacity:0.3;"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-start mb-1">
                                        <h6 style="color:var(--text-dark);font-size:0.95rem;margin:0;flex:1;margin-right:10px;">${item.title}</h6>
                                        <span class="cat-badge">${item.categoryName}</span>
                                    </div>
                                    <c:if test="${not empty item.location}">
                                        <p style="color:var(--text-muted);font-size:0.82rem;margin-bottom:4px;margin-top:6px;">
                                            <i class="bi bi-geo-alt me-1" style="color:var(--primary);"></i>${item.location}
                                        </p>
                                    </c:if>
                                    <c:if test="${not empty item.completionDate}">
                                        <p style="color:var(--text-muted);font-size:0.82rem;margin:0;">
                                            <i class="bi bi-calendar me-1" style="color:var(--primary);"></i>Completed: ${item.completionDate}
                                        </p>
                                    </c:if>
                                    <c:if test="${not empty item.description}">
                                        <p style="color:var(--text-muted);font-size:0.85rem;margin-top:8px;margin-bottom:0;">${item.description}</p>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5 reveal">
                    <i class="bi bi-images" style="font-size:4rem;color:var(--text-muted);opacity:0.25;"></i>
                    <h5 style="color:var(--text-muted);margin-top:16px;">No gallery items yet.</h5>
                    <p style="color:var(--text-muted);">Admin can upload project photos from the Admin Panel.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- CTA -->
<div class="cta-section reveal">
    <div class="container">
        <h3 style="color:#fff;margin-bottom:12px;">Like What You See?</h3>
        <p>Let us create something beautiful for your home or office too.</p>
        <div class="d-flex gap-3 justify-content-center flex-wrap mt-3">
            <a href="${pageContext.request.contextPath}/booking" class="btn btn-gold btn-lg">Book Free Consultation</a>
            <a href="https://wa.me/917772897077" class="btn btn-outline-gold btn-lg" target="_blank">
                <i class="bi bi-whatsapp me-2"></i>Chat on WhatsApp
            </a>
        </div>
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

<a href="https://wa.me/917772897077?text=Hello%20RK%20Group!" class="whatsapp-float" target="_blank"><i class="bi bi-whatsapp"></i></a>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
