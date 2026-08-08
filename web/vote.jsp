<%@ page import="java.sql.*" %>

<%
String email = (String) session.getAttribute("email");

if (email == null) {
    response.sendRedirect("login.html");
    return;
}

/* PREVENT BACK BUTTON + CACHING ISSUES */
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

/* OPTIONAL SAFETY: if already voted flag exists */
String voted = (String) session.getAttribute("voted");
if ("true".equals(voted)) {
    response.sendRedirect("vote-success.html");
    return;
}

/* Error / status messages */
String already = request.getParameter("already");
String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>

<head>
    <title>Cast Vote - Online Voting System</title>

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:Arial,sans-serif;
        }

        body{
            background:
            linear-gradient(rgba(0,0,0,0.65),
            rgba(0,0,0,0.65)),
            url("img/vote.png");

            background-size:cover;
            background-position:center;

            min-height:100vh;
            padding:40px;
        }

        .container{
            width:80%;
            max-width:1000px;
            margin:auto;
            background:rgba(255,255,255,0.96);
            padding:40px;
            border-radius:18px;
            box-shadow:0px 0px 20px rgba(0,0,0,0.4);
        }

        h1{
            text-align:center;
            color:#1e3c72;
            margin-bottom:35px;
            font-size:48px;
        }

        .info{
            text-align:center;
            font-size:18px;
            color:#555;
            margin-bottom:20px;
        }

        .error{
            color:red;
            text-align:center;
            margin:10px 0;
            font-size:18px;
            font-weight:bold;
        }

        form{
            margin-top:20px;
        }

        .candidate{
            background:#f4f7ff;
            border:2px solid #d6dff5;
            padding:25px;
            margin-bottom:25px;
            border-radius:14px;
        }

        .candidate label{
            display:flex;
            align-items:flex-start;
            cursor:pointer;
        }

        .candidate input{
            margin-right:18px;
            margin-top:8px;
            transform:scale(1.3);
        }

        .candidate-details h2{
            color:#1e3c72;
            margin-bottom:10px;
            font-size:30px;
        }

        .candidate-details p{
            font-size:18px;
            color:#444;
            margin-bottom:8px;
        }

        .btn-box{
            text-align:center;
            margin-top:35px;
        }

        .btn{
            padding:15px 35px;
            background:#1e3c72;
            color:white;
            border:none;
            border-radius:8px;
            font-size:20px;
            cursor:pointer;
        }

        .btn:hover{
            background:#16325c;
        }

        .back{
            display:inline-block;
            margin-top:20px;
            text-decoration:none;
            color:#1e3c72;
            font-size:18px;
            font-weight:bold;
        }

        .back:hover{
            text-decoration:underline;
        }

    </style>

</head>

<body>

<div class="container">

    <h1>Cast Your Vote</h1>

    <div class="info">
        Select one candidate carefully. Once submitted, your vote cannot be changed.
    </div>

    <% if ("1".equals(already)) { %>
        <div class="error">You have already voted. Multiple voting is not allowed.</div>
    <% } %>

    <% if ("select".equals(error)) { %>
        <div class="error">Please select a candidate before submitting.</div>
    <% } %>

    <form action="VoteServlet" method="post">

<%
Connection con = null;
Statement st = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/votingdb",
            "root",
            "myadmin"
    );

    st = con.createStatement();
    rs = st.executeQuery("SELECT * FROM candidates");

    while (rs.next()) {
%>

        <div class="candidate">

            <label>

                <input type="radio"
                       name="candidate"
                       value="<%= rs.getInt("id") %>"
                       required>

                <div class="candidate-details">

                    <h2><%= rs.getString("name") %></h2>

                    <p><b>Party:</b> <%= rs.getString("party") %></p>

                    <p><b>Age:</b> <%= rs.getInt("age") %></p>

                </div>

            </label>

        </div>

<%
    }

} catch (Exception e) {
%>

    <div class="error">
        Failed to load candidates.
    </div>

<%
    e.printStackTrace();

} finally {

    try { if (rs != null) rs.close(); } catch (Exception ignored) {}
    try { if (st != null) st.close(); } catch (Exception ignored) {}
    try { if (con != null) con.close(); } catch (Exception ignored) {}

}
%>

        <div class="btn-box">

            <button type="submit" class="btn">
                Submit Vote
            </button>

            <br>

            <a href="voter-dashboard.jsp" class="back">
                Back To Dashboard
            </a>

        </div>

    </form>

</div>

</body>
</html>