<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Admin — EduPath</title>
  <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700&family=DM+Serif+Display&display=swap" rel="stylesheet"/>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root { --navy:#0d1b2a; --sky:#3a9fd6; --light:#f0f6fc; --white:#fff; --muted:#6b849a; --border:#d5e5f0; --success:#2e9b6e; }
    body { font-family:'Sora',sans-serif; background:var(--light); color:#1e2d3d; }
    nav { display:flex; justify-content:space-between; align-items:center; padding:0 5%; height:80px; background:var(--white); border-bottom:1px solid var(--border); }
    .logo { font-family:'DM Serif Display',serif; font-size:2.2rem; letter-spacing:-0.5px; color:var(--navy); text-decoration:none; }
    .logo span { color:var(--sky); }
    .nav-links a { margin-left:1rem; color:var(--muted); text-decoration:none; font-size:0.85rem; }
    .wrap { max-width:1100px; margin:0 auto; padding:2rem 5%; }
    h1 { font-family:'DM Serif Display',serif; font-size:2rem; color:var(--navy); margin-bottom:0.5rem; }
    .sub { color:var(--muted); margin-bottom:2rem; }
    .metrics { display:grid; grid-template-columns:repeat(2,1fr); gap:1rem; margin-bottom:2rem; }
    .metric { background:var(--white); border:1px solid var(--border); border-radius:12px; padding:1.25rem; }
    .metric-val { font-size:1.8rem; font-weight:700; color:var(--navy); }
    .metric-label { font-size:0.8rem; color:var(--muted); margin-top:0.25rem; }
    .card { background:var(--white); border:1px solid var(--border); border-radius:12px; padding:1.5rem; margin-bottom:1.5rem; }
    .card h2 { font-size:1rem; margin-bottom:1rem; color:var(--navy); }
    .grid { display:grid; grid-template-columns:repeat(2,1fr); gap:0.75rem; }
    label { font-size:0.75rem; font-weight:600; color:var(--muted); display:block; margin-bottom:0.25rem; }
    input, select { width:100%; padding:0.65rem 0.75rem; border:1px solid var(--border); border-radius:8px; font-family:'Sora',sans-serif; font-size:0.85rem; }
    .btn { background:var(--navy); color:white; border:none; border-radius:8px; padding:0.75rem 1.25rem; font-family:'Sora',sans-serif; font-weight:600; cursor:pointer; margin-top:1rem; }
    table { width:100%; border-collapse:collapse; font-size:0.85rem; }
    th, td { text-align:left; padding:0.75rem; border-bottom:1px solid var(--border); }
    th { color:var(--muted); font-size:0.75rem; text-transform:uppercase; }
    .btn-del { background:#fee; color:#c62828; border:1px solid #fcc; padding:0.35rem 0.65rem; border-radius:6px; cursor:pointer; font-size:0.75rem; }
    .alert { background:#e8f5e9; color:var(--success); padding:0.75rem 1rem; border-radius:8px; margin-bottom:1rem; font-size:0.85rem; }
    @media (max-width:768px) { .grid, .metrics { grid-template-columns:1fr; } }
  
</style>

</head>
<body>
<nav>
  <a class="logo" href="/">Edu<span>Path</span> Admin</a>
  <div class="nav-links">


    <span style="color:var(--muted);font-size:0.85rem;">${username}</span>
    <a href="/logout">Logout</a>
  </div>
</nav>

<div class="wrap">
  <h1>Platform Admin</h1>
  <p class="sub">Manage college listings and monitor platform usage.</p>

  <c:if test="${param.added == 'true'}"><div class="alert">College added successfully.</div></c:if>
  <c:if test="${param.deleted == 'true'}"><div class="alert">College removed successfully.</div></c:if>

  <div class="metrics">
    <div class="metric"><div class="metric-val">${collegeCount}</div><div class="metric-label">Colleges Listed</div></div>
    <div class="metric"><div class="metric-val">${userCount}</div><div class="metric-label">Registered Users</div></div>
  </div>

  <div class="card">
    <h2>Add New College</h2>
    <form action="/admin/colleges/add" method="post">
      <div class="grid">
        <div><label>Name</label><input name="name" required/></div>
        <div><label>City</label><input name="city" required/></div>
        <div><label>State</label><input name="state" required/></div>
        <div><label>Type</label><input name="collegeType" placeholder="Government / IIT / NIT" required/></div>
        <div><label>Stream</label><input name="stream" placeholder="Engineering (PCM)" required/></div>
        <div><label>Entrance Exam</label><input name="entranceExam" placeholder="JEE"/></div>
        <div><label>Fees (₹/yr)</label><input name="fees" type="number" min="0" required/></div>
        <div><label>Cut-off (%)</label><input name="cutoff" type="number" min="0" max="100" required/></div>
        <div><label>NIRF Rank</label><input name="nirfRank" type="number" min="1" required/></div>
        <div><label>Rating (0-5)</label><input name="rating" type="number" min="0" max="5" step="0.1" value="4.0"/></div>
      </div>
      <button class="btn" type="submit">Add College</button>
    </form>
  </div>

  <div class="card">
    <h2>Existing Colleges</h2>
    <table>
      <thead>
        <tr><th>Name</th><th>Location</th><th>Stream</th><th>Fees</th><th>Rank</th><th></th></tr>
      </thead>
      <tbody>
        <c:forEach var="c" items="${colleges}">
          <tr>
            <td>${c.name}</td>
            <td>${c.city}, ${c.state}</td>
            <td>${c.stream}</td>
            <td>₹${c.fees}</td>
            <td>#${c.nirfRank}</td>
            <td>
              <form action="/admin/colleges/delete" method="post" style="display:inline;">
                <input type="hidden" name="collegeId" value="${c.id}"/>
                <button class="btn-del" type="submit" onclick="return confirm('Delete this college?');">Delete</button>
              </form>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
  
  <div class="card">
    <h2>Registered Users</h2>
    <table>
      <thead>
        <tr><th>Name</th><th>Email</th><th>Class</th></tr>
      </thead>
      <tbody>
        <c:forEach var="u" items="${users}">
          <tr>
            <td>${u.fullName}</td>
            <td>${u.email}</td>
            <td>Class ${u.userClass}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>
