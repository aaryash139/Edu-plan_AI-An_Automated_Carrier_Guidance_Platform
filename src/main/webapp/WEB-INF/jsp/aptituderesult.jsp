<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width,initial-scale=1"/>
<title>Your Result — EduPath</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700&family=DM+Serif+Display:ital@0;1&display=swap" rel="stylesheet"/>
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
:root{
  --navy:#0d1b2a;--blue:#1a5f9c;--sky:#3a9fd6;--accent:#f4a825;
  --light:#f0f6fc;--white:#fff;--text:#1e2d3d;--muted:#6b849a;
  --border:#d5e5f0;--success:#2e9b6e;
}
body{font-family:'Sora',sans-serif;background:var(--light);color:var(--text);min-height:100vh;padding:2rem 1rem;}
.container{max-width:860px;margin:0 auto;}

/* ── HERO BANNER ── */
.hero{
  background:linear-gradient(135deg,var(--navy),var(--blue));
  border-radius:20px;padding:2.5rem 2rem;color:white;
  display:flex;align-items:center;justify-content:space-between;
  gap:1.5rem;flex-wrap:wrap;margin-bottom:2rem;
  position:relative;overflow:hidden;
}
.hero::after{
  content:'';position:absolute;right:-80px;top:-80px;
  width:260px;height:260px;border-radius:50%;
  background:radial-gradient(circle,rgba(255,255,255,0.06) 0%,transparent 70%);
}
.hero-tag{font-size:0.7rem;font-weight:700;letter-spacing:.1em;text-transform:uppercase;color:var(--sky);margin-bottom:.4rem;}
.hero-title{font-family:'DM Serif Display',serif;font-size:2rem;margin-bottom:.5rem;}
.hero-sub{font-size:.85rem;color:rgba(255,255,255,.55);line-height:1.6;max-width:420px;}
.hero-score{text-align:right;flex-shrink:0;}
.score-num{font-family:'DM Serif Display',serif;font-size:3.5rem;color:var(--accent);line-height:1;}
.score-lbl{font-size:.72rem;color:rgba(255,255,255,.4);margin-top:4px;}

/* ── SECTION HEADS ── */
.section-title{
  font-size:.7rem;font-weight:700;letter-spacing:.1em;
  text-transform:uppercase;color:var(--muted);
  margin-bottom:1rem;margin-top:2rem;
}

/* ── COURSE CARDS (Class 12) ── */
.courses-grid{display:flex;flex-direction:column;gap:1rem;}
.course-card{
  background:var(--white);border:1.5px solid var(--border);
  border-radius:14px;padding:1.5rem;
  display:grid;grid-template-columns:1fr auto;gap:1rem;
  transition:box-shadow .2s,border-color .2s;
  cursor:default;
}
.course-card:hover{box-shadow:0 6px 28px rgba(13,27,42,.08);border-color:var(--sky);}
.course-card.top-pick{border-color:var(--accent);background:#fffdf5;}

.course-header{display:flex;align-items:center;gap:.75rem;margin-bottom:.5rem;}
.course-icon{
  width:38px;height:38px;border-radius:10px;
  background:linear-gradient(135deg,var(--sky),var(--blue));
  display:flex;align-items:center;justify-content:center;
  font-size:1rem;flex-shrink:0;
}
.course-name{font-size:1rem;font-weight:700;color:var(--navy);}
.course-dur{font-size:.72rem;color:var(--muted);margin-top:2px;}
.course-desc{font-size:.82rem;color:var(--muted);line-height:1.6;margin-bottom:.85rem;}
.course-reason{
  font-size:.78rem;color:var(--blue);
  background:rgba(58,159,214,.07);border-radius:8px;
  padding:.55rem .85rem;margin-bottom:.85rem;line-height:1.5;
  border-left:3px solid var(--sky);
}
.tag-row{display:flex;flex-wrap:wrap;gap:.4rem;}
.tag{font-size:.68rem;font-weight:600;padding:2px 9px;border-radius:20px;}
.t-blue {background:rgba(58,159,214,.1);color:var(--blue);}
.t-green{background:rgba(46,155,110,.1);color:var(--success);}
.t-amber{background:rgba(244,168,37,.12);color:#b07a00;}

.match-badge{
  align-self:flex-start;
  background:var(--navy);color:white;
  font-size:.72rem;font-weight:700;
  padding:4px 12px;border-radius:20px;white-space:nowrap;
}
.match-badge.high{background:var(--success);}
.match-badge.mid {background:var(--blue);}

.top-label{
  font-size:.65rem;font-weight:700;
  text-transform:uppercase;letter-spacing:.06em;
  color:var(--accent);margin-bottom:.25rem;
}

/* ── STREAM BANNER (Class 10) ── */
.stream-banner{
  background:var(--white);border:1.5px solid var(--border);
  border-radius:14px;padding:2rem;margin-bottom:2rem;
}
.stream-name{font-family:'DM Serif Display',serif;font-size:1.75rem;color:var(--navy);margin-bottom:.5rem;}
.stream-desc{font-size:.88rem;color:var(--muted);line-height:1.7;margin-bottom:1.25rem;}
.careers-row{display:flex;flex-wrap:wrap;gap:.5rem;}
.career-pill{font-size:.75rem;font-weight:600;padding:4px 12px;border-radius:20px;background:var(--light);color:var(--navy);border:1px solid var(--border);}

/* ── ACTIONS ── */
.actions{display:flex;gap:1rem;flex-wrap:wrap;margin-top:2rem;}
.btn-primary{
  background:var(--navy);color:white;text-decoration:none;
  padding:.75rem 1.75rem;border-radius:10px;
  font-size:.88rem;font-weight:600;transition:background .2s;
}
.btn-primary:hover{background:var(--blue);}
.btn-secondary{
  background:var(--white);color:var(--navy);text-decoration:none;
  padding:.75rem 1.75rem;border-radius:10px;border:1.5px solid var(--border);
  font-size:.88rem;font-weight:600;transition:all .2s;
}
.btn-secondary:hover{border-color:var(--sky);}

@media(max-width:560px){
  .hero{flex-direction:column;}
  .hero-score{text-align:left;}
  .course-card{grid-template-columns:1fr;}
}

/* AI Guidance Card Styling */
.ai-report-card {
  background: rgba(255, 255, 255, 0.75);
  border: 1.5px solid rgba(58, 159, 214, 0.25);
  backdrop-filter: blur(16px);
  border-radius: 18px;
  padding: 2.2rem;
  margin-top: 1.5rem;
  margin-bottom: 2rem;
  box-shadow: 0 10px 30px rgba(26, 95, 156, 0.08);
  position: relative;
  overflow: hidden;
  animation: slideInUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) both;
}
.ai-report-card::before {
  content: '';
  position: absolute;
  top: 0; left: 0; width: 6px; height: 100%;
  background: linear-gradient(to bottom, var(--sky), var(--blue));
}
.ai-report-card::after {
  content: '✦ AI';
  position: absolute;
  top: 1rem;
  right: 1.25rem;
  font-size: 0.72rem;
  font-weight: 700;
  text-transform: uppercase;
  color: var(--sky);
  letter-spacing: 0.1em;
  opacity: 0.8;
}
.ai-report-content {
  font-size: 0.9rem;
  line-height: 1.8;
  color: var(--text);
}
.ai-report-content h1, .ai-report-content h2, .ai-report-content h3 {
  font-family: 'DM Serif Display', serif;
  color: var(--navy);
  margin-top: 1.2rem;
  margin-bottom: 0.6rem;
}
.ai-report-content h3 {
  font-size: 1.15rem;
}
.ai-report-content h4 {
  font-size: 0.95rem;
  font-weight: 700;
  color: var(--blue);
  margin-top: 1rem;
  margin-bottom: 0.4rem;
}
.ai-report-content ul, .ai-report-content ol {
  margin-left: 1.5rem;
  margin-bottom: 1rem;
}
.ai-report-content li {
  margin-bottom: 0.45rem;
}
.ai-report-content strong {
  color: var(--navy);
  font-weight: 600;
}
.ai-report-content p {
  margin-bottom: 1rem;
}

@keyframes slideInUp {
  from {
    opacity: 0;
    transform: translateY(24px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

</style>
<script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>

</head>
<body>
<div class="container">

  <!-- ── SCORE HERO ── -->
  <div class="hero">
    <div>
      <div class="hero-tag">Aptitude Test Complete</div>
      <!-- Thymeleaf: user ka naam session se aata hai -->
      <div class="hero-title" id="heroTitle">Your Results Are Ready</div>
      <div class="hero-sub" id="heroSub">Based on your answers, here's what we recommend for you.</div>
    </div>
    <div class="hero-score">
      <div class="score-num" id="scoreNum">—</div>
      <div class="score-lbl">Aptitude Score / 10</div>
    </div>
  </div>

  <!-- ═══════════════════════════════════════
       CLASS 12 → COURSE RECOMMENDATIONS
       (shown via JS when result_type == "COURSES")
  ═══════════════════════════════════════ -->
  <div id="coursesSection" style="display:none;">
    <div class="section-title">Recommended Courses for You</div>
    <div class="courses-grid" id="coursesGrid">
      <!-- JS se dynamically populate hoga -->
    </div>
  </div>

  <!-- ═══════════════════════════════════════
       CLASS 10 → STREAM RECOMMENDATION
       (shown via JS when result_type == "STREAM")
  ═══════════════════════════════════════ -->
  <div id="streamSection" style="display:none;">
    <div class="section-title">Your Recommended Stream</div>
    <div class="stream-banner">
      <div class="stream-name" id="streamName">—</div>
      <div class="stream-desc" id="streamDesc">—</div>
      <div class="careers-row" id="streamCareers"></div>
    </div>
  </div>

  <!-- AI Career Guidance Report Section -->
  <div id="aiReportSection" style="display:none;">
    <div class="section-title">✨ AI-Powered Career Guidance Report</div>
    <div class="ai-report-card" id="aiReportCard">
      <div class="ai-report-content" id="aiReportContent"></div>
    </div>
  </div>

  <!-- ── ACTION BUTTONS ── -->
  <div class="actions">
    <a href="/colleges" id="exploreCollegesBtn" class="btn-primary" style="display:none;">Explore Matching Colleges →</a>
    <a href="/dashboard"  class="btn-secondary">Go to Dashboard</a>
    <a href="/aptitude-test" class="btn-secondary">Retake Test</a>
  </div>

</div>

<script>
// ──────────────────────────────────────────────────────────
//  Yeh page /api/aptitude/submit ka response parse karta hai
//  jo session storage mein save kiya gaya hai aptitude-test.html se
//
//  Flow:
//    aptitude-test.html → POST /api/aptitude/submit
//                       → response sessionStorage mein save karo
//                       → redirect karo /aptitude-result
//    aptitude-result.html → sessionStorage se result read karo
//                         → result_type check karo
//                         → "COURSES" → showCourses()
//                         → "STREAM"  → showStream()
// ──────────────────────────────────────────────────────────

const STREAM_DATA = {
  PCM: {
    name: 'Science (PCM)',
    desc: 'Physics, Chemistry, and Mathematics — the gateway to engineering and technology. Your analytical and logical thinking skills will shine here.',
    careers: ['Engineering', 'Computer Science', 'Data Science', 'Research', 'Architecture']
  },
  COMM: {
    name: 'Commerce',
    desc: 'Accounting, Economics, and Business Studies — the best path for building a career in the finance and management sectors.',
    careers: ['CA', 'MBA', 'Banking', 'Finance', 'Entrepreneurship']
  },
  ARTS: {
    name: 'Arts / Humanities',
    desc: 'History, Political Science, and Psychology — an excellent platform to advance in creative fields and social sciences.',
    careers: ['Law', 'Civil Services', 'Psychology', 'Journalism', 'Design']
  }
};

const CATEGORY_ICONS = {
  'Engineering':        '⚙️',
  'Computer Science':   '💻',
  'Pure Science':       '🔬',
  'Medical':            '🏥',
  'Pharmacy':           '💊',
  'Medical Allied':     '🩺',
  'Life Sciences':      '🧬',
  'Finance & Accounting':'📊',
  'Management':         '📈',
  'Commerce':           '🏦',
  'Finance':            '💰',
  'Law':                '⚖️',
  'Social Sciences':    '🌍',
  'Media & Communication':'📰',
  'Design & Arts':      '🎨',
};

function init() {
  let result;
  try {
    const raw = sessionStorage.getItem('aptitudeResult');
    if (!raw) {
      window.location.href = '/aptitude-test';
      return;
    }
    result = JSON.parse(raw);
  } catch(e) {
    result = null;
  }

  if (!result) {
    document.getElementById('heroSub').textContent = 'Result load nahi hua. Dobara test lo.';
    return;
  }

  // Score set karo
  document.getElementById('scoreNum').textContent = result.aptitude_score ?? '—';

  if (result.result_type === 'COURSES') {
    // ── Class 12 ──
    document.getElementById('heroTitle').textContent = 'Your Course Recommendations';
    document.getElementById('heroSub').textContent =
      'Class 12 ke baad in courses mein tum best perform kar sakte ho — based on your aptitude.';
    showCourses(result.courses || []);
  } else {
    // ── Class 10 ──
    document.getElementById('heroTitle').textContent = 'Your Recommended Stream';
    document.getElementById('heroSub').textContent =
      'Class 10 ke baad yeh stream tumhare liye most suitable hai.';
    showStream(result.recommendation);
  }

  // Show Gemini AI counseling advice if available
  if (result.gemini_recommendation) {
    document.getElementById('aiReportSection').style.display = 'block';
    const reportContentEl = document.getElementById('aiReportContent');
    if (typeof marked !== 'undefined' && typeof marked.parse === 'function') {
      reportContentEl.innerHTML = marked.parse(result.gemini_recommendation);
    } else {
      let formattedText = result.gemini_recommendation
        .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
        .replace(/\*(.*?)\*/g, '<em>$1</em>')
        .replace(/\n/g, '<br>');
      reportContentEl.innerHTML = formattedText;
    }
  }
}

function showCourses(courses) {
  document.getElementById('coursesSection').style.display = 'block';
  document.getElementById('exploreCollegesBtn').style.display = 'inline-block';
  const grid = document.getElementById('coursesGrid');
  grid.innerHTML = '';

  courses.forEach((c, i) => {
    const isTop = i === 0;
    const score = c.match_score ?? 0;
    const badgeClass = score >= 80 ? 'high' : score >= 65 ? 'mid' : '';
    const icon = CATEGORY_ICONS[c.category] || '📚';

    grid.innerHTML += `
      <div class="course-card ${isTop ? 'top-pick' : ''}">
        <div>
          ${isTop ? '<div class="top-label">⭐ Best Match for You</div>' : ''}
          <div class="course-header">
            <div class="course-icon">${icon}</div>
            <div>
              <div class="course-name">${c.name}</div>
              <div class="course-dur">${c.duration} · ${c.category}</div>
            </div>
          </div>
          <div class="course-desc">${c.description}</div>
          <div class="course-reason">💡 ${c.match_reason}</div>
          <div class="tag-row">
            ${(c.exams || []).map(e => `<span class="tag t-amber">📝 ${e}</span>`).join('')}
            ${(c.careers || []).slice(0,3).map(cr => `<span class="tag t-green">→ ${cr}</span>`).join('')}
          </div>
        </div>
        <div>
          <div class="match-badge ${badgeClass}">${score}% match</div>
        </div>
      </div>`;
  });
}

function showStream(rec) {
  document.getElementById('streamSection').style.display = 'block';
  const data = STREAM_DATA[rec] || STREAM_DATA['PCM'];
  document.getElementById('streamName').textContent    = data.name;
  document.getElementById('streamDesc').textContent    = data.desc;
  document.getElementById('streamCareers').innerHTML   =
    data.careers.map(c => `<span class="career-pill">${c}</span>`).join('');
}

init();
</script>

</body>
</html>