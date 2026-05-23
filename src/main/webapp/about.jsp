<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>About Us | RK GROUP FURNITURES &amp; INTERIOR</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Playfair+Display:wght@400;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/style.css"
	rel="stylesheet">
</head>
<body>

	<!-- ===================== NAVBAR ===================== -->
	<nav class="navbar navbar-expand-lg">
		<div class="container">
			<a class="navbar-brand" href="${pageContext.request.contextPath}/">
				<i class="bi bi-gem me-2" style="color: var(--primary)"></i>RK GROUP
				<span>FURNITURES &amp; INTERIOR</span>
			</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navMenu">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navMenu">
				<ul class="navbar-nav ms-auto align-items-center gap-1">
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/">Home</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="${pageContext.request.contextPath}/about.jsp">About</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/gallery">Gallery</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/products">Products</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/jsp/public/contact.jsp">Contact</a></li>
					<li class="nav-item ms-2"><a class="btn btn-gold btn-sm px-3"
						href="${pageContext.request.contextPath}/booking">Book Visit</a></li>
					<li class="nav-item ms-1"><a
						href="${pageContext.request.contextPath}/admin/login"
						style="color: #444; padding: 6px 10px; display: flex; align-items: center;"
						title="Admin Login"> <i class="bi bi-lock"
							style="font-size: 1rem;"></i>
					</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- ===================== PAGE HEADER ===================== -->
	<div
		style="background: var(--dark-2); padding: 70px 0 50px; border-bottom: 1px solid rgba(200, 164, 92, 0.1); position: relative; overflow: hidden;">
		<div
			style="position: absolute; top: -40px; right: -40px; width: 300px; height: 300px; background: radial-gradient(circle, rgba(200, 164, 92, 0.06), transparent); border-radius: 50%;"></div>
		<div class="container">
			<p
				style="color: var(--primary); letter-spacing: 3px; font-size: 0.8rem; text-transform: uppercase; margin-bottom: 10px;">
				Who We Are</p>
			<h1 class="section-title">
				About <span>RK GROUP</span>
			</h1>
			<p style="color: var(--muted); max-width: 600px; margin-top: 12px;">
				Rewa's premier furniture craftsmanship and interior design shop —
				where quality meets elegance.</p>
			<!-- Breadcrumb -->
			<div style="margin-top: 20px; font-size: 0.85rem;">
				<a href="${pageContext.request.contextPath}/"
					style="color: var(--muted);">Home</a> <span
					style="color: #444; margin: 0 8px;">/</span> <span
					style="color: var(--primary);">About Us</span>
			</div>
		</div>
	</div>

	<!-- ===================== COMPANY STORY ===================== -->
<section class="section">
    <div class="container">
        <div class="row align-items-center g-5">

            <!-- Left: Company Image -->
            <div class="col-lg-5">
                <div style="position: relative;">

                    <!-- Image -->
                    <img src="images/about-company.jpg"
                         alt="Company Photo"
                         style="width:100%; height:420px; object-fit:cover; border-radius:16px; border:1px solid var(--dark-3);">

                    <!-- Experience badge -->
                    <div
                        style="position: absolute; bottom: -20px; right: -20px; background: linear-gradient(135deg, var(--primary), var(--primary-dark, #a8843c)); border-radius: 12px; padding: 20px 24px; text-align: center; box-shadow: 0 8px 30px rgba(200, 164, 92, 0.3);">

                        <div
                            style="font-size: 2.2rem; font-weight: 700; color: #1a1a1a; line-height: 1;">
                            10+
                        </div>

                        <div
                            style="font-size: 0.75rem; color: #1a1a1a; font-weight: 600; letter-spacing: 1px;">
                            YEARS EXP.
                        </div>

                    </div>

                </div>
            </div>

            <!-- Right: Company Info -->
            <div class="col-lg-7">
                <p
                    style="color: var(--primary); letter-spacing: 3px; font-size: 0.8rem; text-transform: uppercase; margin-bottom: 12px;">
                    Our Story
                </p>

                <h2 class="section-title mb-3">
                    Rewa ki Trusted <span>Furniture Shop</span>
                </h2>

                <p
                    style="color: var(--muted); margin-bottom: 16px; line-height: 1.9;">

                    <strong style="color: var(--light);">
                        RK GROUP FURNITURES &amp; INTERIOR
                    </strong>

                    was founded by
                    <strong style="color: var(--primary);">
                        Rahul Vishwakarma
                    </strong>

                    with a clear vision — to make premium quality furniture and beautiful
                    interior design accessible to every home and office, without
                    compromising on affordability.
                </p>

                <p
                    style="color: var(--muted); margin-bottom: 24px; line-height: 1.9;">

                    Today, after 10+ years of hard work and 500+ successful projects,
                    we have become one of the most trusted furniture and interior
                    design shops in Rewa. With our skilled workers and modern
                    techniques, we deliver exceptional results in every project.
                </p>

                <!-- Key facts -->
                <div class="row g-3 mb-4">

                    <div class="col-6">
                        <div
                            style="background: var(--dark-2); border: 1px solid var(--dark-3); border-radius: 10px; padding: 18px; border-left: 3px solid var(--primary);">

                            <h4
                                style="color: var(--primary); font-size: 1.8rem; margin-bottom: 4px;">
                                500+
                            </h4>

                            <p style="color: var(--muted); font-size: 0.85rem; margin: 0;">
                                Projects Completed
                            </p>

                        </div>
                    </div>

                    <div class="col-6">
                        <div
                            style="background: var(--dark-2); border: 1px solid var(--dark-3); border-radius: 10px; padding: 18px; border-left: 3px solid var(--success);">

                            <h4
                                style="color: var(--success); font-size: 1.8rem; margin-bottom: 4px;">
                                300+
                            </h4>

                            <p style="color: var(--muted); font-size: 0.85rem; margin: 0;">
                                Happy Clients
                            </p>

                        </div>
                    </div>

                    <div class="col-6">
                        <div
                            style="background: var(--dark-2); border: 1px solid var(--dark-3); border-radius: 10px; padding: 18px; border-left: 3px solid var(--info, #4aa3c8);">

                            <h4
                                style="color: #4aa3c8; font-size: 1.8rem; margin-bottom: 4px;">
                                15+
                            </h4>

                            <p style="color: var(--muted); font-size: 0.85rem; margin: 0;">
                                Skilled Workers
                            </p>

                        </div>
                    </div>

                    <div class="col-6">
                        <div
                            style="background: var(--dark-2); border: 1px solid var(--dark-3); border-radius: 10px; padding: 18px; border-left: 3px solid var(--warning, #f0a830);">

                            <h4
                                style="color: #f0a830; font-size: 1.8rem; margin-bottom: 4px;">
                                10+
                            </h4>

                            <p style="color: var(--muted); font-size: 0.85rem; margin: 0;">
                                Years Experience
                            </p>

                        </div>
                    </div>

                </div>

                <div class="d-flex gap-3 flex-wrap">

                    <a href="${pageContext.request.contextPath}/gallery"
                       class="btn btn-gold">

                        <i class="bi bi-images me-2"></i>
                        View Our Work
                    </a>

                    <a href="https://wa.me/917772897077"
                       class="btn btn-outline-gold"
                       target="_blank">

                        <i class="bi bi-whatsapp me-2"></i>
                        Chat on WhatsApp
                    </a>

                </div>

            </div>
        </div>
    </div>
</section>

	<!-- ===================== MISSION & VISION ===================== -->
	<section class="section section-dark">
		<div class="container">
			<div class="text-center mb-5">
				<p
					style="color: var(--primary); letter-spacing: 3px; font-size: 0.8rem; text-transform: uppercase;">What
					Drives Us</p>
				<h2 class="section-title">
					Mission &amp; <span>Vision</span>
				</h2>
				<div class="divider mx-auto"></div>
			</div>
			<div class="row g-4">
				<!-- Mission -->
				<div class="col-md-4">
					<div class="service-card h-100 text-center">
						<div class="service-icon mx-auto">
							<i class="bi bi-bullseye"></i>
						</div>
						<h5 class="mt-3 mb-3" style="color: var(--primary);">Our
							Mission</h5>
						<p
							style="color: var(--muted); font-size: 0.9rem; line-height: 1.8;">
							To provide every client with premium quality furniture and
							interior design solutions at competitive prices. We are committed
							to maintaining the highest standards of craftsmanship — no
							exceptions, no compromises.</p>
					</div>
				</div>
				<!-- Vision -->
				<div class="col-md-4">
					<div class="service-card h-100 text-center">
						<div class="service-icon mx-auto">
							<i class="bi bi-eye"></i>
						</div>
						<h5 class="mt-3 mb-3" style="color: var(--primary);">Our
							Vision</h5>
						<p
							style="color: var(--muted); font-size: 0.9rem; line-height: 1.8;">
							To become Madhya Pradesh's most recognised furniture and interior
							design brand — the first name that comes to mind whenever someone
							plans to furnish or renovate their home or office.</p>
					</div>
				</div>
				<!-- Values -->
				<div class="col-md-4">
					<div class="service-card h-100 text-center">
						<div class="service-icon mx-auto">
							<i class="bi bi-heart"></i>
						</div>
						<h5 class="mt-3 mb-3" style="color: var(--primary);">Our
							Values</h5>
						<p
							style="color: var(--muted); font-size: 0.9rem; line-height: 1.8;">
							Integrity, Quality, and Customer Satisfaction — these three
							principles form the foundation of everything we do. We uphold
							these values on every project, without exception.</p>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- ===================== OWNER PROFILE ===================== -->
<section class="section">
    <div class="container">

        <div class="text-center mb-5">
            <p
                style="color: var(--primary); letter-spacing: 3px; font-size: 0.8rem; text-transform: uppercase;">
                Leadership
            </p>

            <h2 class="section-title">
                Meet the <span>Owner</span>
            </h2>

            <div class="divider mx-auto"></div>
        </div>

        <div class="row justify-content-center">

            <div class="col-lg-8">

                <div
                    style="background: var(--dark-2); border: 1px solid var(--dark-3); border-radius: 16px; padding: 40px; display: flex; gap: 32px; align-items: flex-start; flex-wrap: wrap;">

                    <!-- Photo -->
                    <div style="flex-shrink: 0; text-align: center;">

                        <div
                            style="width: 140px; height: 140px; border: 2px solid rgba(200, 164, 92, 0.3); border-radius: 50%; overflow: hidden; margin: 0 auto 12px;">

                            <img src="images/owner.jpg"
                                 alt="Rahul Vishwakarma"
                                 style="width:100%; height:100%; object-fit:cover;">

                        </div>

                        <div
                            style="background: rgba(200, 164, 92, 0.1); border: 1px solid rgba(200, 164, 92, 0.2); border-radius: 8px; padding: 6px 16px; display: inline-block;">

                            <small
                                style="color: var(--primary); font-size: 0.75rem; letter-spacing: 1px; text-transform: uppercase;">

                                Founder &amp; Owner

                            </small>

                        </div>

                    </div>

                    <!-- Info -->
                    <div style="flex: 1; min-width: 260px;">

                        <h3
                            style="font-family: 'Playfair Display', serif; color: var(--light); margin-bottom: 4px;">

                            Rahul Vishwakarma

                        </h3>

                        <p
                            style="color: var(--primary); font-size: 0.9rem; margin-bottom: 16px;">

                            RK GROUP FURNITURES &amp; INTERIOR

                        </p>

                        <p
                            style="color: var(--muted); line-height: 1.9; font-size: 0.92rem; margin-bottom: 20px;">

                            At RK GROUP Furnitures & Interior, Rahul started with a small
                            workshop more than 5 years ago. Today, under his leadership, the
                            shop has grown into a trusted furniture and interior
                            destination, helping many homes and offices in Rewa look
                            stylish, comfortable, and modern.

                        </p>

                        <p
                            style="color: var(--muted); line-height: 1.9; font-size: 0.92rem; margin-bottom: 24px;">

                            He believes :
                            <em style="color: var(--light);">

                                "Every home deserves quality furniture and thoughtful design — because
                                home is where your family's happiness begins."

                            </em>

                        </p>

                        <!-- Contact info -->
                        <div class="d-flex flex-wrap gap-3">

                            <a href="tel:7772897077"
                               style="display: flex; align-items: center; gap: 8px; background: rgba(200, 164, 92, 0.1); border: 1px solid rgba(200, 164, 92, 0.2); border-radius: 8px; padding: 8px 16px; color: var(--light); text-decoration: none; font-size: 0.88rem;">

                                <i class="bi bi-telephone" style="color: var(--primary);"></i>
                                7772897077

                            </a>

                            <a href="mailto:rahulvishwakarma111999@gmail.com"
                               style="display: flex; align-items: center; gap: 8px; background: rgba(200, 164, 92, 0.1); border: 1px solid rgba(200, 164, 92, 0.2); border-radius: 8px; padding: 8px 16px; color: var(--light); text-decoration: none; font-size: 0.88rem;">

                                <i class="bi bi-envelope" style="color: var(--primary);"></i>
                                Email Us

                            </a>

                            <a href="https://wa.me/917772897077"
                               target="_blank"
                               style="display: flex; align-items: center; gap: 8px; background: rgba(37, 211, 102, 0.1); border: 1px solid rgba(37, 211, 102, 0.2); border-radius: 8px; padding: 8px 16px; color: var(--light); text-decoration: none; font-size: 0.88rem;">

                                <i class="bi bi-whatsapp" style="color: #25D366;"></i>
                                WhatsApp

                            </a>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>
</section>

	<!-- ===================== SERVICES WE OFFER ===================== -->
	<section class="section section-dark">
		<div class="container">
			<div class="text-center mb-5">
				<p
					style="color: var(--primary); letter-spacing: 3px; font-size: 0.8rem; text-transform: uppercase;">Expertise</p>
				<h2 class="section-title">
					Our <span>Specialities</span>
				</h2>
				<div class="divider mx-auto"></div>
			</div>
			<div class="row g-4">
				<div class="col-lg-4 col-md-6">
					<div class="why-item">
						<div class="why-icon">
							<i class="bi bi-house-door"></i>
						</div>
						<div>
							<h6>Full Home Interior</h6>
							<p style="color: var(--muted); font-size: 0.88rem;">Complete
								home interior design from living room to bedroom — executed by
								our experienced professional team.</p>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<div class="why-item">
						<div class="why-icon">
							<i class="bi bi-grid-3x3-gap"></i>
						</div>
						<div>
							<h6>Modular Kitchen</h6>
							<p style="color: var(--muted); font-size: 0.88rem;">Modern,
								functional and elegant modular kitchens crafted with premium
								materials and intelligent storage solutions.</p>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<div class="why-item">
						<div class="why-icon">
							<i class="bi bi-columns-gap"></i>
						</div>
						<div>
							<h6>Custom Furniture</h6>
							<p style="color: var(--muted); font-size: 0.88rem;">Custom-built
								sofas, beds, wardrobes, TV units and more — crafted precisely to
								your measurements and design preferences.</p>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<div class="why-item">
						<div class="why-icon">
							<i class="bi bi-door-open"></i>
						</div>
						<div>
							<h6>Door &amp; Window Work</h6>
							<p style="color: var(--muted); font-size: 0.88rem;">Premium
								teak, engineered wood and uPVC doors and windows — complete
								supply and professional installation included.</p>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<div class="why-item">
						<div class="why-icon">
							<i class="bi bi-easel2"></i>
						</div>
						<div>
							<h6>False Ceiling &amp; POP</h6>
							<p style="color: var(--muted); font-size: 0.88rem;">Designer
								false ceilings with integrated LED lighting systems — ideal for
								living rooms, bedrooms and commercial spaces.</p>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<div class="why-item">
						<div class="why-icon">
							<i class="bi bi-building"></i>
						</div>
						<div>
							<h6>Office Interior</h6>
							<p style="color: var(--muted); font-size: 0.88rem;">Professional
								office interiors — reception areas, private cabins, conference
								rooms and workstations designed and executed seamlessly.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- ===================== WHY CHOOSE US ===================== -->
	<section class="section">
		<div class="container">
			<div class="text-center mb-5">
				<p
					style="color: var(--primary); letter-spacing: 3px; font-size: 0.8rem; text-transform: uppercase;">Our
					Advantages</p>
				<h2 class="section-title">
					Why <span>Choose RK Group?</span>
				</h2>
				<div class="divider mx-auto"></div>
			</div>
			<div class="row g-4">
				<div class="col-md-3 col-sm-6">
					<div class="service-card text-center">
						<div class="service-icon mx-auto">
							<i class="bi bi-award"></i>
						</div>
						<h6 class="mt-3">10++ Years</h6>
						<p style="color: var(--muted); font-size: 0.85rem;">A decade
							of proven experience reflected in every project we deliver.</p>
					</div>
				</div>
				<div class="col-md-3 col-sm-6">
					<div class="service-card text-center">
						<div class="service-icon mx-auto">
							<i class="bi bi-patch-check"></i>
						</div>
						<h6 class="mt-3">Quality Guarantee</h6>
						<p style="color: var(--muted); font-size: 0.85rem;">Only
							certified, premium grade materials are used across all our
							projects.</p>
					</div>
				</div>
				<div class="col-md-3 col-sm-6">
					<div class="service-card text-center">
						<div class="service-icon mx-auto">
							<i class="bi bi-clock-history"></i>
						</div>
						<h6 class="mt-3">On-Time Delivery</h6>
						<p style="color: var(--muted); font-size: 0.85rem;">Completing
							every project on schedule is a commitment we take seriously.</p>
					</div>
				</div>
				<div class="col-md-3 col-sm-6">
					<div class="service-card text-center">
						<div class="service-icon mx-auto">
							<i class="bi bi-currency-rupee"></i>
						</div>
						<h6 class="mt-3">Best Price</h6>
						<p style="color: var(--muted); font-size: 0.85rem;">Best-in-class
							quality combined with the most competitive pricing in the market.</p>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- ===================== CTA ===================== -->
	<div
		style="background: linear-gradient(135deg, rgba(200, 164, 92, 0.1), rgba(200, 164, 92, 0.03)); border-top: 1px solid rgba(200, 164, 92, 0.15); border-bottom: 1px solid rgba(200, 164, 92, 0.15); padding: 70px 0; text-align: center;">
		<div class="container">
			<h3
				style="font-family: 'Playfair Display', serif; margin-bottom: 12px;">Start
				Your Project Today</h3>
			<p
				style="color: var(--muted); margin-bottom: 30px; max-width: 500px; margin-left: auto; margin-right: auto;">
				Book a free site visit — our expert will visit your space,
				understand your requirements, and provide a detailed FREE quotation.
			</p>
			<div class="d-flex gap-3 justify-content-center flex-wrap">
				<a href="${pageContext.request.contextPath}/booking"
					class="btn btn-gold btn-lg"> <i
					class="bi bi-calendar-check me-2"></i>Book Free Visit
				</a> <a href="${pageContext.request.contextPath}/gallery"
					class="btn btn-outline-gold btn-lg"> <i
					class="bi bi-images me-2"></i>View Our Portfolio
				</a>
			</div>
		</div>
	</div>

	<!-- ===================== FOOTER ===================== -->
	<footer class="footer">
		<div class="container">
			<div class="row g-4">
				<div class="col-lg-4 col-md-6">
					<h4
						style="font-family: 'Playfair Display', serif; color: var(--primary); font-size: 1.3rem; margin-bottom: 16px;">RK
						GROUP</h4>
					<p
						style="color: var(--muted); font-size: 0.88rem; line-height: 1.8;">Premium
						furniture craftsmanship and interior design solutions. We
						transform your space with elegance, quality, and timely delivery.</p>
					<div class="mt-3">
						<a href="https://wa.me/917772897077" class="social-link"
							title="WhatsApp"><i class="bi bi-whatsapp"></i></a> <a href="#"
							class="social-link" title="Facebook"><i
							class="bi bi-facebook"></i></a> <a href="#" class="social-link"
							title="Instagram"><i class="bi bi-instagram"></i></a>
					</div>
				</div>
				<div class="col-lg-2 col-md-6">
					<h5>Quick Links</h5>
					<ul class="list-unstyled" style="font-size: 0.88rem;">
						<li class="mb-2"><a
							href="${pageContext.request.contextPath}/">Home</a></li>
						<li class="mb-2"><a
							href="${pageContext.request.contextPath}/about.jsp">About Us</a></li>
						<li class="mb-2"><a
							href="${pageContext.request.contextPath}/gallery">Gallery</a></li>
						<li class="mb-2"><a
							href="${pageContext.request.contextPath}/products">Products</a></li>
						<li class="mb-2"><a
							href="${pageContext.request.contextPath}/booking">Book Visit</a></li>
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
						<li class="mb-2"><i class="bi bi-telephone me-2"
							style="color: var(--primary);"></i><a href="tel:7772897077">7772897077</a></li>
						<li class="mb-2"><i class="bi bi-whatsapp me-2"
							style="color: var(--primary);"></i><a
							href="https://wa.me/917772897077">WhatsApp Us</a></li>
						<li class="mb-2"><i class="bi bi-envelope me-2"
							style="color: var(--primary);"></i><a
							href="mailto:rahulvishwakarma111999@gmail.com">Email Us</a></li>
						<li class="mb-2"><i class="bi bi-geo-alt me-2"
							style="color: var(--primary);"></i><a
							href="https://maps.app.goo.gl/g78BgUACNh3cK3iz8?g_st=aw"
							target="_blank">View Location</a></li>
					</ul>
				</div>
			</div>
			<div class="footer-bottom text-center">
				<p style="color: var(--muted); font-size: 0.82rem; margin: 0;">
					&copy; 2024 RK GROUP FURNITURES &amp; INTERIOR. All Rights
					Reserved. | Owner: <span style="color: var(--primary);">Rahul
						Vishwakarma</span>
				</p>
				<div style="margin-top: 10px;">
					<a href="${pageContext.request.contextPath}/admin/login"
						style="color: #2a2a2a; font-size: 0.7rem; text-decoration: none;">&bull;
						Admin</a>
				</div>
			</div>
		</div>
	</footer>

	<!-- WhatsApp Float -->
	<a href="https://wa.me/917772897077?text=Hello%20RK%20Group!"
		class="whatsapp-float" target="_blank"> <i class="bi bi-whatsapp"></i>
	</a>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
