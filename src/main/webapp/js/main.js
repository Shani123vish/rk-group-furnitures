/* ============================================================
   main.js — RK GROUP FURNITURES & INTERIOR
   Light Luxury Theme — Animations & Interactions
   ============================================================ */

document.addEventListener('DOMContentLoaded', function () {

    // ---- 1. Scroll Reveal Animation ----
    const revealObserver = new IntersectionObserver(function(entries) {
        entries.forEach(function(entry) {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
                revealObserver.unobserve(entry.target);
            }
        });
    }, { threshold: 0.12, rootMargin: '0px 0px -60px 0px' });

    document.querySelectorAll('.reveal, .reveal-left, .reveal-right')
        .forEach(function(el) { revealObserver.observe(el); });

    // ---- 2. Navbar scroll effect ----
    const navbar = document.querySelector('.navbar');
    if (navbar) {
        window.addEventListener('scroll', function() {
            navbar.classList.toggle('scrolled', window.scrollY > 60);
        });
    }

    // ---- 3. Counter animation ----
    const counterObserver = new IntersectionObserver(function(entries) {
        entries.forEach(function(entry) {
            if (entry.isIntersecting) {
                animateCounter(entry.target);
                counterObserver.unobserve(entry.target);
            }
        });
    }, { threshold: 0.5 });

    document.querySelectorAll('.counter-num').forEach(function(el) {
        counterObserver.observe(el);
    });

    function animateCounter(el) {
        const target = parseInt(el.getAttribute('data-target'));
        const duration = 1800;
        const step = target / (duration / 16);
        let current = 0;
        const timer = setInterval(function() {
            current = Math.min(current + step, target);
            el.textContent = Math.floor(current);
            if (current >= target) clearInterval(timer);
        }, 16);
    }

    // ---- 4. Gallery filter ----
    const filterBtns = document.querySelectorAll('.filter-btn[data-cat]');
    const galleryItems = document.querySelectorAll('.gallery-item-wrap');

    filterBtns.forEach(function(btn) {
        btn.addEventListener('click', function() {
            filterBtns.forEach(function(b) { b.classList.remove('active'); });
            btn.classList.add('active');
            const cat = btn.getAttribute('data-cat');
            galleryItems.forEach(function(item) {
                const show = cat === 'all' || item.getAttribute('data-cat') === cat;
                item.style.display = show ? 'block' : 'none';
                if (show) item.style.animation = 'fadeInUp 0.4s ease';
            });
        });
    });

    // ---- 5. Product search ----
    const searchInput = document.getElementById('productSearch');
    if (searchInput) {
        let timer;
        searchInput.addEventListener('input', function() {
            clearTimeout(timer);
            const q = this.value.trim();
            timer = setTimeout(function() {
                if (q.length >= 2) window.location.href = 'products?search=' + encodeURIComponent(q);
            }, 500);
        });
        searchInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                const q = this.value.trim();
                if (q) window.location.href = 'products?search=' + encodeURIComponent(q);
            }
        });
    }

    // ---- 6. Phone input — numbers only ----
    document.querySelectorAll('input[name="phone"]').forEach(function(input) {
        input.addEventListener('input', function() {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
    });

    // ---- 7. Auto-hide alerts ----
    document.querySelectorAll('.alert-success-rk, .alert-danger-rk').forEach(function(el) {
        setTimeout(function() {
            el.style.transition = 'opacity 0.6s, transform 0.6s';
            el.style.opacity = '0';
            el.style.transform = 'translateY(-10px)';
            setTimeout(function() { el.remove(); }, 600);
        }, 4000);
    });

    // ---- 8. Image preview before upload ----
    document.querySelectorAll('input[type="file"][data-preview]').forEach(function(input) {
        input.addEventListener('change', function() {
            const preview = document.getElementById(this.getAttribute('data-preview'));
            if (preview && this.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                };
                reader.readAsDataURL(this.files[0]);
            }
        });
    });

    // ---- 9. Smooth scroll for anchors ----
    document.querySelectorAll('a[href^="#"]').forEach(function(anchor) {
        anchor.addEventListener('click', function(e) {
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                e.preventDefault();
                target.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        });
    });

    // ---- 10. Form validation ----
    document.querySelectorAll('.needs-validation').forEach(function(form) {
        form.addEventListener('submit', function(e) {
            if (!form.checkValidity()) {
                e.preventDefault();
                e.stopPropagation();
            }
            form.classList.add('was-validated');
        });
    });

    // ---- 11. Card stagger animation ----
    document.querySelectorAll('.stagger-cards > *').forEach(function(card, i) {
        card.style.animationDelay = (i * 0.1) + 's';
        card.classList.add('reveal');
    });

});

// ---- Utility: Confirm delete ----
function confirmDelete(msg) {
    return confirm(msg || 'Are you sure you want to delete this?');
}
