<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires", 0);

String email = (String) session.getAttribute("email");
String admin = (String) session.getAttribute("admin");
String userType = (String) session.getAttribute("user_type");

if (email == null && admin == null) {
    response.sendRedirect("login.html");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>

<title>Election Rules</title>

<style>

body{
font-family:Arial;
background:#f4f4f4;
}

/* TOP RIGHT BUTTON */
.top-right {
    position: fixed;
    top: 20px;
    right: 20px;
    z-index: 1000;
}

.top-right a{
    background:#1e3c72;
    color:white;
    padding:10px 16px;
    text-decoration:none;
    border-radius:8px;
    font-weight:bold;
    font-size:14px;
    transition:0.3s;
}

.top-right a:hover{
    background:#16325c;
}

.container{
width:85%;
margin:40px auto;
background:white;
padding:40px;
border-radius:12px;
}

h1{
text-align:center;
color:#1e3c72;
margin-bottom:30px;
}

.rule{
background:#eef3ff;
padding:20px;
margin-bottom:20px;
border-left:6px solid #1e3c72;
border-radius:8px;
}

.rule h3{
margin-bottom:10px;
color:#1e3c72;
}

.rule p{
font-size:17px;
line-height:1.7;
}

</style>

</head>

<body>

<!-- BACK TO DASHBOARD BUTTON -->
<div class="top-right">
    <a href="<%= "admin".equals(userType) ? "admin-dashboard.jsp" : "voter-dashboard.jsp" %>">
        Back to Dashboard
    </a>
</div>

<div class="container">

<h1>Election Rules & Regulations</h1>

<div class="rule">

<h3>One Voter One Vote</h3>
<p>Every registered voter can cast only one vote.</p>

</div>

<div class="rule">

<h3>Fair Elections</h3>
<p>Election activities must remain transparent and unbiased.</p>

</div>

<div class="rule">

<h3>Admin Responsibilities</h3>
<p>Admins must manage election data securely and ethically.</p>

</div>

<div class="rule">

<h3>Vote Privacy</h3>
<p>Voting information must remain confidential.</p>

</div>

<div class="rule">

<h3>Secure Authentication</h3>
<p>Only authenticated voters can access voting services.</p>

</div>

</div>

</body>
</html>