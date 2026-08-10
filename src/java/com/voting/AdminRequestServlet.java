package com.voting;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AdminRequestServlet")
public class AdminRequestServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/votingdb",
                    "root",
                    "adminmyy"
            );

            Statement st = con.createStatement();

            ResultSet rs = st.executeQuery("SELECT * FROM requests");

            out.println("<html><body>");
            out.println("<h2>Correction Requests</h2>");
            out.println("<table border='1' cellpadding='10'>");

            out.println("<tr>");
            out.println("<th>ID</th>");
            out.println("<th>User Email</th>");
            out.println("<th>Request Type</th>");
            out.println("<th>Message</th>");
            out.println("<th>Status</th>");
            out.println("</tr>");

            while (rs.next()) {

                out.println("<tr>");

                out.println("<td>" + rs.getInt("id") + "</td>");
                out.println("<td>" + rs.getString("user_email") + "</td>");
                out.println("<td>" + rs.getString("request_type") + "</td>");
                out.println("<td>" + rs.getString("message") + "</td>");
                out.println("<td>" + rs.getString("status") + "</td>");

                out.println("</tr>");
            }

            out.println("</table>");
            out.println("</body></html>");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database Error: " + e.getMessage());

        } finally {
            try {
                if (con != null) con.close();
            } catch (Exception ignored) {}
        }
    }
}