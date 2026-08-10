package com.voting;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/VerifyOtpServlet")
public class VerifyOtpServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("register.html");
            return;
        }

        String enteredOtp = request.getParameter("otp");
        String sessionOtp = (String) session.getAttribute("otp");

        Long otpTime = (Long) session.getAttribute("otp_time");

        // OTP expiry check (2 min)
        if (otpTime == null || System.currentTimeMillis() - otpTime > 120000) {
            session.invalidate();
            response.sendRedirect("verify-otp.html?error=expired");
            return;
        }

        // attempts
        Integer attempts = (Integer) session.getAttribute("otp_attempts");
        if (attempts == null) attempts = 0;

        if (attempts >= 3) {
            session.invalidate();
            response.sendRedirect("register.html?error=locked");
            return;
        }

        if (!enteredOtp.equals(sessionOtp)) {
            session.setAttribute("otp_attempts", attempts + 1);
            response.sendRedirect("verify-otp.html?error=wrong");
            return;
        }

        // =========================
        // GET USER DATA
        // =========================
        String name = (String) session.getAttribute("reg_name");
        String email = (String) session.getAttribute("reg_email");
        String mobile = (String) session.getAttribute("reg_mobile");
        String dob = (String) session.getAttribute("reg_dob");
        String gender = (String) session.getAttribute("reg_gender");
        String voterid = (String) session.getAttribute("reg_voterid");
        String aadhaar = (String) session.getAttribute("reg_aadhaar");
        String address = (String) session.getAttribute("reg_address");
        String password = (String) session.getAttribute("reg_password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/votingdb",
                    "root",
                    "adminmyy"
            );

            // =========================
            // FIXED INSERT QUERY (IMPORTANT)
            // =========================
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO voters " +
                "(name, email, mobile, dob, gender, voterid, aadhaar, address, password, status) " +
                "VALUES (?,?,?,?,?,?,?,?,?,?)"
            );

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, mobile);
            ps.setString(4, dob);
            ps.setString(5, gender);
            ps.setString(6, voterid);
            ps.setString(7, aadhaar);
            ps.setString(8, address);
            ps.setString(9, password);
            ps.setString(10, "ACTIVE");

            int rows = ps.executeUpdate();

            System.out.println("ROWS INSERTED: " + rows);

            session.invalidate();

            response.sendRedirect("registersuccess.html");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("DB ERROR: " + e.getMessage());
        }
    }
}