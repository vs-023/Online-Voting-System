package com.voting;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/VoteServlet")
public class VoteServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("login.html");
            return;
        }

        // 🔥 ONE VOTE CHECK
        Boolean hasVoted = (Boolean) session.getAttribute("hasVoted");

        if (hasVoted != null && hasVoted) {
            response.sendRedirect("voter-dashboard.jsp?error=already_voted");
            return;
        }

        String candidateId = request.getParameter("candidateId");

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/votingdb",
                    "root",
                    "myadmin"
            );

            // UPDATE VOTE COUNT
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE candidates SET votes = votes + 1 WHERE id=?"
            );

            ps.setString(1, candidateId);
            ps.executeUpdate();

            // 🔥 LOCK VOTING IN SESSION
            session.setAttribute("hasVoted", true);

            response.sendRedirect("voter-dashboard.jsp?success=voted");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Voting Error");
        }
    }
}