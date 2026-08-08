package com.voting;

import java.io.IOException;
import java.util.Random;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ResendOtpServlet")
public class ResendOtpServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        String otp = String.valueOf(100000 + new Random().nextInt(900000));

        session.setAttribute("otp", otp);
        session.setAttribute("otp_time", System.currentTimeMillis());
        session.setAttribute("otp_attempts", 0);

        System.out.println("🔁 OTP RESENT: " + otp);

        response.sendRedirect("verify-otp.html?resend=1");
    }
}