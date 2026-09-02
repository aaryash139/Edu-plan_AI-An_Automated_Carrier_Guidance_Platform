<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Privacy Policy — EduPath</title>
  <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700&family=DM+Serif+Display:ital@0;1&display=swap" rel="stylesheet"/>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --navy:    #0d1b2a; --blue:    #1a5f9c; --sky:     #3a9fd6;
      --accent:  #f4a825; --light:   #f0f6fc; --white:   #ffffff;
      --text:    #1e2d3d; --muted:   #6b849a; --border:  #d5e5f0;
    }
    body { font-family: 'Sora', sans-serif; background: var(--light); color: var(--text); }
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

    .content-section { padding: 4rem 6%; max-width: 800px; margin: 0 auto; background: var(--white); border: 1px solid var(--border); border-radius: 12px; margin-top: -2rem; position: relative; z-index: 10; margin-bottom: 4rem; }
    .content-section h2 { font-size: 1.25rem; color: var(--navy); margin-top: 2rem; margin-bottom: 0.75rem; }
    .content-section h2:first-child { margin-top: 0; }
    .content-section p { font-size: 0.9rem; color: var(--text); line-height: 1.7; margin-bottom: 1rem; }

    footer { background: var(--navy); color: rgba(255,255,255,0.5); padding: 2.5rem 6%; text-align: center; margin-top: auto; }
  
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
    <h1>Privacy Policy</h1>
    <p>Last updated: June 2026. We are committed to protecting your personal data.</p>
  </header>

  <section class="content-section">
    <h2>1. Introduction</h2>
    <p>Welcome to EduPath. We respect your privacy and are committed to protecting your personal data. This privacy policy will inform you as to how we look after your personal data when you visit our website (regardless of where you visit it from) and tell you about your privacy rights.</p>
    
    <h2>2. Data We Collect</h2>
    <p>We may collect, use, store and transfer different kinds of personal data about you which we have grouped together follows: Identity Data (First Name, Last Name), Contact Data (Email Address, Phone Number), Profile Data (Your Class, Academic Stream, Aptitude Test Results).</p>
    
    <h2>3. How We Use Your Data</h2>
    <p>We will only use your personal data when the law allows us to. Most commonly, we will use your personal data to generate personalized career recommendations using our Gemini AI backend, and to manage your student profile.</p>

    <h2>4. Data Security</h2>
    <p>We have put in place appropriate security measures to prevent your personal data from being accidentally lost, used or accessed in an unauthorized way. In addition, we limit access to your personal data to those employees, agents, contractors and other third parties who have a business need to know.</p>
  </section>

  <footer>
    <p>© 2025 EduPath. All rights reserved.</p>
  </footer>

</body>
</html>
