<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Career Library — EduPath</title>
  <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700&family=DM+Serif+Display:ital@0;1&display=swap" rel="stylesheet"/>
  <script src="https://unpkg.com/lucide@latest"></script>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --navy:    #0d1b2a; --blue:    #1a5f9c; --sky:     #3a9fd6;
      --accent:  #f4a825; --light:   #f0f6fc; --white:   #ffffff;
      --text:    #1e2d3d; --muted:   #6b849a; --border:  #d5e5f0;
      --success: #2e9b6e; --error:   #e53935;
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

    .page-header { padding: 4rem 6% 3rem; background: var(--navy); color: var(--white); text-align: center; }
    .page-header h1 { font-family: 'DM Serif Display', serif; font-size: 2.5rem; margin-bottom: 1rem; }
    .page-header p { color: rgba(255,255,255,0.7); max-width: 600px; margin: 0 auto; line-height: 1.6; }

    /* Search Component */
    .search-wrapper { max-width: 650px; margin: 2rem auto 0; position: relative; }
    .search-input {
      width: 100%; padding: 1.2rem 1.5rem 1.2rem 3rem; border-radius: 50px;
      border: none; font-family: 'Sora', sans-serif; font-size: 1rem;
      outline: none; box-shadow: 0 10px 25px rgba(0,0,0,0.2);
    }
    .search-icon { position: absolute; left: 1.2rem; top: 50%; transform: translateY(-50%); color: var(--muted); }
    .search-btn {
      position: absolute; right: 0.5rem; top: 50%; transform: translateY(-50%);
      background: var(--sky); color: white; border: none; padding: 0.75rem 1.5rem;
      border-radius: 40px; font-weight: 600; cursor: pointer; transition: background 0.2s;
    }
    .search-btn:hover { background: var(--blue); }

    .trending-tags { display: flex; flex-wrap: wrap; justify-content: center; gap: 0.6rem; margin-top: 1.5rem; }
    .trend-tag {
      background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2);
      color: var(--white); padding: 0.4rem 1rem; border-radius: 20px;
      font-size: 0.8rem; cursor: pointer; transition: all 0.2s;
    }
    .trend-tag:hover { background: var(--sky); border-color: var(--sky); }

    /* Content Area */
    .content-section { padding: 3rem 6%; max-width: 900px; margin: 0 auto; min-height: 50vh; }
    
    /* Loading Spinner */
    .loading-state { text-align: center; padding: 4rem 0; display: none; }
    .spinner {
      width: 40px; height: 40px; border: 4px solid var(--border);
      border-top-color: var(--sky); border-radius: 50%;
      animation: spin 1s linear infinite; margin: 0 auto 1.5rem;
    }
    @keyframes spin { to { transform: rotate(360deg); } }

    /* AI Report Card */
    .ai-report-card {
      background: var(--white); border: 1.5px solid var(--border); border-radius: 16px;
      padding: 2.5rem; margin-top: 1rem; display: none;
      box-shadow: 0 10px 30px rgba(13,27,42,0.05); position: relative;
      animation: fadeIn 0.4s ease;
    }
    @keyframes fadeIn { from { opacity:0; transform:translateY(15px); } to { opacity:1; transform:translateY(0); } }
    .ai-report-card::before {
      content: ''; position: absolute; top: 0; left: 0; width: 6px; height: 100%;
      background: linear-gradient(to bottom, var(--sky), var(--blue)); border-radius: 16px 0 0 16px;
    }
    .ai-report-badge {
      position: absolute; top: 1.5rem; right: 1.5rem;
      background: rgba(58,159,214,0.1); color: var(--sky);
      padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.7rem; font-weight: 700;
      letter-spacing: 0.05em; text-transform: uppercase;
    }
    
    /* Markdown Styles */
    .ai-content { font-size: 0.95rem; line-height: 1.7; color: var(--text); }
    .ai-content h1, .ai-content h2, .ai-content h3 { font-family: 'DM Serif Display', serif; color: var(--navy); margin-top: 1.5rem; margin-bottom: 0.75rem; }
    .ai-content h3 { font-size: 1.3rem; border-bottom: 1px solid var(--border); padding-bottom: 0.5rem; }
    .ai-content p { margin-bottom: 1.2rem; }
    .ai-content ul { margin-left: 1.5rem; margin-bottom: 1.2rem; }
    .ai-content li { margin-bottom: 0.5rem; }

    /* Default Grid (Broad Domains) */
    .default-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1.5rem; }
    .domain-card {
      background: var(--white); border: 1px solid var(--border); border-radius: 12px;
      padding: 1.5rem; text-align: center; cursor: pointer; transition: transform 0.2s, border-color 0.2s;
    }
    .domain-card:hover { transform: translateY(-3px); border-color: var(--sky); box-shadow: 0 10px 20px rgba(0,0,0,0.05); }
    .domain-icon { font-size: 2rem; color: var(--sky); margin-bottom: 1rem; display: inline-block; }
    .domain-card h3 { color: var(--navy); font-size: 1.1rem; margin-bottom: 0.5rem; }

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
    <h1>AI Career Library</h1>
    <p>Discover everything you need to know about any profession in India. From required degrees and entrance exams to salary insights.</p>
    
    <div class="search-wrapper">
      <i data-lucide="search" class="search-icon"></i>
      <form id="searchForm" onsubmit="handleSearch(event)">
        <input type="text" id="careerSearch" class="search-input" placeholder="Search any career (e.g. Data Scientist, Corporate Lawyer)..." required autocomplete="off" />
        <button type="submit" class="search-btn">Explore</button>
      </form>
    </div>
    
    <div class="trending-tags">
      <span class="trend-tag" onclick="fetchCareer('Artificial Intelligence Engineer')">AI Engineer</span>
      <span class="trend-tag" onclick="fetchCareer('Investment Banker')">Investment Banker</span>
      <span class="trend-tag" onclick="fetchCareer('Clinical Psychologist')">Psychologist</span>
      <span class="trend-tag" onclick="fetchCareer('UI/UX Designer')">UI/UX Designer</span>
      <span class="trend-tag" onclick="fetchCareer('Commercial Pilot')">Commercial Pilot</span>
    </div>
  </header>

  <section class="content-section">
    <!-- Default Domains View -->
    <div id="defaultView">
      <h2 style="font-family:'DM Serif Display',serif; color:var(--navy); margin-bottom:1.5rem; text-align:center;">Or Explore Broad Domains</h2>
      <div class="default-grid">
        <div class="domain-card" onclick="fetchCareer('Software Engineer in India')">
          <i data-lucide="cpu" class="domain-icon"></i>
          <h3>Engineering & Tech</h3>
        </div>
        <div class="domain-card" onclick="fetchCareer('Doctor / Medical Professional in India')">
          <i data-lucide="stethoscope" class="domain-icon"></i>
          <h3>Medicine & Healthcare</h3>
        </div>
        <div class="domain-card" onclick="fetchCareer('Chartered Accountant (CA)')">
          <i data-lucide="briefcase" class="domain-icon"></i>
          <h3>Commerce & Finance</h3>
        </div>
        <div class="domain-card" onclick="fetchCareer('Corporate Lawyer')">
          <i data-lucide="pen-tool" class="domain-icon"></i>
          <h3>Arts, Law & Humanities</h3>
        </div>
      </div>
    </div>

    <!-- Loading State -->
    <div id="loadingState" class="loading-state">
      <div class="spinner"></div>
      <h3 style="color:var(--navy); font-family:'DM Serif Display',serif;">Generating Career Profile...</h3>
      <p style="color:var(--muted); font-size:0.9rem;">Our AI is compiling the latest data on exams, degrees, and salaries in India.</p>
    </div>

    <!-- AI Result View -->
    <div id="aiResult" class="ai-report-card">
      <div class="ai-report-badge">✨ AI Generated</div>
      <h2 id="resultTitle" style="font-family:'DM Serif Display',serif; color:var(--navy); font-size:2rem; margin-top:0;"></h2>
      <div id="resultContent" class="ai-content"></div>
      
      <div style="margin-top:2.5rem; text-align:center;">
        <button onclick="resetView()" style="background:var(--light); border:1px solid var(--border); padding:0.6rem 1.5rem; border-radius:8px; cursor:pointer; font-family:'Sora',sans-serif; color:var(--muted); font-weight:600; transition:all 0.2s;">← Back to Categories</button>
      </div>
    </div>

  </section>

  <footer>
    <p>© 2025 EduPath. All rights reserved.</p>
  </footer>

  <script>
    lucide.createIcons();

    function handleSearch(e) {
      e.preventDefault();
      const query = document.getElementById('careerSearch').value.trim();
      if(query) fetchCareer(query);
    }

    async function fetchCareer(careerName) {
      // Set UI State
      document.getElementById('careerSearch').value = careerName;
      document.getElementById('defaultView').style.display = 'none';
      document.getElementById('aiResult').style.display = 'none';
      document.getElementById('loadingState').style.display = 'block';

      try {
        const res = await fetch('/api/career/explore', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ careerName: careerName })
        });
        const data = await res.json();
        
        document.getElementById('loadingState').style.display = 'none';
        
        if(res.ok) {
          document.getElementById('resultTitle').textContent = careerName;
          document.getElementById('resultContent').innerHTML = data.profileHtml;
          document.getElementById('aiResult').style.display = 'block';
        } else {
          alert('Error: ' + (data.error || 'Failed to generate profile'));
          resetView();
        }
      } catch (err) {
        document.getElementById('loadingState').style.display = 'none';
        alert('Network error. Please try again.');
        resetView();
      }
    }

    function resetView() {
      document.getElementById('careerSearch').value = '';
      document.getElementById('aiResult').style.display = 'none';
      document.getElementById('loadingState').style.display = 'none';
      document.getElementById('defaultView').style.display = 'block';
    }
  </script>

</body>
</html>
