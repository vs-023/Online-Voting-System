<%@ page import="java.sql.*" %>

<%
/* =========================================
   PREVENT CACHE
   ========================================= */

response.setHeader(
    "Cache-Control",
    "no-cache, no-store, must-revalidate"
);

response.setHeader("Pragma", "no-cache");

response.setDateHeader("Expires", 0);


/* =========================================
   SESSION
   ========================================= */

String email =
    (String) session.getAttribute("email");

String admin =
    (String) session.getAttribute("admin");

String userType =
    (String) session.getAttribute("user_type");


/* =========================================
   DATABASE VARIABLES
   ========================================= */

Connection con = null;

PreparedStatement ps = null;

ResultSet rs = null;


String winner = "No Winner Yet";

int maxVotes = -1;

int totalVotes = 0;

boolean hasCandidates = false;


/* =========================================
   DATABASE
   ========================================= */

try {

    Class.forName(
        "com.mysql.cj.jdbc.Driver"
    );


    con = DriverManager.getConnection(

        "jdbc:mysql://localhost:3306/votingdb",

        "root",

        "adminmyy"
    );


    ps = con.prepareStatement(

        "SELECT id, name, party, age, votes " +
        "FROM candidates " +
        "ORDER BY votes DESC, name ASC"

    );


    rs = ps.executeQuery();


    while (rs.next()) {

        hasCandidates = true;

        int votes =
            rs.getInt("votes");


        totalVotes += votes;


        if (votes > maxVotes) {

            maxVotes = votes;

            winner =
                rs.getString("name");
        }
    }


    rs.close();

    ps.close();


    /*
     * Run query again to display
     * candidates.
     */

    ps = con.prepareStatement(

        "SELECT id, name, party, age, votes " +
        "FROM candidates " +
        "ORDER BY votes DESC, name ASC"

    );


    rs = ps.executeQuery();


} catch (Exception e) {

%>

<div class="error">

    Database Error:
    <%= e.getMessage() %>

</div>

<%

}
%>


<!DOCTYPE html>

<html>

<head>

    <title>Election Results</title>


    <style>

        * {

            margin: 0;

            padding: 0;

            box-sizing: border-box;

            font-family: Arial, sans-serif;
        }


        body {

            min-height: 100vh;

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


        /* =========================
           HEADER
           ========================= */

        .header {

            width: 90%;

            max-width: 1100px;

            margin: auto;

            display: flex;

            justify-content: space-between;

            align-items: center;

            background: rgba(255,255,255,0.96);

            padding: 18px 25px;

            border-radius: 12px;

            box-shadow:
                0 5px 20px
                rgba(0,0,0,0.3);
        }


        .logo {

            color: #1e3c72;

            font-size: 25px;

            font-weight: bold;
        }


        .header-right {

            display: flex;

            gap: 10px;
        }


        .header-btn {

            text-decoration: none;

            padding: 10px 17px;

            border-radius: 7px;

            background: #1e3c72;

            color: white;

            font-size: 14px;

            font-weight: bold;
        }


        .header-btn:hover {

            background: #16325c;
        }


        .logout {

            background: #cc0000;
        }


        .logout:hover {

            background: #990000;
        }


        /* =========================
           MAIN
           ========================= */

        .container {

            width: 90%;

            max-width: 1100px;

            margin: 35px auto;

            background:
                rgba(255,255,255,0.97);

            padding: 40px;

            border-radius: 18px;

            box-shadow:
                0 10px 30px
                rgba(0,0,0,0.35);
        }


        h1 {

            text-align: center;

            color: #1e3c72;

            font-size: 40px;

            margin-bottom: 10px;
        }


        .subtitle {

            text-align: center;

            color: #666;

            font-size: 17px;

            margin-bottom: 30px;
        }


        /* =========================
           WINNER
           ========================= */

        .winner {

            background:
                linear-gradient(
                    135deg,
                    #1e3c72,
                    #2a5298
                );

            color: white;

            padding: 30px;

            border-radius: 15px;

            text-align: center;

            margin-bottom: 30px;

            box-shadow:
                0 8px 20px
                rgba(30,60,114,0.3);
        }


        .winner-title {

            font-size: 18px;

            margin-bottom: 10px;

            opacity: 0.9;
        }


        .winner-name {

            font-size: 32px;

            font-weight: bold;

            margin-bottom: 10px;
        }


        .winner-votes {

            font-size: 18px;

            opacity: 0.95;
        }


        /* =========================
           SUMMARY
           ========================= */

        .summary {

            display: grid;

            grid-template-columns:
                repeat(
                    auto-fit,
                    minmax(220px,1fr)
                );

            gap: 20px;

            margin-bottom: 30px;
        }


        .summary-card {

            background: #f4f7ff;

            border: 1px solid #d6dff5;

            padding: 22px;

            border-radius: 12px;

            text-align: center;
        }


        .summary-card h3 {

            color: #1e3c72;

            margin-bottom: 10px;
        }


        .summary-card p {

            font-size: 28px;

            font-weight: bold;

            color: #333;
        }


        /* =========================
           CANDIDATE RESULTS
           ========================= */

        .results-title {

            color: #1e3c72;

            margin-bottom: 20px;

            font-size: 25px;
        }


        .candidate {

            background: white;

            border: 1px solid #ddd;

            padding: 22px;

            border-radius: 12px;

            margin-bottom: 15px;

            transition: 0.3s;
        }


        .candidate:hover {

            transform: translateY(-2px);

            box-shadow:
                0 5px 15px
                rgba(0,0,0,0.12);
        }


        .candidate-top {

            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-bottom: 12px;
        }


        .candidate-name {

            font-size: 22px;

            font-weight: bold;

            color: #1e3c72;
        }


        .candidate-vote {

            font-size: 20px;

            font-weight: bold;

            color: #333;
        }


        .party {

            color: #666;

            margin-bottom: 12px;
        }


        .bar-background {

            width: 100%;

            height: 13px;

            background: #e5e5e5;

            border-radius: 20px;

            overflow: hidden;
        }


        .bar {

            height: 100%;

            background: #1e3c72;

            border-radius: 20px;

            transition: width 0.5s;
        }


        /* =========================
           EMPTY
           ========================= */

        .empty {

            text-align: center;

            padding: 40px;

            color: #666;

            font-size: 18px;
        }


        /* =========================
           ERROR
           ========================= */

        .error {

            width: 80%;

            margin: 50px auto;

            padding: 20px;

            background: #f8d7da;

            color: #842029;

            border-radius: 10px;

            text-align: center;
        }


        /* =========================
           BACK
           ========================= */

        .back-box {

            text-align: center;

            margin-top: 30px;
        }


        .back {

            display: inline-block;

            padding: 13px 25px;

            background: #1e3c72;

            color: white;

            text-decoration: none;

            border-radius: 8px;

            font-weight: bold;
        }


        .back:hover {

            background: #16325c;
        }


        /* =========================
           FOOTER
           ========================= */

        .footer {

            text-align: center;

            color: white;

            margin-top: 25px;

            font-size: 14px;
        }


        @media(max-width:700px) {

            body {

                padding: 15px;
            }


            .container {

                width: 100%;

                padding: 25px;
            }


            .header {

                width: 100%;

                flex-direction: column;

                gap: 15px;
            }


            h1 {

                font-size: 30px;
            }


            .candidate-top {

                flex-direction: column;

                align-items: flex-start;

                gap: 8px;
            }

        }

    </style>

</head>


<body>


<!-- =========================
     HEADER
     ========================= -->

<div class="header">


    <div class="logo">

        Online Voting System

    </div>


    <div class="header-right">


        <a
            href="home.html"
            class="header-btn"
        >

            Home

        </a>


        <% if (email != null) { %>


            <a
                href="voter-dashboard.jsp"
                class="header-btn"
            >

                Dashboard

            </a>


            <a
                href="LogoutServlet"
                class="header-btn logout"
            >

                Logout

            </a>


        <% } else { %>


            <a
                href="login.html"
                class="header-btn"
            >

                Login

            </a>


            <a
                href="register.html"
                class="header-btn"
            >

                Register

            </a>


        <% } %>


    </div>


</div>



<!-- =========================
     MAIN CONTAINER
     ========================= -->

<div class="container">


    <h1>

        Election Results

    </h1>


    <p class="subtitle">

        Current voting results and candidate standings

    </p>



<%

if (hasCandidates) {

%>


    <!-- =========================
         WINNER
         ========================= -->

    <div class="winner">


        <div class="winner-title">

            Leading Candidate

        </div>


        <div class="winner-name">

            <%= winner %>

        </div>


        <div class="winner-votes">

            Votes: <%= maxVotes %>

        </div>


    </div>



    <!-- =========================
         SUMMARY
         ========================= -->

    <div class="summary">


        <div class="summary-card">

            <h3>

                Total Votes

            </h3>


            <p>

                <%= totalVotes %>

            </p>

        </div>


        <div class="summary-card">

            <h3>

                Candidates

            </h3>


            <p>

                <%

                /*
                 * Count candidates
                 */

                int candidateCount = 0;

                if (rs != null) {

                    while (rs.next()) {

                        candidateCount++;

                    }

                    rs.close();

                    rs = null;
                }

                %>

                <%= candidateCount %>

            </p>

        </div>


    </div>



    <!-- =========================
         RESULTS
         ========================= -->

    <h2 class="results-title">

        Candidate Results

    </h2>


    <%

    /*
     * Run query again for displaying
     * candidate results.
     */

    ps = con.prepareStatement(

        "SELECT id, name, party, age, votes " +
        "FROM candidates " +
        "ORDER BY votes DESC, name ASC"

    );


    rs = ps.executeQuery();


    while (rs.next()) {


        String candidateName =
            rs.getString("name");


        String party =
            rs.getString("party");


        int candidateVotes =
            rs.getInt("votes");


        double percentage = 0;


        if (totalVotes > 0) {

            percentage =
                ((double) candidateVotes /
                totalVotes) * 100;
        }


    %>


    <div class="candidate">


        <div class="candidate-top">


            <div class="candidate-name">

                <%= candidateName %>

            </div>


            <div class="candidate-vote">

                <%= candidateVotes %> votes

            </div>


        </div>


        <div class="party">

            Party:
            <b><%= party %></b>

        </div>


        <div class="bar-background">


            <div
                class="bar"
                style="width:<%= percentage %>%"
            >
            </div>


        </div>


        <div
            style="
                text-align:right;
                margin-top:7px;
                color:#666;
                font-size:14px;
            "
        >

            <%= String.format("%.1f", percentage) %>%

        </div>


    </div>


    <%

    }


} else {

    %>


    <div class="empty">

        No candidates have been added yet.

    </div>


    <%

}

%>


    <div class="back-box">


        <a
            href="voter-dashboard.jsp"
            class="back"
        >

            Back To Dashboard

        </a>


    </div>


</div>



<div class="footer">

    Online Voting System | Election Results

</div>



<%

/* =========================================
   CLOSE DATABASE
   ========================================= */

try {

    if (rs != null) rs.close();

} catch (Exception ignored) {}


try {

    if (ps != null) ps.close();

} catch (Exception ignored) {}


try {

    if (con != null) con.close();

} catch (Exception ignored) {}

%>


</body>

</html>