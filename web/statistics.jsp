<%@ page import="java.sql.*" %>

<%
String admin = (String) session.getAttribute("admin");

if(admin == null){
    response.sendRedirect("login.html");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>

<title>Voting Statistics - Admin</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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

/* NAV */
.navbar{
    background:#1e3c72;
    color:white;
    padding:18px 30px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.navbar a{
    color:white;
    text-decoration:none;
}

/* CONTAINER */
.container{
    width:85%;
    margin:40px auto;
    background:white;
    padding:40px;
    border-radius:15px;
    box-shadow:0px 0px 15px rgba(0,0,0,0.15);
    text-align:center;
}

h1{
    color:#1e3c72;
    margin-bottom:20px;
}

/* CARDS */
.grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
    gap:20px;
    margin-bottom:30px;
}

.card{
    background:#1e3c72;
    color:white;
    padding:25px;
    border-radius:12px;
    font-size:20px;
}

/* BUTTONS */
.btn-group{
    margin:20px 0;
}

.btn{
    padding:10px 18px;
    margin:5px;
    border:none;
    border-radius:6px;
    cursor:pointer;
    background:#1e3c72;
    color:white;
    font-size:15px;
}

.btn:hover{
    background:#16325c;
}

/* CHART */
.chart-box{
    width:70%;
    margin:auto;
}

</style>

</head>

<body>

<div class="navbar">
    <h2>Voting Statistics</h2>
    <a href="admin-dashboard.jsp">Back</a>
</div>

<div class="container">

<h1>Election Analytics Dashboard</h1>

<%

int voters = 0;
int votes = 0;
int remaining = 0;

try{

    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/votingdb",
        "root",
        "myadmin"
    );

    Statement st = con.createStatement();

    ResultSet rs1 = st.executeQuery("SELECT COUNT(*) FROM voters");
    if(rs1.next()) voters = rs1.getInt(1);

    ResultSet rs2 = st.executeQuery("SELECT COUNT(*) FROM votes");
    if(rs2.next()) votes = rs2.getInt(1);

    remaining = voters - votes;
    if(remaining < 0) remaining = 0;

    con.close();

}catch(Exception e){
    out.println(e);
}

%>

<!-- STATS -->
<div class="grid">

    <div class="card">Total Voters<br><b><%= voters %></b></div>
    <div class="card">Votes Cast<br><b><%= votes %></b></div>
    <div class="card">Not Voted<br><b><%= remaining %></b></div>

</div>

<!-- BUTTONS -->
<div class="btn-group">
    <button class="btn" onclick="showBar()">Bar Chart</button>
    <button class="btn" onclick="showPie()">Pie Chart</button>
</div>

<!-- CHART -->
<div class="chart-box">

<canvas id="chartCanvas"></canvas>

</div>

</div>

<script>

let chart;

const data = {
    labels: ['Registered Voters', 'Votes Casted', 'Not Voted'],
    datasets: [{
        label: 'Voting Stats',
        data: [<%= voters %>, <%= votes %>, <%= remaining %>],
        backgroundColor: ['#1e3c72', '#28a745', '#dc3545']
    }]
};

function createBar(){
    return new Chart(document.getElementById('chartCanvas'), {
        type: 'bar',
        data: data,
        options: {
            responsive: true,
            scales: {
                y: { beginAtZero: true }
            }
        }
    });
}

function createPie(){
    return new Chart(document.getElementById('chartCanvas'), {
        type: 'pie',
        data: data
    });
}

function showBar(){
    if(chart) chart.destroy();
    chart = createBar();
}

function showPie(){
    if(chart) chart.destroy();
    chart = createPie();
}

// default
chart = createBar();

</script>

</body>
</html>