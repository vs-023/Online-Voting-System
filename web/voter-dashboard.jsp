<%@ page import="java.sql.*" %>

<%
String email = (String) session.getAttribute("email");

if (email == null || email.trim().isEmpty()) {
    response.sendRedirect("login.html");
    return;
}

String name = "";

String url = "jdbc:mysql://localhost:3306/votingdb";
String username = "root";
String password = "adminmyy";

try {

    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        url,
        username,
        password
    );

    PreparedStatement ps = con.prepareStatement(
        "SELECT name FROM voters WHERE email = ?"
    );

    ps.setString(1, email);

    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        name = rs.getString("name");
    }

    rs.close();
    ps.close();
    con.close();

} catch (Exception e) {

    out.println("<h3>Database Error</h3>");
    out.println("<p>" + e.getMessage() + "</p>");
}
%>


<!DOCTYPE html>

<html lang="en">

<head>

<title>Voter Dashboard | Online Voting System</title>

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

.header {
    background: linear-gradient(135deg, #173f73, #2868a8);
    color: white;
    padding: 18px 6%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 4px 15px rgba(0,0,0,0.15);
    position: sticky;
    top: 0;
    z-index: 100;
}

.logo {
    display: flex;
    align-items: center;
    font-size: 21px;
    font-weight: bold;
}

.header-right {
    display: flex;
    align-items: center;
    gap: 18px;
    font-size: 13px;
}

.portal-text {
    opacity: 0.9;
}


.top-logout {
    display: inline-block;
    background: #d9534f;
    color: white;
    text-decoration: none;
    padding: 8px 16px;
    border-radius: 6px;
    font-size: 13px;
    font-weight: bold;
    transition: 0.25s;
}

.top-logout:hover {
    background: #b52b27;
    transform: translateY(-1px);
}


.container {
    width: 92%;
    max-width: 1150px;
    margin: 35px auto 50px;
}


.welcome {
    position: relative;
    overflow: hidden;
    background: linear-gradient(135deg, #173f73, #2868a8);
    color: white;
    padding: 35px;
    border-radius: 18px;
    margin-bottom: 30px;
    box-shadow: 0 10px 30px rgba(31,62,100,0.18);
}

.welcome::after {
    content: "";
    position: absolute;
    width: 180px;
    height: 180px;
    border-radius: 50%;
    background: rgba(255,255,255,0.07);
    right: -50px;
    top: -70px;
}

.welcome::before {
    content: "";
    position: absolute;
    width: 100px;
    height: 100px;
    border-radius: 50%;
    background: rgba(255,255,255,0.06);
    right: 110px;
    bottom: -50px;
}

.welcome-content {
    position: relative;
    z-index: 2;
}

.welcome-tag {
    display: inline-block;
    background: rgba(255,255,255,0.15);
    padding: 6px 13px;
    border-radius: 20px;
    font-size: 12px;
    margin-bottom: 12px;
}

.welcome h2 {
    margin: 0 0 8px;
    font-size: 30px;
}

.welcome p {
    margin: 6px 0;
    opacity: 0.9;
    font-size: 14px;
}

.email {
    font-weight: 600;
}


.section-heading {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 18px;
}

.section-heading h2 {
    margin: 0;
    color: #173f73;
    font-size: 21px;
}

.section-heading span {
    color: #7b8490;
    font-size: 13px;
}


.cards {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
}

.card {
    position: relative;
    background: white;
    padding: 25px;
    border-radius: 15px;
    border: 1px solid #e5eaf0;
    box-shadow: 0 5px 18px rgba(31,62,100,0.08);

    transition:
        transform 0.25s ease,
        box-shadow 0.25s ease,
        border-color 0.25s ease;

    overflow: hidden;
}

.card::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 4px;
    background: linear-gradient(90deg, #173f73, #4b8ac0);
}

.card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 28px rgba(31,62,100,0.15);
    border-color: #c5d7e8;
}


.card h3 {
    margin: 0 0 10px;
    padding-top: 5px;
    color: #173f73;
    font-size: 18px;
}

.card p {
    margin: 0 0 20px;
    color: #727b86;
    font-size: 13px;
    line-height: 1.6;
    min-height: 42px;
}



.btn {
    display: inline-block;
    background: #2868a8;
    color: white;
    padding: 10px 17px;
    text-decoration: none;
    border-radius: 7px;
    font-size: 13px;
    font-weight: bold;
    transition: 0.25s;
}

.btn:hover {
    background: #173f73;
    transform: translateY(-1px);
}


.logout {
    background: #d9534f;
}

.logout:hover {
    background: #b52b27;
}



.message {
    margin-top: 25px;
    padding: 15px 18px;
    border-radius: 10px;
    background: #dff5e5;
    color: #23733b;
    border: 1px solid #bce3c7;
    font-size: 14px;
    font-weight: bold;
}

.error-message {
    background: #fdeaea;
    color: #a33a36;
    border: 1px solid #f2c2c0;
}


.footer {
    text-align: center;
    color: #89939e;
    font-size: 12px;
    padding: 25px 0 10px;
}


@media (max-width: 900px) {

    .cards {
        grid-template-columns: repeat(2, 1fr);
    }

}


@media (max-width: 600px) {

    .header {
        padding: 15px 5%;
    }

    .logo {
        font-size: 17px;
    }

    .header-right {
        display: flex;
        gap: 8px;
    }

    .portal-text {
        display: none;
    }

    .top-logout {
        padding: 7px 12px;
        font-size: 12px;
    }

    .container {
        width: 94%;
        margin-top: 25px;
    }

    .welcome {
        padding: 27px 22px;
        border-radius: 15px;
    }

    .welcome h2 {
        font-size: 24px;
    }

    .cards {
        grid-template-columns: 1fr;
        gap: 15px;
    }

    .section-heading span {
        display: none;
    }

    .card {
        padding: 22px;
    }

}

</style>

</head>


<body>

<div class="header">


    <div class="logo">

        <span>
            Online Voting System
        </span>

    </div>


    <div class="header-right">

        <span class="portal-text">
            Voter Portal
        </span>

        <a href="logout.html" class="top-logout">
            Logout
        </a>

    </div>


</div>


<div class="container">

    
    <div class="welcome">

        <div class="welcome-content">

            <span class="welcome-tag">
                Voter Account
            </span>

            <h2>
                Welcome, <%= name %>!
            </h2>

            <p>
                You are successfully logged in to the
                Online Voting System.
            </p>

            <p class="email">
                <%= email %>
            </p>

        </div>

    </div>


    <div class="section-heading">

        <h2>
            Voter Services
        </h2>

        <span>
            Manage your voting activities
        </span>

    </div>


    <div class="cards">


        <!-- PROFILE -->

        <div class="card">

            <h3>
                My Profile
            </h3>

            <p>
                View your registered voter
                information and personal details.
            </p>

            <a href="profile.jsp" class="btn">
                View Profile
            </a>

        </div>



        <!-- CANDIDATES -->

        <div class="card">

            <h3>
                View Candidates
            </h3>

            <p>
                View the candidates participating
                in the election.
            </p>

            <a href="view-candidates.jsp" class="btn">
                Candidates
            </a>

        </div>



        <!-- CAST VOTE -->

        <div class="card">

            <h3>
                Cast Vote
            </h3>

            <p>
                Cast your vote securely in the
                ongoing election.
            </p>

            <a href="vote.jsp" class="btn">
                Vote Now
            </a>

        </div>



        <!-- STATUS -->

        <div class="card">

            <h3>
                Voting Status
            </h3>

            <p>
                Check whether your vote has
                already been submitted.
            </p>

            <a href="status.jsp" class="btn">
                Check Status
            </a>

        </div>



        <!-- RESULTS -->

        <div class="card">

            <h3>
                Election Results
            </h3>

            <p>
                View the latest election results
                and voting outcome.
            </p>

            <a href="results.jsp" class="btn">
                View Results
            </a>

        </div>



        <!-- RULES -->

        <div class="card">

            <h3>
                Voting Rules
            </h3>

            <p>
                Read election rules, eligibility
                requirements and guidelines.
            </p>

            <a href="rules.html" class="btn">
                View Rules
            </a>

        </div>



        <!-- HELP -->

        <div class="card">

            <h3>
                Help and Support
            </h3>

            <p>
                Find answers and guidance for
                using the voting system.
            </p>

            <a href="help.html" class="btn">
                Get Help
            </a>

        </div>



        <!-- CONTACT -->

        <div class="card">

            <h3>
                Contact Administration
            </h3>

            <p>
                Contact the election administration
                for assistance.
            </p>

            <a href="contact.html" class="btn">
                Contact
            </a>

        </div>



        <!-- LOGOUT -->

        <div class="card">

            <h3>
                Logout
            </h3>

            <p>
                Securely log out of your
                voter account.
            </p>

            <a href="logout.html" class="btn logout">
                Logout
            </a>

        </div>


    </div>



    <% if ("already_voted".equals(request.getParameter("error"))) { %>

        <div class="message error-message">

            You have already voted!

        </div>

    <% } %>



    <% if ("voted".equals(request.getParameter("success"))) { %>

        <div class="message">

            Vote submitted successfully!

        </div>

    <% } %>


    <div class="footer">

        Online Voting System | Voter Portal

    </div>


</div>


</body>

</html>