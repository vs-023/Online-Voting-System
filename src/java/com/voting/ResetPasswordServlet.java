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

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String newPassword = request.getParameter("newpassword");
        String confirmPassword = request.getParameter("confirmpassword");

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("forgot-password.html");
            return;
        }

        String email = (String) session.getAttribute("resetEmail");

        if (email == null) {
            response.sendRedirect("forgot-password.html");
            return;
        }

        // Password match check
        if (newPassword == null ||
            confirmPassword == null ||
            !newPassword.equals(confirmPassword)) {

            response.sendRedirect(
                "reset-password.html?error=1"
            );

            return;
        }

        // Minimum password length check
        if (newPassword.length() < 8) {

            response.sendRedirect(
                "reset-password.html?error=2"
            );

            return;
        }

        Connection con = null;
        PreparedStatement ps = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/votingdb",
                    "root",
                    "myadmin"
            );

            ps = con.prepareStatement(
                    "UPDATE voters SET password=? WHERE email=?"
            );

            ps.setString(1, newPassword);
            ps.setString(2, email);

            int rows = ps.executeUpdate();

            if (rows > 0) {

                // remove reset session data
                session.removeAttribute("otp");
                session.removeAttribute("resetEmail");

                response.sendRedirect(
                    "login.html?reset=success"
                );

            } else {

                response.sendRedirect(
                    "reset-password.html?error=3"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                "Database Error: " + e.getMessage()
            );

        } finally {

            try {
                if (ps != null) ps.close();
            } catch (Exception ignored) {}

            try {
                if (con != null) con.close();
            } catch (Exception ignored) {}
        }
    }
}