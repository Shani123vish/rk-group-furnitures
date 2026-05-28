
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RK GROUP FURNITURES &amp; INTERIOR | Premium Furniture &amp; Interior Design</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="bi bi-gem me-2"></i>RK GROUP
            <span>FURNITURES &amp; INTERIOR</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav ms-auto align-items-center gap-1">
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about.jsp">About</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/gallery">Gallery</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products">Products</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/jsp/public/contact.jsp">Contact</a></li>
                <li class="nav-item ms-2">
                    <a class="btn btn-gold btn-sm" href="${pageContext.request.contextPath}/booking">
                        <i class="bi bi-calendar-check me-1"></i>Book Visit
                    </a>
                </li>
                <li class="nav-item ms-1">
                    <a href="${pageContext.request.contextPath}/admin/login" style="color:#888;padding:6px 10px;display:flex;align-items:center;" title="Admin Login">
                        <i class="bi bi-lock" style="font-size:1rem;"></i>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- HERO -->
<section class="hero" id="home">
    <div class="container hero-content">
        <div class="row align-items-center">
            <div class="col-lg-7">
                <div class="hero-badge reveal">
                    <i class="bi bi-stars"></i>
                    ✦ Premium Furniture &amp; Interior Design
                </div>
                <h1 class="hero-title reveal">
                    Transform Your Space with <span class="gold-text">Luxury &amp; Elegance</span>
                </h1>
                <p class="hero-sub reveal">
                    RK GROUP delivers world-class furniture craftsmanship and interior design solutions.
                    From modular kitchens to complete home interiors — we bring your vision to life.
                </p>
                <div class="d-flex gap-3 flex-wrap reveal">
                    <a href="${pageContext.request.contextPath}/gallery" class="btn btn-gold">
                        <i class="bi bi-images me-2"></i>View Our Work
                    </a>
                    <a href="${pageContext.request.contextPath}/booking" class="btn btn-outline-gold">
                        <i class="bi bi-calendar-check me-2"></i>Book Free Visit
                    </a>
                </div>
                <div class="hero-stats reveal">
                    <div>
                        <div class="hero-stat-num"><span class="counter-num" data-target="500">0</span>+</div>
                        <div class="hero-stat-label">Projects Done</div>
                    </div>
                    <div style="width:1px;background:rgba(255,255,255,0.1);"></div>
                    <div>
                        <div class="hero-stat-num"><span class="counter-num" data-target="10">0</span>+</div>
                        <div class="hero-stat-label">Years Experience</div>
                    </div>
                    <div style="width:1px;background:rgba(255,255,255,0.1);"></div>
                    <div>
                        <div class="hero-stat-num"><span class="counter-num" data-target="300">0</span>+</div>
                        <div class="hero-stat-label">Happy Clients</div>
                    </div>
                </div>
            </div>
            <div class="col-lg-5 d-none d-lg-block">
                <div class="reveal-right" style="position:relative;">
                    <div style="border-radius:20px;overflow:hidden;box-shadow:0 30px 80px rgba(0,0,0,0.5);">
                        <img src="https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?w=700&q=85"
                             alt="RK Group Premium Interior"
                             style="width:100%;height:500px;object-fit:cover;">
                    </div>
                    <div style="position:absolute;bottom:28px;left:-20px;background:rgba(255,255,255,0.96);backdrop-filter:blur(10px);border-radius:14px;padding:16px 20px;box-shadow:0 10px 40px rgba(0,0,0,0.15);">
                        <div style="display:flex;align-items:center;gap:12px;">
                            <div style="width:42px;height:42px;background:linear-gradient(135deg,#b8860b,#d4a017);border-radius:10px;display:flex;align-items:center;justify-content:center;">
                                <i class="bi bi-award" style="color:#fff;font-size:1.1rem;"></i>
                            </div>
                            <div>
                                <div style="font-weight:700;font-size:0.88rem;color:#1a1a1a;">Featured Project</div>
                                <div style="font-size:0.75rem;color:#888;">Luxury Villa Interior — Bhopal</div>
                            </div>
                        </div>
                    </div>
                    <div style="position:absolute;top:28px;right:-15px;background:linear-gradient(135deg,#b8860b,#d4a017);border-radius:14px;padding:14px 18px;box-shadow:0 10px 30px rgba(184,134,11,0.4);">
                        <div style="color:#fff;font-size:1.6rem;font-weight:700;font-family:'Playfair Display',serif;line-height:1;">10+</div>
                        <div style="color:rgba(255,255,255,0.8);font-size:0.72rem;letter-spacing:1px;">YEARS EXP.</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- SERVICES -->
<section class="section section-light" id="services">
    <div class="container">
        <div class="text-center mb-5 reveal">
            <span class="section-tag">What We Do</span>
            <h2 class="section-title mt-2">Our <span>Services</span></h2>
            <div class="divider divider-center"></div>
        </div>
        <div class="row g-4">
            <div class="col-md-4 col-sm-6 reveal">
                <div class="service-card">
                    <img src="https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?w=500&q=80" alt="Interior Design">
                    <div class="service-card-body">
                        <div class="service-icon"><i class="bi bi-house-door"></i></div>
                        <h5 class="mt-3 mb-2">Interior Design</h5>
                        <p style="color:var(--text-muted);font-size:0.9rem;">Complete home and office interior design solutions tailored to your lifestyle and budget.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-sm-6 reveal">
                <div class="service-card">
                    <img src="https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=500&q=80" alt="Modular Kitchen">
                    <div class="service-card-body">
                        <div class="service-icon"><i class="bi bi-grid-3x3-gap"></i></div>
                        <h5 class="mt-3 mb-2">Modular Kitchen</h5>
                        <p style="color:var(--text-muted);font-size:0.9rem;">Modern modular kitchen designs with premium materials, maximum storage, and elegant finish.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-sm-6 reveal">
                <div class="service-card">
                    <img src="https://images.unsplash.com/photo-1565538810643-b5bdb714032a?w=500&q=80" alt="False Ceiling">
                    <div class="service-card-body">
                        <div class="service-icon"><i class="bi bi-easel2"></i></div>
                        <h5 class="mt-3 mb-2">False Ceiling</h5>
                        <p style="color:var(--text-muted);font-size:0.9rem;">Designer false ceilings with LED lighting to elevate the look of any room.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-sm-6 reveal">
                <div class="service-card">
                    <img src="https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=500&q=80" alt="Door Work">
                    <div class="service-card-body">
                        <div class="service-icon"><i class="bi bi-door-open"></i></div>
                        <h5 class="mt-3 mb-2">Door &amp; Window Work</h5>
                        <p style="color:var(--text-muted);font-size:0.9rem;">Teak, engineered wood, and uPVC doors &amp; windows with expert installation.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-sm-6 reveal">
                <div class="service-card">
                    <img src="https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500&q=80" alt="Custom Furniture">
                    <div class="service-card-body">
                        <div class="service-icon"><i class="bi bi-columns-gap"></i></div>
                        <h5 class="mt-3 mb-2">Custom Furniture</h5>
                        <p style="color:var(--text-muted);font-size:0.9rem;">Handcrafted sofas, wardrobes, beds, and TV units built exactly to your measurements.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-sm-6 reveal">
                <div class="service-card">
                    <img src="https://images.unsplash.com/photo-1631679706909-1844bbd07221?w=500&q=80" alt="Wall Panels">
                    <div class="service-card-body">
                        <div class="service-icon"><i class="bi bi-brush"></i></div>
                        <h5 class="mt-3 mb-2">Wall Panels &amp; POP</h5>
                        <p style="color:var(--text-muted);font-size:0.9rem;">Decorative wall panels, POP work, and texture painting for stunning interiors.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- WHY CHOOSE US -->
<section class="section section-white" id="why">
    <div class="container">
        <div class="row align-items-center g-5">
            <div class="col-lg-5 reveal-left">
                <span class="section-tag">Why RK Group?</span>
                <h2 class="section-title mt-2 mb-3">Craftsmanship You Can <span>Trust</span></h2>
                <p style="color:var(--text-muted);margin-bottom:36px;">We combine traditional woodworking craftsmanship with modern interior design techniques to deliver premium results every time.</p>
                <div class="why-item">
                    <div class="why-icon"><i class="bi bi-award"></i></div>
                    <div>
                        <h6>10+ Years of Experience</h6>
                        <p>Over a decade of delivering quality furniture and interior projects across Madhya Pradesh.</p>
                    </div>
                </div>
                <div class="why-item">
                    <div class="why-icon"><i class="bi bi-patch-check"></i></div>
                    <div>
                        <h6>Premium Quality Materials</h6>
                        <p>We use only certified, durable materials from trusted suppliers for long-lasting results.</p>
                    </div>
                </div>
                <div class="why-item">
                    <div class="why-icon"><i class="bi bi-clock-history"></i></div>
                    <div>
                        <h6>On-Time Delivery</h6>
                        <p>We respect your timeline and complete every project on schedule without compromising quality.</p>
                    </div>
                </div>
                <div class="why-item">
                    <div class="why-icon"><i class="bi bi-headset"></i></div>
                    <div>
                        <h6>Dedicated Support</h6>
                        <p>From first consultation to post-installation, our team is always available to help you.</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-7 reveal-right">
                <div style="position:relative;border-radius:16px;overflow:hidden;box-shadow:var(--shadow-lg);">
                    <img src="https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?w=800&q=80"
                         alt="RK Group - Premium Interior Project"
                         style="width:100%;height:420px;object-fit:cover;display:block;">
                    <div style="position:absolute;bottom:20px;left:20px;background:rgba(26,18,8,0.85);backdrop-filter:blur(8px);border:1px solid rgba(200,164,92,0.3);border-radius:12px;padding:16px 22px;">
                        <p style="color:var(--gold);font-size:0.72rem;letter-spacing:2px;text-transform:uppercase;margin:0 0 4px;">Featured Project</p>
                        <h6 style="color:#fff;margin:0;font-size:0.95rem;">Luxury Villa Interior — Bhopal</h6>
                        <small style="color:rgba(255,255,255,0.6);">Full Interior Design &amp; Custom Furniture</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- TESTIMONIALS -->
<section class="section section-light" id="testimonials">
    <div class="container">
        <div class="text-center mb-5 reveal">
            <span class="section-tag">Client Reviews</span>
            <h2 class="section-title mt-2">What Our <span>Clients Say</span></h2>
            <div class="divider divider-center"></div>
        </div>
        <div class="row g-4">
            <div class="col-md-4 reveal">
                <div class="testimonial-card">
                    <div class="stars mb-3">★★★★★</div>
                    <p style="color:var(--text-muted);font-size:0.92rem;margin-bottom:20px;">
                        "Excellent work on our home interior! Rahul ji and his team completed the modular kitchen and false ceiling beautifully. Very professional and timely delivery."
                    </p>
                    <div class="d-flex align-items-center gap-3">
                        <div style="width:44px;height:44px;background:linear-gradient(135deg,rgba(184,134,11,0.15),rgba(184,134,11,0.05));border:1px solid rgba(184,134,11,0.2);border-radius:50%;display:flex;align-items:center;justify-content:center;color:var(--primary);font-weight:700;">R</div>
                        <div>
                            <h6 style="margin:0;font-size:0.92rem;">Ramesh Sharma</h6>
                            <small style="color:var(--text-muted);">Arera Colony, Bhopal</small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 reveal">
                <div class="testimonial-card">
                    <div class="stars mb-3">★★★★★</div>
                    <p style="color:var(--text-muted);font-size:0.92rem;margin-bottom:20px;">
                        "Got a complete bedroom set and wardrobe made. The quality of wood and finishing is outstanding. Prices are very reasonable too. Highly recommend!"
                    </p>
                    <div class="d-flex align-items-center gap-3">
                        <div style="width:44px;height:44px;background:linear-gradient(135deg,rgba(184,134,11,0.15),rgba(184,134,11,0.05));border:1px solid rgba(184,134,11,0.2);border-radius:50%;display:flex;align-items:center;justify-content:center;color:var(--primary);font-weight:700;">P</div>
                        <div>
                            <h6 style="margin:0;font-size:0.92rem;">Priya Patel</h6>
                            <small style="color:var(--text-muted);">MP Nagar, Bhopal</small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 reveal">
                <div class="testimonial-card">
                    <div class="stars mb-3">★★★★☆</div>
                    <p style="color:var(--text-muted);font-size:0.92rem;margin-bottom:20px;">
                        "RK Group renovated our entire office. The panel work and furniture look very modern and premium. The team was cooperative and worked neatly. Great experience!"
                    </p>
                    <div class="d-flex align-items-center gap-3">
                        <div style="width:44px;height:44px;background:linear-gradient(135deg,rgba(184,134,11,0.15),rgba(184,134,11,0.05));border:1px solid rgba(184,134,11,0.2);border-radius:50%;display:flex;align-items:center;justify-content:center;color:var(--primary);font-weight:700;">S</div>
                        <div>
                            <h6 style="margin:0;font-size:0.92rem;">Sunil Gupta</h6>
                            <small style="color:var(--text-muted);">Betul, MP</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CONTACT + MAP -->
<section class="section section-white" id="contact">
    <div class="container">
        <div class="row g-5">
            <div class="col-lg-5 reveal-left">
                <span class="section-tag">Get In Touch</span>
                <h2 class="section-title mt-2 mb-3">Contact <span>Us</span></h2>
                <p style="color:var(--text-muted);margin-bottom:30px;">Have a project in mind? Send us a message and we'll get back to you within 24 hours.</p>
                <div class="why-item mb-3">
                    <div class="why-icon" style="min-width:46px;height:46px;"><i class="bi bi-telephone"></i></div>
                    <div>
                        <h6>Phone / WhatsApp</h6>
                        <a href="tel:7772897077" style="color:var(--primary);font-weight:600;font-size:1.05rem;">7772897077</a>
                    </div>
                </div>
                <div class="why-item mb-3">
                    <div class="why-icon" style="min-width:46px;height:46px;"><i class="bi bi-envelope"></i></div>
                    <div>
                        <h6>Email</h6>
                        <a href="mailto:rahulvishwakarma111999@gmail.com" style="color:var(--text-mid);font-size:0.88rem;">rahulvishwakarma111999@gmail.com</a>
                    </div>
                </div>
                <div class="why-item mb-4">
                    <div class="why-icon" style="min-width:46px;height:46px;"><i class="bi bi-geo-alt"></i></div>
                    <div>
                        <h6>Location</h6>
                        <a href="https://maps.app.goo.gl/g78BgUACNh3cK3iz8?g_st=aw" target="_blank" style="color:var(--primary);">View on Google Maps →</a>
                    </div>
                </div>
                <form action="${pageContext.request.contextPath}/inquiry" method="post" class="contact-form needs-validation" novalidate>
                    <div class="mb-3">
                        <label>Your Name *</label>
                        <input type="text" class="form-control" name="name" placeholder="Enter your name" required>
                    </div>
                    <div class="mb-3">
                        <label>Phone Number *</label>
                        <input type="tel" class="form-control" name="phone" placeholder="Enter phone number" maxlength="10" required>
                    </div>
                    <div class="mb-3">
                        <label>Message</label>
                        <textarea class="form-control" name="message" rows="3" placeholder="Tell us about your project..."></textarea>
                    </div>
                    <button type="submit" class="btn btn-gold w-100">
                        <i class="bi bi-send me-2"></i>Send Message
                    </button>
                </form>
            </div>
            <div class="col-lg-7 reveal-right">
                <div style="border-radius:var(--radius-lg);overflow:hidden;border:1px solid var(--mid-gray);box-shadow:var(--shadow-md);">
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1000!2d77.9!3d21.9!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zMjHCsDU0JzAwLjAiTiA3N8KwNTQnMDAuMCJF!5e0!3m2!1sen!2sin!4v1234567890"
                            width="100%" height="460" style="border:0;display:block;" allowfullscreen="" loading="lazy">
                    </iframe>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- FOOTER -->
<footer class="footer">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <div class="footer-logo"><span>RK</span> GROUP</div>
                <p style="margin-bottom:20px;">Premium furniture craftsmanship and interior design solutions. We transform your space with elegance, quality, and timely delivery.</p>
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
            <p style="margin:0;font-size:0.82rem;">&copy; 2024 RK GROUP FURNITURES &amp; INTERIOR. All Rights Reserved. | Owner: <span style="color:var(--gold);">Rahul Vishwakarma</span></p>
            <a href="${pageContext.request.contextPath}/admin/login" style="color:#333;font-size:0.72rem;">&bull; Admin</a>
        </div>
    </div>
</footer>

<a href="https://wa.me/917772897077?text=Hello%20RK%20Group%2C%20I%20am%20interested%20in%20your%20services." class="whatsapp-float" target="_blank">
    <i class="bi bi-whatsapp"></i>
</a>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>