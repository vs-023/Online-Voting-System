<%@ page import="java.sql.*" %>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

String email = (String) session.getAttribute("email");
String admin = (String) session.getAttribute("admin");
String userType = (String) session.getAttribute("user_type");
%>

<!DOCTYPE html>
<html>
<head>

<title>Election Results</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>

/* ===== GLOBAL ===== */
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, sans-serif;
}

body{
    background:#f4f4f4;
}

/* ===== TOP RIGHT DASHBOARD BUTTON ===== */
.top-right {
    position: fixed;
    top: 20px;
    right: 20px;
    z-index: 1000;
}

.top-right a{
    background:#1e3c72;
    color:white;
    text-decoration:none;
    padding:10px 16px;
    border-radius:8px;
    font-weight:bold;
    font-size:14px;
    transition:0.3s;
}

.top-right a:hover{
    background:#16325c;
}

/* ===== NAV (MATCH HOME) ===== */
nav{
    background:#1e3c72;
    color:white;
    padding:18px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

nav h2{
    font-size:32px;
    margin-left:20px;
}

nav a{
    color:white;
    text-decoration:none;
    margin:0 15px;
    font-size:18px;
}

nav a:hover{
    color:#ffd700;
}

/* ===== BANNER ===== */
.banner{
    height:250px;
    background:linear-gradient(rgba(0,0,0,0.6),rgba(0,0,0,0.6)),
    url("img/results.png");
    background-size:cover;
    background-position:center;
    display:flex;
    justify-content:center;
    align-items:center;
    color:white;
}

.banner h1{
    font-size:55px;
}

/* ===== CONTAINER ===== */
.container{
    width:90%;
    margin:40px auto;
}

/* ===== CARD ===== */
.card{
    background:white;
    padding:25px;
    border-radius:12px;
    box-shadow:0 0 12px rgba(0,0,0,0.1);
    margin-bottom:25px;
}

/* ===== TABLE ===== */
table{
    width:100%;
    border-collapse:collapse;
}

th{
    background:#1e3c72;
    color:white;
    padding:12px;
}

td{
    text-align:center;
    padding:12px;
    border-bottom:1px solid #ddd;
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

<nav>
    <h2>ONLINE VOTING SYSTEM</h2>

    <div>
        <a href="home.html">Home</a>
        <a href="login.html">Login</a>
        <a href="register.html">Register</a>
    </div>
</nav>

<div class="banner">
    <h1>ELECTION RESULTS</h1>
</div>

<div class="container">

<div class="card">

<h2 style="color:#1e3c72; margin-bottom:15px;">Live Voting Results</h2>

<table>
<tr>
<th>Candidate</th>
<th>Party</th>
<th>Age</th>
<th>Votes</th>
</tr>

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

StringBuilder names = new StringBuilder();
StringBuilder votesArr = new StringBuilder();

int maxVotes = -1;
String winner = "No Candidate";

try {

Class.forName("com.mysql.cj.jdbc.Driver");

con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/votingdb",
"root",
"myadmin"
);

ps = con.prepareStatement("SELECT * FROM candidates");
rs = ps.executeQuery();

while(rs.next()){

String name = rs.getString("name");
String party = rs.getString("party");
int age = rs.getInt("age");
int votes = rs.getInt("votes");

if(votes > maxVotes){
    maxVotes = votes;
    winner = name;
}

names.append("'").append(name).append("',");
votesArr.append(votes).append(",");
%>

<tr>
<td><%= name %></td>
<td><%= party %></td>
<td><%= age %></td>
<td><%= votes %></td>
</tr>

<%
}

} catch(Exception e){
    out.println("<h3>Database Error: " + e.getMessage() + "</h3>");
}
%>

</table>

</div>

</div>

</body>
</html>