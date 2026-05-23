/* ============================================================
   main.js — RK GROUP FURNITURES & INTERIOR
   Public-facing JavaScript
   ============================================================ */

// Run after DOM is ready
document.addEventListener('DOMContentLoaded', function () {

    // ---- 1. Navbar scroll effect ----
    const navbar = document.querySelector('.navbar');
    if (navbar) {
        window.addEventListener('scroll', function () {
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
                navbar.style.padding = '8px 0';
            } else {
                navbar.classList.remove('scrolled');
                navbar.style.padding = '14px 0';
            }
        });
    }

    // ---- 2. Gallery filter buttons ----
    // Clicking "Interior", "Furniture" etc. filters gallery grid
    const filterBtns = document.querySelectorAll('.filter-btn');
    const galleryItems = document.querySelectorAll('.gallery-item-wrap');

    filterBtns.forEach(function (btn) {
        btn.addEventListener('click', function () {
            // Remove active class from all buttons
            filterBtns.forEach(function (b) { b.classList.remove('active'); });
            // Add active to clicked button
            btn.classList.add('active');

            const category = btn.getAttribute('data-cat');

            galleryItems.forEach(function (item) {
                if (category === 'all' || item.getAttribute('data-cat') === category) {
                    item.style.display = 'block';
                    item.style.animation = 'fadeInUp 0.4s ease';
                } else {
                    item.style.display = 'none';
                }
            });
        });
    });

    // ---- 3. Product search (live search feel) ----
    const searchInput = document.getElementById('productSearch');
    if (searchInput) {
        // Small debounce: only search after user stops typing for 500ms
        let searchTimer;
        searchInput.addEventListener('input', function () {
            clearTimeout(searchTimer);
            searchTimer = setTimeout(function () {
                const query = searchInput.value.trim();
                if (query.length >= 2) {
                    window.location.href = 'products?search=' + encodeURIComponent(query);
                }
            }, 500);
        });
    }

    // ---- 4. Phone number validation on forms ----
    const phoneInputs = document.querySelectorAll('input[name="phone"]');
    phoneInputs.forEach(function (input) {
        input.addEventListener('input', function () {
            // Remove anything that is not a digit
            this.value = this.value.replace(/[^0-9]/g, '');
        });
    });

    // ---- 5. Auto-hide alert messages after 4 seconds ----
    const alerts = document.querySelectorAll('.alert-success-rk, .alert-danger-rk');
    alerts.forEach(function (alert) {
        setTimeout(function () {
            alert.style.transition = 'opacity 0.5s';
            alert.style.opacity = '0';
            setTimeout(function () { alert.remove(); }, 500);
        }, 4000);
    });

    // ---- 6. Image preview before upload ----
    // Used on contact/booking form if we add photo upload later
    const imageInputs = document.querySelectorAll('input[type="file"][data-preview]');
    imageInputs.forEach(function (input) {
        input.addEventListener('change', function () {
            const previewId = this.getAttribute('data-preview');
            const preview = document.getElementById(previewId);
            if (preview && this.files && this.files[0]) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                };
                reader.readAsDataURL(this.files[0]);
            }
        });
    });

    // ---- 7. Smooth scroll for anchor links ----
    document.querySelectorAll('a[href^="#"]').forEach(function (anchor) {
        anchor.addEventListener('click', function (e) {
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                e.preventDefault();
                target.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        });
    });

    // ---- 8. Counter animation for stats section ----
    // Animates numbers like 500+ projects, 10+ years etc.
    const counters = document.querySelectorAll('.counter-num');
    const counterObserver = new IntersectionObserver(function (entries) {
        entries.forEach(function (entry) {
            if (entry.isIntersecting) {
                const target = parseInt(entry.target.getAttribute('data-target'));
                let current = 0;
                const step = Math.ceil(target / 60);  // 60 animation frames
                const timer = setInterval(function () {
                    current += step;
                    if (current >= target) {
                        entry.target.textContent = target;
                        clearInterval(timer);
                    } else {
                        entry.target.textContent = current;
                    }
                }, 25);
                counterObserver.unobserve(entry.target);
            }
        });
    }, { threshold: 0.5 });

    counters.forEach(function (counter) {
        counterObserver.observe(counter);
    });

});

/* ---- Utility: Confirm before delete ---- */
function confirmDelete(message) {
    return confirm(message || 'Are you sure you want to delete this?');
}