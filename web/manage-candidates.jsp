<%@ page import="java.sql.*" %>

<%
response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires", 0);

String email = (String) session.getAttribute("email");
String admin = (String) session.getAttribute("admin");

if (email == null && admin == null) {
    response.sendRedirect("login.html");
    return;
}
%>

<!DOCTYPE html>
<html>

<head>

<title>Candidates Info</title>

<style>

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

.navbar{
background:#1e3c72;
padding:18px 40px;
display:flex;
justify-content:space-between;
align-items:center;
color:white;
}

.navbar h1{
font-size:28px;
}

.navbar a{
color:white;
text-decoration:none;
font-size:18px;
background:#16325c;
padding:10px 16px;
border-radius:6px;
}

.navbar a:hover{
background:#0f2342;
}

/* BANNER */

.banner{
position:relative;
height:260px;
margin-bottom:30px;

background:
linear-gradient(rgba(0,0,0,0.65), rgba(0,0,0,0.65)),
url("img/candidate.png");

background-size:cover;
background-position:center;

display:flex;
justify-content:center;
align-items:center;
text-align:center;

color:white;
}

.banner h1{
font-size:52px;
text-shadow:2px 2px 10px black;
}

.banner p{
font-size:20px;
margin-top:10px;
opacity:0.9;
}

/* CONTAINER */

.container{
width:90%;
margin:40px auto;
background:white;
padding:40px;
border-radius:12px;
box-shadow:0px 0px 12px rgba(0,0,0,0.2);
}

h2{
color:#1e3c72;
margin-bottom:25px;
text-align:center;
}

/* TABLE */

table{
width:100%;
border-collapse:collapse;
margin-top:20px;
}

table th{
background:#1e3c72;
color:white;
padding:14px;
font-size:16px;
}

table td{
padding:14px;
border:1px solid #ccc;
text-align:center;
}

tr:hover{
background:#f1f1f1;
}

.vote{
font-weight:bold;
color:green;
}

.empty{
text-align:center;
padding:20px;
font-size:20px;
color:#cc0000;
}

</style>

</head>

<body>

<div class="navbar">

<h1>Manage Candidates</h1>

<a href="admin-dashboard.jsp">Back</a>

</div>

<!-- BANNER -->
<div class="banner">

    <div>
        <h1>Registered Candidates</h1>
        <p>Pre-Assigned Candidate List for Election System</p>
    </div>

</div>

<div class="container">

<h2>Pre-Registered Candidates</h2>

<table>

<tr>
<th>ID</th>
<th>Name</th>
<th>Party</th>
<th>Age</th>
<th>Votes</th>
</tr>

<%

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/votingdb",
"root",
"myadmin"
);

ps = con.prepareStatement("SELECT * FROM candidates");

rs = ps.executeQuery();

boolean found = false;

while(rs.next()){

found = true;

%>

<tr>

<td><%= rs.getInt("id") %></td>
<td><%= rs.getString("name") %></td>
<td><%= rs.getString("party") %></td>
<td><%= rs.getInt("age") %></td>
<td class="vote"><%= rs.getInt("votes") %></td>

</tr>

<%

}

if(!found){
%>

<tr>
<td colspan="5" class="empty">
No Candidates Found
</td>
</tr>

<%
}

}catch(Exception e){
out.println("<tr><td colspan='5' class='empty'>Database Error</td></tr>");
e.printStackTrace();

}finally{

try{
if(rs != null) rs.close();
if(ps != null) ps.close();
if(con != null) con.close();
}catch(Exception ignored){}
}

%>

</table>

</div>

</body>
</html>