<%@ page import="java.sql.*" %>

<%
String email = (String) session.getAttribute("email");

if (email == null || email.trim().isEmpty()) {
    response.sendRedirect("login.html");
    return;
}

/* Prevent browser caching */
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);


/* =========================================
   CHECK WHETHER VOTER HAS ALREADY VOTED
   ========================================= */

boolean hasVoted = false;

Connection checkCon = null;
PreparedStatement checkPs = null;
ResultSet checkRs = null;

try {

    Class.forName("com.mysql.cj.jdbc.Driver");

    checkCon = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/votingdb",
        "root",
        "adminmyy"
    );

    checkPs = checkCon.prepareStatement(
        "SELECT id FROM votes WHERE voter_email = ?"
    );

    checkPs.setString(1, email);

    checkRs = checkPs.executeQuery();

    if (checkRs.next()) {
        hasVoted = true;
    }

} catch (Exception e) {

    out.println(
        "<div style='color:red;text-align:center;padding:20px;'>" +
        "Database Error: " +
        e.getMessage() +
        "</div>"
    );

} finally {

    try {
        if (checkRs != null) checkRs.close();
    } catch (Exception ignored) {}

    try {
        if (checkPs != null) checkPs.close();
    } catch (Exception ignored) {}

    try {
        if (checkCon != null) checkCon.close();
    } catch (Exception ignored) {}
}


String error = request.getParameter("error");
%>


<!DOCTYPE html>

<html>

<head>

    <title>Cast Your Vote</title>


    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }


        body {

            min-height: 100vh;

            padding: 40px;

            background:
            linear-gradient(
                rgba(0,0,0,0.65),
                rgba(0,0,0,0.65)
            ),
            url("img/vote.png");

            background-size: cover;

            background-position: center;
        }


        /* =========================
           LOGOUT
           ========================= */

        .logout {

            position: fixed;

            top: 20px;

            right: 25px;

            background: #cc0000;

            color: white;

            padding: 11px 22px;

            text-decoration: none;

            border-radius: 8px;

            font-weight: bold;

            font-size: 16px;
        }


        .logout:hover {

            background: #990000;
        }


        /* =========================
           MAIN CONTAINER
           ========================= */

        .container {

            width: 80%;

            max-width: 1000px;

            margin: 50px auto;

            background: rgba(255,255,255,0.96);

            padding: 40px;

            border-radius: 18px;

            box-shadow:
                0 0 20px
                rgba(0,0,0,0.4);
        }


        h1 {

            text-align: center;

            color: #1e3c72;

            margin-bottom: 15px;

            font-size: 45px;
        }


        .info {

            text-align: center;

            font-size: 18px;

            color: #555;

            margin-bottom: 25px;

            line-height: 1.6;
        }


        /* =========================
           WARNING
           ========================= */

        .warning {

            background: #fff3cd;

            border: 1px solid #ffe69c;

            color: #856404;

            padding: 15px;

            border-radius: 10px;

            text-align: center;

            margin-bottom: 25px;

            font-size: 16px;

            line-height: 1.5;
        }


        /* =========================
           ERROR
           ========================= */

        .error {

            background: #f8d7da;

            border: 1px solid #f5c2c7;

            color: #842029;

            padding: 15px;

            border-radius: 10px;

            text-align: center;

            margin-bottom: 25px;

            font-size: 17px;

            font-weight: bold;
        }


        /* =========================
           CANDIDATE
           ========================= */

        .candidate {

            background: #f4f7ff;

            border: 2px solid #d6dff5;

            padding: 25px;

            margin-bottom: 20px;

            border-radius: 14px;

            transition: 0.3s;
        }


        .candidate:hover {

            border-color: #1e3c72;

            transform: translateY(-2px);

            box-shadow:
                0 5px 15px
                rgba(30,60,114,0.15);
        }


        .candidate label {

            display: flex;

            align-items: flex-start;

            cursor: pointer;
        }


        .candidate input {

            margin-right: 18px;

            margin-top: 8px;

            width: 20px;

            height: 20px;

            cursor: pointer;
        }


        .candidate-details h2 {

            color: #1e3c72;

            margin-bottom: 10px;

            font-size: 28px;
        }


        .candidate-details p {

            font-size: 17px;

            color: #444;

            margin-bottom: 6px;
        }


        /* =========================
           BUTTON
           ========================= */

        .btn-box {

            text-align: center;

            margin-top: 30px;
        }


        .btn {

            padding: 14px 35px;

            background: #1e3c72;

            color: white;

            border: none;

            border-radius: 8px;

            font-size: 19px;

            cursor: pointer;

            transition: 0.3s;
        }


        .btn:hover {

            background: #16325c;

            transform: translateY(-2px);
        }


        .back {

            display: inline-block;

            margin-top: 20px;

            text-decoration: none;

            color: #1e3c72;

            font-size: 17px;

            font-weight: bold;
        }


        .back:hover {

            text-decoration: underline;
        }


        /* =========================
           ALREADY VOTED
           ========================= */

        .already-voted {

            text-align: center;

            padding: 30px;
        }


        .already-icon {

            font-size: 75px;

            color: #28a745;

            margin-bottom: 15px;
        }


        .already-voted h1 {

            margin-bottom: 20px;
        }


        .already-voted p {

            color: #555;

            font-size: 19px;

            line-height: 1.7;

            margin-bottom: 10px;
        }


        .status-btn {

            display: inline-block;

            margin-top: 25px;

            padding: 14px 28px;

            background: #1e3c72;

            color: white;

            text-decoration: none;

            border-radius: 8px;

            font-size: 17px;
        }


        .status-btn:hover {

            background: #16325c;
        }


        @media(max-width:700px) {

            body {

                padding: 20px;
            }


            .container {

                width: 100%;

                padding: 25px;
            }


            h1 {

                font-size: 32px;
            }

        }

    </style>

</head>


<body>


<a href="LogoutServlet" class="logout">

    Logout

</a>


<div class="container">


<%
/* =========================================
   IF ALREADY VOTED
   ========================================= */

if (hasVoted) {

%>


    <div class="already-voted">


      

        <h1>

            Vote Already Cast

        </h1>


        <p>

            You have already submitted your vote.

        </p>


        <p>

            You cannot cast another vote.

        </p>


        <p>

            Your vote has been recorded securely.

        </p>


        <a
            href="status.jsp"
            class="status-btn"
        >

            View Voting Status

        </a>


        <br>


        <a
            href="voter-dashboard.jsp"
            class="back"
        >

            Back To Dashboard

        </a>


    </div>


<%

} else {

%>


    <!-- =========================
         VOTING FORM
         ========================= -->


    <h1>

        Cast Your Vote

    </h1>


    <div class="info">

        Select your preferred candidate
        and submit your vote securely.

    </div>


    <div class="warning">

        <b>Important:</b>

        You can vote only once.

        Once your vote is submitted,
        it cannot be changed.

        Please check your selection
        carefully before submitting.

    </div>


    <% if ("select".equals(error)) { %>

        <div class="error">

            Please select a candidate
            before submitting your vote.

        </div>

    <% } %>


    <% if ("invalid".equals(error)) { %>

        <div class="error">

            Invalid candidate selected.
            Please try again.

        </div>

    <% } %>


    <form
        action="VoteServlet"
        method="post"
        onsubmit="return confirmVote();"
    >


        <%

        Connection con = null;

        PreparedStatement ps = null;

        ResultSet rs = null;


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

                "SELECT id, name, party, age " +
                "FROM candidates " +
                "ORDER BY id"

            );


            rs = ps.executeQuery();


            while (rs.next()) {

        %>


        <div class="candidate">


            <label>


                <!--
                    IMPORTANT:
                    The name must be candidateId
                -->

                <input
                    type="radio"
                    name="candidateId"
                    value="<%= rs.getInt("id") %>"
                    required
                >


                <div class="candidate-details">


                    <h2>

                        <%= rs.getString("name") %>

                    </h2>


                    <p>

                        <b>Party:</b>

                        <%= rs.getString("party") %>

                    </p>


                    <p>

                        <b>Age:</b>

                        <%= rs.getInt("age") %>

                    </p>


                </div>


            </label>


        </div>


        <%

            }

        } catch (Exception e) {

        %>


            <div class="error">

                Failed to load candidates.

                <br><br>

                <%= e.getMessage() %>

            </div>


        <%

        } finally {


            try {

                if (rs != null) rs.close();

            } catch (Exception ignored) {}


            try {

                if (ps != null) ps.close();

            } catch (Exception ignored) {}


            try {

                if (con != null) con.close();

            } catch (Exception ignored) {}

        }

        %>


        <div class="btn-box">


            <button
                type="submit"
                class="btn"
            >

                Submit Vote

            </button>


            <br>


            <a
                href="voter-dashboard.jsp"
                class="back"
            >

                Back To Dashboard

            </a>


        </div>


    </form>


<%

}

%>


</div>


<script>

function confirmVote() {

    return confirm(
        "Are you sure you want to submit your vote?\n\n" +
        "Your vote cannot be changed after submission."
    );

}

</script>


</body>

</html>