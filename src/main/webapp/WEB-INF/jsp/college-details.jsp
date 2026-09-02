<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>${college.name} - EduPath</title>
  <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700&family=DM+Serif+Display:ital@0;1&display=swap" rel="stylesheet"/>
  <script src="https://unpkg.com/lucide@latest"></script>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --navy:    #0d1b2a; --blue:    #1a5f9c; --sky:     #3a9fd6;
      --accent:  #f4a825; --light:   #f0f6fc; --white:   #ffffff;
      --text:    #1e2d3d; --muted:   #6b849a; --border:  #d5e5f0;
      --success: #2e9b6e; --warning: #d97706; --error:   #e53935;
    }
    body { font-family: 'Sora', sans-serif; background: var(--light); color: var(--text); }
    
    /* Nav */
    nav { display: flex; align-items: center; justify-content: space-between; padding: 0 6%; height: 80px; background: var(--white); border-bottom: 1px solid var(--border); position: sticky; top: 0; z-index: 100; }
    .nav-logo { font-family: 'DM Serif Display', serif; font-size: 2.2rem; letter-spacing: -0.5px; color: var(--navy); text-decoration: none; }
    .nav-logo span { color: var(--sky); }
    .nav-back { font-size: 0.85rem; color: var(--muted); text-decoration: none; display: flex; align-items: center; gap: 0.5rem; }
    .nav-back:hover { color: var(--navy); }

    /* Header Banner */
    .hero-banner {
      background: linear-gradient(rgba(13, 27, 42, 0.8), rgba(13, 27, 42, 0.9)), url('https://images.unsplash.com/photo-1541339907198-e08756dedf3f?ixlib=rb-1.2.1&auto=format&fit=crop&w=1920&q=80') center/cover;
      padding: 4rem 6%; color: var(--white);
    }
    .hero-top { display: flex; justify-content: space-between; align-items: flex-start; flex-wrap: wrap; gap: 1rem; }
    .college-name { font-family: 'DM Serif Display', serif; font-size: 2.5rem; margin-bottom: 0.5rem; }
    .college-location { display: flex; align-items: center; gap: 0.5rem; font-size: 1rem; color: rgba(255,255,255,0.8); margin-bottom: 1.5rem; }
    
    .tags { display: flex; gap: 0.5rem; flex-wrap: wrap; margin-bottom: 1.5rem; }
    .tag { padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.75rem; font-weight: 600; text-transform: uppercase; }
    .tag-type { background: rgba(58,159,214,0.2); color: #8fd3f4; border: 1px solid rgba(58,159,214,0.3); }
    .tag-stream { background: rgba(46,155,110,0.2); color: #84fab0; border: 1px solid rgba(46,155,110,0.3); }

    .action-btn {
      padding: 0.8rem 1.5rem; border-radius: 8px; font-family: 'Sora', sans-serif; font-weight: 600; cursor: pointer;
      display: inline-flex; align-items: center; gap: 0.5rem; transition: all 0.2s; text-decoration: none; font-size: 0.9rem;
    }
    .btn-save { background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.3); color: var(--white); }
    .btn-save:hover { background: rgba(255,255,255,0.2); }
    .btn-save.saved { background: var(--success); border-color: var(--success); }
    .btn-apply { background: var(--sky); border: 1px solid var(--sky); color: var(--white); }
    .btn-apply:hover { background: var(--blue); }

    /* Content Layout */
    .container { padding: 3rem 6%; display: grid; grid-template-columns: 2fr 1fr; gap: 2rem; max-width: 1400px; margin: 0 auto; }
    @media (max-width: 900px) { .container { grid-template-columns: 1fr; } }
    
    .section-title { font-family: 'DM Serif Display', serif; font-size: 1.5rem; color: var(--navy); margin-bottom: 1rem; border-bottom: 2px solid var(--border); padding-bottom: 0.5rem; }
    .card { background: var(--white); border: 1px solid var(--border); border-radius: 12px; padding: 2rem; margin-bottom: 2rem; box-shadow: 0 4px 6px rgba(0,0,0,0.02); }
    
    .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 1.5rem; margin-bottom: 1.5rem; }
    .stat-item { text-align: center; padding: 1.5rem; background: var(--light); border-radius: 8px; }
    .stat-val { font-size: 1.5rem; font-weight: 700; color: var(--navy); margin-bottom: 0.3rem; }
    .stat-label { font-size: 0.8rem; color: var(--muted); }

    .info-list { list-style: none; }
    .info-list li { padding: 1rem 0; border-bottom: 1px solid var(--border); display: flex; justify-content: space-between; align-items: center; }
    .info-list li:last-child { border-bottom: none; padding-bottom: 0; }
    .info-list .label { color: var(--muted); font-size: 0.9rem; }
    .info-list .val { font-weight: 600; color: var(--text); }

    /* Dummy Tabs for details */
    .content-tabs { display: flex; gap: 2rem; border-bottom: 1px solid var(--border); margin-bottom: 2rem; }
    .content-tab { padding: 1rem 0; font-weight: 600; color: var(--muted); cursor: pointer; border-bottom: 3px solid transparent; transition: all 0.2s; }
    .content-tab.active { color: var(--navy); border-bottom-color: var(--sky); }
    
    .tab-pane { display: none; line-height: 1.7; color: var(--text); }
    .tab-pane.active { display: block; animation: fadeIn 0.3s ease; }
    @keyframes fadeIn { from { opacity: 0; transform: translateY(5px); } to { opacity: 1; transform: translateY(0); } }

  
</style>

</head>
<body>
  <nav>
    <a class="nav-logo" href="/">Edu<span>Path</span></a>
    <a class="nav-back" href="/colleges"><i data-lucide="arrow-left" style="width:16px;"></i> Back to Search</a>
  

</nav>

  <header class="hero-banner">
    <div class="hero-top">
      <div>
        <h1 class="college-name">${college.name}</h1>
        <div class="college-location">
          <i data-lucide="map-pin" style="width:18px;"></i> ${college.city}, ${college.state}
        </div>
        <div class="tags">
          <span class="tag tag-type">${college.collegeType}</span>
          <span class="tag tag-stream">${college.stream}</span>
        </div>
      </div>
      <div style="display: flex; gap: 1rem;">
        <button class="action-btn btn-save ${isSaved ? 'saved' : ''}" onclick="toggleSave(${college.id}, this)">
          <i data-lucide="${isSaved ? 'check' : 'bookmark'}" style="width:18px;"></i> ${isSaved ? 'Saved' : 'Save to List'}
        </button>
        <a href="#" class="action-btn btn-apply" onclick="alert('Redirecting to official admission portal...')">
          Apply Now <i data-lucide="external-link" style="width:18px;"></i>
        </a>
      </div>
    </div>
  </header>

  <div class="container">
    <div class="main-content">
      <div class="card">
        <div class="content-tabs">
          <div class="content-tab active" onclick="switchContentTab('overview', this)">Overview</div>
          <div class="content-tab" onclick="switchContentTab('placements', this)">Placements</div>
          <div class="content-tab" onclick="switchContentTab('campus', this)">Campus Life</div>
          <div class="content-tab" onclick="switchContentTab('map', this)">Virtual Campus</div>
        </div>

        <div id="pane-overview" class="tab-pane active">
          <p style="margin-bottom: 1.5rem;">${college.name} is one of the premier institutions in ${college.state}, offering top-tier education in the ${college.stream} stream. Recognized for its academic excellence and rigorous curriculum, it provides students with modern facilities and expert faculty.</p>
          
          <h3 style="color:var(--navy); margin-bottom: 1rem; font-size:1.1rem;">Key Highlights</h3>
          <ul style="padding-left: 1.5rem; margin-bottom: 1.5rem; color: var(--muted);">
            <li style="margin-bottom: 0.5rem;">State-of-the-art infrastructure and modern laboratories.</li>
            <li style="margin-bottom: 0.5rem;">Strong industry tie-ups for internships and practical exposure.</li>
            <li style="margin-bottom: 0.5rem;">Highly qualified faculty with extensive research background.</li>
          </ul>
        </div>

                <div id="pane-placements" class="tab-pane">
          <p style="margin-bottom: 1.5rem;">The placement cell at ${college.name} actively collaborates with leading companies to ensure students secure excellent career opportunities. Training programs covering aptitude, technical skills, and interview preparation are conducted regularly.</p>
          
          <div style="display:flex; gap:1rem; margin-bottom:1.5rem;">
            <div style="flex:1; background:var(--light); padding:1.5rem; border-radius:8px; text-align:center;">
              <div style="font-size:1.5rem; font-weight:700; color:var(--sky);">${college.placementRate}</div>
              <div style="font-size:0.8rem; color:var(--muted);">Placement Rate</div>
            </div>
            <div style="flex:1; background:var(--light); padding:1.5rem; border-radius:8px; text-align:center;">
              <div style="font-size:1.5rem; font-weight:700; color:var(--success);">${college.avgPackage}</div>
              <div style="font-size:0.8rem; color:var(--muted);">Average Package</div>
            </div>
          </div>
          
          <h3 style="color:var(--navy); margin-bottom: 1rem; font-size:1.1rem;">Top Recruiters</h3>
          <p style="color:var(--muted); font-weight:600; line-height:1.6;">${college.topRecruiters}</p>
        </div>

        <div id="pane-campus" class="tab-pane">
          <p style="margin-bottom: 1.5rem;">Experience a vibrant campus life with numerous clubs, societies, and annual cultural and technical fests.</p>
          <h3 style="color:var(--navy); margin-bottom: 1rem; font-size:1.1rem;">Key Facilities</h3>
          <p style="color:var(--muted); line-height:1.6;">${college.facilities}</p>
        </div>

<div id="pane-map" class="tab-pane">
          <p style="margin-bottom: 1.5rem;">Explore the interactive 3D satellite view of the campus below.</p>
          <div style="width: 100%; height: 400px; border-radius: 12px; overflow: hidden; border: 1px solid var(--border);">
            <iframe
              width="100%"
              height="100%"
              frameborder="0" style="border:0"
              src="https://maps.google.com/maps?q=${college.name}, ${college.city}&t=k&z=17&output=embed" 
              allowfullscreen>
            </iframe>
          </div>
        </div>
      </div>
    </div>

    <div class="sidebar">
      <div class="card" style="padding: 1.5rem;">
        <h2 class="section-title" style="font-size:1.2rem;">Quick Facts</h2>
        <div class="stats-grid">
          <div class="stat-item" style="padding: 1rem;">
            <div class="stat-val">#${college.nirfRank}</div>
            <div class="stat-label">NIRF Rank</div>
          </div>
          <div class="stat-item" style="padding: 1rem;">
            <div class="stat-val">${college.cutoff}%</div>
            <div class="stat-label">Min Cutoff</div>
          </div>
        </div>
        
        <ul class="info-list">
          <li><span class="label">Total Fees</span><span class="val">Rs ${college.fees}</span></li>
          <li><span class="label">Accepted Exam</span><span class="val">${college.entranceExam}</span></li>
          <li><span class="label">Institution Type</span><span class="val">${college.collegeType}</span></li>
          <li><span class="label">Stream Focus</span><span class="val">${college.stream}</span></li>
        </ul>
      </div>
    </div>
  </div>

  <script>
    lucide.createIcons();

    function switchContentTab(paneId, element) {
      document.querySelectorAll('.content-tab').forEach(t => t.classList.remove('active'));
      document.querySelectorAll('.tab-pane').forEach(p => p.classList.remove('active'));
      
      element.classList.add('active');
      document.getElementById('pane-' + paneId).classList.add('active');
    }

    async function toggleSave(id, btn) {
      try {
        const res = await fetch('/api/colleges/save', {
          method: 'POST',
          headers: {'Content-Type': 'application/json'},
          body: JSON.stringify({collegeId: id})
        });
        if(res.status === 401) {
          window.location.href = '/login?next=' + window.location.pathname;
          return;
        }
        if(!res.ok) throw new Error();
        const data = await res.json();
        
        if (data.status === 'SAVED') {
          btn.classList.add('saved');
          btn.innerHTML = '<i data-lucide="check" style="width:18px;"></i> Saved';
        } else {
          btn.classList.remove('saved');
          btn.innerHTML = '<i data-lucide="bookmark" style="width:18px;"></i> Save to List';
        }
        lucide.createIcons();
      } catch (err) {
        alert("Failed to update saved status.");
      }
    }
  </script>

</body>
</html>
