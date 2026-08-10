<%@ page import="java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires", 0);

String email = (String) session.getAttribute("email");

if (email == null || email.trim().isEmpty()) {
    response.sendRedirect("login.html");
    return;
}

String name = "";
String mobile = "";
String dob = "";
String gender = "";
String voterid = "";
String aadhaar = "";
String address = "";

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

    ps = con.prepareStatement(
        "SELECT * FROM voters WHERE email=?"
    );

    ps.setString(1, email);

    rs = ps.executeQuery();

    if (rs.next()) {

        name = rs.getString("name");
        mobile = rs.getString("mobile");
        dob = rs.getString("dob");
        gender = rs.getString("gender");
        voterid = rs.getString("voterid");
        aadhaar = rs.getString("aadhaar");
        address = rs.getString("address");

    } else {

        response.sendRedirect("login.html?error=1");
        return;
    }

} catch (Exception e) {

    e.printStackTrace();

} finally {

    try {
        if (rs != null) rs.close();
    } catch(Exception ignored) {}

    try {
        if (ps != null) ps.close();
    } catch(Exception ignored) {}

    try {
        if (con != null) con.close();
    } catch(Exception ignored) {}
}
%>


<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>My Profile - Online Voting System</title>


<style>

/* =========================
   GENERAL
========================= */

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, Helvetica, sans-serif;

    background:
        linear-gradient(
            135deg,
            #eef5fb,
            #f8fbff
        );

    color: #26384d;
}


/* =========================
   HEADER
========================= */

.header {
    background:
        linear-gradient(
            135deg,
            #173f73,
            #2868a8
        );

    color: white;

    padding: 18px 6%;

    display: flex;
    justify-content: space-between;
    align-items: center;

    box-shadow:
        0 4px 15px rgba(0,0,0,0.15);
}

.logo {
    font-size: 22px;
    font-weight: bold;
}

.dashboard-btn {
    text-decoration: none;
    color: white;

    background: rgba(255,255,255,0.15);

    padding: 10px 18px;

    border-radius: 7px;

    transition: 0.3s;
}

.dashboard-btn:hover {
    background: rgba(255,255,255,0.28);
}


/* =========================
   MAIN
========================= */

.container {
    width: 92%;
    max-width: 950px;

    margin: 45px auto;
}


/* =========================
   PROFILE CARD
========================= */

.profile-card {

    background: white;

    border-radius: 18px;

    overflow: hidden;

    box-shadow:
        0 10px 35px rgba(31,62,100,0.13);
}


/* =========================
   PROFILE TOP
========================= */

.profile-top {

    background:
        linear-gradient(
            135deg,
            #173f73,
            #2868a8
        );

    color: white;

    padding: 38px 35px;

    display: flex;

    align-items: center;

    gap: 22px;
}


/* AVATAR */

.avatar {

    width: 82px;
    height: 82px;

    border-radius: 50%;

    background:
        rgba(255,255,255,0.18);

    border:
        2px solid rgba(255,255,255,0.5);

    display: flex;

    justify-content: center;
    align-items: center;

    font-size: 40px;

    flex-shrink: 0;
}


.profile-info h1 {

    margin: 0 0 7px 0;

    font-size: 27px;
}

.profile-info p {

    margin: 4px 0;

    opacity: 0.88;

    font-size: 14px;
}


/* ACTIVE BADGE */

.active-badge {

    display: inline-block;

    margin-top: 9px;

    padding: 5px 13px;

    border-radius: 20px;

    background: #d9fbe5;

    color: #15803d;

    font-size: 12px;

    font-weight: bold;
}


/* =========================
   DETAILS
========================= */

.details {

    padding: 35px;
}


.section-title {

    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-bottom: 23px;
}


.section-title h2 {

    margin: 0;

    color: #173f73;

    font-size: 20px;
}


.section-title span {

    color: #777;

    font-size: 13px;
}


/* =========================
   GRID
========================= */

.details-grid {

    display: grid;

    grid-template-columns:
        repeat(2, 1fr);

    gap: 17px;
}


/* =========================
   INFORMATION BOX
========================= */

.info-box {

    background: #f8fafc;

    border: 1px solid #e5e9ef;

    border-radius: 11px;

    padding: 17px;

    transition: all 0.25s ease;
}

.info-box:hover {

    transform: translateY(-3px);

    box-shadow:
        0 7px 18px rgba(0,0,0,0.07);

    border-color: #b9cfe5;
}


.info-label {

    display: block;

    font-size: 11px;

    color: #7b8490;

    text-transform: uppercase;

    letter-spacing: 0.7px;

    margin-bottom: 7px;
}


.info-value {

    display: block;

    font-size: 15px;

    font-weight: 600;

    color: #26384d;

    word-break: break-word;
}


/* =========================
   VOTER ID
========================= */

.highlight {

    background:
        linear-gradient(
            135deg,
            #eef6ff,
            #f7fbff
        );

    border:
        1px solid #b8d3ec;
}


.highlight .info-value {

    color: #1f5f94;

    letter-spacing: 0.5px;
}


/* =========================
   ADDRESS
========================= */

.address {

    grid-column: 1 / -1;
}


/* =========================
   ACTIONS
========================= */

.actions {

    padding: 0 35px 35px;

    display: flex;

    justify-content: center;

    gap: 12px;
}


.btn {

    text-decoration: none;

    padding: 11px 22px;

    border-radius: 8px;

    font-size: 14px;

    font-weight: 600;

    transition: 0.25s;
}


.back-btn {

    background: #2868a8;

    color: white;
}


.back-btn:hover {

    background: #173f73;

    transform: translateY(-2px);
}


.logout-btn {

    background: #f1f3f5;

    color: #4a5562;
}


.logout-btn:hover {

    background: #e4e7eb;

    transform: translateY(-2px);
}


/* =========================
   MOBILE
========================= */

@media (max-width: 650px) {

    .header {

        padding: 16px 5%;
    }

    .logo {

        font-size: 18px;
    }

    .dashboard-btn {

        padding: 8px 12px;

        font-size: 13px;
    }

    .container {

        width: 94%;

        margin: 25px auto;
    }

    .profile-top {

        padding: 30px 20px;

        flex-direction: column;

        text-align: center;
    }

    .details {

        padding: 22px;
    }

    .details-grid {

        grid-template-columns: 1fr;
    }

    .address {

        grid-column: auto;
    }

    .section-title {

        display: block;
    }

    .section-title span {

        display: block;

        margin-top: 5px;
    }

    .actions {

        padding: 0 22px 25px;

        flex-direction: column;
    }

    .btn {

        text-align: center;
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
        🗳️ Online Voting System
    </div>


    <a href="voter-dashboard.jsp"
       class="dashboard-btn">

        Dashboard

    </a>

</div>



<!-- =========================
     MAIN PROFILE
========================= -->

<div class="container">


    <div class="profile-card">


        <!-- PROFILE HEADER -->

        <div class="profile-top">


            <div class="avatar">
                👤
            </div>


            <div class="profile-info">

                <h1>
                    <%= name %>
                </h1>

                <p>
                    <%= email %>
                </p>

                <span class="active-badge">
                    ● Active Voter
                </span>

            </div>


        </div>



        <!-- DETAILS -->

        <div class="details">


            <div class="section-title">

                <h2>
                    Personal Information
                </h2>

                <span>
                    Registered Voter Details
                </span>

            </div>



            <div class="details-grid">


                <!-- NAME -->

                <div class="info-box">

                    <span class="info-label">
                        Full Name
                    </span>

                    <span class="info-value">
                        <%= name %>
                    </span>

                </div>


                <!-- EMAIL -->

                <div class="info-box">

                    <span class="info-label">
                        Email Address
                    </span>

                    <span class="info-value">
                        <%= email %>
                    </span>

                </div>


                <!-- MOBILE -->

                <div class="info-box">

                    <span class="info-label">
                        Mobile Number
                    </span>

                    <span class="info-value">
                        <%= mobile %>
                    </span>

                </div>


                <!-- DOB -->

                <div class="info-box">

                    <span class="info-label">
                        Date of Birth
                    </span>

                    <span class="info-value">
                        <%= dob %>
                    </span>

                </div>


                <!-- GENDER -->

                <div class="info-box">

                    <span class="info-label">
                        Gender
                    </span>

                    <span class="info-value">
                        <%= gender %>
                    </span>

                </div>


                <!-- VOTER ID -->

                <div class="info-box highlight">

                    <span class="info-label">
                        Voter ID
                    </span>

                    <span class="info-value">
                        <%= voterid %>
                    </span>

                </div>


                <!-- AADHAAR -->

                <div class="info-box">

                    <span class="info-label">
                        Aadhaar Number
                    </span>

                    <span class="info-value">
                        <%= aadhaar %>
                    </span>

                </div>


                <!-- ADDRESS -->

                <div class="info-box address">

                    <span class="info-label">
                        Address
                    </span>

                    <span class="info-value">
                        <%= address %>
                    </span>

                </div>


            </div>

        </div>



        <!-- BUTTONS -->

        <div class="actions">


            <a href="voter-dashboard.jsp"
               class="btn back-btn">

                ← Back to Dashboard

            </a>


            <a href="logout.html"
               class="btn logout-btn">

                Logout

            </a>


        </div>


    </div>

</div>


</body>

</html>