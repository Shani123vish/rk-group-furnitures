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
    <title>Contact Us | RK GROUP FURNITURES &amp; INTERIOR</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <style>
        .contact-wrap {
            background: var(--white);
            border: 1px solid var(--mid-gray);
            border-radius: var(--radius-lg);
            padding: 32px;
            box-shadow: var(--shadow-md);
        }
        .contact-wrap .form-control {
            background: var(--white);
            border: 1.5px solid var(--mid-gray);
            color: var(--text-dark);
            border-radius: var(--radius);
            padding: 12px 16px;
            transition: var(--transition);
        }
        .contact-wrap .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(184,134,11,0.1);
        }
        .contact-wrap label { color: var(--text-mid); font-size: 0.88rem; font-weight: 500; margin-bottom: 6px; }
        .contact-info-item {
            background: var(--white);
            border: 1px solid var(--mid-gray);
            border-radius: var(--radius-lg);
            padding: 16px 20px;
            display: flex;
            align-items: flex-start;
            gap: 16px;
            margin-bottom: 14px;
            transition: var(--transition);
            box-shadow: var(--shadow-sm);
        }
        .contact-info-item:hover { transform: translateX(5px); border-color: rgba(184,134,11,0.3); box-shadow: var(--shadow-md); }
        .wa-card {
            background: var(--white);
            border: 1px solid var(--mid-gray);
            border-radius: var(--radius-lg);
            padding: 28px;
            text-align: center;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            gap: 14px;
            box-shadow: var(--shadow-sm);
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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/gallery">Gallery</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products">Products</a></li>
                <li class="nav-item"><a class="nav-link active" href="#">Contact</a></li>
                <li class="nav-item ms-2"><a class="btn btn-gold btn-sm" href="${pageContext.request.contextPath}/booking"><i class="bi bi-calendar-check me-1"></i>Book Visit</a></li>
                <li class="nav-item ms-1"><a href="${pageContext.request.contextPath}/admin/login" style="color:#888;padding:6px 10px;display:flex;align-items:center;"><i class="bi bi-lock" style="font-size:1rem;"></i></a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- PAGE HEADER -->
<div class="page-header-banner">
    <div class="container">
        <span class="section-tag" style="color:rgba(201,168,76,0.9);border-color:rgba(201,168,76,0.25);background:rgba(201,168,76,0.08);">Reach Out</span>
        <h1 class="section-title mt-2" style="color:#fff;">Contact <span style="color:var(--gold-light);">Us</span></h1>
        <p style="color:rgba(255,255,255,0.55);margin-top:8px;">Get in touch with us for any queries, quotations or project discussions.</p>
    </div>
</div>

<section class="section section-light">
    <div class="container">

        <c:if test="${not empty success}">
            <div class="alert-success-rk mb-4 reveal"><i class="bi bi-check-circle me-2"></i>${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert-danger-rk mb-4 reveal"><i class="bi bi-exclamation-circle me-2"></i>${error}</div>
        </c:if>

        <div class="row g-5">

            <!-- Contact Info -->
            <div class="col-lg-4 reveal-left">
                <h4 style="font-family:'Playfair Display',serif;color:var(--text-dark);margin-bottom:24px;">Get In Touch</h4>

                <div class="contact-info-item">
                    <div class="why-icon" style="min-width:48px;height:48px;flex-shrink:0;"><i class="bi bi-person"></i></div>
                    <div>
                        <h6 style="color:var(--text-muted);font-size:0.78rem;margin-bottom:4px;text-transform:uppercase;letter-spacing:1px;">OWNER</h6>
                        <p style="color:var(--text-dark);margin:0;font-weight:600;">Rahul Vishwakarma</p>
                    </div>
                </div>
                <div class="contact-info-item">
                    <div class="why-icon" style="min-width:48px;height:48px;flex-shrink:0;"><i class="bi bi-telephone"></i></div>
                    <div>
                        <h6 style="color:var(--text-muted);font-size:0.78rem;margin-bottom:4px;text-transform:uppercase;letter-spacing:1px;">PHONE</h6>
                        <a href="tel:7772897077" style="color:var(--primary);font-weight:600;font-size:1.05rem;">7772897077</a>
                    </div>
                </div>
                <div class="contact-info-item">
                    <div class="why-icon" style="min-width:48px;height:48px;flex-shrink:0;"><i class="bi bi-envelope"></i></div>
                    <div>
                        <h6 style="color:var(--text-muted);font-size:0.78rem;margin-bottom:4px;text-transform:uppercase;letter-spacing:1px;">EMAIL</h6>
                        <a href="mailto:rahulvishwakarma111999@gmail.com" style="color:var(--text-mid);font-size:0.85rem;">rahulvishwakarma111999@gmail.com</a>
                    </div>
                </div>
                <div class="contact-info-item">
                    <div class="why-icon" style="min-width:48px;height:48px;flex-shrink:0;"><i class="bi bi-geo-alt"></i></div>
                    <div>
                        <h6 style="color:var(--text-muted);font-size:0.78rem;margin-bottom:4px;text-transform:uppercase;letter-spacing:1px;">LOCATION</h6>
                        <a href="https://maps.app.goo.gl/g78BgUACNh3cK3iz8?g_st=aw" target="_blank" style="color:var(--primary);">Open in Google Maps →</a>
                    </div>
                </div>
                <div class="contact-info-item">
                    <div class="why-icon" style="min-width:48px;height:48px;flex-shrink:0;"><i class="bi bi-clock"></i></div>
                    <div>
                        <h6 style="color:var(--text-muted);font-size:0.78rem;margin-bottom:4px;text-transform:uppercase;letter-spacing:1px;">WORKING HOURS</h6>
                        <p style="color:var(--text-dark);margin:0;font-size:0.9rem;">Mon - Sat: 9 AM – 7 PM</p>
                        <p style="color:var(--text-muted);margin:0;font-size:0.85rem;">Sunday: 10 AM – 4 PM</p>
                    </div>
                </div>
            </div>

            <!-- Contact Form -->
            <div class="col-lg-5 reveal">
                <div class="contact-wrap">
                    <h5 style="color:var(--primary);margin-bottom:6px;font-family:'Playfair Display',serif;">Send Us a Message</h5>
                    <p style="color:var(--text-muted);font-size:0.85rem;margin-bottom:24px;">We'll get back to you within 24 hours.</p>
                    <form action="${pageContext.request.contextPath}/inquiry" method="post" class="needs-validation" novalidate>
                        <div class="mb-3">
                            <label class="form-label">Your Name *</label>
                            <input type="text" class="form-control" name="name" placeholder="Enter full name" required>
                            <div class="invalid-feedback">Name is required.</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Phone Number *</label>
                            <input type="tel" class="form-control" name="phone" placeholder="10-digit mobile number" maxlength="10" required>
                            <div class="invalid-feedback">Phone is required.</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email Address</label>
                            <input type="email" class="form-control" name="email" placeholder="your@email.com">
                        </div>
                        <div class="mb-4">
                            <label class="form-label">Your Message *</label>
                            <textarea class="form-control" name="message" rows="4"
                                      placeholder="Tell us about your project, requirements, budget..." required></textarea>
                            <div class="invalid-feedback">Please write a message.</div>
                        </div>
                        <button type="submit" class="btn btn-gold w-100 py-3">
                            <i class="bi bi-send me-2"></i>Send Message
                        </button>
                    </form>
                </div>
            </div>

            <!-- WhatsApp CTA -->
            <div class="col-lg-3 reveal-right">
                <div class="wa-card">
                    <div style="font-size:3.5rem;color:#25D366;"><i class="bi bi-whatsapp"></i></div>
                    <h5 style="color:var(--text-dark);font-size:1rem;">Quick Response via WhatsApp</h5>
                    <p style="color:var(--text-muted);font-size:0.88rem;margin:0;">For faster replies, chat with us directly on WhatsApp.</p>
                    <a href="https://wa.me/917772897077?text=Hello%20RK%20Group%2C%20I%20need%20a%20quotation%20for%20my%20project."
                       class="btn btn-gold w-100" target="_blank">
                        <i class="bi bi-whatsapp me-2"></i>Chat Now
                    </a>
                    <hr style="border-color:var(--mid-gray);margin:4px 0;">
                    <p style="color:var(--text-muted);font-size:0.82rem;margin:0;">Or call us directly:</p>
                    <a href="tel:7772897077" class="btn btn-outline-gold w-100">
                        <i class="bi bi-telephone me-2"></i>7772897077
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- FOOTER -->
<footer class="footer">
    <div class="container">
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