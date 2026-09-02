<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Blog — EduPath</title>
  <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700&family=DM+Serif+Display:ital@0;1&display=swap" rel="stylesheet"/>
  <script src="https://unpkg.com/lucide@latest"></script>
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

    .content-section { padding: 4rem 6%; max-width: 1000px; margin: 0 auto; }
    .blog-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1.5rem; }
    .blog-card {
      background: var(--white); border: 1px solid var(--border); border-radius: 12px;
      overflow: hidden; transition: transform 0.2s; display: flex; flex-direction: column;
    }
    .blog-card:hover { transform: translateY(-3px); box-shadow: 0 10px 20px rgba(0,0,0,0.05); }
    .blog-img { width: 100%; height: 160px; background: linear-gradient(135deg, var(--sky), var(--blue)); }
    .blog-content { padding: 1.5rem; display: flex; flex-direction: column; flex: 1; }
    .blog-tag { font-size: 0.7rem; color: var(--sky); font-weight: 700; text-transform: uppercase; margin-bottom: 0.5rem; }
    .blog-title { color: var(--navy); font-size: 1.1rem; margin-bottom: 0.5rem; line-height: 1.4; }
    .blog-desc { font-size: 0.85rem; color: var(--muted); line-height: 1.6; margin-bottom: 1.5rem; flex: 1; }
    .blog-meta { font-size: 0.75rem; color: var(--muted); border-top: 1px solid var(--border); padding-top: 1rem; }

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
    <h1>EduPath Blog</h1>
    <p>Insights, exam tips, and career advice from industry experts and counselors.</p>
  </header>

  <section class="content-section">
    <div class="blog-grid">
      <div class="blog-card">
        <div class="blog-img" style="background: linear-gradient(135deg, #FF9A9E, #FECFEF);"></div>
        <div class="blog-content">
          <div class="blog-tag">Study Tips</div>
          <h3 class="blog-title">How to manage stress during Board Exams</h3>
          <p class="blog-desc">Practical psychological techniques to stay calm and focused when preparing for Class 10 and 12 boards.</p>
          <div class="blog-meta">5 min read · Oct 12, 2024</div>
        </div>
      </div>
      <div class="blog-card">
        <div class="blog-img" style="background: linear-gradient(135deg, #a18cd1, #fbc2eb);"></div>
        <div class="blog-content">
          <div class="blog-tag">Career Trends</div>
          <h3 class="blog-title">Why Data Science is the career of the decade</h3>
          <p class="blog-desc">An exploration into why companies are desperate for data scientists and what it takes to become one.</p>
          <div class="blog-meta">8 min read · Nov 03, 2024</div>
        </div>
      </div>
      <div class="blog-card">
        <div class="blog-img" style="background: linear-gradient(135deg, #84fab0, #8fd3f4);"></div>
        <div class="blog-content">
          <div class="blog-tag">College Admissions</div>
          <h3 class="blog-title">Demystifying the JEE Mains pattern changes</h3>
          <p class="blog-desc">Everything you need to know about the recent syllabus reductions and how to adapt your strategy.</p>
          <div class="blog-meta">4 min read · Jan 15, 2025</div>
        </div>
      </div>
    </div>
  </section>

  <footer>
    <p>© 2025 EduPath. All rights reserved.</p>
  </footer>

  <script>lucide.createIcons();</script>

</body>
</html>
