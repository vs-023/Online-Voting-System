package com.voting;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/CandidateServlet")
public class CandidateServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String candidate = request.getParameter("candidate");
        String party = request.getParameter("party");
        String ageStr = request.getParameter("age");

        if(candidate == null || party == null || ageStr == null ||
           candidate.isEmpty() || party.isEmpty() || ageStr.isEmpty()) {

            response.getWriter().println("All fields are required");
            return;
        }

        Connection con = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/votingdb",
                    "root",
                    "myadmin"
            );

            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO candidates(name, party, age) VALUES(?,?,?)"
            );

            ps.setString(1, candidate);
            ps.setString(2, party);
            ps.setInt(3, Integer.parseInt(ageStr));

            ps.executeUpdate();

            response.sendRedirect("candidate.html");

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Database Error: " + e.getMessage()
            );

        } finally {

            try {
                if(con != null)
                    con.close();
            } catch(Exception ignored){}
        }
    }
}