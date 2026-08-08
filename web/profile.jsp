<%@ page import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires", 0);

String email = (String) session.getAttribute("email");

if (email == null || email.trim().isEmpty()) {
    response.sendRedirect("login.html");
    return;
}

String name = "", mobile = "", dob = "", gender = "", voterid = "", aadhaar = "", address = "";

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {

    Class.forName("com.mysql.cj.jdbc.Driver");

    con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/votingdb",
            "root",
            "myadmin"
    );

    ps = con.prepareStatement("SELECT * FROM voters WHERE email=?");
    ps.setString(1, email);

    rs = ps.executeQuery();

    if (rs.next()) {

        name = rs.getString("name");
        mobile = rs.getString("mobile");
        dob = rs.getString("dob");
        gender = rs.getString("gender");
        voterid = rs.getString("voterid");
        aadhaar = rs.getString("aadhaar");
        address = rs.getString("address");

    } else {
        response.sendRedirect("login.html?error=1");
        return;
    }

} catch (Exception e) {
    e.printStackTrace();
}

finally {
    try { if (rs != null) rs.close(); } catch(Exception ignored){}
    try { if (ps != null) ps.close(); } catch(Exception ignored){}
    try { if (con != null) con.close(); } catch(Exception ignored){}
}
%>

<!DOCTYPE html>
<html>
<head>
<title>My Profile</title>

<style>

body{
    margin:0;
    font-family:Arial;
    background:linear-gradient(rgba(0,0,0,0.6),rgba(0,0,0,0.6)),
    url("img/slide2.png");
    background-size:cover;
    display:flex;
    justify-content:center;
    align-items:center;
    min-height:100vh;
}

/* TOP BUTTON */
.top-btn{
    position:fixed;
    top:20px;
    right:20px;
}

.top-btn a{
    background:#1e3c72;
    color:white;
    padding:10px 15px;
    text-decoration:none;
    border-radius:8px;
    font-weight:bold;
    transition:0.3s;
}

.top-btn a:hover{
    background:#16325c;
}

/* CARD */
.card{
    width:420px;
    background:white;
    padding:30px;
    border-radius:15px;
    box-shadow:0 0 25px rgba(0,0,0,0.4);
}

/* TITLE */
h2{
    text-align:center;
    color:#1e3c72;
    margin-bottom:20px;
}

/* FIELD */
.row{
    margin:12px 0;
    padding:10px;
    background:#f4f6ff;
    border-left:5px solid #1e3c72;
    border-radius:6px;
}

.label{
    font-weight:bold;
    color:#1e3c72;
}

.value{
    color:#333;
}

/* EMAIL BOX */
.email-box{
    text-align:center;
    margin-bottom:15px;
    color:#555;
}

</style>
</head>

<body>

<!-- BACK BUTTON -->
<div class="top-btn">
    <a href="voter-dashboard.jsp">Back to Dashboard</a>
</div>

<div class="card">

<h2>My Profile</h2>

<div class="email-box">
    Logged in as: <b><%= email %></b>
</div>

<div class="row"><span class="label">Name:</span> <span class="value"><%= name %></span></div>
<div class="row"><span class="label">Mobile:</span> <span class="value"><%= mobile %></span></div>
<div class="row"><span class="label">DOB:</span> <span class="value"><%= dob %></span></div>
<div class="row"><span class="label">Gender:</span> <span class="value"><%= gender %></span></div>
<div class="row"><span class="label">Voter ID:</span> <span class="value"><%= voterid %></span></div>
<div class="row"><span class="label">Aadhaar:</span> <span class="value"><%= aadhaar %></span></div>
<div class="row"><span class="label">Address:</span> <span class="value"><%= address %></span></div>

</div>

</body>
</html>