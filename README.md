\# Online Voting System



\## Overview



The Online Voting System is a web-based application developed to provide a secure and user-friendly platform for conducting elections digitally.



The system allows voters to register, verify their identity using OTP, log in, view candidates, cast their votes, check their voting status, and view election results.



An administrator module is also provided to manage voters, candidates, requests, election rules, statistics, and results.



\---



\## Features



\- \*\*Voter Registration:\*\* Allows eligible users to create an account.

\- \*\*OTP Verification:\*\* Provides email-based OTP verification.

\- \*\*User Login:\*\* Authenticates registered voters.

\- \*\*Candidate Management:\*\* Admin can add and manage candidates.

\- \*\*Online Voting:\*\* Allows registered voters to cast their vote.

\- \*\*One-Time Voting:\*\* Prevents a voter from voting multiple times.

\- \*\*Voting Status:\*\* Allows voters to check their voting status.

\- \*\*Election Results:\*\* Displays voting results.

\- \*\*Admin Dashboard:\*\* Provides administrative control over the system.

\- \*\*Voter Management:\*\* Admin can view and manage voters.

\- \*\*Password Recovery:\*\* Supports forgot and reset password functionality.

\- \*\*Voting Rules:\*\* Provides election rules and eligibility information.

\- \*\*Statistics:\*\* Displays voting-related statistics.



\---



\## Project Structure



```text

Online-Voting-System/

│

├── build.xml

├── .gitignore

│

├── nbproject/

│   ├── ant-deploy.xml

│   ├── build-impl.xml

│   ├── genfiles.properties

│   ├── project.properties

│   └── project.xml

│

├── src/

│   ├── conf/

│   │   └── MANIFEST.MF

│   │

│   └── java/

│       └── com/

│           └── voting/

│               ├── AdminRequestServlet.java

│               ├── AdminServlet.java

│               ├── CandidateServlet.java

│               ├── EmailUtil.java

│               ├── ForgotPasswordServlet.java

│               ├── LoginServlet.java

│               ├── LogoutServlet.java

│               ├── RegisterServlet.java

│               ├── RequestServlet.java

│               ├── ResendOtpServlet.java

│               ├── ResetPasswordServlet.java

│               ├── ResultServlet.java

│               ├── SendOtpEmailServlet.java

│               ├── SendOtpServlet.java

│               ├── TestLogServlet.java

│               ├── VerifyOtpServlet.java

│               └── VoteServlet.java

│

└── web/

&#x20;   ├── META-INF/

&#x20;   │   └── context.xml

&#x20;   │

&#x20;   ├── WEB-INF/

&#x20;   │   └── web.xml

&#x20;   │

&#x20;   ├── img/

&#x20;   │   ├── admin.png

&#x20;   │   ├── candidate.png

&#x20;   │   ├── project.png

&#x20;   │   ├── results.png

&#x20;   │   ├── voter.png

&#x20;   │   └── ...

&#x20;   │

&#x20;   ├── index.html

&#x20;   ├── home.html

&#x20;   ├── login.html

&#x20;   ├── register.html

&#x20;   ├── vote.html

&#x20;   ├── vote.jsp

&#x20;   ├── result.html

&#x20;   ├── results.jsp

&#x20;   ├── profile.jsp

&#x20;   ├── voter-dashboard.jsp

&#x20;   ├── admin-dashboard.jsp

&#x20;   └── ...







Technologies Used

Java – Backend programming

Java Servlets – Server-side request processing

JSP – Dynamic web pages

HTML5 – Web page structure

CSS3 – Styling and layout

JavaScript – Client-side interaction

MySQL – Database management

Apache Tomcat – Web application server

NetBeans IDE – Development environment

Git \& GitHub – Version control



System Modules

1\. Voter Module



The voter module provides:



Registration

OTP verification

Login

Profile management

Candidate viewing

Vote casting

Voting status

Election results

Password recovery

2\. Administrator Module



The administrator module provides:



Admin login

Candidate management

Voter management

Request management

Election rules management

Voting statistics

Result management





Voter

&#x20; │

&#x20; ▼

Registration

&#x20; │

&#x20; ▼

OTP Verification

&#x20; │

&#x20; ▼

Login

&#x20; │

&#x20; ▼

Voter Dashboard

&#x20; │

&#x20; ├── View Candidates

&#x20; │

&#x20; ├── Cast Vote

&#x20; │

&#x20; ├── Check Voting Status

&#x20; │

&#x20; └── View Results



Admin

&#x20; │

&#x20; ▼

Admin Login

&#x20; │

&#x20; ▼

Admin Dashboard

&#x20; │

&#x20; ├── Manage Voters

&#x20; ├── Manage Candidates

&#x20; ├── Manage Requests

&#x20; ├── Manage Rules

&#x20; ├── View Statistics

&#x20; └── Manage Results



Database



The application uses MySQL to store and manage:



Voter information

Candidate information

Voting records

Login details

OTP information

Requests

Election data

Results

