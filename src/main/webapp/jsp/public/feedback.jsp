<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Feedback | RK GROUP FURNITURES &amp; INTERIOR</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <style>
        /* ---- Star Rating Input ---- */
        .star-rating { display:flex; flex-direction:row-reverse; justify-content:flex-end; gap:6px; }
        .star-rating input { display:none; }
        .star-rating label {
            font-size:2rem; color:#ddd; cursor:pointer;
            transition:color 0.2s;
        }
        .star-rating input:checked ~ label,
        .star-rating label:hover,
        .star-rating label:hover ~ label { color:#b8860b; }

        /* ---- Feedback Card ---- */
        .feedback-card {
            background: var(--white);
            border: 1px solid var(--mid-gray);
            border-radius: var(--radius-lg);
            padding: 28px;
            transition: var(--transition);
            box-shadow: var(--shadow-sm);
            position: relative;
            height: 100%;
        }
        .feedback-card:hover { transform:translateY(-5px); box-shadow:var(--shadow-lg); border-color:rgba(184,134,11,0.3); }
        .feedback-card::before {
            content: '\201C';
            font-family: 'Playfair Display', serif;
            font-size: 5rem;
            color: var(--primary);
            opacity: 0.12;
            position: absolute;
            top: -10px; left: 18px;
            line-height: 1;
        }
        .star-display { color: #b8860b; letter-spacing:2px; font-size:1rem; }
        .star-display .empty { color: #ddd; }

        /* ---- Form Card ---- */
        .form-card {
            background: var(--white);
            border: 1px solid var(--mid-gray);
            border-radius: var(--radius-lg);
            padding: 36px;
            box-shadow: var(--shadow-md);
        }
        .form-card .form-control {
            background: var(--white);
            border: 1.5px solid var(--mid-gray);
            color: var(--text-dark);
            border-radius: var(--radius);
            padding: 12px 16px;
            transition: var(--transition);
        }
        .form-card .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(184,134,11,0.1);
            outline: none;
        }
        .form-card label { color:var(--text-mid); font-size:0.88rem; font-weight:500; margin-bottom:6px; }

        /* ---- Avatar ---- */
        .avatar {
            width:46px; height:46px;
            border-radius:50%;
            background: linear-gradient(135deg,rgba(184,134,11,0.15),rgba(184,134,11,0.05));
            border: 1px solid rgba(184,134,11,0.2);
            display:flex; align-items:center; justify-content:center;
            font-weight:700; color:var(--primary);
            font-size:1.1rem; flex-shrink:0;
        }

        /* ---- Rating Summary ---- */
        .rating-summary {
            background: linear-gradient(135deg,rgba(184,134,11,0.06),rgba(184,134,11,0.02));
            border: 1px solid rgba(184,134,11,0.2);
            border-radius: var(--radius-lg);
            padding: 28px;
            text-align: center;
        }
        .big-rating {
            font-family: 'Playfair Display', serif;
            font-size: 4rem;
            font-weight: 700;
            color: var(--primary);
            line-height: 1;
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/"><i class="bi bi-gem me-2"></i>RK GROUP<span>FURNITURES &amp; INTERIOR</span></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav ms-auto align-items-center gap-1">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about.jsp">About</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/gallery">Gallery</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products">Products</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/feedback">Feedback</a></li>
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
        <span class="section-tag" style="color:rgba(201,168,76,0.9);border-color:rgba(201,168,76,0.25);background:rgba(201,168,76,0.08);">What Clients Say</span>
        <h1 class="section-title mt-2" style="color:#fff;">Customer <span style="color:var(--gold-light);">Feedback</span></h1>
        <p style="color:rgba(255,255,255,0.55);margin-top:8px;">Real reviews from our happy clients — share your experience too!</p>
        <nav aria-label="breadcrumb" class="mt-3">
            <ol class="breadcrumb" style="background:none;padding:0;margin:0;">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/" style="color:rgba(255,255,255,0.5);">Home</a></li>
                <li class="breadcrumb-item active" style="color:var(--gold-light);">Feedback</li>
            </ol>
        </nav>
    </div>
</div>

<!-- RATING SUMMARY BAR -->
<div style="background:var(--white);border-bottom:1px solid var(--mid-gray);padding:24px 0;box-shadow:var(--shadow-sm);">
    <div class="container">
        <div class="row align-items-center g-3">
            <div class="col-auto">
                <div class="d-flex align-items-center gap-3">
                    <div>
                        <div class="big-rating">${String.format("%.1f", avgRating)}</div>
                        <div style="color:var(--text-muted);font-size:0.78rem;margin-top:4px;">Overall Rating</div>
                    </div>
                    <div>
                        <div style="font-size:1.6rem;color:#b8860b;letter-spacing:3px;">★★★★★</div>
                        <div style="color:var(--text-muted);font-size:0.8rem;">${feedbackList.size()} reviews</div>
                    </div>
                </div>
            </div>
            <div class="col">
                <a href="#writeReview" class="btn btn-gold ms-3" style="border-radius:50px;">
                    <i class="bi bi-pencil-square me-2"></i>Write a Review
                </a>
            </div>
        </div>
    </div>
</div>

<section class="section section-light" style="padding-top:50px;">
    <div class="container">
        <div class="row g-5">

            <!-- LEFT: All Reviews -->
            <div class="col-lg-7">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <h4 style="font-family:'Playfair Display',serif;color:var(--text-dark);margin:0;">
                        All <span style="color:var(--primary);">Reviews</span>
                    </h4>
                    <span style="background:rgba(184,134,11,0.08);border:1px solid rgba(184,134,11,0.2);color:var(--primary);padding:4px 14px;border-radius:20px;font-size:0.82rem;font-weight:600;">
                        ${feedbackList.size()} Reviews
                    </span>
                </div>

                <c:choose>
                    <c:when test="${not empty feedbackList}">
                        <div class="row g-4">
                            <c:forEach var="fb" items="${feedbackList}">
                                <div class="col-12 reveal">
                                    <div class="feedback-card">
                                        <!-- Stars -->
                                        <div class="star-display mb-3">
                                            <c:forEach begin="1" end="5" var="star">
                                                <c:choose>
                                                    <c:when test="${star <= fb.rating}">★</c:when>
                                                    <c:otherwise><span class="empty">★</span></c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </div>
                                        <!-- Message -->
                                        <p style="color:var(--text-muted);font-size:0.92rem;line-height:1.8;margin-bottom:20px;">
                                            "${fb.message}"
                                        </p>
                                        <!-- Author -->
                                        <div class="d-flex align-items-center gap-3">
                                            <div class="avatar">
                                                ${fb.name.substring(0,1).toUpperCase()}
                                            </div>
                                            <div>
                                                <h6 style="margin:0;font-size:0.92rem;color:var(--text-dark);font-weight:600;">${fb.name}</h6>
                                                <small style="color:var(--text-muted);">
                                                    <c:if test="${not empty fb.location}">
                                                        <i class="bi bi-geo-alt me-1" style="color:var(--primary);"></i>${fb.location} •
                                                    </c:if>
                                                    ${fb.createdAt.substring(0,10)}
                                                </small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5" style="background:var(--white);border:1px solid var(--mid-gray);border-radius:var(--radius-lg);">
                            <i class="bi bi-chat-quote" style="font-size:3.5rem;color:var(--text-muted);opacity:0.25;"></i>
                            <h5 style="color:var(--text-muted);margin-top:16px;">No reviews yet.</h5>
                            <p style="color:var(--text-muted);">Be the first to share your experience!</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- RIGHT: Write Review Form -->
            <div class="col-lg-5" id="writeReview">
                <div class="form-card reveal-right" style="position:sticky;top:90px;">

                    <h5 style="font-family:'Playfair Display',serif;color:var(--text-dark);margin-bottom:6px;">
                        <i class="bi bi-pencil-square me-2" style="color:var(--primary);"></i>Share Your Experience
                    </h5>
                    <p style="color:var(--text-muted);font-size:0.85rem;margin-bottom:24px;">
                        Your feedback helps us improve and helps others choose us with confidence.
                    </p>

                    <!-- Flash messages -->
                    <c:if test="${not empty success}">
                        <div class="alert-success-rk mb-4">
                            <i class="bi bi-check-circle me-2"></i>${success}
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert-danger-rk mb-4">
                            <i class="bi bi-exclamation-circle me-2"></i>${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/feedback" method="post" class="needs-validation" novalidate>

                        <!-- Star Rating Selector -->
                        <div class="mb-4">
                            <label class="form-label d-block">Your Rating *</label>
                            <div class="star-rating">
                                <input type="radio" id="star5" name="rating" value="5" checked>
                                <label for="star5" title="5 stars">★</label>
                                <input type="radio" id="star4" name="rating" value="4">
                                <label for="star4" title="4 stars">★</label>
                                <input type="radio" id="star3" name="rating" value="3">
                                <label for="star3" title="3 stars">★</label>
                                <input type="radio" id="star2" name="rating" value="2">
                                <label for="star2" title="2 stars">★</label>
                                <input type="radio" id="star1" name="rating" value="1">
                                <label for="star1" title="1 star">★</label>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Your Name *</label>
                            <input type="text" class="form-control" name="name"
                                   placeholder="Enter your full name" required>
                            <div class="invalid-feedback">Name is required.</div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-6">
                                <label class="form-label">Phone</label>
                                <input type="tel" class="form-control" name="phone"
                                       placeholder="Optional" maxlength="10">
                            </div>
                            <div class="col-6">
                                <label class="form-label">Location</label>
                                <input type="text" class="form-control" name="location"
                                       placeholder="e.g. Bhopal">
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Your Review *</label>
                            <textarea class="form-control" name="message" rows="4"
                                      placeholder="Share your experience with RK GROUP — quality, service, delivery..." required></textarea>
                            <div class="invalid-feedback">Please write your review.</div>
                        </div>

                        <button type="submit" class="btn btn-gold w-100 py-3">
                            <i class="bi bi-send me-2"></i>Submit Review
                        </button>
                        <p style="color:var(--text-muted);font-size:0.78rem;text-align:center;margin-top:10px;">
                            <i class="bi bi-shield-check me-1" style="color:var(--primary);"></i>
                            Your review will be published immediately.
                        </p>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CTA -->
<div class="cta-section reveal">
    <div class="container">
        <h3 style="color:#fff;margin-bottom:12px;">Ready to Experience Our Service?</h3>
        <p>Book a free site visit — our expert will come and provide a FREE quotation.</p>
        <div class="d-flex gap-3 justify-content-center flex-wrap mt-3">
            <a href="${pageContext.request.contextPath}/booking" class="btn btn-gold btn-lg">
                <i class="bi bi-calendar-check me-2"></i>Book Free Visit
            </a>
            <a href="${pageContext.request.contextPath}/gallery" class="btn btn-outline-gold btn-lg">
                <i class="bi bi-images me-2"></i>View Our Work
            </a>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer class="footer">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <div class="footer-logo"><span>RK</span> GROUP</div>
                <p>Premium furniture craftsmanship and interior design solutions. We transform your space with elegance, quality, and timely delivery.</p>
                <div class="mt-3">
                    <a href="https://wa.me/917772897077" class="social-link"><i class="bi bi-whatsapp"></i></a>
                    <a href="#" class="social-link"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="social-link"><i class="bi bi-instagram"></i></a>
                </div>
            </div>
            <div class="col-lg-2 col-md-6">
                <h5>Quick Links</h5>
                <ul class="list-unstyled" style="font-size:0.88rem;">
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/about.jsp">About Us</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/gallery">Gallery</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/products">Products</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/feedback">Feedback</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/booking">Book Visit</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5>Services</h5>
                <ul class="list-unstyled" style="font-size:0.88rem;">
                    <li class="mb-2"><a href="#">Interior Design</a></li>
                    <li class="mb-2"><a href="#">Modular Kitchen</a></li>
                    <li class="mb-2"><a href="#">Custom Furniture</a></li>
                    <li class="mb-2"><a href="#">Door &amp; Window Work</a></li>
                    <li class="mb-2"><a href="#">False Ceiling</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5>Contact Info</h5>
                <ul class="list-unstyled" style="font-size:0.88rem;">
                    <li class="mb-2"><i class="bi bi-telephone me-2" style="color:var(--gold);"></i><a href="tel:7772897077">7772897077</a></li>
                    <li class="mb-2"><i class="bi bi-whatsapp me-2" style="color:var(--gold);"></i><a href="https://wa.me/917772897077">WhatsApp Us</a></li>
                    <li class="mb-2"><i class="bi bi-envelope me-2" style="color:var(--gold);"></i><a href="mailto:rahulvishwakarma111999@gmail.com">Email Us</a></li>
                    <li class="mb-2"><i class="bi bi-geo-alt me-2" style="color:var(--gold);"></i><a href="https://maps.app.goo.gl/g78BgUACNh3cK3iz8?g_st=aw" target="_blank">View Location</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom d-flex justify-content-between align-items-center flex-wrap gap-2">
            <p style="margin:0;font-size:0.82rem;">&copy; 2024 RK GROUP FURNITURES &amp; INTERIOR. All Rights Reserved.</p>
            <a href="${pageContext.request.contextPath}/admin/login" style="color:#333;font-size:0.72rem;">&bull; Admin</a>
        </div>
    </div>
</footer>

<a href="https://wa.me/917772897077" class="whatsapp-float" target="_blank"><i class="bi bi-whatsapp"></i></a>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
