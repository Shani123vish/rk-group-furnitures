<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery | RK GROUP FURNITURES &amp; INTERIOR</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Playfair+Display:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>

<%-- Include navbar (reuse same navbar snippet) --%>
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/"><i class="bi bi-gem me-2" style="color:var(--primary)"></i>RK GROUP<span>FURNITURES &amp; INTERIOR</span></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav ms-auto align-items-center gap-1">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about.jsp">About</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/gallery">Gallery</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products">Products</a></li>
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

<!-- Page Header -->
<div style="background:var(--dark-2);padding:60px 0 40px;border-bottom:1px solid rgba(200,164,92,0.1);">
    <div class="container">
        <p style="color:var(--primary);letter-spacing:3px;font-size:0.8rem;text-transform:uppercase;margin-bottom:8px;">Portfolio</p>
        <h1 class="section-title">Our <span>Work Gallery</span></h1>
        <p style="color:var(--muted);">Explore our completed projects — interiors, furniture, kitchens and more.</p>
    </div>
</div>

<!-- Filter Buttons -->
<section class="section" style="padding-bottom:20px;">
    <div class="container">
        <div class="d-flex gap-2 flex-wrap mb-4">
            <%-- 
                FIX: JSTL EL mein Java method call nahi hota.
                'abc'.equals(x) → WRONG in EL
                param.catId eq 'abc' → CORRECT in EL
            --%>
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
</section>

<!-- Gallery Grid -->
<section style="padding:0 0 80px;">
    <div class="container">
        <c:choose>
            <c:when test="${not empty galleryList}">
                <div class="row g-3">
                    <c:forEach var="item" items="${galleryList}">
                        <div class="col-lg-4 col-md-6">
                            <div class="gallery-item rk-card">
                                <c:choose>
                                    <%-- Video media type --%>
                                    <c:when test="${item.mediaType eq 'video' and not empty item.imageUrl}">
                                        <div style="position:relative;height:250px;background:#000;overflow:hidden;">
                                            <video style="width:100%;height:250px;object-fit:cover;"
                                                   controls preload="metadata"
                                                   poster="${item.imageUrl.replace('/upload/', '/upload/so_0/')}">
                                                <source src="${item.imageUrl}" type="video/mp4">
                                            </video>
                                            <div style="position:absolute;top:10px;left:10px;background:rgba(0,0,0,0.7);color:#fff;padding:3px 10px;border-radius:12px;font-size:0.72rem;">
                                                <i class="bi bi-camera-video me-1"></i>Video
                                            </div>
                                        </div>
                                    </c:when>
                                    <%-- Cloudinary image URL --%>
                                    <c:when test="${not empty item.imageUrl}">
                                        <img src="${item.imageUrl}"
                                             alt="${item.title}" style="height:250px;object-fit:cover;width:100%;">
                                    </c:when>
                                    <%-- Old local image (fallback) --%>
                                    <c:when test="${not empty item.imageFilename}">
                                        <img src="${pageContext.request.contextPath}/uploads/${item.imageFilename}"
                                             alt="${item.title}" style="height:250px;object-fit:cover;width:100%;">
                                    </c:when>
                                    <c:otherwise>
                                        <div style="height:250px;background:var(--dark-3);display:flex;align-items:center;justify-content:center;">
                                            <i class="bi bi-image" style="font-size:3rem;color:var(--muted);opacity:0.4;"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="card-body p-3">
                                    <div class="d-flex justify-content-between align-items-start mb-1">
                                        <h6 class="card-title mb-0">${item.title}</h6>
                                        <span style="background:rgba(200,164,92,0.1);color:var(--primary);font-size:0.75rem;padding:2px 10px;border-radius:20px;white-space:nowrap;">${item.categoryName}</span>
                                    </div>
                                    <c:if test="${not empty item.location}">
                                        <p style="color:var(--muted);font-size:0.82rem;margin-bottom:4px;"><i class="bi bi-geo-alt me-1" style="color:var(--primary);"></i>${item.location}</p>
                                    </c:if>
                                    <c:if test="${not empty item.completionDate}">
                                        <p style="color:var(--muted);font-size:0.82rem;margin:0;"><i class="bi bi-calendar me-1" style="color:var(--primary);"></i>Completed: ${item.completionDate}</p>
                                    </c:if>
                                    <c:if test="${not empty item.description}">
                                        <p style="color:var(--muted);font-size:0.85rem;margin-top:8px;">${item.description}</p>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5">
                    <i class="bi bi-images" style="font-size:4rem;color:var(--muted);opacity:0.3;"></i>
                    <h5 style="color:var(--muted);margin-top:16px;">No gallery items yet.</h5>
                    <p style="color:#555;">Admin can upload project photos from the Admin Panel.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- CTA -->
<div style="background:linear-gradient(135deg,rgba(200,164,92,0.08),rgba(200,164,92,0.03));border-top:1px solid rgba(200,164,92,0.15);border-bottom:1px solid rgba(200,164,92,0.15);padding:60px 0;text-align:center;">
    <div class="container">
        <h3 style="font-family:'Playfair Display',serif;">Like What You See?</h3>
        <p style="color:var(--muted);margin:12px 0 28px;">Let us create something beautiful for your home or office too.</p>
        <a href="${pageContext.request.contextPath}/booking" class="btn btn-gold me-3">Book Free Consultation</a>
        <a href="https://wa.me/917772897077" class="btn btn-outline-gold" target="_blank">Chat on WhatsApp</a>
    </div>
</div>

<!-- Footer -->
<footer class="footer"><div class="container"><div class="footer-bottom text-center"><p style="color:var(--muted);font-size:0.82rem;margin:0;">&copy; 2024 RK GROUP FURNITURES &amp; INTERIOR. All Rights Reserved.</p>
<div style="margin-top:8px;"><a href="${pageContext.request.contextPath}/admin/login" style="color:#2a2a2a;font-size:0.7rem;text-decoration:none;">&bull; Admin</a></div>
</div></div></footer>

<a href="https://wa.me/917772897077?text=Hello%20RK%20Group!" class="whatsapp-float" target="_blank"><i class="bi bi-whatsapp"></i></a>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
