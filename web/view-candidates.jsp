<%@ page import="java.sql.*" %>

<%

String email =
        (String) session.getAttribute("email");

if(email == null){

    response.sendRedirect("login.html");

    return;
}

/* Prevent back after logout */

response.setHeader(
        "Cache-Control",
        "no-cache, no-store, must-revalidate"
);

response.setHeader("Pragma", "no-cache");

response.setDateHeader("Expires", 0);

%>

<!DOCTYPE html>
<html>
<head>

<title>View Candidates</title>

<style>

body{
    font-family:Arial;
    background:#f4f4f4;
}

.container{

    width:80%;
    margin:50px auto;

    background:white;

    padding:40px;

    border-radius:10px;

    box-shadow:0px 0px 10px rgba(0,0,0,0.2);
}

h1{

    text-align:center;
    color:#1e3c72;
    margin-bottom:30px;
}

table{

    width:100%;
    border-collapse:collapse;
}

th,td{

    padding:15px;
    border:1px solid #ccc;
    text-align:center;
}

th{

    background:#1e3c72;
    color:white;
}

.btn{

    display:inline-block;

    margin-top:20px;

    padding:12px 20px;

    background:#1e3c72;

    color:white;

    text-decoration:none;

    border-radius:6px;
}

.btn:hover{

    background:#16325c;
}

</style>

</head>

<body>

<div class="container">

<h1>Election Candidates</h1>

<table>

<tr>
<th>ID</th>
<th>Name</th>
<th>Party</th>
<th>Age</th>
</tr>

<%

Connection con = null;

try{

    Class.forName("com.mysql.cj.jdbc.Driver");

    con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/votingdb",
            "root",
            "myadmin"
    );

    Statement st = con.createStatement();

    ResultSet rs = st.executeQuery(
            "SELECT * FROM candidates"
    );

    while(rs.next()){

%>

<tr>

<td><%= rs.getInt("id") %></td>

<td><%= rs.getString("name") %></td>

<td><%= rs.getString("party") %></td>

<td><%= rs.getInt("age") %></td>

</tr>

<%

    }

    rs.close();
    st.close();

}catch(Exception e){

%>

<tr>

<td colspan="4" style="color:red;">

    Database Error:
    <%= e.getMessage() %>

</td>

</tr>

<%

}finally{

    try{

        if(con != null){

            con.close();
        }

    }catch(Exception ignored){}
}

%>

</table>

<center>
<a href="voter-dashboard.jsp" class="btn">Back</a>
</center>

</div>

</body>
</html>