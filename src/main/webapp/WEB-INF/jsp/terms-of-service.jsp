<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Terms of Service — EduPath</title>
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
    <h1>Terms of Service</h1>
    <p>Please read these terms carefully before using our platform.</p>
  </header>

  <section class="content-section">
    <h2>1. Agreement to Terms</h2>
    <p>By accessing or using EduPath, you agree to be bound by these Terms of Service. If you disagree with any part of the terms, you may not access the platform.</p>
    
    <h2>2. Educational Purposes Only</h2>
    <p>The career recommendations provided by EduPath, powered by AI, are for informational and educational purposes only. They do not guarantee admission into any college or success in any specific career path. Users are encouraged to perform their own research and consult with human career counselors.</p>
    
    <h2>3. User Accounts</h2>
    <p>When you create an account with us, you must provide information that is accurate, complete, and current at all times. Failure to do so constitutes a breach of the Terms, which may result in immediate termination of your account on our Service.</p>

    <h2>4. Intellectual Property</h2>
    <p>The Service and its original content, features, and functionality are and will remain the exclusive property of EduPath and its licensors. The Service is protected by copyright, trademark, and other laws.</p>
  </section>

  <footer>
    <p>© 2025 EduPath. All rights reserved.</p>
  </footer>

</body>
</html>
