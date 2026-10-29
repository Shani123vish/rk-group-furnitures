<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
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
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>About Us | RK GROUP FURNITURES &amp; INTERIOR</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
<style>
.stat-box {
	background: var(--white);
	border: 1px solid var(--mid-gray);
	border-radius: var(--radius-lg);
	padding: 20px;
	text-align: center;
	transition: var(--transition);
	box-shadow: var(--shadow-sm);
}
.stat-box:hover {
	transform: translateY(-4px);
	box-shadow: var(--shadow-md);
	border-color: rgba(184, 134, 11, 0.3);
}
.stat-box .num {
	font-family: 'Playfair Display', serif;
	font-size: 2rem;
	font-weight: 700;
	color: var(--primary);
	line-height: 1;
}
.stat-box .lbl {
	font-size: 0.8rem;
	color: var(--text-muted);
	margin-top: 6px;
}
.mv-card {
	background: var(--white);
	border: 1px solid var(--mid-gray);
	border-radius: var(--radius-lg);
	padding: 32px 24px;
	text-align: center;
	transition: var(--transition);
	box-shadow: var(--shadow-sm);
	height: 100%;
}
.mv-card:hover {
	transform: translateY(-5px);
	box-shadow: var(--shadow-lg);
	border-color: rgba(184, 134, 11, 0.3);
}
.why-card {
	background: var(--white);
	border: 1px solid var(--mid-gray);
	border-radius: var(--radius-lg);
	padding: 20px;
	text-align: center;
	transition: var(--transition);
	box-shadow: var(--shadow-sm);
}
.why-card:hover {
	transform: translateY(-4px);
	box-shadow: var(--shadow-md);
	border-color: rgba(184, 134, 11, 0.3);
}
</style>
</head>
<body>

	<!-- NAVBAR -->
	<nav class="navbar navbar-expand-lg">
		<div class="container">
			<a class="navbar-brand" href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/images/rk-logo.png" alt="RK Group Logo" class="brand-logo">RK GROUP<span>FURNITURES &amp; INTERIOR</span></a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navMenu">
				<ul class="navbar-nav ms-auto align-items-center gap-1">
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">Home</a></li>
					<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/about.jsp">About</a></li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/gallery">Gallery</a></li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products">Products</a></li>
					<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/jsp/public/contact.jsp">Contact</a></li>
					<li class="nav-item ms-2"><a class="btn btn-gold btn-sm" href="${pageContext.request.contextPath}/booking"><i class="bi bi-calendar-check me-1"></i>Book Visit</a></li>
					<li class="nav-item ms-1"><a href="${pageContext.request.contextPath}/admin/login" style="color: #888; padding: 6px 10px; display: flex; align-items: center;"><i class="bi bi-lock" style="font-size: 1rem;"></i></a></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- PAGE HEADER -->
	<div class="page-header-banner">
		<div class="container">
			<span class="section-tag" style="color: rgba(201, 168, 76, 0.9); border-color: rgba(201, 168, 76, 0.25); background: rgba(201, 168, 76, 0.08);">Who We Are</span>
			<h1 class="section-title mt-2" style="color: #fff;">
				About <span style="color: var(--gold-light);">RK GROUP</span>
			</h1>
			<p style="color: rgba(255, 255, 255, 0.55); margin-top: 8px;">Rewa's premier furniture craftsmanship and interior design company — where quality meets elegance.</p>
			<nav aria-label="breadcrumb" class="mt-3">
				<ol class="breadcrumb" style="background: none; padding: 0; margin: 0;">
					<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/" style="color: rgba(255, 255, 255, 0.5);">Home</a></li>
					<li class="breadcrumb-item active" style="color: var(--gold-light);">About Us</li>
				</ol>
			</nav>
		</div>
	</div>

	<!-- COMPANY STORY -->
	<section class="section section-light">
		<div class="container">
			<div class="row align-items-center g-5">
				<div class="col-lg-5 reveal-left">
					<div style="position: relative;">
						<img src="${pageContext.request.contextPath}/images/about-company.jpg" alt="RK Group Company" style="width: 100%; height: 440px; object-fit: cover;">
						<div style="position: absolute; bottom: -18px; right: -16px; background: linear-gradient(135deg, var(--primary-light), var(--primary-dark)); border-radius: var(--radius-lg); padding: 20px 24px; text-align: center; box-shadow: var(--shadow-gold);">
							<div style="font-family: 'Playfair Display', serif; font-size: 2.2rem; font-weight: 700; color: #fff; line-height: 1;">10+</div>
							<div style="color: rgba(255, 255, 255, 0.8); font-size: 0.72rem; letter-spacing: 2px; text-transform: uppercase;">YEARS EXP.</div>
						</div>
					</div>
				</div>
				<div class="col-lg-7 reveal-right">
					<span class="section-tag">Our Story</span>
					<h2 class="section-title mt-2 mb-3">
						Rewa's Trusted <span>Furniture Shop</span>
					</h2>
					<p style="color: var(--text-muted); margin-bottom: 16px; line-height: 1.9;">
						<strong style="color: var(--text-dark);">RK GROUP FURNITURES &amp; INTERIOR</strong> was founded by <strong style="color: var(--primary);">Rahul Vishwakarma</strong> with a
						clear vision — to make premium quality furniture and beautiful
						interior design accessible to every home and office, without
						compromising on affordability.
					</p>
					<p style="color: var(--text-muted); margin-bottom: 32px; line-height: 1.9;">
						Today, after 10+ years of hard work and 500+ successful projects,
						we have become one of the most trusted furniture and interior
						design Shop in Rewa. With our skilled workers and modern
						techniques, we deliver exceptional results in every project.</p>
					<div class="row g-3 mb-4">
						<div class="col-6"><div class="stat-box"><div class="num">500+</div><div class="lbl">Projects Completed</div></div></div>
						<div class="col-6"><div class="stat-box"><div class="num">300+</div><div class="lbl">Happy Clients</div></div></div>
						<div class="col-6"><div class="stat-box"><div class="num">15+</div><div class="lbl">Skilled Workers</div></div></div>
						<div class="col-6"><div class="stat-box"><div class="num">10+</div><div class="lbl">Years Experience</div></div></div>
					</div>
					<div class="d-flex gap-3 flex-wrap">
						<a href="${pageContext.request.contextPath}/gallery" class="btn btn-gold"><i class="bi bi-images me-2"></i>View Our Work</a>
						<a href="https://wa.me/917772897077" class="btn btn-outline-gold" target="_blank"><i class="bi bi-whatsapp me-2"></i>Chat on WhatsApp</a>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- MISSION & VISION -->
	<section class="section section-white">
		<div class="container">
			<div class="text-center mb-5 reveal">
				<span class="section-tag">What Drives Us</span>
				<h2 class="section-title mt-2">Mission &amp; <span>Vision</span></h2>
				<div class="divider divider-center"></div>
			</div>
			<div class="row g-4">
				<div class="col-md-4 reveal">
					<div class="mv-card">
						<div class="service-icon mx-auto mb-3"><i class="bi bi-bullseye"></i></div>
						<h5 style="color: var(--primary); margin-bottom: 14px;">Our Mission</h5>
						<p style="color: var(--text-muted); font-size: 0.9rem; line-height: 1.8;">
							To provide every client with premium quality furniture and
							interior design solutions at competitive prices. We are committed
							to maintaining the highest standards of craftsmanship — no
							exceptions, no compromises.</p>
					</div>
				</div>
				<div class="col-md-4 reveal">
					<div class="mv-card" style="border-color: rgba(184, 134, 11, 0.2); background: linear-gradient(135deg, rgba(184, 134, 11, 0.03), var(--white));">
						<div class="service-icon mx-auto mb-3"><i class="bi bi-eye"></i></div>
						<h5 style="color: var(--primary); margin-bottom: 14px;">Our Vision</h5>
						<p style="color: var(--text-muted); font-size: 0.9rem; line-height: 1.8;">
							To become Madhya Pradesh's most recognised furniture and interior
							design brand — the first name that comes to mind whenever someone
							plans to furnish or renovate their home or office.</p>
					</div>
				</div>
				<div class="col-md-4 reveal">
					<div class="mv-card">
						<div class="service-icon mx-auto mb-3"><i class="bi bi-heart"></i></div>
						<h5 style="color: var(--primary); margin-bottom: 14px;">Our Values</h5>
						<p style="color: var(--text-muted); font-size: 0.9rem; line-height: 1.8;">
							Integrity, Quality, and Customer Satisfaction — these three
							principles form the foundation of everything we do. We uphold
							these values on every project, without exception.</p>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- OWNER PROFILE -->
	<section class="section section-light">
		<div class="container">
			<div class="text-center mb-5 reveal">
				<span class="section-tag">Leadership</span>
				<h2 class="section-title mt-2">Meet the <span>Owner</span></h2>
				<div class="divider divider-center"></div>
			</div>
			<div class="row justify-content-center">
				<div class="col-lg-9 reveal">
					<div style="background: var(--white); border: 1px solid var(--mid-gray); border-radius: var(--radius-lg); padding: 40px; box-shadow: var(--shadow-md);">
						<div class="row align-items-center g-4">
							<div class="col-md-3 text-center">
								<div style="width: 130px; height: 130px; border: 2px solid rgba(184, 134, 11, 0.25); border-radius: 50%; overflow: hidden; margin: 0 auto 14px;">
									<img src="${pageContext.request.contextPath}/images/owner.jpg" alt="Rahul Vishwakarma" style="width: 100%; height: 100%; object-fit: cover;">
								</div>
								<span style="background: rgba(184, 134, 11, 0.08); border: 1px solid rgba(184, 134, 11, 0.2); color: var(--primary); padding: 4px 14px; border-radius: 20px; font-size: 0.75rem; font-weight: 600;">Founder &amp; Owner</span>
							</div>
							<div class="col-md-9 text-start">
								<h3 style="font-family: 'Playfair Display', serif; color: var(--text-dark); margin-bottom: 4px;">Rahul Vishwakarma</h3>
								<p style="color: var(--primary); font-size: 0.9rem; margin-bottom: 16px; font-weight: 500;">RK GROUP FURNITURES &amp; INTERIOR</p>
								<p style="color: var(--text-muted); line-height: 1.9; font-size: 0.92rem; margin-bottom: 16px;">
									At RK GROUP Furnitures &amp; Interior, Rahul started with a
									small workshop more than 10 years ago. Today, under his
									leadership, the company has grown into a trusted furniture and
									interior destination, helping hundreds of homes and offices in
									Rewa look stylish, comfortable, and modern.</p>
								<blockquote style="border-left: 3px solid var(--primary); padding-left: 16px; color: var(--text-mid); font-style: italic; font-size: 0.92rem; margin-bottom: 20px;">
									"Every home deserves quality furniture and thoughtful design —
									because home is where your family's happiness begins."</blockquote>
								<div class="d-flex flex-wrap gap-2">
									<a href="tel:7772897077" style="display: inline-flex; align-items: center; gap: 8px; background: rgba(184, 134, 11, 0.06); border: 1px solid rgba(184, 134, 11, 0.2); border-radius: 50px; padding: 8px 18px; color: var(--text-dark); font-size: 0.85rem; font-weight: 500; text-decoration: none;">
										<i class="bi bi-telephone" style="color: var(--primary);"></i>7772897077
									</a>
									<a href="mailto:rkgroupfurnituresinterior@gmail.com" style="display: inline-flex; align-items: center; gap: 8px; background: rgba(184, 134, 11, 0.06); border: 1px solid rgba(184, 134, 11, 0.2); border-radius: 50px; padding: 8px 18px; color: var(--text-dark); font-size: 0.85rem; font-weight: 500; text-decoration: none;">
										<i class="bi bi-envelope" style="color: var(--primary);"></i>Email Us
									</a>
									<a href="https://wa.me/917772897077" target="_blank" style="display: inline-flex; align-items: center; gap: 8px; background: rgba(37, 211, 102, 0.07); border: 1px solid rgba(37, 211, 102, 0.2); border-radius: 50px; padding: 8px 18px; color: var(--text-dark); font-size: 0.85rem; font-weight: 500; text-decoration: none;">
										<i class="bi bi-whatsapp" style="color: #25D366;"></i>WhatsApp
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- SPECIALITIES -->
	<section class="section section-white">
		<div class="container">
			<div class="text-center mb-5 reveal">
				<span class="section-tag">Expertise</span>
				<h2 class="section-title mt-2">Our <span>Specialities</span></h2>
				<div class="divider divider-center"></div>
			</div>
			<div class="row g-4">
				<div class="col-lg-4 col-md-6 reveal">
					<div class="why-item">
						<div class="why-icon"><i class="bi bi-house-door"></i></div>
						<div><h6>Full Home Interior</h6>
							<p>Complete home interior design from living room to bedroom — executed by our experienced professional team.</p></div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6 reveal">
					<div class="why-item">
						<div class="why-icon"><i class="bi bi-grid-3x3-gap"></i></div>
						<div><h6>Modular Kitchen</h6>
							<p>Modern, functional and elegant modular kitchens crafted with premium materials and intelligent storage solutions.</p></div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6 reveal">
					<div class="why-item">
						<div class="why-icon"><i class="bi bi-columns-gap"></i></div>
						<div><h6>Custom Furniture</h6>
							<p>Custom-built sofas, beds, wardrobes, TV units and more — crafted precisely to your measurements and design preferences.</p></div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6 reveal">
					<div class="why-item">
						<div class="why-icon"><i class="bi bi-door-open"></i></div>
						<div><h6>Door &amp; Window Work</h6>
							<p>Premium teak, engineered wood and uPVC doors and windows — complete supply and professional installation included.</p></div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6 reveal">
					<div class="why-item">
						<div class="why-icon"><i class="bi bi-easel2"></i></div>
						<div><h6>False Ceiling &amp; POP</h6>
							<p>Designer false ceilings with integrated LED lighting systems — ideal for living rooms, bedrooms and commercial spaces.</p></div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6 reveal">
					<div class="why-item">
						<div class="why-icon"><i class="bi bi-building"></i></div>
						<div><h6>Office Interior</h6>
							<p>Professional office interiors — reception areas, private cabins, conference rooms and workstations designed and executed seamlessly.</p></div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- WHY CHOOSE US -->
	<section class="section section-light">
		<div class="container">
			<div class="text-center mb-5 reveal">
				<span class="section-tag">Our Advantages</span>
				<h2 class="section-title mt-2">Why <span>Choose RK Group?</span></h2>
				<div class="divider divider-center"></div>
			</div>
			<div class="row g-4">
				<div class="col-md-3 col-sm-6 reveal">
					<div class="why-card">
						<div class="service-icon mx-auto mb-3"><i class="bi bi-award"></i></div>
						<h6 class="mt-2">10+ Years</h6>
						<p style="color: var(--text-muted); font-size: 0.85rem; margin: 0;">A decade of proven experience reflected in every project we deliver.</p>
					</div>
				</div>
				<div class="col-md-3 col-sm-6 reveal">
					<div class="why-card">
						<div class="service-icon mx-auto mb-3"><i class="bi bi-patch-check"></i></div>
						<h6 class="mt-2">Quality Guarantee</h6>
						<p style="color: var(--text-muted); font-size: 0.85rem; margin: 0;">Only certified, premium grade materials are used across all our projects.</p>
					</div>
				</div>
				<div class="col-md-3 col-sm-6 reveal">
					<div class="why-card">
						<div class="service-icon mx-auto mb-3"><i class="bi bi-clock-history"></i></div>
						<h6 class="mt-2">On-Time Delivery</h6>
						<p style="color: var(--text-muted); font-size: 0.85rem; margin: 0;">Completing every project on schedule is a commitment we take seriously.</p>
					</div>
				</div>
				<div class="col-md-3 col-sm-6 reveal">
					<div class="why-card">
						<div class="service-icon mx-auto mb-3"><i class="bi bi-currency-rupee"></i></div>
						<h6 class="mt-2">Best Price</h6>
						<p style="color: var(--text-muted); font-size: 0.85rem; margin: 0;">Best-in-class quality combined with the most competitive pricing in the market.</p>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- CTA -->
	<div class="cta-section reveal">
		<div class="container">
			<span class="section-tag" style="color: rgba(201, 168, 76, 0.9); border-color: rgba(201, 168, 76, 0.25); background: rgba(201, 168, 76, 0.08);">Start Today</span>
			<h2 class="section-title mt-3 mb-3" style="color: #fff;">
				Start Your <span style="color: var(--gold-light);">Project Today</span>
			</h2>
			<p>Book a free site visit — our expert will visit your space,
				understand your requirements, and provide a detailed FREE quotation.</p>
			<div class="d-flex gap-3 justify-content-center flex-wrap mt-4">
				<a href="${pageContext.request.contextPath}/booking" class="btn btn-gold btn-lg"><i class="bi bi-calendar-check me-2"></i>Book Free Visit</a>
				<a href="${pageContext.request.contextPath}/gallery" class="btn btn-outline-gold btn-lg"><i class="bi bi-images me-2"></i>View Our Portfolio</a>
			</div>
		</div>
	</div>

	<!-- FOOTER -->
	<footer class="footer">
		<div class="container">
			<div class="row g-4">
				<div class="col-lg-4 col-md-6">
					<div class="footer-logo">
						<img src="${pageContext.request.contextPath}/images/rk-logo.png" alt="RK Group" style="height:40px;width:auto;margin-right:8px;vertical-align:middle;"><span>RK</span> GROUP
					</div>
					<p>Premium furniture craftsmanship and interior design
						solutions. We transform your space with elegance, quality, and
						timely delivery.</p>
					<div class="mt-3">
						<a href="https://wa.me/917772897077" class="social-link"><i class="bi bi-whatsapp"></i></a>
						<a href="#" class="social-link"><i class="bi bi-facebook"></i></a>
						<a href="#" class="social-link"><i class="bi bi-instagram"></i></a>
					</div>
				</div>
				<div class="col-lg-2 col-md-6">
					<h5>Quick Links</h5>
					<ul class="list-unstyled" style="font-size: 0.88rem;">
						<li class="mb-2"><a href="${pageContext.request.contextPath}/">Home</a></li>
						<li class="mb-2"><a href="${pageContext.request.contextPath}/about.jsp">About Us</a></li>
						<li class="mb-2"><a href="${pageContext.request.contextPath}/gallery">Gallery</a></li>
						<li class="mb-2"><a href="${pageContext.request.contextPath}/products">Products</a></li>
						<li class="mb-2"><a href="${pageContext.request.contextPath}/booking">Book Visit</a></li>
					</ul>
				</div>
				<div class="col-lg-3 col-md-6">
					<h5>Services</h5>
					<ul class="list-unstyled" style="font-size: 0.88rem;">
						<li class="mb-2"><a href="#">Interior Design</a></li>
						<li class="mb-2"><a href="#">Modular Kitchen</a></li>
						<li class="mb-2"><a href="#">Custom Furniture</a></li>
						<li class="mb-2"><a href="#">Door &amp; Window Work</a></li>
						<li class="mb-2"><a href="#">False Ceiling</a></li>
					</ul>
				</div>
				<div class="col-lg-3 col-md-6">
					<h5>Contact Info</h5>
					<ul class="list-unstyled" style="font-size: 0.88rem;">
						<li class="mb-2"><i class="bi bi-telephone me-2" style="color: var(--gold);"></i><a href="tel:7772897077">7772897077</a></li>
						<li class="mb-2"><i class="bi bi-whatsapp me-2" style="color: var(--gold);"></i><a href="https://wa.me/917772897077">WhatsApp Us</a></li>
						<li class="mb-2"><i class="bi bi-envelope me-2" style="color: var(--gold);"></i><a href="mailto:rkgroupfurnituresinterior@gmail.com">Email Us</a></li>
						<li class="mb-2"><i class="bi bi-geo-alt me-2" style="color: var(--gold);"></i><a href="https://maps.app.goo.gl/g78BgUACNh3cK3iz8?g_st=aw" target="_blank">View Location</a></li>
					</ul>
				</div>
			</div>
			<div class="footer-bottom d-flex justify-content-between align-items-center flex-wrap gap-2">
				<p style="margin: 0; font-size: 0.82rem;">
					&copy; 2024 RK GROUP FURNITURES &amp; INTERIOR. All Rights
					Reserved. | Owner: <span style="color: var(--gold);">Rahul Vishwakarma</span>
				</p>
				<a href="${pageContext.request.contextPath}/admin/login" style="color: #333; font-size: 0.72rem;">&bull; Admin</a>
			</div>
		</div>
	</footer>

	<a href="https://wa.me/917772897077?text=Hello%20RK%20Group!" class="whatsapp-float" target="_blank"><i class="bi bi-whatsapp"></i></a>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
