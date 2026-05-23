<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Visit | RK GROUP FURNITURES &amp; INTERIOR</title>
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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products">Products</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/jsp/public/contact.jsp">Contact</a></li>
                <li class="nav-item ms-2"><a class="btn btn-gold btn-sm px-3 active" href="#">Book Visit</a></li>
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
        <h1 class="section-title">Book a <span>Free Site Visit</span></h1>
        <p style="color:var(--muted);">Schedule a free consultation at your home or office. Our expert will visit and guide you.</p>
    </div>
</div>

<section class="section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-7">

                <c:if test="${not empty success}">
                    <div class="alert-success-rk mb-4">
                        <i class="bi bi-check-circle-fill me-2"></i>${success}
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert-danger-rk mb-4">
                        <i class="bi bi-exclamation-triangle me-2"></i>${error}
                    </div>
                </c:if>

                <div class="admin-form-card">
                    <h5 style="color:var(--primary);margin-bottom:24px;"><i class="bi bi-calendar-check me-2"></i>Booking Request Form</h5>
                    <form action="${pageContext.request.contextPath}/booking" method="post" class="contact-form needs-validation" novalidate>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Your Full Name *</label>
                                <input type="text" class="form-control" name="customerName" placeholder="Enter your name" required>
                                <div class="invalid-feedback">Name is required.</div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Phone Number *</label>
                                <input type="tel" class="form-control" name="phone" placeholder="10-digit number" maxlength="10" required>
                                <div class="invalid-feedback">Phone is required.</div>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Email Address</label>
                                <input type="email" class="form-control" name="email" placeholder="optional">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Preferred Visit Date *</label>
                                <input type="date" class="form-control" name="visitDate" required
                                       min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                                <div class="invalid-feedback">Please select a date.</div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Your Address (Visit Location) *</label>
                            <input type="text" class="form-control" name="address" placeholder="Full address where you want the visit" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Project Details / Message</label>
                            <textarea class="form-control" name="message" rows="4"
                                      placeholder="Describe your project: bedroom, kitchen, full home, office, budget range..."></textarea>
                        </div>

                        <button type="submit" class="btn btn-gold w-100 py-3">
                            <i class="bi bi-calendar-check me-2"></i>Submit Booking Request
                        </button>
                        <p style="color:var(--muted);font-size:0.82rem;text-align:center;margin-top:12px;">
                            We will confirm your booking via phone within 24 hours.
                        </p>
                    </form>
                </div>
            </div>

            <!-- Info Column -->
            <div class="col-lg-4 mt-4 mt-lg-0">
                <div class="service-card mb-3">
                    <div class="service-icon"><i class="bi bi-calendar-check"></i></div>
                    <h6 class="mt-3">Free Consultation</h6>
                    <p style="color:var(--muted);font-size:0.88rem;">Our site visit is completely FREE. No charges for consultation.</p>
                </div>
                <div class="service-card mb-3">
                    <div class="service-icon"><i class="bi bi-pencil-square"></i></div>
                    <h6 class="mt-3">Custom Quotation</h6>
                    <p style="color:var(--muted);font-size:0.88rem;">You'll receive a detailed quotation tailored to your space and budget.</p>
                </div>
                <div class="service-card">
                    <div class="service-icon"><i class="bi bi-shield-check"></i></div>
                    <h6 class="mt-3">No Obligation</h6>
                    <p style="color:var(--muted);font-size:0.88rem;">Booking a visit doesn't commit you to anything. Explore at your comfort.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<a href="https://wa.me/917772897077" class="whatsapp-float" target="_blank"><i class="bi bi-whatsapp"></i></a>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
