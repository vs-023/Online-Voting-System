<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires", 0);

String admin = (String) session.getAttribute("admin");

// STRICT ADMIN CHECK
if (admin == null) {
    response.sendRedirect("login.html");
    return;
}
%>

<!DOCTYPE html>
<html>

<head>

<title>Admin Dashboard</title>

<style>

/* (NO CHANGE IN YOUR CSS) */

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:Arial,sans-serif;
}

body{
background:#f4f4f4;
}

/* NAVBAR */
nav{
background:#1e3c72;
color:white;
padding:18px 30px;
display:flex;
justify-content:space-between;
align-items:center;
flex-wrap:wrap;
}

nav h2{
font-size:30px;
}

nav ul{
list-style:none;
display:flex;
flex-wrap:wrap;
}

nav ul li{
margin-left:25px;
margin-top:5px;
}

nav ul li a{
color:white;
text-decoration:none;
font-size:17px;
transition:0.3s;
}

nav ul li a:hover{
color:#ffd700;
}

.logout{
background:red;
padding:8px 14px;
border-radius:6px;
}

.logout:hover{
background:darkred;
color:white;
}

/* BANNER */
.banner{
height:400px;

background:
linear-gradient(rgba(0,0,0,0.6),
rgba(0,0,0,0.6)),
url("img/admin.png");

background-size:cover;
background-position:center;

display:flex;
justify-content:center;
align-items:center;

color:white;
text-align:center;
padding:20px;
}

.banner h1{
font-size:55px;
text-shadow:2px 2px 10px black;
}

/* ADMIN INFO */
.admin-box{
width:85%;
margin:40px auto;
background:white;
padding:30px;
text-align:center;
border-radius:12px;
box-shadow:0px 0px 12px rgba(0,0,0,0.15);
}

.admin-box h2{
color:#1e3c72;
margin-bottom:15px;
}

.admin-box p{
font-size:20px;
color:#444;
}

/* FEATURES */
.features{
width:90%;
margin:40px auto;

display:grid;
grid-template-columns:repeat(auto-fit,minmax(250px,1fr));

gap:25px;
}

.feature-box{
background:white;
padding:30px;
text-align:center;
border-radius:12px;
box-shadow:0px 0px 10px rgba(0,0,0,0.12);
transition:0.3s;
}

.feature-box:hover{
transform:translateY(-8px);
}

.feature-box h3{
color:#1e3c72;
margin-bottom:15px;
font-size:26px;
}

.feature-box p{
font-size:17px;
color:#555;
margin-bottom:25px;
line-height:1.6;
}

.btn{
background:#1e3c72;
color:white;
padding:12px 22px;
text-decoration:none;
border-radius:6px;
display:inline-block;
transition:0.3s;
}

.btn:hover{
background:#16325c;
}

/* FOOTER */
footer{
background:#1e3c72;
color:white;
text-align:center;
padding:15px;
margin-top:40px;
font-size:17px;
}

/* RESPONSIVE */
@media(max-width:768px){

nav{
flex-direction:column;
gap:15px;
}

nav ul{
justify-content:center;
}

.banner h1{
font-size:38px;
}

.admin-box{
width:95%;
}
}

</style>

</head>

<body>

<!-- NAVBAR -->

<nav>

<h2>ADMIN PANEL</h2>

<ul>

<li><a href="admin-dashboard.jsp">Dashboard</a></li>
<li><a href="manage-candidates.jsp">Candidates</a></li>
<li><a href="view-voters.jsp">Voters</a></li>
<li><a href="results.jsp">Results</a></li>
<li><a href="requests.jsp">Requests</a></li>
<li><a href="admin-rules.jsp">Rules</a></li>
<li><a href="LogoutServlet" class="logout">Logout</a></li>

</ul>

</nav>

<!-- BANNER -->

<div class="banner">

    <div>
        <h1>Welcome, <%= admin %></h1>
    </div>

</div>

<!-- ADMIN INFO -->

<div class="admin-box">

<h2>Administrator Access</h2>

<p>
Logged in as:
<b><%= admin %></b>
</p>

</div>

<!-- FEATURES -->

<div class="features">

<div class="feature-box">
<h3>Manage Candidates</h3>
<p>View and manage all election candidates.</p>
<a href="manage-candidates.jsp" class="btn">Open</a>
</div>

<div class="feature-box">
<h3>View Voters</h3>
<p>Access voter details and monitor voting status.</p>
<a href="view-voters.jsp" class="btn">Open</a>
</div>

<div class="feature-box">
<h3>Election Results</h3>
<p>Check live vote counts and leading candidates.</p>
<a href="results.jsp" class="btn">Open</a>
</div>

<div class="feature-box">
<h3>Correction Requests</h3>
<p>Review voter correction and update requests.</p>
<a href="requests.jsp" class="btn">Open</a>
</div>

</div>

<!-- FOOTER -->

<footer>
© 2026 Online Voting System | Admin Dashboard
</footer>

<script>
window.history.forward();
function noBack() {
    window.history.forward();
}
setTimeout(noBack, 0);
window.onpageshow = function(evt) {
    if (evt.persisted) noBack();
};
</script>

</body>

</html>