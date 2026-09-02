<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>College Search — EduPath</title>
  <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700&family=DM+Serif+Display:ital@0;1&display=swap" rel="stylesheet"/>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --navy:   #0d1b2a;
      --blue:   #1a5f9c;
      --sky:    #3a9fd6;
      --accent: #f4a825;
      --light:  #f0f6fc;
      --white:  #ffffff;
      --text:   #1e2d3d;
      --muted:  #6b849a;
      --border: #d5e5f0;
      --success:#2e9b6e;
      --error:  #e53935;
    }

    body { font-family: 'Sora', sans-serif; background: var(--light); color: var(--text); min-height: 100vh; }

    /* NAV */
    nav {
      display: flex; align-items: center; justify-content: space-between;
      padding: 0 5%; height: 80px;
      background: rgba(255,255,255,0.92); backdrop-filter: blur(12px);
      border-bottom: 1px solid var(--border);
      position: sticky; top: 0; z-index: 100;
    }
    .nav-logo { font-family: 'DM Serif Display', serif; font-size: 2.2rem; letter-spacing: -0.5px; color: var(--navy); text-decoration: none; }
    .nav-logo span { color: var(--sky); }
    .nav-links { display: flex; align-items: center; gap: 1.5rem; list-style: none; }
    .nav-links a { font-size: 0.85rem; color: var(--muted); text-decoration: none; transition: color 0.2s; }
    .nav-links a:hover { color: var(--navy); }
    .btn-nav { background: var(--navy); color: var(--white) !important; padding: 0.45rem 1.1rem; border-radius: 6px; font-weight: 600 !important; }

    /* HERO STRIP */
    .page-hero {
      background: var(--navy); padding: 3rem 5%;
      position: relative; overflow: hidden;
    }
    .page-hero::before {
      content: ''; position: absolute; top: -80px; right: -80px;
      width: 350px; height: 350px;
      background: radial-gradient(circle, rgba(58,159,214,0.18) 0%, transparent 70%);
      border-radius: 50%;
    }
    .hero-inner { position: relative; z-index: 1; max-width: 600px; }
    .hero-tag { font-size: 0.72rem; font-weight: 700; letter-spacing: 0.1em; text-transform: uppercase; color: var(--sky); margin-bottom: 0.75rem; }
    .page-hero h1 { font-family: 'DM Serif Display', serif; font-size: 2rem; color: var(--white); margin-bottom: 0.5rem; line-height: 1.2; }
    .page-hero h1 em { font-style: italic; color: var(--sky); }
    .page-hero p { font-size: 0.9rem; color: rgba(255,255,255,0.5); line-height: 1.7; }

    /* SEARCH BAR */
    .search-bar-wrap {
      background: var(--white); border-bottom: 1px solid var(--border);
      padding: 1rem 5%; display: flex; gap: 0.75rem; align-items: center; flex-wrap: wrap;
    }
    .search-input-wrap { flex: 1; min-width: 220px; position: relative; }
    .search-input-wrap input {
      width: 100%; padding: 0.7rem 0.9rem 0.7rem 2.5rem;
      border: 1.5px solid var(--border); border-radius: 8px;
      font-family: 'Sora', sans-serif; font-size: 0.88rem; color: var(--text);
      outline: none; transition: border-color 0.2s, box-shadow 0.2s;
    }
    .search-input-wrap input:focus { border-color: var(--sky); box-shadow: 0 0 0 3px rgba(58,159,214,0.1); }
    .search-icon { position: absolute; left: 0.75rem; top: 50%; transform: translateY(-50%); font-size: 0.9rem; color: var(--muted); }
    .result-count { font-size: 0.82rem; color: var(--muted); white-space: nowrap; }

    /* LAYOUT */
    .main-layout { display: grid; grid-template-columns: 280px 1fr; gap: 0; min-height: calc(100vh - 180px); }

    /* FILTER PANEL */
    .filter-panel {
      background: var(--white); border-right: 1px solid var(--border);
      padding: 1.5rem; position: sticky; top: 64px;
      height: calc(100vh - 80px); overflow-y: auto;
    }
    .filter-panel::-webkit-scrollbar { width: 4px; }
    .filter-panel::-webkit-scrollbar-thumb { background: var(--border); border-radius: 10px; }

    .filter-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem; }
    .filter-header h3 { font-size: 0.88rem; font-weight: 700; color: var(--navy); }
    .clear-btn { font-size: 0.75rem; color: var(--sky); background: none; border: none; cursor: pointer; font-family: 'Sora', sans-serif; }
    .clear-btn:hover { text-decoration: underline; }

    .filter-group { margin-bottom: 1.5rem; }
    .filter-group label { display: block; font-size: 0.78rem; font-weight: 700; color: var(--text); text-transform: uppercase; letter-spacing: 0.06em; margin-bottom: 0.6rem; }

    select.filter-select {
      width: 100%; padding: 0.6rem 0.8rem;
      border: 1.5px solid var(--border); border-radius: 7px;
      font-family: 'Sora', sans-serif; font-size: 0.83rem; color: var(--text);
      background: var(--white); outline: none; appearance: none;
      transition: border-color 0.2s;
    }
    select.filter-select:focus { border-color: var(--sky); }

    /* Range slider */
    .range-wrap { padding: 0.25rem 0; }
    .range-labels { display: flex; justify-content: space-between; font-size: 0.75rem; color: var(--muted); margin-top: 0.4rem; }
    input[type=range] { width: 100%; accent-color: var(--sky); }

    /* Checkbox filters */
    .check-options { display: flex; flex-direction: column; gap: 0.5rem; }
    .check-item { display: flex; align-items: center; gap: 0.6rem; cursor: pointer; }
    .check-item input { accent-color: var(--sky); width: 14px; height: 14px; cursor: pointer; }
    .check-item span { font-size: 0.82rem; color: var(--text); }

    /* RESULTS PANEL */
    .results-panel { padding: 1.5rem 2rem; }

    /* Sort bar */
    .sort-bar { display: flex; align-items: center; gap: 1rem; margin-bottom: 1.25rem; flex-wrap: wrap; }
    .sort-bar span { font-size: 0.8rem; color: var(--muted); }
    .sort-btn {
      font-size: 0.8rem; padding: 0.35rem 0.9rem; border-radius: 20px;
      border: 1.5px solid var(--border); background: var(--white);
      cursor: pointer; font-family: 'Sora', sans-serif; color: var(--muted);
      transition: all 0.2s;
    }
    .sort-btn.active { background: var(--navy); border-color: var(--navy); color: white; font-weight: 600; }

    /* College cards */
    .colleges-grid { display: flex; flex-direction: column; gap: 1rem; }

    .college-card {
      background: var(--white); border: 1px solid var(--border);
      border-radius: 14px; padding: 1.5rem;
      display: grid; grid-template-columns: 1fr auto;
      gap: 1rem; align-items: start;
      transition: box-shadow 0.2s, transform 0.2s;
      position: relative;
    }
    .college-card:hover { box-shadow: 0 8px 32px rgba(13,27,42,0.1); transform: translateY(-2px); }
    .college-card.saved { border-color: var(--sky); }

    .college-rank {
      position: absolute; top: 1rem; left: -1px;
      background: var(--navy); color: white;
      font-size: 0.68rem; font-weight: 700; padding: 3px 10px 3px 12px;
      border-radius: 0 20px 20px 0;
    }
    .college-rank.top { background: var(--accent); color: var(--navy); }

    .college-main { padding-left: 0.5rem; }
    .college-name { font-size: 1rem; font-weight: 700; color: var(--navy); margin-bottom: 0.3rem; margin-top: 0.25rem; }
    .college-location { font-size: 0.8rem; color: var(--muted); margin-bottom: 0.75rem; display: flex; align-items: center; gap: 0.3rem; }

    .college-tags { display: flex; flex-wrap: wrap; gap: 0.4rem; margin-bottom: 1rem; }
    .ctag {
      font-size: 0.7rem; font-weight: 600; padding: 3px 10px; border-radius: 20px;
    }
    .ctag-type  { background: rgba(58,159,214,0.1); color: var(--blue); }
    .ctag-stream{ background: rgba(46,155,110,0.1); color: var(--success); }
    .ctag-exam  { background: rgba(244,168,37,0.12); color: #b07a00; }

    .college-stats { display: flex; gap: 1.5rem; flex-wrap: wrap; }
    .stat-item { }
    .stat-val { font-size: 0.92rem; font-weight: 700; color: var(--navy); }
    .stat-key { font-size: 0.7rem; color: var(--muted); margin-top: 1px; }

    .college-actions { display: flex; flex-direction: column; gap: 0.5rem; align-items: flex-end; }
    .btn-save {
      padding: 0.5rem 1rem; border-radius: 7px;
      font-family: 'Sora', sans-serif; font-size: 0.78rem; font-weight: 600;
      cursor: pointer; transition: all 0.2s; white-space: nowrap;
    }
    .btn-save-outline { background: transparent; border: 1.5px solid var(--border); color: var(--muted); }
    .btn-save-outline:hover { border-color: var(--sky); color: var(--sky); }
    .btn-save-filled { background: var(--sky); border: 1.5px solid var(--sky); color: white; }
    .rating-badge {
      display: flex; align-items: center; gap: 0.3rem;
      font-size: 0.78rem; font-weight: 700; color: var(--accent);
    }

    /* Empty state */
    .empty-state {
      text-align: center; padding: 4rem 2rem; display: none;
    }
    .empty-state.show { display: block; }
    .empty-icon { font-size: 3rem; margin-bottom: 1rem; }
    .empty-state h3 { font-size: 1rem; font-weight: 700; color: var(--navy); margin-bottom: 0.5rem; }
    .empty-state p { font-size: 0.85rem; color: var(--muted); }

    /* Saved counter chip */
    .saved-chip {
      background: rgba(46,155,110,0.1); color: var(--success);
      border: 1px solid rgba(46,155,110,0.25);
      padding: 0.3rem 0.8rem; border-radius: 20px;
      font-size: 0.75rem; font-weight: 600;
    }

    @media (max-width: 860px) {
      .main-layout { grid-template-columns: 1fr; }
      .filter-panel { position: static; height: auto; border-right: none; border-bottom: 1px solid var(--border); }
      .results-panel { padding: 1.25rem; }
      .nav-links { display: none; }
    }
    @media (max-width: 560px) {
      .college-card { grid-template-columns: 1fr; }
      .college-actions { flex-direction: row; align-items: center; }
    }
  
</style>

</head>
<body>

<!-- NAV -->
<nav>
  <a class="nav-logo" href="/">Edu<span>Path</span></a>
  <ul class="nav-links">
    <li><a href="/aptitude-test">Take Test</a></li>
    <li><a href="/colleges" style="color:var(--navy);font-weight:600;">College Search</a></li>
    <li><a href="/dashboard" class="btn-nav">Dashboard</a></li>
  </ul>


</nav>

<!-- HERO -->
<div class="page-hero">
  <div class="hero-inner">
    <div class="hero-tag">College Discovery Engine</div>
    <h1>Find your <em>perfect college</em></h1>
    <p>Search and filter 500+ colleges across India by location, fees, cut-off, and ranking — all in one place.</p>
  </div>
</div>

<!-- SEARCH BAR -->
<div class="search-bar-wrap">
  <div class="search-input-wrap">
    <span class="search-icon">ðŸ”</span>
    <input type="text" id="searchInput" placeholder="Search by college name or cityâ€¦" oninput="applyFilters()" />
  </div>
  <span class="result-count" id="resultCount">Showing 20 colleges</span>
  <span class="saved-chip" id="savedChip" style="display:none;">0 saved</span>
</div>

<!-- MAIN LAYOUT -->
<div class="main-layout">

  <!-- FILTER PANEL -->
  <div class="filter-panel">
    <div class="filter-header">
      <h3>Filters</h3>
      <button class="clear-btn" onclick="clearFilters()">Clear all</button>
    </div>

    <div class="filter-group">
      <label>State</label>
      <select class="filter-select" id="fState" onchange="applyFilters()">
        <option value="">All States</option>
        <option>Madhya Pradesh</option>
        <option>Maharashtra</option>
        <option>Delhi</option>
        <option>Karnataka</option>
        <option>Tamil Nadu</option>
        <option>Uttar Pradesh</option>
        <option>Rajasthan</option>
        <option>West Bengal</option>
        <option>Gujarat</option>
        <option>Telangana</option>
      </select>
    </div>

    <div class="filter-group">
      <label>Stream / Course</label>
      <select class="filter-select" id="fStream" onchange="applyFilters()">
        <option value="">All Streams</option>
        <option>Science (PCM)</option>
        <option>Science (PCB)</option>
        <option>Commerce</option>
        <option>Arts / Humanities</option>
        <option>Law</option>
        <option>Design</option>
      </select>
    </div>

    <div class="filter-group">
      <label>College Type</label>
      <select class="filter-select" id="fType" onchange="applyFilters()">
        <option value="">All Types</option>
        <option>Government / IIT / NIT</option>
        <option>Deemed University</option>
        <option>Private University</option>
        <option>Autonomous College</option>
      </select>
    </div>

    <div class="filter-group">
      <label>Max Annual Fees</label>
      <div class="range-wrap">
        <input type="range" id="fFees" min="50000" max="2000000" step="50000" value="2000000" oninput="updateFeesLabel()" onchange="applyFilters()" />
        <div class="range-labels">
          <span>₹50K</span>
          <span id="feesLabel">Any</span>
          <span>₹20L</span>
        </div>
      </div>
    </div>

    <div class="filter-group">
      <label>Min Cut-off %</label>
      <div class="range-wrap">
        <input type="range" id="fCutoff" min="50" max="100" step="1" value="50" oninput="updateCutoffLabel()" onchange="applyFilters()" />
        <div class="range-labels">
          <span>50%</span>
          <span id="cutoffLabel">50%+</span>
          <span>100%</span>
        </div>
      </div>
    </div>

    <div class="filter-group">
      <label>Entrance Exam</label>
      <div class="check-options">
        <label class="check-item"><input type="checkbox" class="fExam" value="JEE" onchange="applyFilters()" /><span>JEE Main / Advanced</span></label>
        <label class="check-item"><input type="checkbox" class="fExam" value="NEET" onchange="applyFilters()" /><span>NEET</span></label>
        <label class="check-item"><input type="checkbox" class="fExam" value="CAT" onchange="applyFilters()" /><span>CAT / MAT</span></label>
        <label class="check-item"><input type="checkbox" class="fExam" value="CLAT" onchange="applyFilters()" /><span>CLAT</span></label>
        <label class="check-item"><input type="checkbox" class="fExam" value="Board" onchange="applyFilters()" /><span>Board Marks Only</span></label>
      </div>
    </div>

    <div class="filter-group">
      <label>Min NIRF Ranking</label>
      <select class="filter-select" id="fRank" onchange="applyFilters()">
        <option value="">Any Rank</option>
        <option value="10">Top 10</option>
        <option value="25">Top 25</option>
        <option value="50">Top 50</option>
        <option value="100">Top 100</option>
        <option value="200">Top 200</option>
        <option value="300">Top 300</option>
        <option value="500">Top 500</option>
      </select>
    </div>
  </div>

  <!-- RESULTS -->
  <div class="results-panel">

    <div class="sort-bar">
      <span>Sort by:</span>
      <button class="sort-btn active" onclick="setSort('rank', this)">NIRF Rank</button>
      <button class="sort-btn" onclick="setSort('fees', this)">Fees ↓</button>
      <button class="sort-btn" onclick="setSort('cutoff', this)">Cut-off â†“</button>
      <button class="sort-btn" onclick="setSort('name', this)">Aâ€“Z</button>
    </div>

    <div class="colleges-grid" id="collegesGrid"></div>
    <div class="empty-state" id="emptyState">
      <div class="empty-icon">ðŸ›</div>
      <h3>No colleges match your filters</h3>
      <p>Try adjusting your filters or clearing some criteria.</p>
    </div>

  </div>
</div>

<script>
// Colleges Spring Boot API se load hote hain
let colleges = [];
let saved = new Set(${empty savedCollegeIds ? '[]' : savedCollegeIds});
let sortKey = 'rank';
let filteredList = [...colleges];

function fmtFees(n) {
  if (n >= 100000) return '₹' + (n/100000).toFixed(1) + 'L/yr';
  return '₹' + (n/1000).toFixed(0) + 'K/yr';
}

function updateFeesLabel() {
  const v = +document.getElementById('fFees').value;
  document.getElementById('feesLabel').textContent = v >= 2000000 ? 'Any' : fmtFees(v);
}
function updateCutoffLabel() {
  const v = +document.getElementById('fCutoff').value;
  document.getElementById('cutoffLabel').textContent = v + '%+';
}

async function applyFilters() {
  const search  = document.getElementById('searchInput').value.toLowerCase();
  const fState  = document.getElementById('fState').value;
  const fStream = document.getElementById('fStream').value;
  const fType   = document.getElementById('fType').value;
  const fFees   = +document.getElementById('fFees').value;
  const fCutoff = +document.getElementById('fCutoff').value;
  const fRank   = +document.getElementById('fRank').value || 9999;
  const exams   = [...document.querySelectorAll('.fExam:checked')].map(e => e.value);

  const params = new URLSearchParams({
    search: search,
    state: fState,
    stream: fStream,
    type: fType,
    maxFees: String(fFees),
    minCutoff: String(fCutoff),
    maxRank: String(fRank),
    sort: sortKey
  });

  exams.forEach(e => params.append('exam', e));

  try {
    const res = await fetch('/api/colleges?' + params.toString());
    if (res.ok) {
      colleges = await res.json();
      filteredList = [...colleges];
    } else {
      filteredList = [];
    }
  } catch (e) {
    filteredList = [];
  }

  renderCards();
}

function setSort(key, btn) {
  sortKey = key;
  document.querySelectorAll('.sort-btn').forEach(b => b.classList.remove('active'));
  btn.classList.add('active');
  applyFilters();
}

function renderCards() {
  const grid = document.getElementById('collegesGrid');
  const empty = document.getElementById('emptyState');

  document.getElementById('resultCount').textContent =
    `Showing \${filteredList.length} college\${filteredList.length !== 1 ? 's' : ''}`;

  if (!filteredList.length) {
    grid.innerHTML = ''; empty.classList.add('show'); return;
  }
  empty.classList.remove('show');

  grid.innerHTML = filteredList.map(c => {
    const isSaved = saved.has(c.id);
    const isTop = c.rank <= 10;
    const stars = '★'.repeat(Math.round(c.rating));
    return `
    <div class="college-card \${isSaved ? 'saved' : ''}" id="card_\${c.id}">
      <div class="college-rank \${isTop ? 'top' : ''}">#\${c.rank} NIRF</div>
      <div class="college-main">
        <a href="/college/\${c.id}" style="text-decoration:none; color:inherit; display:block; cursor:pointer;">
          <div class="college-name" style="color:var(--navy); transition:color 0.2s;" onmouseover="this.style.color='var(--sky)'" onmouseout="this.style.color='var(--navy)'">\${c.name}</div>
          <div class="college-location">📍 \${c.city}, \${c.state}</div>
          <div class="college-tags">
            <span class="ctag ctag-type">\${c.type}</span>
            <span class="ctag ctag-stream">\${c.stream}</span>
            <span class="ctag ctag-exam">\${c.exam}</span>
          </div>
          <div class="college-stats">
            <div class="stat-item">
              <div class="stat-val">\${fmtFees(c.fees)}</div>
              <div class="stat-key">Annual Fees</div>
            </div>
            <div class="stat-item">
              <div class="stat-val">\${c.cutoff}%</div>
              <div class="stat-key">Cut-off</div>
            </div>
            <div class="stat-item">
              <div class="stat-val">\${c.rating}/5</div>
              <div class="stat-key">Rating</div>
            </div>
          </div>
        </a>
      </div>
      <div class="college-actions">
        <div class="rating-badge">★ \${c.rating}</div>
        <button class="btn-save \${isSaved ? 'btn-save-filled' : 'btn-save-outline'}"
          onclick="toggleSave(\${c.id})">
          \${isSaved ? 'âœ“ Saved' : '+ Save'}
        </button>
      </div>
    </div>`;
  }).join('');
}

async function toggleSave(id) {
  const wasSaved = saved.has(id);
  if (wasSaved) saved.delete(id);
  else saved.add(id);

  try {
    const res = await fetch('/api/colleges/save', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ collegeId: id })
    });
    if (res.status === 401) {
      if (wasSaved) saved.add(id); else saved.delete(id);
      alert('Please log in to save colleges.');
      window.location.href = '/login?next=/colleges';
      return;
    }
    if (!res.ok) {
      if (wasSaved) saved.add(id); else saved.delete(id);
      alert('Could not update saved list. Please try again.');
    }
  } catch (e) {
    if (wasSaved) saved.add(id); else saved.delete(id);
    alert('Network error while saving college.');
  }
  const chip = document.getElementById('savedChip');
  chip.textContent = saved.size + ' saved';
  chip.style.display = saved.size ? 'inline-flex' : 'none';
  renderCards();
}

function clearFilters() {
  document.getElementById('searchInput').value = '';
  document.getElementById('fState').value  = '';
  document.getElementById('fStream').value = '';
  document.getElementById('fType').value   = '';
  document.getElementById('fFees').value   = 2000000;
  document.getElementById('fCutoff').value = 50;
  document.getElementById('fRank').value   = '';
  document.querySelectorAll('.fExam').forEach(e => e.checked = false);
  updateFeesLabel(); updateCutoffLabel();
  applyFilters();
}

// Init
const chip = document.getElementById('savedChip');
chip.textContent = saved.size + ' saved';
chip.style.display = saved.size ? 'inline-flex' : 'none';
applyFilters();
</script>

</body>
</html>

