<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Register — EduPath</title>
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
            display: flex;
            flex-direction: column;
        }

        /* ── NAV ── */
        nav {
            display: flex; align-items: center; justify-content: space-between;
            padding: 0 6%; height: 80px;
            background: rgba(255,255,255,0.88);
            backdrop-filter: blur(12px);
            border-bottom: 1px solid var(--border);
        }
        .nav-logo {
            font-family: 'DM Serif Display', serif;
            font-size: 2.2rem;
            letter-spacing: -0.5px;
            color: var(--navy);
            text-decoration: none;
        }
        .nav-logo span { color: var(--sky); }
        .nav-back {
            font-size: 0.85rem; color: var(--muted);
            text-decoration: none; display: flex; align-items: center; gap: 0.4rem;
            transition: color 0.2s;
        }
        .nav-back:hover { color: var(--navy); }

        /* ── LAYOUT ── */
        .page {
            flex: 1;
            display: grid;
            grid-template-columns: 1fr 1fr;
            min-height: calc(100vh - 80px);
        }

        /* ── LEFT PANEL ── */
        .left-panel {
            background: var(--navy);
            padding: 4rem 4rem;
            display: flex; flex-direction: column; justify-content: center;
            position: relative; overflow: hidden;
        }
        .left-panel::before {
            content: '';
            position: absolute; top: -100px; right: -100px;
            width: 400px; height: 400px;
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
        .left-tag {
            font-size: 0.75rem; font-weight: 600; letter-spacing: 0.1em;
            text-transform: uppercase; color: var(--sky); margin-bottom: 1.25rem;
        }
        .left-panel h2 {
            font-family: 'DM Serif Display', serif;
            font-size: 2.2rem; line-height: 1.2;
            color: var(--white); margin-bottom: 1rem;
        }
        .left-panel h2 em { font-style: italic; color: var(--sky); }
        .left-panel p {
            font-size: 0.95rem; color: rgba(255,255,255,0.55);
            line-height: 1.75; margin-bottom: 2.5rem;
        }
        .perks { display: flex; flex-direction: column; gap: 1rem; }
        .perk {
            display: flex; align-items: flex-start; gap: 0.9rem;
        }
        .perk-icon {
            width: 36px; height: 36px; border-radius: 8px; flex-shrink: 0;
            display: flex; align-items: center; justify-content: center;
            font-size: 1rem;
            background: rgba(255,255,255,0.07);
            border: 1px solid rgba(255,255,255,0.1);
        }
        .perk-text strong { display: block; font-size: 0.88rem; color: var(--white); font-weight: 600; }
        .perk-text span { font-size: 0.8rem; color: rgba(255,255,255,0.45); }

        .left-footer {
            margin-top: 3rem;
            padding-top: 2rem;
            border-top: 1px solid rgba(255,255,255,0.08);
            font-size: 0.8rem; color: rgba(255,255,255,0.3);
        }

        /* ── RIGHT PANEL (FORM) ── */
        .right-panel {
            display: flex; align-items: center; justify-content: center;
            padding: 3rem 2rem;
            background: var(--white);
        }
        .form-box { width: 100%; max-width: 440px; }
        .form-box h1 {
            font-family: 'DM Serif Display', serif;
            font-size: 1.9rem; color: var(--navy);
            margin-bottom: 0.4rem;
        }
        .form-box .subtitle {
            font-size: 0.9rem; color: var(--muted);
            margin-bottom: 2rem;
        }
        .form-box .subtitle a { color: var(--sky); text-decoration: none; font-weight: 600; }
        .form-box .subtitle a:hover { text-decoration: underline; }

        .server-alert {
            padding: 0.8rem 1rem;
            border-radius: 8px;
            font-size: 0.83rem;
            margin-bottom: 1rem;
            border: 1px solid #fecaca;
            background: #fef2f2;
            color: #b91c1c;
        }

        /* Steps indicator */
        .steps-indicator {
            display: flex; align-items: center; gap: 0;
            margin-bottom: 2rem;
        }
        .step-dot {
            width: 28px; height: 28px; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 0.75rem; font-weight: 700;
            border: 2px solid var(--border);
            color: var(--muted);
            transition: all 0.3s;
            flex-shrink: 0;
        }
        .step-dot.active { background: var(--sky); border-color: var(--sky); color: var(--white); }
        .step-dot.done { background: var(--success); border-color: var(--success); color: var(--white); }
        .step-line {
            flex: 1; height: 2px; background: var(--border);
            transition: background 0.3s;
        }
        .step-line.done { background: var(--success); }
        .step-labels {
            display: flex; justify-content: space-between;
            margin-top: 0.4rem; margin-bottom: 1.5rem;
        }
        .step-label { font-size: 0.7rem; color: var(--muted); text-align: center; flex: 1; }
        .step-label:first-child { text-align: left; }
        .step-label:last-child { text-align: right; }
        .step-label.active { color: var(--sky); font-weight: 600; }

        /* Form elements */
        .form-group { margin-bottom: 1.15rem; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
        label {
            display: block; font-size: 0.8rem; font-weight: 600;
            color: var(--text); margin-bottom: 0.4rem;
        }
        label .req { color: var(--error); margin-left: 2px; }

        input[type=text],
        input[type=email],
        input[type=password],
        input[type=tel],
        select {
            width: 100%; padding: 0.72rem 0.9rem;
            border: 1.5px solid var(--border);
            border-radius: 8px;
            font-family: 'Sora', sans-serif;
            font-size: 0.88rem; color: var(--text);
            background: var(--white);
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
            appearance: none;
        }
        input:focus, select:focus {
            border-color: var(--sky);
            box-shadow: 0 0 0 3px rgba(58,159,214,0.12);
        }
        input.error { border-color: var(--error); }
        input.error:focus { box-shadow: 0 0 0 3px rgba(229,57,53,0.1); }
        .field-error { font-size: 0.75rem; color: var(--error); margin-top: 0.3rem; display: none; }
        .field-error.show { display: block; }

        /* Password strength */
        .pwd-wrapper { position: relative; }
        .pwd-toggle {
            position: absolute; right: 0.75rem; top: 50%; transform: translateY(-50%);
            background: none; border: none; cursor: pointer;
            font-size: 1rem; color: var(--muted); padding: 0;
        }
        .strength-bar { display: flex; gap: 4px; margin-top: 0.5rem; }
        .strength-seg {
            flex: 1; height: 3px; border-radius: 10px;
            background: var(--border); transition: background 0.3s;
        }
        .strength-text { font-size: 0.72rem; color: var(--muted); margin-top: 0.3rem; }

        /* Class selection */
        .class-select { display: grid; grid-template-columns: 1fr 1fr; gap: 0.75rem; margin-top: 0.4rem; }
        .class-btn {
            padding: 0.8rem; border-radius: 8px; cursor: pointer;
            border: 1.5px solid var(--border); background: var(--white);
            text-align: center; transition: all 0.2s;
            font-family: 'Sora', sans-serif;
        }
        .class-btn:hover { border-color: var(--sky); background: #f0f8ff; }
        .class-btn.selected { border-color: var(--sky); background: rgba(58,159,214,0.08); }
        .class-btn .class-num { font-size: 1.3rem; font-weight: 700; color: var(--navy); display: block; }
        .class-btn .class-sub { font-size: 0.72rem; color: var(--muted); }
        .class-btn.selected .class-num { color: var(--sky); }

        /* Checkbox */
        .checkbox-row { display: flex; align-items: flex-start; gap: 0.6rem; margin-top: 0.5rem; }
        .checkbox-row input[type=checkbox] { width: 16px; height: 16px; margin-top: 2px; accent-color: var(--sky); flex-shrink: 0; cursor: pointer; }
        .checkbox-row label { font-size: 0.8rem; color: var(--muted); font-weight: 400; margin: 0; cursor: pointer; }
        .checkbox-row a { color: var(--sky); text-decoration: none; }
        .checkbox-row a:hover { text-decoration: underline; }

        /* Buttons */
        .btn-submit {
            width: 100%; padding: 0.9rem;
            background: var(--navy); color: var(--white);
            border: none; border-radius: 8px;
            font-family: 'Sora', sans-serif;
            font-size: 0.95rem; font-weight: 600;
            cursor: pointer; margin-top: 1.25rem;
            transition: background 0.2s, transform 0.15s;
        }
        .btn-submit:hover { background: var(--blue); transform: translateY(-1px); }
        .btn-submit:disabled { background: var(--muted); cursor: not-allowed; transform: none; }

        .btn-back {
            width: 100%; padding: 0.75rem;
            background: transparent; color: var(--muted);
            border: 1.5px solid var(--border); border-radius: 8px;
            font-family: 'Sora', sans-serif;
            font-size: 0.88rem; font-weight: 600;
            cursor: pointer; margin-top: 0.6rem;
            transition: all 0.2s;
        }
        .btn-back:hover { border-color: var(--navy); color: var(--navy); }

        /* Form steps */
        .form-step { display: none; }
        .form-step.active { display: block; animation: fadeIn 0.3s ease; }

        /* Success screen */
        .success-screen {
            text-align: center; padding: 2rem 0;
            display: none;
            animation: fadeIn 0.4s ease;
        }
        .success-screen.show { display: block; }
        .success-icon {
            width: 72px; height: 72px; border-radius: 50%;
            background: rgba(46,155,110,0.1); border: 2px solid rgba(46,155,110,0.3);
            display: flex; align-items: center; justify-content: center;
            font-size: 2rem; margin: 0 auto 1.5rem;
        }
        .success-screen h2 { font-family: 'DM Serif Display', serif; font-size: 1.7rem; color: var(--navy); margin-bottom: 0.5rem; }
        .success-screen p { font-size: 0.9rem; color: var(--muted); margin-bottom: 2rem; line-height: 1.7; }
        .btn-go {
            display: inline-block; background: var(--navy); color: var(--white);
            padding: 0.85rem 2rem; border-radius: 8px;
            font-size: 0.95rem; font-weight: 600;
            text-decoration: none; transition: background 0.2s;
        }
        .btn-go:hover { background: var(--blue); }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(12px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /* Responsive */
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
                <div class="left-tag">Join EduPath</div>
                <h2>Start your journey to the <em>right career</em></h2>
                <p>Create a free account and get personalised career guidance based on your aptitude — not someone else's opinion.</p>
                <div class="perks">
                    <div class="perk"><div class="perk-icon">🎯</div><div class="perk-text"><strong>Free Aptitude Assessment</strong><span>Discover your strengths in Logic, Math & Verbal</span></div></div>
                    <div class="perk"><div class="perk-icon">🏛</div><div class="perk-text"><strong>500+ College Database</strong><span>Search by fees, cut-off, location & ranking</span></div></div>
                    <div class="perk"><div class="perk-icon">📊</div><div class="perk-text"><strong>Personal Dashboard</strong><span>Track your tests and saved colleges anytime</span></div></div>
                    <div class="perk"><div class="perk-icon">🔒</div><div class="perk-text"><strong>100% Secure & Private</strong><span>Your data is encrypted and never shared</span></div></div>
                </div>
                <div class="left-footer">EduPath · A Smart Career Guidance Platform</div>
            </div>
        </div>

        <div class="right-panel">
            <div class="form-box">
                <div class="steps-indicator">
                    <div class="step-dot active" id="dot1">1</div>
                    <div class="step-line" id="line1"></div>
                    <div class="step-dot" id="dot2">2</div>
                    <div class="step-line" id="line2"></div>
                    <div class="step-dot" id="dot3">3</div>
                </div>
                <div class="step-labels">
                    <span class="step-label active" id="lbl1">Basic Info</span>
                    <span class="step-label" id="lbl2">Academic</span>
                    <span class="step-label" id="lbl3">Password</span>
                </div>

                <h1>Create Account</h1>
                <p class="subtitle">Already registered? <a href="/login">Login here</a></p>
                <% if (request.getAttribute("errorMsg") != null) { %>
                    <div class="server-alert"><%= request.getAttribute("errorMsg") %></div>
                <% } %>

                <form id="regForm" action="/RegisterServlet" method="POST">

                    <div class="form-step active" id="step1">
                        <div class="form-row">
                            <div class="form-group">
                                <label>First Name <span class="req">*</span></label>
                                <input type="text" name="firstName" id="firstName" placeholder="John" />
                                <div class="field-error" id="err-firstName">Please enter your first name</div>
                            </div>
                            <div class="form-group">
                                <label>Last Name <span class="req">*</span></label>
                                <input type="text" name="lastName" id="lastName" placeholder="Doe" />
                                <div class="field-error" id="err-lastName">Please enter your last name</div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Email Address <span class="req">*</span></label>
                            <input type="email" name="email" id="email" placeholder="you@example.com" />
                            <div class="field-error" id="err-email">Please enter a valid email address</div>
                        </div>
                        <div class="form-group">
                            <label>Mobile Number <span class="req">*</span></label>
                            <input type="tel" name="mobile" id="mobile" placeholder="9876543210" maxlength="10" />
                            <div class="field-error" id="err-mobile">Please enter a valid 10-digit mobile number</div>
                        </div>
                        <button type="button" class="btn-submit" onclick="goStep2()">Continue →</button>
                    </div>

                    <div class="form-step" id="step2">
                        <div class="form-group">
                            <label>I am currently in <span class="req">*</span></label>
                            <div class="class-select">
                                <div class="class-btn" id="btn10" onclick="selectClass('10')">
                                    <span class="class-num">10th</span>
                                    <span class="class-sub">Stream selection</span>
                                </div>
                                <div class="class-btn" id="btn12" onclick="selectClass('12')">
                                    <span class="class-num">12th</span>
                                    <span class="class-sub">College discovery</span>
                                </div>
                            </div>
                            <input type="hidden" name="userClass" id="userClass" value="">
                            <div class="field-error" id="err-class">Please select your class</div>
                        </div>
                        <div class="form-group" id="streamGroup" style="display:none;">
                            <label>Current Stream <span class="req">*</span></label>
                            <select name="stream" id="stream">
                                <option value="">Select your stream</option>
                                <option>Science (PCM)</option>
                                <option>Science (PCB)</option>
                                <option>Commerce</option>
                                <option>Arts / Humanities</option>
                            </select>
                            <div class="field-error" id="err-stream">Please select your stream</div>
                        </div>
                        <div class="form-group">
                            <label>State <span class="req">*</span></label>
                            <select name="state" id="state">
                                <option value="">Select your state</option>
                                <option>Madhya Pradesh</option>
                                <option>Maharashtra</option>
                                <option>Uttar Pradesh</option>
                                <option>Rajasthan</option>
                                <option>Gujarat</option>
                                <option>Karnataka</option>
                                <option>Tamil Nadu</option>
                                <option>Delhi</option>
                                <option>West Bengal</option>
                                <option>Other</option>
                            </select>
                            <div class="field-error" id="err-state">Please select your state</div>
                        </div>
                        <div class="form-group">
                            <label>Last Exam Percentage <span class="req">*</span></label>
                            <input type="text" name="percentage" id="percentage" placeholder="e.g. 85.5" maxlength="5" />
                            <div class="field-error" id="err-percentage">Please enter a valid percentage (0–100)</div>
                        </div>
                        <button type="button" class="btn-submit" onclick="goStep3()">Continue →</button>
                        <button type="button" class="btn-back" onclick="goBack(1)">← Back</button>
                    </div>

<div class="form-step" id="step3">
    <div class="form-group">
        <label>Create Password <span class="req">*</span></label>
        <div class="pwd-wrapper">
            <!-- CHANGED: name="password" is now name="passwordHash" -->
            <input type="password" name="passwordHash" id="password" placeholder="Min. 8 characters" oninput="checkStrength()" />
            <button class="pwd-toggle" onclick="togglePwd('password', this)" type="button">👁</button>
        </div>
        <div class="strength-bar">
            <div class="strength-seg" id="s1"></div>
            <div class="strength-seg" id="s2"></div>
            <div class="strength-seg" id="s3"></div>
            <div class="strength-seg" id="s4"></div>
        </div>
        <div class="strength-text" id="strengthText"></div>
        <div class="field-error" id="err-password">Password must be at least 8 characters</div>
    </div>
    <div class="form-group">
        <label>Confirm Password <span class="req">*</span></label>
        <div class="pwd-wrapper">
            <!-- I also added name="confirmPassword" here just in case you ever want to check it on the backend -->
            <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Re-enter password" />
            <button class="pwd-toggle" onclick="togglePwd('confirmPassword', this)" type="button">👁</button>
        </div>
        <div class="field-error" id="err-confirmPassword">Passwords do not match</div>
    </div>
                        <div class="checkbox-row">
                            <input type="checkbox" id="terms" />
                            <label for="terms">I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a></label>
                        </div>
                        <div class="field-error" id="err-terms">Please accept the terms to continue</div>
                        <button type="button" class="btn-submit" onclick="submitForm()">Create My Account 🎉</button>
                        <button type="button" class="btn-back" onclick="goBack(2)">← Back</button>
</div>
                </form>

                <div class="success-screen" id="successScreen">
                    <div class="success-icon">✓</div>
                    <h2>You're all set!</h2>
                    <p>Your EduPath account has been created successfully.<br>Take your aptitude test now and discover the best career path for you.</p>
                    <a href="/login" class="btn-go">Go to Login →</a>
                </div>

            </div>
        </div>
    </div>

    <script>
        let selectedClassValue = '';

        function showError(id, show) {
            const el = document.getElementById('err-' + id);
            if (el) el.classList.toggle('show', show);
            const input = document.getElementById(id);
            if (input) input.classList.toggle('error', show);
        }

        function goStep2() {
            const fn = document.getElementById('firstName').value.trim();
            const ln = document.getElementById('lastName').value.trim();
            const em = document.getElementById('email').value.trim();
            const mb = document.getElementById('mobile').value.trim();
            let ok = true;
            showError('firstName', !fn); if (!fn) ok = false;
            showError('lastName', !ln); if (!ln) ok = false;
            const emailOk = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(em);
            showError('email', !emailOk); if (!emailOk) ok = false;
            const mobOk = /^\d{10}$/.test(mb);
            showError('mobile', !mobOk); if (!mobOk) ok = false;
            if (!ok) return;
            setStep(2);
        }

        function goStep3() {
            let ok = true;
            if (!selectedClassValue) { showError('class', true); ok = false; } else { showError('class', false); }
            if (selectedClassValue === '12') {
                const st = document.getElementById('stream').value;
                showError('stream', !st); if (!st) ok = false;
            }
            const state = document.getElementById('state').value;
            showError('state', !state); if (!state) ok = false;
            const pct = parseFloat(document.getElementById('percentage').value);
            const pctOk = !isNaN(pct) && pct >= 0 && pct <= 100;
            showError('percentage', !pctOk); if (!pctOk) ok = false;
            if (!ok) return;
            setStep(3);
        }

        function submitForm() {
            const pwd = document.getElementById('password').value;
            const cpwd = document.getElementById('confirmPassword').value;
            const terms = document.getElementById('terms').checked;
            let ok = true;
            showError('password', pwd.length < 8); if (pwd.length < 8) ok = false;
            showError('confirmPassword', pwd !== cpwd); if (pwd !== cpwd) ok = false;
            showError('terms', !terms); if (!terms) ok = false;
            if (!ok) return;
            document.getElementById('regForm').submit();
        }

        function goBack(toStep) {
            setStep(toStep);
        }

        function setStep(n) {
            document.querySelectorAll('.form-step').forEach(s => s.classList.remove('active'));
            document.getElementById('step' + n).classList.add('active');

            for (let i = 1; i <= 3; i++) {
                const dot = document.getElementById('dot' + i);
                const lbl = document.getElementById('lbl' + i);
                dot.classList.remove('active', 'done');
                lbl.classList.remove('active');
                if (i < n) { dot.classList.add('done'); dot.textContent = '✓'; }
                else if (i === n) { dot.classList.add('active'); dot.textContent = i; lbl.classList.add('active'); }
                else { dot.textContent = i; }
            }
            for (let i = 1; i <= 2; i++) {
                document.getElementById('line' + i).classList.toggle('done', i < n);
            }
        }

        function selectClass(cls) {
            selectedClassValue = cls;
            document.getElementById('userClass').value = cls;
            document.getElementById('btn10').classList.toggle('selected', cls === '10');
            document.getElementById('btn12').classList.toggle('selected', cls === '12');
            document.getElementById('streamGroup').style.display = cls === '12' ? 'block' : 'none';
            showError('class', false);
        }

        function togglePwd(id, btn) {
            const input = document.getElementById(id);
            if (input.type === 'password') { input.type = 'text'; btn.textContent = '🙈'; }
            else { input.type = 'password'; btn.textContent = '👁'; }
        }

        function checkStrength() {
            const pwd = document.getElementById('password').value;
            const segs = [document.getElementById('s1'), document.getElementById('s2'), document.getElementById('s3'), document.getElementById('s4')];
            const txt = document.getElementById('strengthText');
            let score = 0;
            if (pwd.length >= 8) score++;
            if (/[A-Z]/.test(pwd)) score++;
            if (/[0-9]/.test(pwd)) score++;
            if (/[^A-Za-z0-9]/.test(pwd)) score++;
            const colors = ['#e53935', '#f4a825', '#3a9fd6', '#2e9b6e'];
            const labels = ['Weak', 'Fair', 'Good', 'Strong'];
            segs.forEach((s, i) => { s.style.background = i < score ? colors[score - 1] : 'var(--border)'; });
            txt.textContent = pwd.length > 0 ? labels[score - 1] || '' : '';
            txt.style.color = score > 0 ? colors[score - 1] : 'var(--muted)';
        }
    </script>

</body>
</html>