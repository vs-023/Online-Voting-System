<%@ page import="java.sql.*" %>

<%

String email = (String) session.getAttribute("email");

if(email == null){

    response.sendRedirect("login.html");

    return;
}

boolean voted = false;

try{

    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/votingdb",
            "root",
            "myadmin"
    );

    PreparedStatement ps =
            con.prepareStatement(
                    "SELECT * FROM votes WHERE voter_email=?"
            );

    ps.setString(1, email);

    ResultSet rs = ps.executeQuery();

    if(rs.next()){

        voted = true;
    }

    con.close();

}catch(Exception e){

    e.printStackTrace();
}

%>

<!DOCTYPE html>
<html>

<head>

    <title>Voting Status</title>

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:Arial,sans-serif;
        }

        body{

            height:100vh;

            display:flex;

            justify-content:center;

            align-items:center;

            background:
            linear-gradient(rgba(0,0,0,0.65),
            rgba(0,0,0,0.65)),
            url("img/vote.png");

            background-size:cover;
            background-position:center;
        }

        .box{

            width:500px;

            background:rgba(255,255,255,0.96);

            padding:45px;

            border-radius:18px;

            text-align:center;

            box-shadow:0px 15px 40px rgba(0,0,0,0.35);

            animation:fadeIn 0.7s ease;
        }

        @keyframes fadeIn{

            from{
                opacity:0;
                transform:translateY(20px);
            }

            to{
                opacity:1;
                transform:translateY(0);
            }
        }

        .icon{

            font-size:70px;

            margin-bottom:20px;
        }

        .success{

            color:#28a745;
        }

        .pending{

            color:#ff9800;
        }

        h1{

            color:#1e3c72;

            margin-bottom:20px;

            font-size:34px;
        }

        p{

            font-size:18px;

            color:#555;

            line-height:1.7;

            margin-bottom:30px;
        }

        .btn{

            display:inline-block;

            padding:14px 28px;

            background:#1e3c72;

            color:white;

            text-decoration:none;

            border-radius:8px;

            font-size:17px;

            transition:0.3s;
        }

        .btn:hover{

            background:#16325c;

            transform:translateY(-2px);
        }

    </style>

</head>

<body>

<div class="box">

    <%

    if(voted){

    %>

        <div class="icon success">

        </div>

        <h1>

            Vote Submitted Successfully

        </h1>

        <p>

            Thank you for participating in the election.
            <br>
            Your vote has been recorded securely.

        </p>

    <%

    }else{

    %>

        <div class="icon pending">


        </div>

        <h1>

            Vote Pending

        </h1>

        <p>

            You have not cast your vote yet.
            <br>
            Please participate before the election closes.

        </p>

    <%

    }

    %>

    <a href="voter-dashboard.jsp" class="btn">

        Back To Dashboard

    </a>

</div>

</body>

</html>