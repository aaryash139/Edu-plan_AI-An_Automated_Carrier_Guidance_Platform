<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Aptitude Test — EduPath</title>
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
      --error:  #e53935;
      --success:#2e9b6e;
      --pcm:    #3a9fd6;
      --comm:   #f4a825;
      --arts:   #9b5de5;
    }

    body {
      font-family: 'Sora', sans-serif;
      background: var(--light);
      color: var(--text);
      min-height: 100vh;
      display: flex; flex-direction: column;
    }

    /* NAV */
    nav {
      display: flex; align-items: center; justify-content: space-between;
      padding: 0 5%; height: 80px;
      background: rgba(255,255,255,0.92);
      backdrop-filter: blur(12px);
      border-bottom: 1px solid var(--border);
      position: sticky; top: 0; z-index: 50;
    }
    .nav-logo { font-family: 'DM Serif Display', serif; font-size: 2.2rem; letter-spacing: -0.5px; color: var(--navy); text-decoration: none; }
    .nav-logo span { color: var(--sky); }
    .nav-right { display: flex; align-items: center; gap: 1.5rem; }
    .timer-box {
      display: flex; align-items: center; gap: 0.5rem;
      background: var(--navy); color: var(--white);
      padding: 0.4rem 1rem; border-radius: 20px;
      font-size: 0.88rem; font-weight: 600;
    }
    .timer-box.warning { background: var(--accent); color: var(--navy); }
    .timer-box.danger  { background: var(--error); animation: pulse 1s infinite; }
    @keyframes pulse { 0%,100%{opacity:1} 50%{opacity:0.7} }
    .nav-progress-text { font-size: 0.8rem; color: var(--muted); }

    /* SCREENS */
    .screen { display: none; }
    .screen.active { display: block; animation: fadeUp 0.4s ease; }
    @keyframes fadeUp { from{opacity:0;transform:translateY(16px)} to{opacity:1;transform:translateY(0)} }

    /* ── INTRO SCREEN ── */
    .intro-wrap {
      max-width: 700px; margin: 0 auto;
      padding: 4rem 2rem;
    }
    .intro-tag { font-size: 0.75rem; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase; color: var(--sky); margin-bottom: 1rem; }
    .intro-wrap h1 { font-family: 'DM Serif Display', serif; font-size: 2.4rem; color: var(--navy); margin-bottom: 1rem; line-height: 1.2; }
    .intro-wrap h1 em { font-style: italic; color: var(--sky); }
    .intro-wrap p { font-size: 0.95rem; color: var(--muted); line-height: 1.75; margin-bottom: 2rem; }

    .level-cards { display: grid; grid-template-columns: repeat(3, 1fr); gap: 1rem; margin-bottom: 2.5rem; }
    .level-card {
      background: var(--white); border: 1px solid var(--border);
      border-radius: 12px; padding: 1.25rem;
      text-align: center;
    }
    .lc-icon { font-size: 1.8rem; margin-bottom: 0.5rem; }
    .lc-title { font-size: 0.85rem; font-weight: 700; color: var(--navy); margin-bottom: 0.25rem; }
    .lc-sub { font-size: 0.75rem; color: var(--muted); line-height: 1.5; }
    .lc-badge {
      display: inline-block; margin-top: 0.6rem;
      font-size: 0.7rem; font-weight: 600; padding: 2px 10px;
      border-radius: 20px;
    }
    .badge-blue  { background: rgba(58,159,214,0.12); color: var(--sky); }
    .badge-amber { background: rgba(244,168,37,0.15); color: #b07a00; }
    .badge-purple{ background: rgba(155,93,229,0.12); color: #7c3aed; }

    .rules-box {
      background: var(--white); border: 1px solid var(--border);
      border-radius: 12px; padding: 1.5rem; margin-bottom: 2rem;
    }
    .rules-box h3 { font-size: 0.9rem; font-weight: 700; color: var(--navy); margin-bottom: 0.75rem; }
    .rules-list { list-style: none; display: flex; flex-direction: column; gap: 0.5rem; }
    .rules-list li { font-size: 0.83rem; color: var(--muted); display: flex; gap: 0.6rem; align-items: flex-start; }
    .rules-list li::before { content: '→'; color: var(--sky); font-weight: 700; flex-shrink: 0; }

    .btn-start {
      display: inline-block; background: var(--navy); color: var(--white);
      padding: 0.9rem 2.5rem; border-radius: 8px;
      font-size: 1rem; font-weight: 600; border: none; cursor: pointer;
      transition: background 0.2s, transform 0.15s;
    }
    .btn-start:hover { background: var(--blue); transform: translateY(-2px); }

    /* ── QUIZ SCREEN ── */
    .quiz-wrap { 
      max-width: 1200px; margin: 0 auto; padding: 2.5rem 2rem; 
      display: flex; gap: 2.5rem; align-items: flex-start; flex-direction: column;
    }
    @media(min-width: 900px) {
      .quiz-wrap { flex-direction: row; }
    }
    .quiz-left { flex: 1; min-width: 0; width: 100%; }
    .quiz-right { 
      width: 100%; background: var(--white); border: 1px solid var(--border); 
      border-radius: 12px; padding: 1.5rem; 
    }
    @media(min-width: 900px) {
      .quiz-right { width: 340px; flex-shrink: 0; position: sticky; top: 2rem; }
    }
    .palette-title { font-size: 1.1rem; color: var(--navy); margin-bottom: 1rem; border-bottom: 1px solid var(--border); padding-bottom: 0.8rem; font-weight: 600; }
    .palette-legend { margin-top: 1.5rem; display: flex; flex-direction: column; gap: 0.8rem; font-size: 0.85rem; color: var(--text); }
    .legend-item { display: flex; align-items: center; gap: 0.6rem; }

    .level-header {
      display: flex; align-items: center; gap: 1rem;
      margin-bottom: 1.5rem; padding: 1rem 1.25rem;
      border-radius: 12px; border: 1px solid;
    }
    .lh-icon { font-size: 1.6rem; }
    .lh-title { font-size: 0.95rem; font-weight: 700; }
    .lh-sub { font-size: 0.78rem; margin-top: 2px; }
    .lh-l1 { background: rgba(58,159,214,0.07); border-color: rgba(58,159,214,0.25); }
    .lh-l1 .lh-title { color: var(--sky); }
    .lh-l1 .lh-sub { color: var(--muted); }
    .lh-l2 { background: rgba(244,168,37,0.07); border-color: rgba(244,168,37,0.3); }
    .lh-l2 .lh-title { color: #b07a00; }
    .lh-l2 .lh-sub { color: var(--muted); }
    .lh-l3 { background: rgba(155,93,229,0.07); border-color: rgba(155,93,229,0.25); }
    .lh-l3 .lh-title { color: #7c3aed; }
    .lh-l3 .lh-sub { color: var(--muted); }

    .progress-track { height: 6px; background: var(--border); border-radius: 10px; margin-bottom: 0.5rem; overflow: hidden; }
    .progress-fill { height: 100%; border-radius: 10px; background: var(--sky); transition: width 0.4s ease; }
    .progress-label { display: flex; justify-content: space-between; font-size: 0.75rem; color: var(--muted); margin-bottom: 2rem; }

    .q-card {
      background: var(--white); border: 1px solid var(--border);
      border-radius: 16px; padding: 2rem;
      box-shadow: 0 4px 20px rgba(13,27,42,0.06);
    }
    .q-meta { display: flex; align-items: center; gap: 0.6rem; margin-bottom: 1.25rem; }
    .q-num { font-size: 0.75rem; font-weight: 700; color: var(--muted); }
    .q-level-tag {
      font-size: 0.68rem; font-weight: 700; letter-spacing: 0.06em;
      text-transform: uppercase; padding: 2px 8px; border-radius: 20px;
    }
    .tag-l1 { background: rgba(58,159,214,0.12); color: var(--sky); }
    .tag-l2 { background: rgba(244,168,37,0.15); color: #b07a00; }
    .tag-l3 { background: rgba(155,93,229,0.12); color: #7c3aed; }

    .q-text {
      font-size: 1.05rem; font-weight: 600; color: var(--navy);
      line-height: 1.6; margin-bottom: 1.75rem;
    }

    .options { display: flex; flex-direction: column; gap: 0.75rem; }
    .option {
      display: flex; align-items: flex-start; gap: 1rem;
      padding: 0.9rem 1rem; border-radius: 10px;
      border: 1.5px solid var(--border);
      cursor: pointer; transition: all 0.18s;
      background: var(--white);
    }
    .option:hover { border-color: var(--sky); background: #f0f8ff; }
    .option.selected { border-color: var(--sky); background: rgba(58,159,214,0.08); }
    .option.correct  { border-color: var(--success); background: rgba(46,155,110,0.08); }
    .option.wrong    { border-color: var(--error);   background: rgba(229,57,53,0.07); }
    .option.disabled { cursor: default; }

    .opt-letter {
      width: 28px; height: 28px; border-radius: 50%; flex-shrink: 0;
      display: flex; align-items: center; justify-content: center;
      font-size: 0.75rem; font-weight: 700;
      background: var(--light); color: var(--muted);
      border: 1.5px solid var(--border);
      transition: all 0.18s;
    }
    .option.selected .opt-letter { background: var(--sky); color: white; border-color: var(--sky); }
    .option.correct  .opt-letter { background: var(--success); color: white; border-color: var(--success); }
    .option.wrong    .opt-letter { background: var(--error); color: white; border-color: var(--error); }
    .opt-text { font-size: 0.9rem; color: var(--text); line-height: 1.5; padding-top: 3px; }

    .q-feedback {
      margin-top: 1rem; padding: 0.75rem 1rem;
      border-radius: 8px; font-size: 0.82rem; font-weight: 600;
      display: none;
    }
    .q-feedback.show { display: block; }
    .fb-correct { background: rgba(46,155,110,0.1); color: #166534; border: 1px solid rgba(46,155,110,0.25); }
    .fb-wrong   { background: rgba(229,57,53,0.08); color: #b91c1c; border: 1px solid rgba(229,57,53,0.2); }
    .fb-info    { background: rgba(58,159,214,0.08); color: var(--blue); border: 1px solid rgba(58,159,214,0.2); }

    .q-nav { display: flex; justify-content: space-between; align-items: center; margin-top: 1.75rem; }
    .btn-nav-q {
      padding: 0.75rem 1.75rem; border-radius: 8px;
      font-family: 'Sora', sans-serif; font-size: 0.88rem; font-weight: 600;
      cursor: pointer; transition: all 0.2s;
    }
    .btn-prev { background: transparent; border: 1.5px solid var(--border); color: var(--muted); }
    .btn-prev:hover { border-color: var(--navy); color: var(--navy); }
    .btn-prev:disabled { opacity: 0.4; cursor: default; }
    .btn-next { background: var(--navy); border: none; color: white; }
    .btn-next:hover { background: var(--blue); transform: translateY(-1px); }
    .btn-next:disabled { background: var(--muted); cursor: default; transform: none; }

    .q-map { display: flex; flex-wrap: wrap; gap: 6px; margin-top: 1.5rem; }
    .q-dot {
      width: 28px; height: 28px; border-radius: 6px;
      display: flex; align-items: center; justify-content: center;
      font-size: 0.7rem; font-weight: 600; cursor: pointer;
      border: 1.5px solid var(--border); color: var(--muted);
      background: var(--white); transition: all 0.15s;
    }
    .q-dot.answered { background: var(--sky); border-color: var(--sky); color: white; }
    .q-dot.current  { border-color: var(--navy); color: var(--navy); font-weight: 700; }
    .q-dot.correct  { background: var(--success); border-color: var(--success); color: white; }
    .q-dot.wrong    { background: var(--error); border-color: var(--error); color: white; }

    /* ── RESULT SCREEN ── */
    .result-wrap { max-width: 720px; margin: 0 auto; padding: 3rem 2rem; }
    .result-wrap h1 { font-family: 'DM Serif Display', serif; font-size: 2.2rem; color: var(--navy); margin-bottom: 0.5rem; }
    .result-wrap h1 em { font-style: italic; color: var(--sky); }
    .result-sub { font-size: 0.95rem; color: var(--muted); margin-bottom: 2.5rem; line-height: 1.7; }

    .rec-card {
      border-radius: 16px; padding: 2rem;
      margin-bottom: 2rem; position: relative; overflow: hidden;
      border: 1px solid;
    }
    .rec-tag { font-size: 0.72rem; font-weight: 700; letter-spacing: 0.1em; text-transform: uppercase; margin-bottom: 0.75rem; }
    .rec-stream { font-family: 'DM Serif Display', serif; font-size: 2rem; margin-bottom: 0.5rem; }
    .rec-desc { font-size: 0.9rem; line-height: 1.7; margin-bottom: 1.25rem; }
    .rec-careers { display: flex; flex-wrap: wrap; gap: 0.5rem; }
    .career-pill { font-size: 0.75rem; font-weight: 600; padding: 0.3rem 0.9rem; border-radius: 20px; }
    .rec-big { position: absolute; bottom: -1rem; right: 1rem; font-size: 7rem; opacity: 0.06; font-family: 'DM Serif Display', serif; }

    .rec-pcm   { background: linear-gradient(135deg, #e8f4fd, #d0eaf9); border-color: #b8dcf0; }
    .rec-pcm   .rec-tag { color: var(--blue); }
    .rec-pcm   .rec-stream { color: var(--navy); }
    .rec-pcm   .rec-desc { color: var(--muted); }
    .rec-pcm   .career-pill { background: rgba(58,159,214,0.12); color: var(--blue); }

    .rec-comm  { background: linear-gradient(135deg, #fef4e0, #fde8b5); border-color: #f5d580; }
    .rec-comm  .rec-tag { color: #b07a00; }
    .rec-comm  .rec-stream { color: var(--navy); }
    .rec-comm  .rec-desc { color: var(--muted); }
    .rec-comm  .career-pill { background: rgba(244,168,37,0.15); color: #b07a00; }

    .rec-arts  { background: linear-gradient(135deg, #f3eefe, #e8d9fc); border-color: #d0b8f5; }
    .rec-arts  .rec-tag { color: #7c3aed; }
    .rec-arts  .rec-stream { color: var(--navy); }
    .rec-arts  .rec-desc { color: var(--muted); }
    .rec-arts  .career-pill { background: rgba(155,93,229,0.12); color: #7c3aed; }

    .score-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 1rem; margin-bottom: 2rem; }
    .score-card {
      background: var(--white); border: 1px solid var(--border);
      border-radius: 12px; padding: 1.25rem; text-align: center;
    }
    .score-num { font-family: 'DM Serif Display', serif; font-size: 2rem; margin-bottom: 0.25rem; }
    .score-label { font-size: 0.75rem; color: var(--muted); }

    .personality-row {
      background: var(--white); border: 1px solid var(--border);
      border-radius: 12px; padding: 1.5rem; margin-bottom: 2rem;
    }
    .personality-row h3 { font-size: 0.9rem; font-weight: 700; color: var(--navy); margin-bottom: 1rem; }
    .trait-bar { margin-bottom: 0.9rem; }
    .trait-label { display: flex; justify-content: space-between; font-size: 0.8rem; color: var(--text); margin-bottom: 0.4rem; font-weight: 600; }
    .trait-track { height: 8px; background: var(--border); border-radius: 10px; overflow: hidden; }
    .trait-fill { height: 100%; border-radius: 10px; transition: width 1s ease; }

    .result-actions { display: flex; gap: 1rem; flex-wrap: wrap; }
    .btn-action {
      padding: 0.85rem 1.75rem; border-radius: 8px;
      font-family: 'Sora', sans-serif; font-size: 0.9rem; font-weight: 600;
      cursor: pointer; text-decoration: none; display: inline-block;
      transition: all 0.2s;
    }
    .btn-primary-r { background: var(--navy); color: white; border: none; }
    .btn-primary-r:hover { background: var(--blue); transform: translateY(-1px); }
    .btn-outline-r { background: transparent; border: 1.5px solid var(--navy); color: var(--navy); }
    .btn-outline-r:hover { background: var(--navy); color: white; }

    @media (max-width: 600px) {
      .level-cards { grid-template-columns: 1fr; }
      .score-grid  { grid-template-columns: 1fr 1fr; }
      .q-card { padding: 1.25rem; }
    }
  
</style>

</head>
<nav>
  <a class="nav-logo" href="/">Edu<span>Path</span></a>
  <div class="nav-right">
    <span class="nav-progress-text" id="navProgress"></span>
    <div class="timer-box" id="timerBox">⏱ <span id="timerDisplay">00:30</span></div>
    
  </div>
</nav>

<!-- ══ INTRO SCREEN ══ -->
<div class="screen active" id="screenIntro">
  <div class="intro-wrap">
    <div class="intro-tag">Aptitude Assessment</div>
    <h1>Discover your <em>ideal career path</em></h1>
    <p>Answer 30 questions across 3 levels designed to map your interests, logical aptitude, and personality traits. Your results will recommend the best academic stream for you.</p>

    <div class="level-cards">
      <div class="level-card">
        <div class="lc-icon">🎯</div>
        <div class="lc-title">Level 1 — Interest</div>
        <div class="lc-sub">10 questions exploring your natural curiosity and preferences</div>
        <span class="lc-badge badge-blue">No right/wrong</span>
      </div>
      <div class="level-card">
        <div class="lc-icon">🧠</div>
        <div class="lc-title">Level 2 — Aptitude</div>
        <div class="lc-sub">10 questions testing logic, math, and verbal reasoning</div>
        <span class="lc-badge badge-amber">Scored</span>
      </div>
      <div class="level-card">
        <div class="lc-icon">🧩</div>
        <div class="lc-title">Level 3 — Personality</div>
        <div class="lc-sub">10 questions understanding how you think and work</div>
        <span class="lc-badge badge-purple">No right/wrong</span>
      </div>
    </div>

    <div class="rules-box">
      <h3>Before you begin</h3>
      <ul class="rules-list">
        <li>Each question has a <strong>strict time limit</strong> (30s or 60s).</li>
        <li>Level 1 & 3 have no right or wrong answers — just pick what feels most like you.</li>
        <li>Level 2 is scored — each correct answer adds to your aptitude score.</li>
        <li>The timer pauses if you jump to another question via the palette.</li>
        <li>Your results will appear immediately after submission.</li>
      </ul>
    </div>

    <%-- BUG FIX: onclick="startTest()" — correct function name, no extra braces --%>
    <button class="btn-start" onclick="startTest()">Start Assessment →</button>
  </div>
</div>

<!-- ══ QUIZ SCREEN ══ -->
<div class="screen" id="screenQuiz">
  <div class="quiz-wrap">

    <div class="quiz-left">
      <div class="level-header lh-l1" id="levelHeader">
        <div class="lh-icon" id="lvlIcon">🎯</div>
        <div>
          <div class="lh-title" id="lvlTitle">Level 1 — Interest Mapping</div>
          <div class="lh-sub" id="lvlSub">Choose the option that feels most natural to you</div>
        </div>
      </div>

      <div class="progress-track"><div class="progress-fill" id="progressFill" style="width:0%"></div></div>
      <div class="progress-label">
        <span id="progressLabel">Question 1 of 30</span>
        <span id="answeredLabel">0 answered</span>
      </div>

      <div class="q-card">
        <div class="q-meta">
          <span class="q-num" id="qNum">Q1</span>
          <span class="q-level-tag tag-l1" id="qTag">Interest</span>
        </div>
        <div class="q-text" id="qText"></div>
        <div class="options" id="optionsContainer"></div>
        <div class="q-feedback" id="qFeedback"></div>
      </div>

      <div class="q-nav">
        <button class="btn-nav-q btn-prev" id="btnPrev" onclick="prevQ()" disabled>← Previous</button>
        <button class="btn-nav-q btn-next" id="btnNext" onclick="nextQ()">Next →</button>
      </div>
    </div>

    <div class="quiz-right">
      <h3 class="palette-title">Question Palette</h3>
      <div class="q-map" id="qMap" style="margin-top:0;"></div>
      
      <div class="palette-legend">
        <div class="legend-item">
          <div class="q-dot answered" style="width:22px; height:22px;"></div> Answered
        </div>
        <div class="legend-item">
          <div class="q-dot" style="width:22px; height:22px;"></div> Not Answered
        </div>
        <div class="legend-item">
          <div class="q-dot current" style="width:22px; height:22px;"></div> Current
        </div>
      </div>
      
      <button class="btn-end" onclick="submitTest()" style="width: 100%; margin-top: 2rem; display: block;">Submit Test</button>
    </div>

  </div>
</div>

<!-- ══ RESULT SCREEN ══ -->
<div class="screen" id="screenResult">
  <div class="result-wrap">
    <div class="intro-tag">Your Results</div>
    <h1>Your recommended <em>stream</em></h1>
    <p class="result-sub" id="resultSub"></p>

    <div class="rec-card" id="recCard">
      <div class="rec-tag"    id="recTag"></div>
      <div class="rec-stream" id="recStream"></div>
      <div class="rec-desc"   id="recDesc"></div>
      <div class="rec-careers" id="recCareers"></div>
      <div class="rec-big"    id="recBig"></div>
    </div>

    <div class="score-grid">
      <div class="score-card">
        <div class="score-num" id="scAptitude" style="color:var(--accent)">0/10</div>
        <div class="score-label">Aptitude Score</div>
      </div>
      <div class="score-card">
        <div class="score-num" id="scInterest" style="color:var(--sky)">—</div>
        <div class="score-label">Interest Area</div>
      </div>
      <div class="score-card">
        <div class="score-num" id="scPersonality" style="color:var(--arts)">—</div>
        <div class="score-label">Personality Type</div>
      </div>
    </div>

    <div class="personality-row">
      <h3>Your Profile Breakdown</h3>
      <div class="trait-bar">
        <div class="trait-label"><span>Analyst (PCM Leaning)</span><span id="pctAnalyst">0%</span></div>
        <div class="trait-track"><div class="trait-fill" id="barAnalyst" style="width:0%;background:var(--sky)"></div></div>
      </div>
      <div class="trait-bar">
        <div class="trait-label"><span>Leader (Commerce Leaning)</span><span id="pctLeader">0%</span></div>
        <div class="trait-track"><div class="trait-fill" id="barLeader" style="width:0%;background:var(--accent)"></div></div>
      </div>
      <div class="trait-bar">
        <div class="trait-label"><span>Humanist (Arts Leaning)</span><span id="pctHumanist">0%</span></div>
        <div class="trait-track"><div class="trait-fill" id="barHumanist" style="width:0%;background:var(--arts)"></div></div>
      </div>
    </div>

    <div class="result-actions">
      <a href="/colleges" class="btn-action btn-primary-r">Find Matching Colleges →</a>
      <button class="btn-action btn-outline-r" onclick="retakeTest()">Retake Test</button>
    </div>
  </div>
</div>

<script>
const questions = [
  // LEVEL 1 (Interest Mapping)
  { lvl:1, q:"You find a broken electronic device. What is your first instinct?", opts:["Open it up to see the parts and how they work.","Think about repair costs and if you can sell it.","Read about its history and who designed it."], tags:["PCM","COMM","ARTS"] },
  { lvl:1, q:"Your school is hosting a large fest. Which team do you want to lead?", opts:["Tech Team: Managing sound, lights, and apps.","Finance Team: Handling budget and sponsors.","Creative Team: Scripting, decoration, and hosting."], tags:["PCM","COMM","ARTS"] },
  { lvl:1, q:"While planning a trip with friends, what do you usually do?", opts:["Figure out the best routes and timings.","Collect money and manage the group budget.","Take photos and write about the experience."], tags:["PCM","COMM","ARTS"] },
  { lvl:1, q:"If you started a YouTube channel today, what would it be about?", opts:["Gadget reviews or coding tutorials.","Business tips and money management.","Vlogs, storytelling, or social issues."], tags:["PCM","COMM","ARTS"] },
  { lvl:1, q:"There is a water shortage in your society. How do you help?", opts:["Check the pipes and suggest a technical fix.","Organize a fund collection for water tankers.","Write a strong letter to the local authorities."], tags:["PCM","COMM","ARTS"] },
  { lvl:1, q:"Which gift would you be most excited to receive?", opts:["A DIY robotics kit or a cool gadget.","A book on how successful businesses are built.","A sketchbook or a famous fiction novel."], tags:["PCM","COMM","ARTS"] },
  { lvl:1, q:"Which section of the news interests you the most?", opts:["Technology, Space, and Science.","Business, Startups, and Market Trends.","Global Politics, Editorials, and Art."], tags:["PCM","COMM","ARTS"] },
  { lvl:1, q:"What does your dream workplace look like?", opts:["A high-tech lab with multiple screens.","A busy office with a great management team.","A creative studio full of art and ideas."], tags:["PCM","COMM","ARTS"] },
  { lvl:1, q:"Which books draw you in the most?", opts:["Physics, Mathematics, or Computer Science.","Management, Economics, or Accountancy.","Psychology, History, or Literature."], tags:["PCM","COMM","ARTS"] },
  { lvl:1, q:"What kind of video games do you prefer playing?", opts:["Logic and building games like Minecraft.","Management games like Business Tycoon.","Story-driven games with deep characters."], tags:["PCM","COMM","ARTS"] },

  // LEVEL 2 (Aptitude) - Ensuring 4 options for all
  { lvl:2, q:"Complete the sequence: 2, 6, 12, 20, ...?", opts:["26","28","30","32"], correct:"30" },
  { lvl:2, q:"A product costs ₹500. After a 20% discount, what is the final price?", opts:["₹380","₹400","₹420","₹450"], correct:"₹400" },
  { lvl:2, q:"'Stagnant' is to 'Flowing' as 'Static' is to:", opts:["Dynamic","Stable","Fixed","Motionless"], correct:"Dynamic" },
  { lvl:2, q:"If all A are B and all B are C, which statement is true?", opts:["All A are definitely C","Only some A are C","No A is C","Cannot be determined"], correct:"All A are definitely C" },
  { lvl:2, q:"If 'APPLE' is coded as 'ELPPA', how is 'JAVA' coded?", opts:["VAAJ","AAJV","AVAJ","JAAX"], correct:"AVAJ" },
  { lvl:2, q:"What is the probability of getting two 'Heads' in two coin tosses?", opts:["1/2","1/3","1/4","1/8"], correct:"1/4" },
  { lvl:2, q:"Which word does NOT belong in the group?", opts:["Jupiter","Mars","Moon","Venus"], correct:"Moon" },
  { lvl:2, q:"A car travels at 60 km/h. What distance does it cover in 15 minutes?", opts:["10 km","12 km","15 km","20 km"], correct:"15 km" },
  { lvl:2, q:"A woman says 'His mother is the daughter of my mother.' What is her relation to him?", opts:["Sister","Mother","Aunt","Grandmother"], correct:"Mother" },
  { lvl:2, q:"Complete the sequence: 1, 4, 9, 16, ...?", opts:["20","24","25","36"], correct:"25" },

  // LEVEL 3 (Personality) - Focused on school/teenage context
  { lvl:3, q:"Your school project is delayed. How do you fix it?", opts:["Figure out the technical errors and solve them.","Re-assign tasks to friends to finish faster.","Talk to the team and keep them stress-free."], tags:["Analyst","Leader","Humanist"] },
  { lvl:3, q:"In group assignments, what role do you naturally take?", opts:["The researcher who finds all the exact facts.","The leader who divides work and tracks progress.","The creative mind who designs the presentation."], tags:["Analyst","Leader","Humanist"] },
  { lvl:3, q:"How do you usually convince your friends about an idea?", opts:["Using logical points and solid proof.","Showing them how everyone benefits practically.","Understanding their feelings and persuading them."], tags:["Analyst","Leader","Humanist"] },
  { lvl:3, q:"What fascinates you the most?", opts:["How complex machines or software work.","How businesses make money and grow.","How human psychology and society work."], tags:["Analyst","Leader","Humanist"] },
  { lvl:3, q:"As a class monitor or team captain, what is your top priority?", opts:["Making sure the rules are logically followed.","Making sure tasks are done efficiently on time.","Making sure every student feels included."], tags:["Analyst","Leader","Humanist"] },
  { lvl:3, q:"Your school suddenly changes the syllabus. How do you react?", opts:["Analyze the new pattern and plan a study logic.","Find out how to maximize marks in the new system.","Help your classmates who are panicking."], tags:["Analyst","Leader","Humanist"] },
  { lvl:3, q:"What drives you to participate in competitions?", opts:["The challenge of solving hard problems.","The desire to win and get recognized.","The experience and meeting new people."], tags:["Analyst","Leader","Humanist"] },
  { lvl:3, q:"How do you prefer to learn a hard topic?", opts:["Experimenting and finding the logic myself.","Watching toppers' strategies and applying them.","Discussing and studying in a group."], tags:["Analyst","Leader","Humanist"] },
  { lvl:3, q:"How do you prefer to spend a free Sunday afternoon?", opts:["Trying out a new tech hobby or puzzle.","Planning out your goals for the coming week.","Hanging out with friends or helping someone."], tags:["Analyst","Leader","Humanist"] },
  { lvl:3, q:"What kind of person do you want to be known as?", opts:["An expert innovator or problem solver.","A successful leader or entrepreneur.","A creative thinker or helpful mentor."], tags:["Analyst","Leader","Humanist"] }
];

// ── State variables ──
let answers   = new Array(30).fill(null);
let current   = 0;
let timerInterval;
let timeRemaining = questions.map(q => q.lvl === 2 ? 60 : 30);

const levelInfo = {
  1: { cls:'lh-l1', icon:'🎯', title:'Level 1 — Interest Mapping',  sub:'Choose the option that feels most natural to you', tag:'Interest',    tagCls:'tag-l1' },
  2: { cls:'lh-l2', icon:'🧠', title:'Level 2 — Aptitude Test',     sub:'Pick the most logically correct answer',           tag:'Aptitude',    tagCls:'tag-l2' },
  3: { cls:'lh-l3', icon:'🧩', title:'Level 3 — Personality Profile',sub:'Choose the option that best describes you',       tag:'Personality', tagCls:'tag-l3' }
};
const letters = ['A','B','C','D'];

// ══════════════════════════════════════════
// BUG FIX 1 — startTest() was broken:
//   • Had wrong element IDs (intro-screen / quiz-screen)
//   • Had an extra closing brace } that closed the function too early
//   • startTimer() was never called, so timer never started
// ══════════════════════════════════════════
function startTest() {
  // Hide intro, show quiz — using the CORRECT element IDs
  document.getElementById('screenIntro').classList.remove('active');
  document.getElementById('screenQuiz').classList.add('active');

  // Build question map dots
  buildMap();

  // Render first question
  renderQ();

  // Start the 45-minute countdown timer
  startTimer();
}

function startTimer() {
  updateTimerDisplay();
  timerInterval = setInterval(function() {
    if (timeRemaining[current] > 0) {
      timeRemaining[current]--;
      updateTimerDisplay();
      if (timeRemaining[current] === 0) {
        lockAndAdvance();
      }
    }
  }, 1000);
}

function updateTimerDisplay() {
  var t = timeRemaining[current];
  var m = Math.floor(t / 60);
  var s = t % 60;
  document.getElementById('timerDisplay').textContent =
    (m < 10 ? '0' : '') + m + ':' + (s < 10 ? '0' : '') + s;

  var box = document.getElementById('timerBox');
  box.className = 'timer-box';
  if      (t <= 5)  box.classList.add('danger');
  else if (t <= 10) box.classList.add('warning');
}

function lockAndAdvance() {
  var fb = document.getElementById('qFeedback');
  fb.className = 'q-feedback show fb-wrong';
  fb.textContent = '⏱ Time is up for this question.';
  var cont = document.getElementById('optionsContainer');
  cont.querySelectorAll('.option').forEach(function(o){ o.classList.add('disabled'); });
  
  setTimeout(function() {
    if (current < 29) { nextQ(); }
  }, 1200);
}

function renderQ() {
  var q  = questions[current];
  var li = levelInfo[q.lvl];

  // Level header
  var lh = document.getElementById('levelHeader');
  lh.className = 'level-header ' + li.cls;
  document.getElementById('lvlIcon').textContent  = li.icon;
  document.getElementById('lvlTitle').textContent = li.title;
  document.getElementById('lvlSub').textContent   = li.sub;

  // Progress bar
  var pct = (current / 30) * 100;
  document.getElementById('progressFill').style.width = pct + '%';
  document.getElementById('progressLabel').textContent = 'Question ' + (current + 1) + ' of 30';
  var answered = answers.filter(function(a){ return a !== null; }).length;
  document.getElementById('answeredLabel').textContent = answered + ' answered';
  document.getElementById('navProgress').textContent   = (current + 1) + '/30';

  // Question meta
  document.getElementById('qNum').textContent  = 'Q' + (current + 1);
  document.getElementById('qTag').textContent  = li.tag;
  document.getElementById('qTag').className    = 'q-level-tag ' + li.tagCls;
  document.getElementById('qText').textContent = q.q;

  // Options
  var cont = document.getElementById('optionsContainer');
  cont.innerHTML = '';
  q.opts.forEach(function(opt, i) {
    var div       = document.createElement('div');
    div.className = 'option';
    div.id        = 'opt_' + i;
    div.innerHTML = '<div class="opt-letter">' + letters[i] + '</div><div class="opt-text">' + opt + '</div>';
    div.onclick   = (function(idx){ return function(){ selectOption(idx); }; })(i);
    cont.appendChild(div);
  });

  // Restore saved answer
  var saved = answers[current];
  var fb    = document.getElementById('qFeedback');
  fb.className  = 'q-feedback';
  fb.textContent = '';

  if (saved !== null) {
    var selDiv = document.getElementById('opt_' + saved);
    if (q.lvl === 2) {
      var isCorrect = (q.opts[saved] === q.correct);
      selDiv.classList.add(isCorrect ? 'correct' : 'wrong', 'disabled');
      if (!isCorrect) {
        var ci = q.opts.indexOf(q.correct);
        if (ci !== -1) document.getElementById('opt_' + ci).classList.add('correct', 'disabled');
        fb.className   = 'q-feedback show fb-wrong';
        fb.textContent = '✗ Incorrect. The correct answer is: ' + q.correct;
      } else {
        fb.className   = 'q-feedback show fb-correct';
        fb.textContent = '✓ Correct!';
      }
      cont.querySelectorAll('.option').forEach(function(o){ o.classList.add('disabled'); });
    } else {
      selDiv.classList.add('selected');
      fb.className   = 'q-feedback show fb-info';
      fb.textContent = 'Preference recorded. You can change your answer any time.';
    }
  } else if (timeRemaining[current] <= 0) {
    fb.className   = 'q-feedback show fb-wrong';
    fb.textContent = '⏱ Time is up for this question.';
    cont.querySelectorAll('.option').forEach(function(o){ o.classList.add('disabled'); });
  }

  // Prev / Next buttons
  document.getElementById('btnPrev').disabled = (current === 0);
  var nextBtn = document.getElementById('btnNext');
  if (current === 29) {
    nextBtn.textContent = 'Submit Test ✓';
    nextBtn.onclick = submitTest;
  } else {
    nextBtn.textContent = 'Next →';
    nextBtn.onclick = nextQ;
  }
  nextBtn.disabled = false;

  updateMap();
  updateTimerDisplay();
}

function selectOption(i) {
  if (timeRemaining[current] <= 0) return;
  var q = questions[current];
  if (q.lvl === 2 && answers[current] !== null) return; // lock Level 2 after first answer

  answers[current] = i;

  var cont = document.getElementById('optionsContainer');
  var fb   = document.getElementById('qFeedback');
  cont.querySelectorAll('.option').forEach(function(o){
    o.classList.remove('selected','correct','wrong');
  });

  if (q.lvl === 2) {
    var isCorrect = (q.opts[i] === q.correct);
    document.getElementById('opt_' + i).classList.add(isCorrect ? 'correct' : 'wrong', 'disabled');
    if (!isCorrect) {
      var ci = q.opts.indexOf(q.correct);
      if (ci !== -1) document.getElementById('opt_' + ci).classList.add('correct', 'disabled');
      fb.className   = 'q-feedback show fb-wrong';
      fb.textContent = '✗ Incorrect. The correct answer is: ' + q.correct;
    } else {
      fb.className   = 'q-feedback show fb-correct';
      fb.textContent = '✓ Correct!';
    }
    cont.querySelectorAll('.option').forEach(function(o){ o.classList.add('disabled'); });
  } else {
    document.getElementById('opt_' + i).classList.add('selected');
    fb.className   = 'q-feedback show fb-info';
    fb.textContent = 'Preference recorded. You can change your answer any time.';
  }
  updateMap();
}

function nextQ() {
  if (current < 29) { current++; renderQ(); window.scrollTo(0,0); }
}
function prevQ() {
  if (current > 0) { current--; renderQ(); window.scrollTo(0,0); }
}

function buildMap() {
  var map = document.getElementById('qMap');
  map.innerHTML = '';
  for (var i = 0; i < 30; i++) {
    var d       = document.createElement('div');
    d.className = 'q-dot';
    d.textContent = i + 1;
    d.id        = 'qdot_' + i;
    d.onclick   = (function(idx){ return function(){ current = idx; renderQ(); window.scrollTo(0,0); }; })(i);
    map.appendChild(d);
  }
}

function updateMap() {
  for (var i = 0; i < 30; i++) {
    var d = document.getElementById('qdot_' + i);
    d.className = 'q-dot';
    if (i === current) { d.classList.add('current'); continue; }
    if (answers[i] === null) continue;
    var q = questions[i];
    if (q.lvl === 2) {
      d.classList.add(q.opts[answers[i]] === q.correct ? 'correct' : 'wrong');
    } else {
      d.classList.add('answered');
    }
  }
}

async function submitTest() {
  clearInterval(timerInterval);

  var pcm=0, comm=0, arts=0;
  var analyst=0, leader=0, humanist=0;
  var aptScore=0;

  questions.forEach(function(q, i) {
    var a = answers[i];
    if (a === null) return;
    if (q.lvl === 1) {
      if (q.tags[a] === 'PCM')  pcm++;
      if (q.tags[a] === 'COMM') comm++;
      if (q.tags[a] === 'ARTS') arts++;
    }
    if (q.lvl === 2 && q.opts[a] === q.correct) aptScore++;
    if (q.lvl === 3) {
      if (q.tags[a] === 'Analyst')  analyst++;
      if (q.tags[a] === 'Leader')   leader++;
      if (q.tags[a] === 'Humanist') humanist++;
    }
  });

  var totalL1 = (pcm + comm + arts)       || 1;
  var totalL3 = (analyst + leader + humanist) || 1;
  var scorePCM  = (pcm/totalL1)*40  + (analyst/totalL3)*40  + (aptScore/10)*20;
  var scoreCOMM = (comm/totalL1)*40 + (leader/totalL3)*40   + ((10-aptScore)/10)*10;
  var scoreARTS = (arts/totalL1)*40 + (humanist/totalL3)*40;
  var max = Math.max(scorePCM, scoreCOMM, scoreARTS);
  var rec = (max === scorePCM) ? 'PCM' : (max === scoreCOMM) ? 'COMM' : 'ARTS';

  var maxP = Math.max(analyst, leader, humanist);
  var personality = (maxP === analyst) ? 'Analyst' : (maxP === leader) ? 'Leader' : 'Humanist';
  var maxI = Math.max(pcm, comm, arts);
  var interest = (maxI === pcm) ? 'Science & Tech' : (maxI === comm) ? 'Business & Finance' : 'Humanities & Arts';

  const payload = {
    level1: { pcm: pcm, comm: comm, arts: arts },
    level2: { aptitude_score: aptScore },
    level3: { analyst: analyst, leader: leader, humanist: humanist },
    meta: { total_questions: 30, answered: answers.filter(a => a !== null).length }
  };

  try {
    const apiRes = await fetch('/api/aptitude/submit', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload)
    });
    if (apiRes.ok) {
      const ai = await apiRes.json();
      sessionStorage.setItem('aptitudeResult', JSON.stringify(ai));
      window.location.href = '/aptitude-result';
      return;
    }
    if (apiRes.status === 401) {
      window.location.href = '/login?next=/aptitude-test';
      return;
    }
  } catch (e) { /* fall back to local result */ }

  showResult(rec, aptScore, interest, personality, analyst, leader, humanist, totalL3);
}

var recData = {
  PCM:  { cls:'rec-pcm',  tag:'Recommended Stream', stream:'Science (PCM)', big:'∑', desc:'Your logical aptitude, interest in technical systems, and analytical personality make Science with Physics, Chemistry & Math the perfect foundation for your future.', careers:['Engineering','Computer Science','Research','Architecture','Data Science','Defence'] },
  COMM: { cls:'rec-comm', tag:'Recommended Stream', stream:'Commerce',      big:'₹', desc:'Your leadership instincts, interest in markets and finance, and strategic personality type align strongly with the world of business and commerce.',              careers:['CA / CMA','MBA','Banking','Stock Market','Economics','Entrepreneurship'] },
  ARTS: { cls:'rec-arts', tag:'Recommended Stream', stream:'Arts / Humanities', big:'✦', desc:'Your humanist values, creative curiosity, and interest in people and society make Arts & Humanities a powerful path to create lasting impact.',               careers:['Law','Psychology','Journalism','Civil Services','Design','Education'] }
};

function showResult(rec, aptScore, interest, personality, analyst, leader, humanist, total) {
  document.getElementById('screenQuiz').classList.remove('active');
  document.getElementById('screenResult').classList.add('active');
  window.scrollTo(0,0);

  var rd   = recData[rec];
  var card = document.getElementById('recCard');
  card.className = 'rec-card ' + rd.cls;
  document.getElementById('recTag').textContent    = rd.tag;
  document.getElementById('recStream').textContent = rd.stream;
  document.getElementById('recDesc').textContent   = rd.desc;
  document.getElementById('recBig').textContent    = rd.big;

  var careers = document.getElementById('recCareers');
  careers.innerHTML = rd.careers.map(function(c){ return '<span class="career-pill">' + c + '</span>'; }).join('');

  document.getElementById('resultSub').textContent     = 'Based on your responses, ' + rd.stream + ' is your strongest match. Here\'s a full breakdown of your profile.';
  document.getElementById('scAptitude').textContent    = aptScore + '/10';
  document.getElementById('scInterest').textContent    = interest.split(' ')[0];
  document.getElementById('scPersonality').textContent = personality;

  setTimeout(function() {
    var ap = Math.round((analyst  / total) * 100);
    var lp = Math.round((leader   / total) * 100);
    var hp = Math.round((humanist / total) * 100);
    document.getElementById('barAnalyst').style.width   = ap + '%';
    document.getElementById('barLeader').style.width    = lp + '%';
    document.getElementById('barHumanist').style.width  = hp + '%';
    document.getElementById('pctAnalyst').textContent   = ap + '%';
    document.getElementById('pctLeader').textContent    = lp + '%';
    document.getElementById('pctHumanist').textContent  = hp + '%';
  }, 300);

  document.getElementById('timerBox').style.display    = 'none';
  document.getElementById('navProgress').textContent   = 'Completed';
}

function showResultFromAI(ai, interest, personality, aptScore, analyst, leader, humanist, total) {
  let rec = 'PCM';
  if (ai.recommended_stream === 'COMMERCE') rec = 'COMM';
  if (ai.recommended_stream === 'ARTS_HUMANITIES') rec = 'ARTS';
  showResult(rec, ai.aptitude_score || aptScore, interest, personality, analyst, leader, humanist, total);
}

function retakeTest() {
  answers   = new Array(30).fill(null);
  current   = 0;
  timeRemaining = questions.map(q => q.lvl === 2 ? 60 : 30);
  clearInterval(timerInterval);
  document.getElementById('screenResult').classList.remove('active');
  document.getElementById('screenQuiz').classList.remove('active');
  document.getElementById('screenIntro').classList.add('active');
  document.getElementById('timerBox').style.display = 'flex';
}
</script>


</body>
</html>
