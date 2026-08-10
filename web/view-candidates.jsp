<%@ page import="java.sql.*" %>

<%
String email = (String) session.getAttribute("email");

if (email == null || email.trim().isEmpty()) {
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

    <title>View Candidates | Online Voting System</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: linear-gradient(135deg, #eef5fb, #f8fbff);
            color: #26384d;
            min-height: 100vh;
        }


        /* HEADER */

        .header {
            background: linear-gradient(135deg, #173f73, #2868a8);
            color: white;
            padding: 18px 6%;

            display: flex;
            justify-content: space-between;
            align-items: center;

            box-shadow: 0 4px 15px rgba(0,0,0,0.15);
        }


        .logo {
            font-size: 21px;
            font-weight: bold;
        }


        .header-right {
            display: flex;
            align-items: center;
            gap: 18px;
        }


        .portal {
            font-size: 13px;
            opacity: 0.9;
        }


        .logout {
            background: #d9534f;
            color: white;
            text-decoration: none;

            padding: 8px 16px;

            border-radius: 6px;

            font-size: 13px;
            font-weight: bold;

            transition: 0.25s;
        }


        .logout:hover {
            background: #b52b27;
        }


        /* MAIN CONTAINER */

        .container {
            width: 92%;
            max-width: 1100px;

            margin: 35px auto 50px;
        }


        /* INTRO */

        .intro {
            background: linear-gradient(
                135deg,
                #173f73,
                #2868a8
            );

            color: white;

            padding: 30px;

            border-radius: 17px;

            margin-bottom: 30px;

            box-shadow:
                0 10px 30px
                rgba(31,62,100,0.18);
        }


        .intro h1 {
            margin: 0 0 10px;
            font-size: 28px;
        }


        .intro p {
            margin: 0;

            font-size: 14px;

            opacity: 0.9;

            line-height: 1.6;
        }


        /* NAVIGATION */

        .navigation {
            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-bottom: 25px;
        }


        .navigation h2 {
            margin: 0;

            color: #173f73;

            font-size: 21px;
        }


        .dashboard-btn {
            background: #2868a8;

            color: white;

            text-decoration: none;

            padding: 10px 17px;

            border-radius: 7px;

            font-size: 13px;

            font-weight: bold;

            transition: 0.25s;
        }


        .dashboard-btn:hover {
            background: #173f73;
        }


        /* CANDIDATE GRID */

        .candidate-grid {
            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 22px;
        }


        /* CANDIDATE CARD */

        .candidate-card {
            background: white;

            border-radius: 15px;

            padding: 25px;

            border: 1px solid #e5eaf0;

            box-shadow:
                0 5px 18px
                rgba(31,62,100,0.08);

            transition:
                transform 0.25s ease,
                box-shadow 0.25s ease;

            position: relative;

            overflow: hidden;
        }


        .candidate-card::before {
            content: "";

            position: absolute;

            top: 0;
            left: 0;

            width: 100%;

            height: 4px;

            background:
                linear-gradient(
                    90deg,
                    #173f73,
                    #4b8ac0
                );
        }


        .candidate-card:hover {
            transform: translateY(-6px);

            box-shadow:
                0 12px 28px
                rgba(31,62,100,0.15);
        }


        /* CANDIDATE INFORMATION */

        .candidate-card h3 {
            margin: 0 0 8px;

            padding-top: 5px;

            color: #173f73;

            font-size: 19px;
        }


        .party {
            color: #2868a8;

            font-weight: bold;

            font-size: 14px;

            margin-bottom: 15px;
        }


        .details {
            border-top: 1px solid #edf0f3;

            padding-top: 14px;

            margin-top: 10px;
        }


        .detail {
            display: flex;

            justify-content: space-between;

            margin-bottom: 9px;

            font-size: 13px;
        }


        .detail-label {
            color: #7b8490;
        }


        .detail-value {
            color: #26384d;

            font-weight: bold;
        }


        /* VOTE BUTTON */

        .vote-btn {
            display: block;

            text-align: center;

            background: #2868a8;

            color: white;

            text-decoration: none;

            padding: 11px;

            border-radius: 7px;

            margin-top: 18px;

            font-size: 13px;

            font-weight: bold;

            transition: 0.25s;
        }


        .vote-btn:hover {
            background: #173f73;

            transform: translateY(-1px);
        }


        /* DATABASE ERROR */

        .error {
            background: #fdeaea;

            color: #a33a36;

            border: 1px solid #f2c2c0;

            padding: 18px;

            border-radius: 10px;

            margin-top: 20px;
        }


        /* FOOTER */

        .footer {
            text-align: center;

            color: #89939e;

            font-size: 12px;

            padding: 30px 0 10px;
        }


        /* TABLET */

        @media (max-width: 900px) {

            .candidate-grid {
                grid-template-columns:
                    repeat(2, 1fr);
            }

        }


        /* MOBILE */

        @media (max-width: 600px) {

            .header {
                padding: 15px 5%;
            }


            .logo {
                font-size: 17px;
            }


            .portal {
                display: none;
            }


            .container {
                width: 94%;

                margin-top: 25px;
            }


            .intro {
                padding: 25px 22px;
            }


            .intro h1 {
                font-size: 24px;
            }


            .navigation {
                align-items: flex-start;

                gap: 15px;

                flex-direction: column;
            }


            .candidate-grid {
                grid-template-columns: 1fr;
            }

        }

    </style>

</head>


<body>


<!-- HEADER -->

<div class="header">

    <div class="logo">

        Online Voting System

    </div>


    <div class="header-right">

        <span class="portal">

            Voter Portal

        </span>


        <a href="logout.html" class="logout">

            Logout

        </a>

    </div>

</div>



<!-- MAIN -->

<div class="container">


    <!-- INTRO -->

    <div class="intro">

        <h1>
            Election Candidates
        </h1>

        <p>
            View the candidates participating in
            the election before casting your vote.
        </p>

    </div>



    <!-- NAVIGATION -->

    <div class="navigation">

        <h2>
            Available Candidates
        </h2>


        <a href="voter-dashboard.jsp"
           class="dashboard-btn">

            Back to Dashboard

        </a>

    </div>



    <!-- CANDIDATES -->

    <div class="candidate-grid">


<%

Connection con = null;
Statement st = null;
ResultSet rs = null;

try {

    Class.forName("com.mysql.cj.jdbc.Driver");


    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/votingdb",
        "root",
        "adminmyy"
    );


    st = con.createStatement();


    rs = st.executeQuery(
        "SELECT id, name, party, age FROM candidates"
    );


    boolean found = false;


    while (rs.next()) {

        found = true;

        int id = rs.getInt("id");

        String candidateName =
            rs.getString("name");

        String party =
            rs.getString("party");

        int age =
            rs.getInt("age");

%>


        <!-- CANDIDATE CARD -->

        <div class="candidate-card">


            <h3>
                <%= candidateName %>
            </h3>


            <div class="party">
                <%= party %>
            </div>


            <div class="details">


                <div class="detail">

                    <span class="detail-label">
                        Candidate ID
                    </span>

                    <span class="detail-value">
                        <%= id %>
                    </span>

                </div>


                <div class="detail">

                    <span class="detail-label">
                        Age
                    </span>

                    <span class="detail-value">
                        <%= age %>
                    </span>

                </div>


            </div>


            <a href="vote.jsp"
               class="vote-btn">

                Vote for a Candidate

            </a>


        </div>


<%

    }


    if (!found) {

%>


        <div class="error">

            No candidates are currently available.

        </div>


<%

    }


} catch (Exception e) {

%>


        <div class="error">

            <strong>
                Database Error
            </strong>

            <br><br>

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

        if (st != null) {
            st.close();
        }

    } catch (Exception ignored) {}


    try {

        if (con != null) {
            con.close();
        }

    } catch (Exception ignored) {}

}

%>


    </div>



    <!-- FOOTER -->

    <div class="footer">

        Online Voting System | Voter Portal

    </div>


</div>


</body>

</html>