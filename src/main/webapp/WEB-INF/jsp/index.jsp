<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>EduPath — Automated Career Guidance</title>
  <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700&family=DM+Serif+Display:ital@0;1&display=swap" rel="stylesheet"/>
  <script src="https://unpkg.com/lucide@latest"></script>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    :root {
      --navy:    #0d1b2a;
      --blue:    #1a5f9c;
      --sky:     #3a9fd6;
      --accent:  #f4a825;
      --light:   #f0f6fc;
      --white:   #ffffff;
      --text:    #1e2d3d;
      --muted:   #6b849a;
      --card-bg: #ffffff;
      --border:  #d5e5f0;
    }

    html { scroll-behavior: smooth; }

    body {
      font-family: 'Sora', sans-serif;
      background: var(--light);
      color: var(--text);
      overflow-x: hidden;
    }

    /* ── NAV ── */
    nav {
      position: fixed; top: 0; left: 0; right: 0; z-index: 100;
      display: flex; align-items: center; justify-content: space-between;
      padding: 0 6%; height: 80px;
      background: rgba(255,255,255,0.88);
      backdrop-filter: blur(12px);
      border-bottom: 1px solid var(--border);
    }
    .nav-logo {
      font-family: 'DM Serif Display', serif;
      font-size: 2.2rem;
      color: var(--navy);
      text-decoration: none;
      letter-spacing: -0.5px;
    }
    .nav-logo span { color: var(--sky); }
    .nav-links { display: flex; align-items: center; gap: 2rem; list-style: none; }
    .nav-links a {
      font-size: 0.875rem; font-weight: 400;
      color: var(--muted); text-decoration: none;
      transition: color 0.2s;
    }
    .nav-links a:hover { color: var(--navy); }
    .btn-nav {
      background: var(--navy); color: var(--white) !important;
      padding: 0.5rem 1.25rem; border-radius: 6px;
      font-weight: 600; font-size: 0.85rem !important;
      transition: background 0.2s !important;
    }
    .btn-nav:hover { background: var(--blue) !important; }

    .hero {
      min-height: 100vh;
      display: flex; align-items: center;
      padding: 120px 6% 60px;
      background: linear-gradient(135deg, #e8f4fd 0%, #f0f6fc 50%, #fef9ef 100%);
      position: relative; overflow: hidden;
    }
    .hero::before {
      content: '';
      position: absolute; top: -120px; right: -80px;
      width: 560px; height: 560px;
      background: radial-gradient(circle, rgba(58,159,214,0.12) 0%, transparent 70%);
      border-radius: 50%;
    }
    .hero::after {
      content: '';
      position: absolute; bottom: -80px; left: -60px;
      width: 400px; height: 400px;
      background: radial-gradient(circle, rgba(244,168,37,0.1) 0%, transparent 70%);
      border-radius: 50%;
    }
    .hero-content { max-width: 620px; position: relative; z-index: 1; }
    .hero-badge {
      display: inline-flex; align-items: center; gap: 0.5rem;
      background: rgba(58,159,214,0.1); color: var(--blue);
      border: 1px solid rgba(58,159,214,0.25);
      padding: 0.35rem 0.9rem; border-radius: 20px;
      font-size: 0.8rem; font-weight: 600; letter-spacing: 0.03em;
      margin-bottom: 1.5rem;
      animation: fadeUp 0.6s ease both;
    }
    .hero-badge::before { content: '●'; font-size: 0.5rem; color: var(--sky); }
    h1 {
      font-family: 'DM Serif Display', serif;
      font-size: clamp(2.4rem, 5vw, 3.6rem);
      line-height: 1.15;
      color: var(--navy);
      margin-bottom: 1.25rem;
      animation: fadeUp 0.6s 0.1s ease both;
    }
    h1 em { font-style: italic; color: var(--sky); }
    .hero-sub {
      font-size: 1.05rem; line-height: 1.75;
      color: var(--muted); max-width: 520px;
      margin-bottom: 2.2rem;
      animation: fadeUp 0.6s 0.2s ease both;
    }
    .hero-btns {
      display: flex; gap: 1rem; flex-wrap: wrap;
      animation: fadeUp 0.6s 0.3s ease both;
    }
    .btn-primary {
      background: var(--navy); color: var(--white);
      padding: 0.85rem 2rem; border-radius: 8px;
      font-size: 0.95rem; font-weight: 600;
      text-decoration: none; border: none; cursor: pointer;
      transition: background 0.2s, transform 0.15s;
      display: inline-block;
    }
    .btn-primary:hover { background: var(--blue); transform: translateY(-2px); }
    .btn-secondary {
      background: transparent; color: var(--navy);
      padding: 0.85rem 2rem; border-radius: 8px;
      font-size: 0.95rem; font-weight: 600;
      border: 1.5px solid var(--navy); cursor: pointer;
      text-decoration: none; display: inline-block;
      transition: background 0.2s, transform 0.15s;
    }
    .btn-secondary:hover { background: var(--navy); color: var(--white); transform: translateY(-2px); }

    .hero-stats {
      display: flex; gap: 2.5rem; margin-top: 3rem;
      animation: fadeUp 0.6s 0.4s ease both;
    }
    .stat-num {
      font-family: 'DM Serif Display', serif;
      font-size: 1.8rem; color: var(--navy);
    }
    .stat-label { font-size: 0.78rem; color: var(--muted); margin-top: 2px; }

    .hero-visual {
      position: absolute; right: 5%; top: 50%;
      transform: translateY(-50%);
      display: flex; flex-direction: column; gap: 1rem;
      animation: fadeUp 0.8s 0.3s ease both;
    }
    .mini-card {
      background: var(--white);
      border: 1px solid var(--border);
      border-radius: 12px; padding: 1rem 1.25rem;
      min-width: 230px; max-width: 260px;
      box-shadow: 0 4px 20px rgba(13,27,42,0.07);
    }
    .mini-card-label { font-size: 0.72rem; color: var(--muted); text-transform: uppercase; letter-spacing: 0.06em; margin-bottom: 0.4rem; }
    .mini-card-title { font-size: 0.92rem; font-weight: 600; color: var(--navy); margin-bottom: 0.6rem; }
    .progress-bar { height: 6px; background: var(--border); border-radius: 10px; overflow: hidden; }
    .progress-fill { height: 100%; border-radius: 10px; }

    /* ── HOW IT WORKS ── */
    section { padding: 90px 6%; }
    .section-tag {
      font-size: 0.78rem; font-weight: 600; letter-spacing: 0.08em;
      text-transform: uppercase; color: var(--sky);
      margin-bottom: 0.75rem;
    }
    .section-title {
      font-family: 'DM Serif Display', serif;
      font-size: clamp(1.8rem, 3.5vw, 2.5rem);
      color: var(--navy); line-height: 1.2;
      margin-bottom: 1rem;
    }
    .section-sub { font-size: 1rem; color: var(--muted); max-width: 520px; line-height: 1.7; margin-bottom: 3rem; }

    .steps { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 2rem; }
    .step-card {
      background: var(--white); border: 1px solid var(--border);
      border-radius: 14px; padding: 1.75rem;
      position: relative; overflow: hidden;
      transition: transform 0.2s, box-shadow 0.2s;
    }
    .step-card:hover { transform: translateY(-4px); box-shadow: 0 12px 40px rgba(13,27,42,0.1); }
    .step-num {
      font-family: 'DM Serif Display', serif;
      font-size: 3rem; color: rgba(58,159,214,0.12);
      position: absolute; top: 0.5rem; right: 1rem;
      line-height: 1;
    }
    .step-icon {
      width: 44px; height: 44px; border-radius: 10px;
      display: flex; align-items: center; justify-content: center;
      font-size: 1.3rem; margin-bottom: 1rem;
    }
    .icon-blue { background: rgba(58,159,214,0.12); }
    .icon-green { background: rgba(34,197,94,0.12); }
    .icon-orange { background: rgba(244,168,37,0.15); }
    .icon-purple { background: rgba(139,92,246,0.12); }
    .step-card h3 { font-size: 1rem; font-weight: 600; color: var(--navy); margin-bottom: 0.5rem; }
    .step-card p { font-size: 0.875rem; color: var(--muted); line-height: 1.65; }

    /* ── FEATURES ── */
    .features-section { background: var(--light); color: var(--text); }
    .features-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1.5rem; }
    .feat-card {
      background: var(--white);
      border: 1px solid var(--border);
      border-radius: 14px; padding: 1.75rem;
      transition: transform 0.2s, box-shadow 0.2s;
    }
    .feat-card:nth-child(1) { background: #ffffff; }
    .feat-card:nth-child(2) { background: #f8fbfe; }
    .feat-card:nth-child(3) { background: #f0f6fc; }
    .feat-card:nth-child(4) { background: #e8f1f9; }
    .feat-card:nth-child(5) { background: #dfeaf5; }
    .feat-card:nth-child(6) { background: #d6e2f0; }
    .feat-card:nth-child(7) { background: #ccdaeb; }
    
    .feat-card:hover { transform: translateY(-4px); box-shadow: 0 12px 40px rgba(13,27,42,0.1); }
    .feat-icon { font-size: 1.6rem; margin-bottom: 1rem; }
    .feat-card h3 { font-size: 1rem; font-weight: 600; color: var(--navy); margin-bottom: 0.5rem; }
    .feat-card p { font-size: 0.875rem; color: var(--muted); line-height: 1.65; }
    .feat-badge {
      display: inline-block; margin-top: 1rem;
      font-size: 0.72rem; font-weight: 600; letter-spacing: 0.05em;
      padding: 0.25rem 0.75rem; border-radius: 20px;
      background: rgba(58,159,214,0.12); color: var(--blue);
    }

    /* ── FOR WHO ── */
    .audience { display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; }
    .audience-card {
      border-radius: 16px; padding: 2.5rem;
      position: relative; overflow: hidden;
    }
    .aud-class10 { background: linear-gradient(135deg, #e8f4fd, #d0eaf9); border: 1px solid #b8dcf0; }
    .aud-class12 { background: linear-gradient(135deg, #fef4e0, #fde8b5); border: 1px solid #f5d580; }
    .aud-label {
      font-size: 0.75rem; font-weight: 700; letter-spacing: 0.1em;
      text-transform: uppercase; margin-bottom: 1rem;
    }
    .aud-class10 .aud-label { color: var(--blue); }
    .aud-class12 .aud-label { color: #b07a00; }
    .audience-card h3 { font-family: 'DM Serif Display', serif; font-size: 1.5rem; color: var(--navy); margin-bottom: 0.75rem; }
    .audience-card p { font-size: 0.9rem; color: var(--muted); line-height: 1.7; margin-bottom: 1.5rem; }
    .aud-list { list-style: none; display: flex; flex-direction: column; gap: 0.5rem; }
    .aud-list li { font-size: 0.875rem; color: var(--text); display: flex; align-items: center; gap: 0.5rem; }
    .aud-list li::before { content: '✓'; font-weight: 700; color: var(--sky); }
    .aud-class12 .aud-list li::before { color: var(--accent); }
    .aud-big { position: absolute; bottom: 1rem; right: 1.5rem; font-size: 5rem; opacity: 0.08; font-family: 'DM Serif Display', serif; color: var(--navy); }

    /* ── CTA ── */
    .cta-section {
      text-align: center;
      background: linear-gradient(135deg, #e8f4fd 0%, #fef9ef 100%);
      border-top: 1px solid var(--border);
    }
    .cta-section .section-title { margin-bottom: 1rem; }
    .cta-section .section-sub { margin: 0 auto 2rem; text-align: center; }
    .cta-btns { display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap; }

    /* ── FAT FOOTER ── */
    footer { background: var(--navy); color: rgba(255,255,255,0.7); padding: 4rem 6% 2rem; }
    .footer-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 3rem; margin-bottom: 3rem; }
    .footer-col h4 { color: var(--white); font-size: 1.05rem; margin-bottom: 1.2rem; font-family: 'DM Serif Display', serif; }
    .footer-links { list-style: none; display: flex; flex-direction: column; gap: 0.8rem; }
    .footer-links a { color: rgba(255,255,255,0.7); text-decoration: none; font-size: 0.85rem; transition: color 0.2s; }
    .footer-links a:hover { color: var(--white); }
    .footer-socials { display: flex; gap: 1rem; margin-top: 1.5rem; }
    .footer-socials a { color: rgba(255,255,255,0.7); transition: color 0.2s; }
    .footer-socials a:hover { color: var(--white); }
    .footer-bottom { padding-top: 2rem; border-top: 1px solid rgba(255,255,255,0.1); display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem; font-size: 0.8rem; }

    /* ── NEW UI ADDITIONS ── */
    .reveal { opacity: 0; transform: translateY(30px); transition: all 0.8s cubic-bezier(0.16, 1, 0.3, 1); }
    .reveal.active { opacity: 1; transform: translateY(0); }
    
    .bg-mesh {
      background-color: #ffffff;
      background-image: radial-gradient(at 0% 0%, rgba(58,159,214,0.1) 0px, transparent 50%),
                        radial-gradient(at 100% 100%, rgba(244,168,37,0.1) 0px, transparent 50%);
    }

    /* ── TESTIMONIALS ── */
    .test-section { background: var(--white); border-top: 1px solid var(--border); }
    .test-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1.5rem; }
    .test-card {
      background: var(--light); border: 1px solid var(--border);
      border-radius: 14px; padding: 2rem;
      transition: transform 0.2s, box-shadow 0.2s;
    }
    .test-card:hover { transform: translateY(-3px); box-shadow: 0 10px 30px rgba(13,27,42,0.05); }
    .test-stars { color: #facc15; display: flex; gap: 0.2rem; margin-bottom: 1rem; }
    .test-stars i { width: 16px; height: 16px; fill: currentColor; }
    .test-quote { font-size: 0.95rem; color: var(--text); line-height: 1.7; font-style: italic; margin-bottom: 1.5rem; }
    .test-author { display: flex; align-items: center; gap: 1rem; }
    .test-avatar { width: 45px; height: 45px; border-radius: 50%; background: var(--navy); display: flex; align-items: center; justify-content: center; color: var(--white); font-weight: bold; font-family: 'DM Serif Display', serif; }
    .test-name { font-size: 0.9rem; font-weight: 600; color: var(--navy); }
    .test-role { font-size: 0.75rem; color: var(--muted); }

    /* ── FAQ ── */
    .faq-section { background: var(--light); padding-bottom: 4rem; }
    .faq-container { max-width: 800px; margin: 0 auto; background: var(--white); border-radius: 16px; border: 1px solid var(--border); overflow: hidden; }
    .faq-item { border-bottom: 1px solid var(--border); }
    .faq-item:last-child { border-bottom: none; }
    .faq-btn {
      width: 100%; display: flex; justify-content: space-between; align-items: center;
      padding: 1.5rem; background: none; border: none; font-family: 'Sora', sans-serif; font-size: 1rem;
      font-weight: 600; color: var(--navy); cursor: pointer; text-align: left;
    }
    .faq-btn:hover { background: rgba(58,159,214,0.03); }
    .faq-icon { transition: transform 0.3s; color: var(--muted); }
    .faq-content {
      max-height: 0; overflow: hidden; transition: max-height 0.3s ease-out;
      font-size: 0.9rem; color: var(--muted); line-height: 1.7; background: var(--white);
    }
    .faq-content-inner { padding: 0 1.5rem 1.5rem; }
    .faq-item.active .faq-icon { transform: rotate(180deg); color: var(--sky); }

    /* ── ANIMATIONS ── */
    @keyframes fadeUp {
      from { opacity: 0; transform: translateY(24px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    /* ── RESPONSIVE ── */
    @media (max-width: 900px) {
      .hero-visual { display: none; }
      .audience { grid-template-columns: 1fr; }
    }
    .menu-btn { display: none; background: none; border: none; color: var(--navy); cursor: pointer; padding: 0.5rem; }
    @media (max-width: 768px) {
      .menu-btn { display: block; }
      .nav-links { 
        display: none; position: absolute; top: 68px; left: 0; right: 0; 
        background: var(--white); flex-direction: column; padding: 1.5rem 6%; 
        border-bottom: 1px solid var(--border); box-shadow: 0 10px 20px rgba(0,0,0,0.05); gap: 1.5rem;
      }
      .nav-links.active { display: flex; }
      .hero-stats { gap: 1.5rem; }
    }
    nav { height: 80px; display: flex; align-items: center; justify-content: space-between; padding: 0 6%; }
  
</style>

</head>
<body>

  <nav>
    <a class="nav-logo" href="/">Edu<span>Path</span></a>
    <button class="menu-btn" onclick="toggleMenu()"><i data-lucide="menu"></i></button>
    <ul class="nav-links" id="navLinks"><li>

</li>
      <li><a href="#how">How It Works</a></li>
      <li><a href="#features">Features</a></li>
      <li><a href="#who">Who Is It For</a></li>
      <li><a href="/login" class="btn-nav">Login / Register</a></li>
    </ul>
  </nav>

  <section class="hero">
    <div class="hero-content">
      <div class="hero-badge">India's Smart Career Guidance Platform</div>
      <h1>Find your <em>right path</em> after Class 10 & 12</h1>
      <p class="hero-sub">
        Stop guessing your future. EduPath uses aptitude science and real college data to give you
        personalised, unbiased career guidance — completely free.
      </p>
      <div class="hero-btns">
        <a href="/signup" class="btn-primary">Get Started — It's Free</a>
        <a href="#how" class="btn-secondary">See How It Works</a>
      </div>
      <div class="hero-stats">
        <div>
          <div class="stat-num">500+</div>
          <div class="stat-label">Colleges in Database</div>
        </div>
        <div>
          <div class="stat-num">3</div>
          <div class="stat-label">Aptitude Dimensions</div>
        </div>
        <div>
          <div class="stat-num">24/7</div>
          <div class="stat-label">Always Available</div>
        </div>
      </div>
    </div>

    <div class="hero-visual">
      <div class="mini-card reveal">
        <div class="mini-card-label">Your Aptitude Score</div>
        <div class="mini-card-title" style="display:flex;align-items:center;gap:0.4rem;"><i data-lucide="calculator" style="width:18px;height:18px;color:var(--sky);"></i> Math & Logic</div>
        <div class="progress-bar"><div class="progress-fill" style="width:82%;background:#3a9fd6;"></div></div>
        <div style="margin-top:0.35rem;font-size:0.75rem;color:#6b849a;">82 / 100</div>
      </div>
      <div class="mini-card reveal">
        <div class="mini-card-label">Top Recommendation</div>
        <div class="mini-card-title" style="display:flex;align-items:center;gap:0.4rem;"><i data-lucide="graduation-cap" style="width:18px;height:18px;color:var(--sky);"></i> Science Stream</div>
        <div style="font-size:0.8rem;color:#6b849a;margin-top:0.25rem;">Engineering · Medical · Research</div>
      </div>
      <div class="mini-card reveal">
        <div class="mini-card-label">College Match</div>
        <div class="mini-card-title" style="display:flex;align-items:center;gap:0.4rem;"><i data-lucide="building-2" style="width:18px;height:18px;color:var(--sky);"></i> IIT Indore</div>
        <div style="display:flex;align-items:center;gap:0.4rem;margin-top:0.4rem;">
          <span style="font-size:0.75rem;background:#e8f4fd;color:#1a5f9c;padding:2px 8px;border-radius:20px;font-weight:600;">Cut-off: 95%</span>
          <span style="font-size:0.75rem;background:#fef4e0;color:#b07a00;padding:2px 8px;border-radius:20px;font-weight:600;">Fees: ₹2.5L</span>
        </div>
      </div>
    </div>
  </section>

  <section id="how" class="bg-mesh">
    <div class="section-tag">How It Works</div>
    <h2 class="section-title reveal">From confusion to clarity<br>in 4 simple steps</h2>
    <p class="section-sub reveal">No counsellor required. No appointments needed. Just your answers and our data.</p>
    <div class="steps">
      <div class="step-card reveal">
        <div class="step-num">01</div>
        <div class="step-icon icon-blue"><i data-lucide="user-plus"></i></div>
        <h3>Create Your Profile</h3>
        <p>Register with your class (10th or 12th), marks, and basic details. Takes under 2 minutes.</p>
      </div>
      <div class="step-card reveal">
        <div class="step-num">02</div>
        <div class="step-icon icon-green"><i data-lucide="brain-circuit"></i></div>
        <h3>Take the Aptitude Test</h3>
        <p>Answer 30 questions covering Logic, Math, and Verbal ability. A timer keeps things fair.</p>
      </div>
      <div class="step-card reveal">
        <div class="step-num">03</div>
        <div class="step-icon icon-orange"><i data-lucide="zap"></i></div>
        <h3>Get Your Career Report</h3>
        <p>Our engine instantly analyses your scores and recommends the best-fit stream or career path.</p>
      </div>
      <div class="step-card reveal">
        <div class="step-num">04</div>
        <div class="step-icon icon-purple"><i data-lucide="library"></i></div>
        <h3>Discover Colleges</h3>
        <p>Filter 500+ colleges by location, fees, cut-offs and ranking. Save your favourites to your dashboard.</p>
      </div>
    </div>
  </section>

  <section id="features" class="features-section">
    <div class="section-tag">Key Features</div>
    <h2 class="section-title reveal">Everything you need,<br>nothing you don't</h2>
    <p class="section-sub reveal">Built specifically for Indian students navigating the 10th and 12th turning points.</p>
    <div class="features-grid">
      <div class="feat-card reveal">
        <div class="feat-icon"><i data-lucide="target" style="color:var(--sky);"></i></div>
        <h3>Automated Aptitude Assessment</h3>
        <p>A scientifically structured quiz measuring your Logic, Mathematical, and Verbal strengths — not just marks.</p>
        <span class="feat-badge">Core Feature</span>
      </div>
      <div class="feat-card reveal">
        <div class="feat-icon"><i data-lucide="search" style="color:var(--sky);"></i></div>
        <h3>College Discovery Engine</h3>
        <p>Search and filter colleges by state, city, fees range, cut-off percentile, and NIRF ranking in one place.</p>
        <span class="feat-badge">Core Feature</span>
      </div>
      <div class="feat-card reveal">
        <div class="feat-icon"><i data-lucide="bar-chart-2" style="color:var(--sky);"></i></div>
        <h3>Personal Analytics Dashboard</h3>
        <p>Track your test history, see score trends, and access your saved colleges — all in one personalized view.</p>
      </div>
      <div class="feat-card reveal">
        <div class="feat-icon"><i data-lucide="library" style="color:var(--sky);"></i></div>
        <h3>Resource Library</h3>
        <p>Up-to-date info on courses, career paths, entrance exams, and scholarship opportunities across India.</p>
      </div>
      <div class="feat-card reveal">
        <div class="feat-icon"><i data-lucide="shield-check" style="color:var(--sky);"></i></div>
        <h3>Secure & Private</h3>
        <p>Your academic data is protected with encrypted storage. We never share your information with third parties.</p>
      </div>
      <div class="feat-card reveal">
        <div class="feat-icon"><i data-lucide="smartphone" style="color:var(--sky);"></i></div>
        <h3>Works on Any Device</h3>
        <p>Fully responsive design — use EduPath on your phone, tablet, or desktop with no app download needed.</p>
      </div>
      <div class="feat-card reveal">
        <div class="feat-icon">✨</div>
        <h3>AI Admission Counselor</h3>
        <p>Chat with our AI bot or generate a personalized admission strategy based on your category, exams, and target state.</p>
        <span class="feat-badge">New</span>
      </div>
    </div>
  </section>

  <section id="who">
    <div class="section-tag">Who Is It For</div>
    <h2 class="section-title reveal">Designed for two critical moments</h2>
    <p class="section-sub reveal">EduPath focuses on the exact points where students need guidance the most.</p>
    <div class="audience">
      <div class="audience-card aud-class10 reveal">
        <div class="aud-label">Class 10 Students</div>
        <h3>Choose Your Stream with Confidence</h3>
        <p>Picking Science, Commerce, or Arts based on pressure from parents or friends leads to regret. Let data guide you instead.</p>
        <ul class="aud-list">
          <li>30-question aptitude test</li>
          <li>Stream recommendation (Science / Commerce / Arts)</li>
          <li>Career paths matching your strengths</li>
          <li>Clear explanation of why you were recommended</li>
        </ul>
        <div class="aud-big">10</div>
      </div>
      <div class="audience-card aud-class12 reveal">
        <div class="aud-label">Class 12 Students</div>
        <h3>Find the Right College for You</h3>
        <p>Stop jumping between 50 websites. EduPath gives you all the data you need — cut-offs, fees, rankings — in one search.</p>
        <ul class="aud-list">
          <li>Filter 500+ colleges instantly</li>
          <li>See fees, cut-offs & rankings side by side</li>
          <li>Save favourites to your dashboard</li>
          <li>Entrance exam guidance included</li>
        </ul>
        <div class="aud-big">12</div>
      </div>
    </div>
  </section>

  <section id="testimonials" class="test-section">
    <div style="padding: 90px 6%;">
      <div class="section-tag" style="text-align:center;">Success Stories</div>
      <h2 class="section-title reveal" style="text-align:center;">Join students who found their path</h2>
      <div class="test-grid" style="max-width:1100px; margin: 3rem auto 0;">
        <div class="test-card reveal">
          <div class="test-stars"><i data-lucide="star"></i><i data-lucide="star"></i><i data-lucide="star"></i><i data-lucide="star"></i><i data-lucide="star"></i></div>
          <p class="test-quote">"I was confused whether to take Science or Commerce. EduPath's test showed I was exceptionally strong in logic but struggled with theoretical science. Commerce was the perfect fit!"</p>
          <div class="test-author">
            <div class="test-avatar">A</div>
            <div><div class="test-name">Aditya Sharma</div><div class="test-role">Class 11, Delhi</div></div>
          </div>
        </div>
        <div class="test-card reveal">
          <div class="test-stars"><i data-lucide="star"></i><i data-lucide="star"></i><i data-lucide="star"></i><i data-lucide="star"></i><i data-lucide="star"></i></div>
          <p class="test-quote">"The college discovery engine saved me hours. Instead of checking 20 websites, I filtered by my percentile and fees to find the exact list of engineering colleges I could apply to."</p>
          <div class="test-author">
            <div class="test-avatar" style="background:var(--accent);">N</div>
            <div><div class="test-name">Neha Verma</div><div class="test-role">Class 12, Pune</div></div>
          </div>
        </div>
        <div class="test-card reveal">
          <div class="test-stars"><i data-lucide="star"></i><i data-lucide="star"></i><i data-lucide="star"></i><i data-lucide="star"></i><i data-lucide="star"></i></div>
          <p class="test-quote">"The Gemini AI career suggestions were mind-blowing. It didn't just tell me to take Arts, it suggested specific roles like UI/UX Design based on my humanist scores."</p>
          <div class="test-author">
            <div class="test-avatar" style="background:var(--sky);">K</div>
            <div><div class="test-name">Karan Patel</div><div class="test-role">Class 10, Ahmedabad</div></div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section id="faq" class="faq-section">
    <div class="section-tag" style="text-align:center;">Got Questions?</div>
    <h2 class="section-title reveal" style="text-align:center; margin-bottom: 3rem;">Frequently Asked Questions</h2>
    <div class="faq-container reveal">
      <div class="faq-item">
        <button class="faq-btn" onclick="toggleFaq(this)">Is the aptitude test really free?<i data-lucide="chevron-down" class="faq-icon"></i></button>
        <div class="faq-content"><div class="faq-content-inner">Yes! EduPath is built as an open platform to help students. The core aptitude test, career recommendations, and college discovery engine are 100% free forever.</div></div>
      </div>
      <div class="faq-item">
        <button class="faq-btn" onclick="toggleFaq(this)">How accurate are the career recommendations?<i data-lucide="chevron-down" class="faq-icon"></i></button>
        <div class="faq-content"><div class="faq-content-inner">Our test uses proven logical, mathematical, and verbal assessment frameworks combined with Google's Gemini AI to analyze your strengths. However, it should be used as a guiding tool rather than an absolute rule.</div></div>
      </div>
      <div class="faq-item">
        <button class="faq-btn" onclick="toggleFaq(this)">Can I re-take the aptitude test?<i data-lucide="chevron-down" class="faq-icon"></i></button>
        <div class="faq-content"><div class="faq-content-inner">Yes, you can re-take the test from your dashboard to see how your cognitive skills have improved over time. We save all your past results for easy comparison!</div></div>
      </div>
    </div>
  </section>

  <section class="cta-section">
    <div class="section-tag" style="text-align:center;">Get Started Today</div>
    <h2 class="section-title reveal">Your career clarity is<br>one test away</h2>
    <p class="section-sub reveal">Join thousands of students making smarter academic decisions with EduPath. It's free, fast, and made for you.</p>
    <div class="cta-btns reveal">
      <a href="/signup" class="btn-primary">Create Free Account</a>
      <a href="/login" class="btn-secondary">Already have an account? Login</a>
    </div>
  </section>

  <footer>
    <div class="footer-grid">
      <div class="footer-col">
        <div class="footer-logo" style="margin-bottom: 1rem; font-family: 'DM Serif Display', serif; font-size: 1.5rem; color: var(--white);">Edu<span style="color:var(--sky);">Path</span></div>
        <p style="font-size: 0.85rem; line-height: 1.6;">India's smart career guidance platform. Making career decisions data-driven and stress-free for Class 10 & 12 students.</p>
        <div class="footer-socials">
          <a href="#"><i data-lucide="twitter"></i></a>
          <a href="#"><i data-lucide="instagram"></i></a>
          <a href="#"><i data-lucide="linkedin"></i></a>
        </div>
      </div>
      <div class="footer-col">
        <h4>Platform</h4>
        <ul class="footer-links">
          <li><a href="#how">How It Works</a></li>
          <li><a href="#features">Key Features</a></li>
          <li><a href="#testimonials">Success Stories</a></li>
          <li><a href="/login">Student Login</a></li>
        </ul>
      </div>
      <div class="footer-col">
        <h4>Resources</h4>
        <ul class="footer-links">
          <li><a href="/career-library">Career Library</a></li>
          <li><a href="/colleges">College Database</a></li>
          <li><a href="/aptitude-framework">Aptitude Framework</a></li>
          <li><a href="/blog">Blog</a></li>
        </ul>
      </div>
      <div class="footer-col">
        <h4>Legal</h4>
        <ul class="footer-links">
          <li><a href="/privacy-policy">Privacy Policy</a></li>
          <li><a href="/terms-of-service">Terms of Service</a></li>
          <li><a href="/contact">Contact Support</a></li>
        </ul>
      </div>
    </div>
    <div class="footer-bottom">
      <p>© 2025 EduPath. All rights reserved.</p>
      <p>A Smart Career Guidance Platform</p>
    </div>
  </footer>

  <script>
    lucide.createIcons();

    function toggleFaq(btn) {
      const item = btn.parentElement;
      const content = item.querySelector('.faq-content');
      const isActive = item.classList.contains('active');
      
      document.querySelectorAll('.faq-item').forEach(i => {
        i.classList.remove('active');
        i.querySelector('.faq-content').style.maxHeight = null;
      });

      if (!isActive) {
        item.classList.add('active');
        content.style.maxHeight = content.scrollHeight + "px";
      }
    }

    const observerOptions = { root: null, rootMargin: '0px', threshold: 0.15 };
    const observer = new IntersectionObserver((entries, obs) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('active');
          obs.unobserve(entry.target);
        }
      });
    }, observerOptions);

    document.querySelectorAll('.reveal').forEach(el => observer.observe(el));

    function toggleMenu() {
      document.getElementById('navLinks').classList.toggle('active');
    }
  </script>

</body>
</html>