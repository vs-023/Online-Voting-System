# ***Online Voting System***



### Overview:

The Online Voting System is a web-based application developed to provide a secure and user-friendly platform for conducting elections digitally. The project was developed and tested using NetBeans IDE and Apache Tomcat.The system provides a digital platform for managing the basic election process. 

Voters can register, complete OTP-based verification, log in, view available candidates, cast their vote, check their voting status, and view election results.

The system also includes an Administrator Module for managing voters, candidates, voting requests, election rules, statistics, and results.

The OTP verification implemented in this project is simulated for academic purposes and does not use an external OTP API.



### Features:



\- Voter Registration: Allows eligible users to create an account.

\- OTP Verification: Provides simulated email-based OTP verification.

\- User Login: Authenticates registered voters.

\- Candidate Management: Admin can add and manage candidates.

\- Online Voting: Allows registered voters to cast their vote.

\- One-Time Voting: Prevents a voter from voting multiple times.

\- Voting Status: Allows voters to check their voting status.

\- Election Results: Displays voting results.

\- Admin Dashboard: Provides administrative control over the system.

\- Voter Management: Admin can view and manage voters.

\- Password Recovery: Supports forgot and reset password functionality.

\- Voting Rules: Provides election rules and eligibility information.

\- Statistics: Displays voting-related statistics.





### Project Structure:



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

&#x20;   │   ├── slide1.png

&#x20;   │   ├── slide2.png

&#x20;   │   ├── slide3.png

&#x20;   │   ├── slide4.png

&#x20;   │   ├── slide5.png

&#x20;   │   ├── vote.png

&#x20;   │   └── voter.png

&#x20;   │

&#x20;   ├── about.html

&#x20;   ├── admin-dashboard.jsp

&#x20;   ├── admin-rules.html

&#x20;   ├── admin-rules.jsp

&#x20;   ├── adminpanel.html

&#x20;   ├── adminrequests.html

&#x20;   ├── already-voted.html

&#x20;   ├── candidate.html

&#x20;   ├── centers.html

&#x20;   ├── contact.html

&#x20;   ├── eligibility.html

&#x20;   ├── faq.html

&#x20;   ├── forgot-password.html

&#x20;   ├── help.html

&#x20;   ├── home.html

&#x20;   ├── index.html

&#x20;   ├── login.html

&#x20;   ├── logout-confirm.html

&#x20;   ├── logout.html

&#x20;   ├── manage-candidates.jsp

&#x20;   ├── morefaq.html

&#x20;   ├── profile.jsp

&#x20;   ├── register.html

&#x20;   ├── registersuccess.html

&#x20;   ├── requestchange.html

&#x20;   ├── requests.jsp

&#x20;   ├── requestsuccess.html

&#x20;   ├── reset-password.html

&#x20;   ├── result.html

&#x20;   ├── results.jsp

&#x20;   ├── rules.html

&#x20;   ├── statistics.jsp

&#x20;   ├── status.jsp

&#x20;   ├── verify-otp.html

&#x20;   ├── view-candidates.jsp

&#x20;   ├── view-voters.jsp

&#x20;   ├── vote-success.html

&#x20;   ├── vote.html

&#x20;   ├── vote.jsp

&#x20;   └── voter-dashboard.jsp



### Technologies Used:

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



### System Modules:

##### 

###### 1\. Voter Module:

The voter module provides:



* Registration
* OTP verification
* Login
* Profile management
* Candidate viewing
* Vote casting
* Voting status
* Election results
* Password recovery

###### 

###### 2\. Administrator Module:

The administrator module provides:



* Admin login
* Candidate management
* Voter management
* Request management
* Election rules management
* Voting statistics
* Result management



#### Application Flow:



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

&#x09;  │

&#x09;  ├── View Candidates

&#x09;  │	

&#x09;  ├── Cast Vote

&#x09;  │

&#x09;  ├── Check Voting Status

&#x09;  │

&#x09;  └── View Results



#### Admin Flow:



Admin

&#x20; │

&#x20; ▼

Admin Login

&#x20; │

&#x20; ▼

Admin Dashboard

&#x09;  │

&#x09;  ├── Manage Voters

&#x09;  ├── Manage Candidates

&#x09;  ├── Manage Requests

&#x09;  ├── Manage Rules

&#x09;  ├── View Statistics

&#x09;  └── Manage Results



#### Database:

The application uses MySQL to store and manage:



* Voter information
* Candidate information
* Voting records
* Login details
* OTP information
* Requests
* Election data
* Results





