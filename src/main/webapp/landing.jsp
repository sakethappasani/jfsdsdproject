<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ActivityHub - Student Activity Management</title>
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
    <link rel="stylesheet" href="logland.css">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <div class="nav-brand">
                <svg xmlns="http://www.w3.org/2000/svg" class="nav-logo" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 12h-4l-3 9L9 3l-3 9H2"/></svg>
                <span>ActivityHub</span>
            </div>
            <div class="nav-links">
                <a href="login" class="nav-button">Login</a>
            </div>
        </div>
    </nav>

    <!-- Hero Section with Carousel -->
    <div class="hero-section">
        <div class="swiper-container">
            <div class="swiper-wrapper">
                <div class="swiper-slide" style="background-image: url('https://images.unsplash.com/photo-1523240795612-9a054b0db644?auto=format&fit=crop&q=80')">
                    <div class="slide-content">
                        <h1>Manage Your Student Activities with Ease</h1>
                        <p>Track, organize, and excel in your extracurricular journey with our comprehensive management system.</p>
                        <a href="login" class="cta-button">Start Your Journey</a>
                    </div>
                </div>
                <div class="swiper-slide" style="background-image: url('https://images.unsplash.com/photo-1526947425960-945c6e72858f?auto=format&fit=crop&q=80')">
                    <div class="slide-content">
                        <h1>Transform Your Academic Journey</h1>
                        <p>Join thousands of students who are making the most of their extracurricular activities.</p>
                        <a href="login.html" class="cta-button">Get Started Today</a>
                    </div>
                </div>
                <div class="swiper-slide" style="background-image: url('https://images.unsplash.com/photo-1577896851231-70ef18881754?auto=format&fit=crop&q=80')">
                    <div class="slide-content">
                        <h1>Achieve More Together</h1>
                        <p>Connect with peers and create lasting impact through organized activities.</p>
                        <a href="login.html" class="cta-button">Join Now</a>
                    </div>
                </div>
            </div>
            <div class="swiper-button-next"></div>
            <div class="swiper-button-prev"></div>
        </div>
    </div>

    <!-- Features Section -->
    <section class="features-section">
        <div class="container">
            <div class="section-header">
                <h2>Everything You Need</h2>
                <p>Comprehensive tools to manage your extracurricular activities</p>
            </div>
            <div class="features-grid">
                <div class="feature-card">
                    <svg xmlns="http://www.w3.org/2000/svg" class="feature-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                    <h3>Event Management</h3>
                    <p>Schedule and manage all your extracurricular activities efficiently</p>
                </div>
                <div class="feature-card">
                    <svg xmlns="http://www.w3.org/2000/svg" class="feature-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
                    <h3>Team Collaboration</h3>
                    <p>Connect with peers and form activity groups seamlessly</p>
                </div>
                <div class="feature-card">
                    <svg xmlns="http://www.w3.org/2000/svg" class="feature-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="7"></circle><polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline></svg>
                    <h3>Achievement Tracking</h3>
                    <p>Record and showcase your extracurricular accomplishments</p>
                </div>
                <div class="feature-card">
                    <svg xmlns="http://www.w3.org/2000/svg" class="feature-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"></polyline></svg>
                    <h3>Progress Monitoring</h3>
                    <p>Track your participation and growth in various activities</p>
                </div>
            </div>
        </div>
    </section>

    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <script>
        const swiper = new Swiper('.swiper-container', {
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
            loop: true,
        });
    </script>
</body>
</html>
