<%@ page import="java.sql.*" %>

<%
String email = (String) session.getAttribute("email");

if (email == null || email.trim().isEmpty()) {
    response.sendRedirect("login.html");
    return;
}


/* Prevent back button and caching */

response.setHeader(
    "Cache-Control",
    "no-cache, no-store, must-revalidate"
);

response.setHeader("Pragma", "no-cache");

response.setDateHeader("Expires", 0);


/* Voting information */

boolean voted = false;

String candidateName = "";
String party = "";
String voteTime = "";

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;


try {

    Class.forName("com.mysql.cj.jdbc.Driver");


    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/votingdb",
        "root",
        "adminmyy"
    );


    /*
       Check whether this voter has already voted.
       Also get the candidate name and vote time.
    */

    String sql =
        "SELECT c.name, c.party, v.vote_time " +
        "FROM votes v " +
        "JOIN candidates c " +
        "ON v.candidate_id = c.id " +
        "WHERE v.voter_email = ?";


    ps = con.prepareStatement(sql);

    ps.setString(1, email);

    rs = ps.executeQuery();


    if (rs.next()) {

        voted = true;

        candidateName =
            rs.getString("name");

        party =
            rs.getString("party");

        voteTime =
            rs.getString("vote_time");
    }


} catch (Exception e) {

%>

    <div style="
        color:red;
        text-align:center;
        padding:20px;
        font-family:Arial;
    ">

        Database Error:
        <%= e.getMessage() %>

    </div>

<%

} finally {


    try {

        if (rs != null) {
            rs.close();
        }

    } catch (Exception ignored) {}


    try {

        if (ps != null) {
            ps.close();
        }

    } catch (Exception ignored) {}


    try {

        if (con != null) {
            con.close();
        }

    } catch (Exception ignored) {}

}

%>


<!DOCTYPE html>

<html>

<head>

    <title>Voting Status</title>


    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }


        body {

            min-height: 100vh;

            display: flex;

            justify-content: center;

            align-items: center;

            background:
            linear-gradient(
                rgba(0,0,0,0.65),
                rgba(0,0,0,0.65)
            ),
            url("img/vote.png");

            background-size: cover;

            background-position: center;

            padding: 30px;
        }


        .box {

            width: 550px;

            max-width: 100%;

            background:
                rgba(255,255,255,0.96);

            padding: 45px;

            border-radius: 18px;

            text-align: center;

            box-shadow:
                0px 15px 40px
                rgba(0,0,0,0.35);

            animation:
                fadeIn 0.7s ease;
        }


        @keyframes fadeIn {

            from {

                opacity: 0;

                transform:
                    translateY(20px);
            }

            to {

                opacity: 1;

                transform:
                    translateY(0);
            }
        }


        .icon {

            font-size: 60px;

            margin-bottom: 15px;
        }


        .success {

            color: #28a745;
        }


        .pending {

            color: #ff9800;
        }


        h1 {

            color: #1e3c72;

            margin-bottom: 20px;

            font-size: 32px;
        }


        .status-text {

            font-size: 18px;

            color: #555;

            line-height: 1.7;

            margin-bottom: 25px;
        }


        .status-badge {

            display: inline-block;

            padding: 9px 20px;

            border-radius: 30px;

            font-size: 15px;

            font-weight: bold;

            margin-bottom: 25px;
        }


        .voted-badge {

            background: #dff5e3;

            color: #218838;
        }


        .pending-badge {

            background: #fff3cd;

            color: #d68910;
        }


        .details {

            background: #f4f7ff;

            border-radius: 12px;

            padding: 20px;

            margin-bottom: 25px;

            text-align: left;
        }


        .detail-row {

            display: flex;

            justify-content: space-between;

            gap: 20px;

            padding: 10px 0;

            border-bottom:
                1px solid #dfe5ef;
        }


        .detail-row:last-child {

            border-bottom: none;
        }


        .label {

            color: #777;

            font-weight: bold;
        }


        .value {

            color: #1e3c72;

            font-weight: bold;

            text-align: right;
        }


        .warning {

            background: #fff3cd;

            color: #856404;

            border: 1px solid #ffe69c;

            padding: 15px;

            border-radius: 10px;

            margin-bottom: 25px;

            font-size: 15px;

            line-height: 1.5;
        }


        .info {

            background: #e8f1ff;

            color: #24558a;

            border: 1px solid #c9ddf7;

            padding: 15px;

            border-radius: 10px;

            margin-bottom: 25px;

            font-size: 15px;

            line-height: 1.5;
        }


        .btn {

            display: inline-block;

            padding: 14px 28px;

            background: #1e3c72;

            color: white;

            text-decoration: none;

            border-radius: 8px;

            font-size: 17px;

            transition: 0.3s;
        }


        .btn:hover {

            background: #16325c;

            transform:
                translateY(-2px);
        }


        @media (max-width: 600px) {

            body {

                padding: 20px;
            }


            .box {

                padding: 30px 20px;
            }


            h1 {

                font-size: 26px;
            }


            .detail-row {

                flex-direction: column;

                gap: 4px;
            }


            .value {

                text-align: left;
            }

        }

    </style>

</head>


<body>


<div class="box">


<%

if (voted) {

%>






    <h1>

        Vote Submitted Successfully

    </h1>


    <p class="status-text">

        Thank you for participating in the election.

        <br>

        Your vote has been recorded securely.

    </p>


    <div class="details">


        <div class="detail-row">

            <span class="label">
                Voter Email
            </span>

            <span class="value">
                <%= email %>
            </span>

        </div>


        <div class="detail-row">

            <span class="label">
                Candidate
            </span>

            <span class="value">
                <%= candidateName %>
            </span>

        </div>


        <div class="detail-row">

            <span class="label">
                Party
            </span>

            <span class="value">
                <%= party %>
            </span>

        </div>


        <div class="detail-row">

            <span class="label">
                Vote Time
            </span>

            <span class="value">
                <%= voteTime %>
            </span>

        </div>


    </div>


    <div class="warning">

        Your vote has already been submitted.

        <br>

        You cannot cast another vote.

    </div>


<%

} else {

%>


    <div class="icon pending">
        !
    </div>


    <div class="status-badge pending-badge">

        NOT VOTED

    </div>


    <h1>

        Vote Pending

    </h1>


    <p class="status-text">

        You have not cast your vote yet.

        <br>

        Please participate before the election closes.

    </p>


    <div class="info">

        You can cast your vote only once.
        Please review your candidate selection
        carefully before submitting.

    </div>


    <a href="vote.jsp" class="btn">

        Cast Your Vote

    </a>


<%

}

%>


    <br>


    <a href="voter-dashboard.jsp"
       class="btn"
       style="margin-top:15px;">

        Back To Dashboard

    </a>


</div>


</body>

</html>