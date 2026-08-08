package com.voting;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/votingdb",
                    "root",
                    "myadmin"
            );

            // CHECK USER EXISTS

            ps = con.prepareStatement(
                    "SELECT * FROM voters WHERE email=? AND mobile=?"
            );

            ps.setString(1, email);
            ps.setString(2, mobile);

            rs = ps.executeQuery();

            if (rs.next()) {

                // GENERATE 6-DIGIT OTP

                Random rand = new Random();

                int otp = 100000 + rand.nextInt(900000);

                // DELETE OLD OTP IF EXISTS

                PreparedStatement deletePs =
                        con.prepareStatement(
                                "DELETE FROM password_reset WHERE email=?"
                        );

                deletePs.setString(1, email);
                deletePs.executeUpdate();

                // INSERT NEW OTP

                PreparedStatement insertPs =
                        con.prepareStatement(
                                "INSERT INTO password_reset(email, otp) VALUES(?,?)"
                        );

                insertPs.setString(1, email);
                insertPs.setString(2, String.valueOf(otp));

                insertPs.executeUpdate();

                // CREATE SESSION

                HttpSession session = request.getSession();

                session.setAttribute("resetEmail", email);
                session.setAttribute("otp", String.valueOf(otp));

                // 10 MINUTES SESSION TIME

                session.setMaxInactiveInterval(10 * 60);

                // PRINT OTP IN CONSOLE

                System.out.println("=================================");
                System.out.println("PASSWORD RESET OTP : " + otp);
                System.out.println("EMAIL : " + email);
                System.out.println("=================================");

                response.sendRedirect(
                        "verify-otp.html"
                );

            } else {

                response.sendRedirect(
                        "forgot-password.html?error=1"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Database Error : " + e.getMessage()
            );

        } finally {

            try {
                if (rs != null) rs.close();
            } catch (Exception ignored) {}

            try {
                if (ps != null) ps.close();
            } catch (Exception ignored) {}

            try {
                if (con != null) con.close();
            } catch (Exception ignored) {}
        }
    }
}