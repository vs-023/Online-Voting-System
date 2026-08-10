<%@ page import="java.sql.*" %>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

String message = request.getParameter("message");
String status = request.getParameter("status");
%>

<!DOCTYPE html>

<html>

<head>

```
<title>Feedback - Online Voting System</title>

<style>

    *{
        margin:0;
        padding:0;
        box-sizing:border-box;
        font-family:Arial,sans-serif;
    }

    body{

        min-height:100vh;

        display:flex;

        justify-content:center;

        align-items:center;

        background:
        linear-gradient(
            rgba(0,0,0,0.65),
            rgba(0,0,0,0.65)
        ),
        url("img/vote.png");

        background-size:cover;

        background-position:center;

        padding:30px;
    }

    .container{

        width:500px;

        background:rgba(255,255,255,0.97);

        padding:40px;

        border-radius:18px;

        box-shadow:0px 15px 40px rgba(0,0,0,0.4);
    }

    h1{

        text-align:center;

        color:#1e3c72;

        margin-bottom:10px;

        font-size:35px;
    }

    .subtitle{

        text-align:center;

        color:#666;

        margin-bottom:30px;

        font-size:16px;
    }

    label{

        display:block;

        color:#333;

        font-weight:bold;

        margin-bottom:7px;

    }

    input,
    select,
    textarea{

        width:100%;

        padding:12px;

        margin-bottom:20px;

        border:1px solid #ccc;

        border-radius:8px;

        font-size:15px;

        outline:none;
    }

    input:focus,
    select:focus,
    textarea:focus{

        border-color:#1e3c72;

        box-shadow:0 0 6px rgba(30,60,114,0.25);
    }

    textarea{

        height:130px;

        resize:none;
    }

    .btn{

        width:100%;

        padding:13px;

        border:none;

        border-radius:8px;

        background:#1e3c72;

        color:white;

        font-size:17px;

        font-weight:bold;

        cursor:pointer;

        transition:0.3s;
    }

    .btn:hover{

        background:#16325c;

        transform:translateY(-2px);
    }

    .back{

        display:block;

        text-align:center;

        margin-top:20px;

        color:#1e3c72;

        text-decoration:none;

        font-weight:bold;
    }

    .back:hover{

        text-decoration:underline;
    }

    .success{

        background:#e6ffed;

        color:#218838;

        padding:12px;

        border-radius:8px;

        text-align:center;

        margin-bottom:20px;

        font-weight:bold;
    }

    .error{

        background:#ffe5e5;

        color:#cc0000;

        padding:12px;

        border-radius:8px;

        text-align:center;

        margin-bottom:20px;

        font-weight:bold;
    }

</style>
```

</head>

<body>

<div class="container">

```
<h1>Feedback</h1>

<p class="subtitle">
    We value your feedback. Help us improve the Online Voting System.
</p>

<% if ("success".equals(status)) { %>

    <div class="success">
        Feedback submitted successfully!
    </div>

<% } %>

<% if ("error".equals(status)) { %>

    <div class="error">
        Unable to submit feedback. Please try again.
    </div>

<% } %>

<form action="FeedbackServlet" method="post">

    <label>Name</label>

    <input
        type="text"
        name="name"
        placeholder="Enter your name"
        required
    >

    <label>Email</label>

    <input
        type="email"
        name="email"
        placeholder="Enter your email"
        required
    >

    <label>Rating</label>

    <select name="rating" required>

        <option value="">
            Select Rating
        </option>

        <option value="5">
            Excellent - 5
        </option>

        <option value="4">
            Very Good - 4
        </option>

        <option value="3">
            Good - 3
        </option>

        <option value="2">
            Average - 2
        </option>

        <option value="1">
            Poor - 1
        </option>

    </select>

    <label>Feedback</label>

    <textarea
        name="feedback"
        placeholder="Write your feedback or suggestions..."
        required
    ></textarea>

    <button type="submit" class="btn">
        Submit Feedback
    </button>

</form>

<a href="home.html" class="back">
    Back To Home
</a>
```

</div>

</body>

</html>
