<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Contact Support — EduPath</title>
  <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700&family=DM+Serif+Display:ital@0;1&display=swap" rel="stylesheet"/>
  <script src="https://unpkg.com/lucide@latest"></script>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --navy:    #0d1b2a; --blue:    #1a5f9c; --sky:     #3a9fd6;
      --accent:  #f4a825; --light:   #f0f6fc; --white:   #ffffff;
      --text:    #1e2d3d; --muted:   #6b849a; --border:  #d5e5f0;
    }
    body { font-family: 'Sora', sans-serif; background: var(--light); color: var(--text); display: flex; flex-direction: column; min-height: 100vh; }
    nav {
      display: flex; align-items: center; justify-content: space-between;
      padding: 0 6%; height: 80px; background: var(--white); border-bottom: 1px solid var(--border);
    }
    .nav-logo { font-family: 'DM Serif Display', serif; font-size: 2.2rem; letter-spacing: -0.5px; color: var(--navy); text-decoration: none; }
    .nav-logo span { color: var(--sky); }
    .nav-back { font-size: 0.85rem; color: var(--muted); text-decoration: none; }
    .nav-back:hover { color: var(--navy); }

    .page-header { padding: 4rem 6%; background: var(--navy); color: var(--white); text-align: center; }
    .page-header h1 { font-family: 'DM Serif Display', serif; font-size: 2.5rem; margin-bottom: 1rem; }
    .page-header p { color: rgba(255,255,255,0.7); max-width: 600px; margin: 0 auto; line-height: 1.6; }

    .content-section { padding: 4rem 6%; max-width: 800px; margin: -2rem auto 4rem; position: relative; z-index: 10; display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; background: var(--white); border: 1px solid var(--border); border-radius: 12px; }
    
    .contact-info { display: flex; flex-direction: column; gap: 1.5rem; }
    .info-card { display: flex; align-items: center; gap: 1rem; }
    .info-icon { width: 48px; height: 48px; border-radius: 50%; background: linear-gradient(135deg, rgba(58,159,214,0.1), rgba(26,95,156,0.1)); color: var(--blue); display: flex; align-items: center; justify-content: center; font-size: 1.2rem; }
    .info-card h4 { font-size: 0.9rem; color: var(--navy); margin-bottom: 0.2rem; }
    .info-card p { font-size: 0.85rem; color: var(--muted); }

    .contact-form { display: flex; flex-direction: column; gap: 1rem; }
    .form-grp { display: flex; flex-direction: column; gap: 0.4rem; }
    .form-grp label { font-size: 0.8rem; font-weight: 600; color: var(--navy); }
    .form-grp input, .form-grp textarea { width: 100%; padding: 0.75rem; border: 1.5px solid var(--border); border-radius: 8px; font-family: 'Sora', sans-serif; font-size: 0.85rem; outline: none; transition: border-color 0.2s; }
    .form-grp input:focus, .form-grp textarea:focus { border-color: var(--sky); }
    .btn-submit { background: var(--navy); color: var(--white); border: none; padding: 0.8rem; border-radius: 8px; font-family: 'Sora', sans-serif; font-weight: 600; cursor: pointer; transition: background 0.2s; margin-top: 0.5rem; }
    .btn-submit:hover { background: var(--blue); }

    footer { background: var(--navy); color: rgba(255,255,255,0.5); padding: 2.5rem 6%; text-align: center; margin-top: auto; }

    @media (max-width: 768px) {
      .content-section { grid-template-columns: 1fr; }
    }
  
</style>

</head>
<body>
  <nav>
    <a class="nav-logo" href="/">Edu<span>Path</span></a>
    <div id="nav-right-wrap" style="display:flex; align-items:center; gap:1rem;">
    <a class="nav-back" href="/" style="margin:0;">← Back to Home</a>

</div>
</nav>

  <header class="page-header">
    <h1>Get in Touch</h1>
    <p>Have a question about your career report or need help with your account? We're here to help.</p>
  </header>

  <section class="content-section">
    <div class="contact-info">
      <h3>Contact Information</h3>
      <div class="info-card">
        <div class="info-icon"><i data-lucide="mail"></i></div>
        <div>
          <h4>Email Us</h4>
          <p>support@edupath.in</p>
        </div>
      </div>
      <div class="info-card">
        <div class="info-icon"><i data-lucide="phone"></i></div>
        <div>
          <h4>Call Us</h4>
          <p>+91 98765 43210 (Mon-Fri, 9AM-6PM)</p>
        </div>
      </div>
      <div class="info-card">
        <div class="info-icon"><i data-lucide="map-pin"></i></div>
        <div>
          <h4>Office</h4>
          <p>IIST Indore Campus, Rau-Pithampur Road<br>Indore, Madhya Pradesh 453331</p>
        </div>
      </div>
    </div>

    <form class="contact-form" action="#" method="POST" onsubmit="event.preventDefault(); alert('Thank you for reaching out! We will get back to you within 24 hours.');">
      <div class="form-grp">
        <label>Your Name</label>
        <input type="text" placeholder="John Doe" required />
      </div>
      <div class="form-grp">
        <label>Email Address</label>
        <input type="email" placeholder="john@example.com" required />
      </div>
      <div class="form-grp">
        <label>Message</label>
        <textarea rows="4" placeholder="How can we help you?" required></textarea>
      </div>
      <button type="submit" class="btn-submit">Send Message</button>
    </form>
  </section>

  <footer>
    <p>© 2025 EduPath. All rights reserved.</p>
  </footer>

  <script>lucide.createIcons();</script>

</body>
</html>
