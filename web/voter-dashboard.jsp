<%
if ("already_voted".equals(request.getParameter("error"))) {
%>
    <p style="color:red;">You have already voted!</p>
<%
}

if ("voted".equals(request.getParameter("success"))) {
%>
    <p style="color:green;">Vote submitted successfully!</p>
<%
}
%>