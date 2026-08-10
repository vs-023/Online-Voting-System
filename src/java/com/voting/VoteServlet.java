package com.voting;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/VoteServlet")
public class VoteServlet extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {


        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("email") == null) {

            response.sendRedirect("login.html");
            return;
        }

        String email =
                (String) session.getAttribute("email");


        String candidateId =
                request.getParameter("candidateId");

        if (candidateId == null ||
            candidateId.trim().isEmpty()) {

            response.sendRedirect(
                    "vote.jsp?error=select");

            return;
        }


        int candidate;

        try {

            candidate =
                    Integer.parseInt(candidateId);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "vote.jsp?error=invalid");

            return;
        }


        Connection con = null;
        PreparedStatement checkPs = null;
        PreparedStatement insertPs = null;
        PreparedStatement updatePs = null;
        ResultSet rs = null;


        try {


            Class.forName(
                    "com.mysql.cj.jdbc.Driver");


            con = DriverManager.getConnection(

                    "jdbc:mysql://localhost:3306/votingdb",

                    "root",

                    "adminmyy"
            );



            checkPs = con.prepareStatement(

                    "SELECT id FROM votes " +
                    "WHERE voter_email = ?"

            );

            checkPs.setString(1, email);

            rs = checkPs.executeQuery();


            if (rs.next()) {

                session.setAttribute(
                        "hasVoted",
                        true
                );

                response.sendRedirect(
                        "vote.jsp?error=already_voted"
                );

                return;
            }


            rs.close();
            rs = null;

            checkPs.close();
            checkPs = null;



            con.setAutoCommit(false);



            insertPs = con.prepareStatement(

                    "INSERT INTO votes " +
                    "(voter_email, candidate_id) " +
                    "VALUES (?, ?)"

            );

            insertPs.setString(1, email);

            insertPs.setInt(2, candidate);

            insertPs.executeUpdate();



            updatePs = con.prepareStatement(

                    "UPDATE candidates " +
                    "SET votes = votes + 1 " +
                    "WHERE id = ?"

            );

            updatePs.setInt(1, candidate);


            int updated =
                    updatePs.executeUpdate();



            if (updated == 0) {

                con.rollback();

                response.sendRedirect(
                        "vote.jsp?error=invalid"
                );

                return;
            }



            con.commit();




            session.setAttribute(
                    "hasVoted",
                    true
            );



            response.sendRedirect(
                    "voter-dashboard.jsp?success=voted"
            );


        } catch (SQLException e) {

            try {

                if (con != null) {
                    con.rollback();
                }

            } catch (Exception ignored) {
            }



            if (e.getMessage() != null &&
                e.getMessage().contains("Duplicate")) {

                session.setAttribute(
                        "hasVoted",
                        true
                );

                response.sendRedirect(
                        "vote.jsp?error=already_voted"
                );

                return;
            }


            e.printStackTrace();


            response.setContentType(
                    "text/html"
            );

            response.getWriter().println(
                    "<h2>Voting Error</h2>"
            );

            response.getWriter().println(
                    "<p>" +
                    e.getMessage() +
                    "</p>"
            );


        } catch (Exception e) {

            try {

                if (con != null) {
                    con.rollback();
                }

            } catch (Exception ignored) {
            }


            e.printStackTrace();


            response.setContentType(
                    "text/html"
            );

            response.getWriter().println(
                    "<h2>Voting Error</h2>"
            );

            response.getWriter().println(
                    "<p>" +
                    e.getMessage() +
                    "</p>"
            );


        } finally {

            try {

                if (rs != null) {
                    rs.close();
                }

            } catch (Exception ignored) {
            }


            try {

                if (checkPs != null) {
                    checkPs.close();
                }

            } catch (Exception ignored) {
            }


            try {

                if (insertPs != null) {
                    insertPs.close();
                }

            } catch (Exception ignored) {
            }


            try {

                if (updatePs != null) {
                    updatePs.close();
                }

            } catch (Exception ignored) {
            }


            try {

                if (con != null) {
                    con.close();
                }

            } catch (Exception ignored) {
            }
        }
    }
}