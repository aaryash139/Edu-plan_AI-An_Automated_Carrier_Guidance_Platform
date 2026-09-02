<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Login — EduPath</title>
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
    }

    body {
      font-family: 'Sora', sans-serif;
      background: linear-gradient(135deg, #e8f4fd 0%, #f0f6fc 50%, #fef9ef 100%);
      min-height: 100vh;
      display: flex; flex-direction: column;
    }

    /* NAV */
    nav {
      display: flex; align-items: center; justify-content: space-between;
      padding: 0 6%; height: 80px;
      background: rgba(255,255,255,0.88);
      backdrop-filter: blur(12px);
      border-bottom: 1px solid var(--border);
    }
    .nav-logo { font-family: 'DM Serif Display', serif; font-size: 2.2rem; letter-spacing: -0.5px; color: var(--navy); text-decoration: none; }
    .nav-logo span { color: var(--sky); }
    .nav-back { font-size: 0.85rem; color: var(--muted); text-decoration: none; display: flex; align-items: center; gap: 0.4rem; transition: color 0.2s; }
    .nav-back:hover { color: var(--navy); }

    /* LAYOUT */
    .page {
      flex: 1;
      display: grid;
      grid-template-columns: 1fr 1fr;
      min-height: calc(100vh - 80px);
    }

    /* LEFT PANEL */
    .left-panel {
      background: var(--navy);
      padding: 4rem;
      display: flex; flex-direction: column; justify-content: center;
      position: relative; overflow: hidden;
    }
    .left-panel::before {
      content: '';
      position: absolute; top: -100px; right: -100px;
      width: 420px; height: 420px;
      background: radial-gradient(circle, rgba(58,159,214,0.15) 0%, transparent 70%);
      border-radius: 50%;
    }
    .left-panel::after {
      content: '';
      position: absolute; bottom: -80px; left: -80px;
      width: 300px; height: 300px;
      background: radial-gradient(circle, rgba(244,168,37,0.12) 0%, transparent 70%);
      border-radius: 50%;
    }
    .left-content { position: relative; z-index: 1; }
    .left-tag { font-size: 0.75rem; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase; color: var(--sky); margin-bottom: 1.25rem; }
    .left-panel h2 { font-family: 'DM Serif Display', serif; font-size: 2.2rem; line-height: 1.2; color: var(--white); margin-bottom: 1rem; }
    .left-panel h2 em { font-style: italic; color: var(--sky); }
    .left-panel > .left-content > p { font-size: 0.95rem; color: rgba(255,255,255,0.5); line-height: 1.75; margin-bottom: 2.5rem; }

    /* User type cards */
    .user-cards { display: flex; flex-direction: column; gap: 1rem; }
    .user-card {
      background: rgba(255,255,255,0.06);
      border: 1px solid rgba(255,255,255,0.1);
      border-radius: 12px; padding: 1.1rem 1.25rem;
      display: flex; align-items: center; gap: 1rem;
    }
    .user-card-icon { font-size: 1.5rem; }
    .user-card-title { font-size: 0.88rem; font-weight: 600; color: var(--white); }
    .user-card-sub { font-size: 0.76rem; color: rgba(255,255,255,0.4); margin-top: 2px; }

    .left-divider { height: 1px; background: rgba(255,255,255,0.08); margin: 2rem 0; }
    .left-footer { font-size: 0.78rem; color: rgba(255,255,255,0.25); }

    /* RIGHT PANEL */
    .right-panel {
      display: flex; align-items: center; justify-content: center;
      padding: 3rem 2rem;
      background: var(--white);
    }
    .form-box { width: 100%; max-width: 400px; animation: fadeUp 0.5s ease both; }

    .form-box h1 { font-family: 'DM Serif Display', serif; font-size: 2rem; color: var(--navy); margin-bottom: 0.4rem; }
    .subtitle { font-size: 0.9rem; color: var(--muted); margin-bottom: 2rem; }
    .subtitle a { color: var(--sky); text-decoration: none; font-weight: 600; }
    .subtitle a:hover { text-decoration: underline; }

    /* Role toggle */
    .role-toggle {
      display: grid; grid-template-columns: 1fr 1fr;
      background: var(--light); border-radius: 10px;
      padding: 4px; gap: 4px; margin-bottom: 1.75rem;
    }
    .role-btn {
      padding: 0.6rem; border-radius: 7px; border: none;
      font-family: 'Sora', sans-serif; font-size: 0.83rem; font-weight: 600;
      cursor: pointer; transition: all 0.2s;
      background: transparent; color: var(--muted);
    }
    .role-btn.active { background: var(--white); color: var(--navy); box-shadow: 0 1px 4px rgba(13,27,42,0.1); }

    /* Form */
    .form-group { margin-bottom: 1.15rem; }
    label { display: block; font-size: 0.8rem; font-weight: 600; color: var(--text); margin-bottom: 0.4rem; }
    .label-row { display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.4rem; }
    .label-row label { margin-bottom: 0; }
    .forgot-link { font-size: 0.78rem; color: var(--sky); text-decoration: none; }
    .forgot-link:hover { text-decoration: underline; }

    input[type=email], input[type=password], input[type=text], select {
      width: 100%; padding: 0.75rem 0.9rem;
      border: 1.5px solid var(--border); border-radius: 8px;
      font-family: 'Sora', sans-serif; font-size: 0.88rem; color: var(--text);
      background: var(--white); outline: none;
      transition: border-color 0.2s, box-shadow 0.2s;
    }
    input:focus, select:focus { border-color: var(--sky); box-shadow: 0 0 0 3px rgba(58,159,214,0.12); }
    input.error, select.error { border-color: var(--error); }
    input.error:focus, select.error:focus { box-shadow: 0 0 0 3px rgba(229,57,53,0.1); }

    .pwd-wrapper { position: relative; }
    .pwd-toggle {
      position: absolute; right: 0.75rem; top: 50%; transform: translateY(-50%);
      background: none; border: none; cursor: pointer; font-size: 1rem; color: var(--muted); padding: 0;
    }

    .field-error { font-size: 0.75rem; color: var(--error); margin-top: 0.35rem; display: none; }
    .field-error.show { display: block; }

    /* Alert box */
    .alert {
      padding: 0.8rem 1rem; border-radius: 8px;
      font-size: 0.83rem; margin-bottom: 1.25rem;
      display: none; align-items: center; gap: 0.6rem;
    }
    .alert.show { display: flex; }
    .alert-error { background: #fef2f2; border: 1px solid #fecaca; color: #b91c1c; }
    .alert-success { background: #f0fdf4; border: 1px solid #bbf7d0; color: #166534; }

    /* Remember me */
    .remember-row { display: flex; align-items: center; justify-content: space-between; margin-bottom: 1.25rem; }
    .check-label { display: flex; align-items: center; gap: 0.5rem; font-size: 0.8rem; color: var(--muted); cursor: pointer; }
    .check-label input { accent-color: var(--sky); width: 15px; height: 15px; }

    /* Submit */
    .btn-submit {
      width: 100%; padding: 0.9rem;
      background: var(--navy); color: var(--white);
      border: none; border-radius: 8px;
      font-family: 'Sora', sans-serif; font-size: 0.95rem; font-weight: 600;
      cursor: pointer; transition: background 0.2s, transform 0.15s;
      display: flex; align-items: center; justify-content: center; gap: 0.5rem;
    }
    .btn-submit:hover { background: var(--blue); transform: translateY(-1px); }
    .btn-submit:disabled { background: var(--muted); cursor: not-allowed; transform: none; }

    /* Spinner */
    .spinner {
      width: 16px; height: 16px; border: 2px solid rgba(255,255,255,0.3);
      border-top-color: white; border-radius: 50%;
      animation: spin 0.7s linear infinite; display: none;
    }
    @keyframes spin { to { transform: rotate(360deg); } }

    /* Divider */
    .or-divider {
      display: flex; align-items: center; gap: 1rem;
      margin: 1.5rem 0; font-size: 0.78rem; color: var(--muted);
    }
    .or-divider::before, .or-divider::after { content: ''; flex: 1; height: 1px; background: var(--border); }

    /* Demo account */
    .demo-cards { display: grid; grid-template-columns: 1fr 1fr; gap: 0.75rem; }
    .demo-card {
      border: 1.5px solid var(--border); border-radius: 8px; padding: 0.75rem;
      cursor: pointer; transition: all 0.2s; text-align: center;
    }
    .demo-card:hover { border-color: var(--sky); background: #f0f8ff; }
    .demo-card .demo-icon { font-size: 1.2rem; margin-bottom: 0.25rem; }
    .demo-card .demo-role { font-size: 0.78rem; font-weight: 600; color: var(--navy); }
    .demo-card .demo-hint { font-size: 0.7rem; color: var(--muted); margin-top: 2px; }

    .register-cta {
      margin-top: 1.75rem; text-align: center;
      padding-top: 1.5rem; border-top: 1px solid var(--border);
      font-size: 0.85rem; color: var(--muted);
    }
    .register-cta a { color: var(--sky); font-weight: 600; text-decoration: none; }
    .register-cta a:hover { text-decoration: underline; }

    @keyframes fadeUp {
      from { opacity: 0; transform: translateY(20px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    @media (max-width: 820px) {
      .page { grid-template-columns: 1fr; }
      .left-panel { display: none; }
      .right-panel { padding: 2rem 1.5rem; align-items: flex-start; padding-top: 3rem; }
    }
  
</style>

</head>
<body>

  <nav>
    <a class="nav-logo" href="/">Edu<span>Path</span></a>
    <a class="nav-back" href="/">← Back to Home</a>
  </nav>

  <div class="page">

    <div class="left-panel">
      <div class="left-content">
        <div class="left-tag">Welcome to EduPath</div>
        <h2>Continue your <em>career journey</em></h2>
        <p>Log back in to access your aptitude results, saved colleges, and personalised dashboard.</p>

        <div class="user-cards">
          <div class="user-card">
            <div class="user-card-icon">🎓</div>
            <div>
              <div class="user-card-title">Student Login</div>
              <div class="user-card-sub">Access your tests, results & college shortlist</div>
            </div>
          </div>
          <div class="user-card">
            <div class="user-card-icon">🛠</div>
            <div>
              <div class="user-card-title">Admin Login</div>
              <div class="user-card-sub">Manage college data, users & platform settings</div>
            </div>
          </div>
        </div>

        <div class="left-divider"></div>
        <div class="left-footer">EduPath · A Smart Career Guidance Platform</div>
      </div>
    </div>

    <div class="right-panel">
      <div class="form-box">

        <h1>Welcome to EduPath</h1>


        <form id="loginForm" action="/LoginServlet" method="POST">
            <input type="hidden" name="next" id="nextUrl" value="" />

            <div class="form-group">
              <label>Login As</label>
              <select name="userRole" id="userRole" onchange="setRole(this.value)">
                <option value="student">🎓 Student</option>
                <option value="admin">🛠 Admin</option>
              </select>
            </div>

            <div class="form-group" id="adminCodeGroup" style="display:none;">
              <label>Admin Secret Code</label>
              <input type="password" name="adminCode" id="adminCode" placeholder="Enter admin code" onkeydown="if(event.key==='Enter')doLogin()" />
              <div class="field-error" id="err-adminCode">Please enter the admin code</div>
            </div>

            <div class="alert alert-error" id="alertError">
              <span>⚠</span> <span id="alertMsg">Invalid email or password. Please try again.</span>
            </div>
            <div class="alert alert-success" id="alertSuccess">
              <span>✓</span> <span>Login successful! Redirecting to your dashboard…</span>
            </div>

            <div class="form-group">
              <label>Email Address</label>
              <input type="email" name="email" id="email" placeholder="you@example.com" onkeydown="if(event.key==='Enter')doLogin()" />
              <div class="field-error" id="err-email">Please enter a valid email address</div>
            </div>

            <div class="form-group">
              <div class="label-row">
                <label>Password</label>
                <a href="#" class="forgot-link" onclick="showForgot(event)">Need help signing in?</a>
              </div>
              <div class="pwd-wrapper">
                <input type="password" name="password" id="password" placeholder="Enter your password" onkeydown="if(event.key==='Enter')doLogin()" />
                <button class="pwd-toggle" onclick="togglePwd()" type="button">👁</button>
              </div>
              <div class="field-error" id="err-password">Please enter your password</div>
            </div>

            <div class="remember-row">
              <label class="check-label">
                <input type="checkbox" name="remember" id="remember" /> Remember me
              </label>
            </div>

            <button type="button" class="btn-submit" id="loginBtn" onclick="doLogin()">
              <span id="btnText">Login to EduPath</span>
              <div class="spinner" id="spinner"></div>
            </button>
        </form>

        <div class="or-divider">or try a demo account</div>
        <div class="demo-cards">
          <div class="demo-card" onclick="fillDemo('student')">
            <div class="demo-icon">🎓</div>
            <div class="demo-role">Student Demo</div>
            <div class="demo-hint">Click to autofill</div>
          </div>
          <div class="demo-card" onclick="fillDemo('admin')">
            <div class="demo-icon">🛠</div>
            <div class="demo-role">Admin Demo</div>
            <div class="demo-hint">Click to autofill</div>
          </div>
        </div>

        <div class="register-cta">
          New to EduPath? <a href="/signup">Create a free account →</a>
        </div>

      </div>
    </div>
  </div>

  <div id="forgotOverlay" style="display:none; position:fixed; inset:0; background:rgba(13,27,42,0.5); z-index:200; align-items:center; justify-content:center;">
    <div style="background:var(--white); border-radius:16px; padding:2rem; width:90%; max-width:380px; animation:fadeUp 0.3s ease;">
      <h3 style="font-family:'DM Serif Display',serif; font-size:1.4rem; color:var(--navy); margin-bottom:0.5rem;">Account Help</h3>
      <p style="font-size:0.85rem; color:var(--muted); margin-bottom:1.25rem; line-height:1.6;">Password reset is not enabled in this demo. Use a demo account or register a new student account.</p>
      <div style="font-size:0.82rem; color:var(--navy); background:var(--light); padding:0.75rem; border-radius:8px; margin-bottom:1rem;">
        Student: student@edupath.in / Student@123<br/>
        Admin: admin@edupath.in / Admin@123
      </div>
      <button onclick="closeForgot()" style="width:100%; padding:0.75rem; background:var(--navy); border:none; border-radius:8px; font-family:'Sora',sans-serif; font-size:0.88rem; font-weight:600; color:white; cursor:pointer;">Close</button>
    </div>
  </div>

  <script>
    const demoAccounts = {
      student: { email: 'student@edupath.in', password: 'Student@123' },
      admin:   { email: 'admin@edupath.in',   password: 'Admin@123'   }
    };

    let currentRole = 'student';

    function setRole(role) {
      currentRole = role;
      document.getElementById('userRole').value = role; // Update select if called from demo
      const adminGroup = document.getElementById('adminCodeGroup');
      if (adminGroup) {
        adminGroup.style.display = (role === 'admin') ? 'block' : 'none';
      }
      hideAlerts();
    }

    function togglePwd() {
      const inp = document.getElementById('password');
      const btn = document.querySelector('.pwd-toggle');
      inp.type = inp.type === 'password' ? 'text' : 'password';
      btn.textContent = inp.type === 'password' ? '👁' : '🙈';
    }

    function hideAlerts() {
      document.getElementById('alertError').classList.remove('show');
      document.getElementById('alertSuccess').classList.remove('show');
    }

    function showError(id, show) {
      const err = document.getElementById('err-' + id);
      const inp = document.getElementById(id);
      if (err) err.classList.toggle('show', show);
      if (inp) inp.classList.toggle('error', show);
    }

    function fillDemo(role) {
      setRole(role);
      document.getElementById('email').value    = demoAccounts[role].email;
      document.getElementById('password').value = demoAccounts[role].password;
      if (role === 'admin') {
        const ac = document.getElementById('adminCode');
        if (ac) ac.value = 'EDUPATH_ADMIN_2025';
      }
      hideAlerts();
      showError('email', false);
      showError('password', false);
      showError('adminCode', false);
    }

  function doLogin() {
    hideAlerts();
    const email = document.getElementById('email').value.trim();
    const pwd   = document.getElementById('password').value;
    const role  = document.getElementById('userRole').value;
    let ok = true;

    // 1. Validation (Email aur Password empty nahi hone chahiye)
    const emailOk = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
    showError('email', !emailOk);    if (!emailOk) ok = false;
    showError('password', !pwd);     if (!pwd)     ok = false;
    
    if (role === 'admin') {
      const adminCode = document.getElementById('adminCode');
      if (adminCode && !adminCode.value.trim()) {
        showError('adminCode', true);
        ok = false;
      } else {
        showError('adminCode', false);
      }
    }

    if (!ok) return;

    // 2. UI Feedback (Button ko disable karna taaki double click na ho)
    const btn = document.getElementById('loginBtn');
    document.getElementById('btnText').textContent = 'Connecting to Server...';
    document.getElementById('spinner').style.display = 'block';
    btn.disabled = true;

    // 3. REAL SUBMISSION (Ye line aapke Java Servlet ko call karegi)
    document.getElementById('loginForm').submit();
  }

    function showForgot(e) {
      e.preventDefault();
      document.getElementById('forgotOverlay').style.display = 'flex';
    }
    function closeForgot() {
      document.getElementById('forgotOverlay').style.display = 'none';
    }

    (function showServerMessages() {
      <% if (request.getAttribute("errorMsg") != null) { %>
        document.getElementById('alertMsg').textContent = '<%= request.getAttribute("errorMsg") %>';
        document.getElementById('alertError').classList.add('show');
      <% } %>
      <% if (request.getAttribute("successMsg") != null) { %>
        const successAlert = document.getElementById('alertSuccess');
        successAlert.querySelector('span:last-child').textContent = '<%= request.getAttribute("successMsg") %>';
        successAlert.classList.add('show');
      <% } %>
      const params = new URLSearchParams(window.location.search);
      if (params.get('error') === 'true') {
        document.getElementById('alertMsg').textContent = 'Invalid email or password. Please try again.';
        document.getElementById('alertError').classList.add('show');
      }
      if (params.get('registered') === 'true') {
        const successAlert = document.getElementById('alertSuccess');
        successAlert.querySelector('span:last-child').textContent = 'Account created successfully! Please login.';
        successAlert.classList.add('show');
      }
      const nextInput = document.getElementById('nextUrl');
      const nextFromServer = '${nextUrl != null ? nextUrl : ""}';
      if (nextFromServer) nextInput.value = nextFromServer;
      else if (params.get('next')) nextInput.value = params.get('next');
      const roleFromServer = '${loginRole != null ? loginRole : ""}';
      if (roleFromServer) setRole(roleFromServer);
    })();
  </script>


</body>
</html>