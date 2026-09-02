<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Aptitude Framework — EduPath</title>
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

    .content-section { padding: 4rem 6%; max-width: 800px; margin: 0 auto; }
    .framework-item { background: var(--white); border: 1px solid var(--border); border-radius: 12px; padding: 2rem; margin-bottom: 1.5rem; }
    .framework-item h3 { color: var(--navy); font-size: 1.2rem; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem; }
    .framework-item p { font-size: 0.9rem; color: var(--muted); line-height: 1.7; }

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
    <h1>Our Aptitude Framework</h1>
    <p>Discover the science behind our career recommendations. EduPath measures three core cognitive abilities to predict academic success.</p>
  </header>

  <section class="content-section">
    <div class="framework-item">
      <h3><i data-lucide="calculator" style="color:var(--sky);"></i> Mathematical Ability</h3>
      <p>Measures your ability to process numerical data, perform complex calculations, and understand quantitative relationships. Essential for Engineering, Finance, and Data Science.</p>
    </div>
    <div class="framework-item">
      <h3><i data-lucide="brain-circuit" style="color:var(--sky);"></i> Logical Reasoning</h3>
      <p>Evaluates your capacity to analyze patterns, solve abstract problems, and think critically under pressure. A high logic score correlates with success in Computer Science and Law.</p>
    </div>
    <div class="framework-item">
      <h3><i data-lucide="book-open" style="color:var(--sky);"></i> Verbal Comprehension</h3>
      <p>Tests your vocabulary, grammar, and ability to extract meaning from complex texts. Crucial for careers in Journalism, Humanities, and Management.</p>
    </div>
  </section>

  <footer>
    <p>© 2025 EduPath. All rights reserved.</p>
  </footer>

  <script>lucide.createIcons();</script>

</body>
</html>
