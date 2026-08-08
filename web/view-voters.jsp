<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %>

<%

String admin =
        (String) session.getAttribute("admin");

if(admin == null){

    response.sendRedirect("login.html");

    return;
}

/* Prevent back after logout */

response.setHeader("Cache-Control",
        "no-cache, no-store, must-revalidate");

response.setHeader("Pragma", "no-cache");

response.setDateHeader("Expires", 0);

%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>View Voters</title>

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

        nav{

            background:#1e3c72;

            color:white;

            padding:18px 30px;

            display:flex;

            justify-content:space-between;

            align-items:center;
        }

        nav h2{

            font-size:32px;
        }

        nav a{

            color:white;

            text-decoration:none;

            background:#16325c;

            padding:10px 18px;

            border-radius:6px;

            transition:0.3s;
        }

        nav a:hover{

            background:#0f2342;
        }

        /* BANNER */

        .banner{

            height:280px;

            background:
            linear-gradient(rgba(0,0,0,0.65),
            rgba(0,0,0,0.65)),
            url("img/candidate.png");

            background-size:cover;

            background-position:center;

            display:flex;

            justify-content:center;

            align-items:center;

            text-align:center;

            color:white;

            border-bottom:3px solid #1e3c72;
        }

        .banner h1{

            font-size:55px;

            text-shadow:2px 2px 8px black;
        }

        /* TABLE */

        .container{

            width:96%;

            margin:40px auto;

            background:white;

            padding:30px;

            border-radius:12px;

            box-shadow:0px 0px 15px rgba(0,0,0,0.2);

            overflow:auto;
        }

        table{

            width:100%;

            border-collapse:collapse;
        }

        th{

            background:#1e3c72;

            color:white;

            padding:15px;

            font-size:16px;
        }

        td{

            padding:14px;

            border-bottom:1px solid #ddd;

            text-align:center;

            font-size:15px;
        }

        tr:hover{

            background:#f1f1f1;
        }

        .active{

            color:green;

            font-weight:bold;
        }

        .voted{

            color:green;

            font-weight:bold;
        }

        .notvoted{

            color:red;

            font-weight:bold;
        }

        footer{

            background:#1e3c72;

            color:white;

            text-align:center;

            padding:18px;

            margin-top:40px;

            font-size:16px;
        }

    </style>

</head>

<body>

<!-- NAVBAR -->

<nav>

    <h2>VIEW VOTERS</h2>

    <a href="admin-dashboard.jsp">

        Back To Dashboard

    </a>

</nav>

<!-- BANNER -->

<div class="banner">

    <div>

        <h1>Registered Voters</h1>

    </div>

</div>

<!-- TABLE -->

<div class="container">

<table>

<tr>

    <th>ID</th>
    <th>Name</th>
    <th>Email</th>
    <th>Mobile</th>
    <th>DOB</th>
    <th>Gender</th>
    <th>Voter ID</th>
    <th>Aadhaar</th>
    <th>Address</th>
    <th>Account Status</th>
    <th>Voting Status</th>

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
            "SELECT * FROM voters"
    );

    while(rs.next()){

        String voterEmail = rs.getString("email");

        PreparedStatement ps = con.prepareStatement(
                "SELECT id FROM votes WHERE voter_email=?"
        );

        ps.setString(1, voterEmail);

        ResultSet voteRs = ps.executeQuery();

        boolean voted = voteRs.next();

%>

<tr>

    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getString("email") %></td>
    <td><%= rs.getString("mobile") %></td>
    <td><%= rs.getString("dob") %></td>
    <td><%= rs.getString("gender") %></td>
    <td><%= rs.getString("voterid") %></td>
    <td><%= rs.getString("aadhaar") %></td>
    <td><%= rs.getString("address") %></td>

    <td class="active">

        <%= rs.getString("status") == null
        ? "ACTIVE"
        : rs.getString("status") %>

    </td>

    <td>

        <%

        if(voted){

        %>

            <span class="voted">VOTED</span>

        <%

        }else{

        %>

            <span class="notvoted">NOT VOTED</span>

        <%

        }

        %>

    </td>

</tr>

<%

        voteRs.close();
        ps.close();

    }

    rs.close();
    st.close();

}catch(Exception e){

    out.println(
        "<h3 style='color:red;text-align:center;'>"
        + e.getMessage() +
        "</h3>"
    );

}finally{

    try{

        if(con != null){

            con.close();
        }

    }catch(Exception ignored){}
}

%>

</table>

</div>

<footer>

    © 2026 Online Voting System | Admin Panel

</footer>

</body>

</html>