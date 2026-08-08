<%@ page import="java.sql.*" %>

<%
String admin = (String) session.getAttribute("admin");

if(admin == null){
    response.sendRedirect("login.html");
    return;
}

/* Prevent back after logout */
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>

<!DOCTYPE html>
<html>

<head>

<title>Correction Requests</title>

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
font-size:30px;
}

.navbar a{
text-decoration:none;
color:white;
background:#16325c;
padding:10px 16px;
border-radius:6px;
transition:0.3s;
}

.navbar a:hover{
background:#0f2342;
}

/* CONTAINER */

.container{
width:92%;
margin:40px auto;
background:white;
padding:35px;
border-radius:12px;
box-shadow:0px 0px 12px rgba(0,0,0,0.15);
}

.container h2{
margin-bottom:25px;
color:#1e3c72;
text-align:center;
font-size:34px;
}

/* TABLE */

table{
width:100%;
border-collapse:collapse;
margin-top:20px;
}

th{
background:#1e3c72;
color:white;
padding:14px;
font-size:16px;
}

td{
padding:14px;
border:1px solid #ccc;
text-align:center;
font-size:16px;
}

tr:hover{
background:#f5f5f5;
}

/* STATUS */

.pending{
color:#d48806;
font-weight:bold;
}

.approved{
color:green;
font-weight:bold;
}

.rejected{
color:red;
font-weight:bold;
}

/* EMPTY */

.empty{
text-align:center;
padding:20px;
font-size:20px;
color:#cc0000;
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

</style>

</head>

<body>

<!-- NAVBAR -->

<div class="navbar">

<h1>Correction Requests</h1>

<a href="admin-dashboard.jsp">

Back To Dashboard

</a>

</div>

<!-- CONTAINER -->

<div class="container">

<h2>Voter Correction Requests</h2>

<table>

<tr>

<th>ID</th>
<th>Email</th>
<th>Request Type</th>
<th>Message</th>
<th>Status</th>

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

ps = con.prepareStatement("SELECT * FROM requests");

rs = ps.executeQuery();

boolean found = false;

while(rs.next()){

found = true;

String status = rs.getString("status");

if(status == null || status.trim().equals("")){
status = "Pending";
}

String cssClass = "pending";

if(status.equalsIgnoreCase("Approved")){
cssClass = "approved";
}
else if(status.equalsIgnoreCase("Rejected")){
cssClass = "rejected";
}

%>

<tr>

<td><%= rs.getInt("id") %></td>

<td><%= rs.getString("user_email") %></td>

<td><%= rs.getString("request_type") %></td>

<td><%= rs.getString("message") %></td>

<td class="<%= cssClass %>">

<%= status %>

</td>

</tr>

<%

}

if(!found){
%>

<tr>

<td colspan="5" class="empty">

No Requests Found

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

<footer>

© 2026 Online Voting System | Admin Requests Panel

</footer>

</body>

</html>