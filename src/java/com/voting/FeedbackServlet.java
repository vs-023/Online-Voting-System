package com.voting;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("email") == null) {

            response.sendRedirect("login.html");

            return;
        }


        String email =
                (String) session.getAttribute("email");


        String rating =
                request.getParameter("rating");


        String feedback =
                request.getParameter("feedback");


        if (rating == null ||
            feedback == null ||
            feedback.trim().isEmpty()) {

            response.sendRedirect(
                    "feedback.jsp"
            );

            return;
        }


        try {

            Class.forName(
                    "com.mysql.cj.jdbc.Driver"
            );


            Connection con =
                    DriverManager.getConnection(

                        "jdbc:mysql://localhost:3306/votingdb",

                        "root",

                        "adminmyy"
                    );


            PreparedStatement ps =
                    con.prepareStatement(

                        "INSERT INTO feedback " +
                        "(voter_email, rating, feedback) " +
                        "VALUES (?, ?, ?)"
                    );


            ps.setString(
                    1,
                    email
            );


            ps.setInt(
                    2,
                    Integer.parseInt(rating)
            );


            ps.setString(
                    3,
                    feedback
            );


            ps.executeUpdate();


            ps.close();

            con.close();


            /*
             * Logout after feedback
             */

            session.invalidate();


            response.sendRedirect(
                    "login.html?feedback=success"
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "<h2>Feedback Error</h2>"
            );

            response.getWriter().println(
                    "<p>" +
                    e.getMessage() +
                    "</p>"
            );
        }
    }
}