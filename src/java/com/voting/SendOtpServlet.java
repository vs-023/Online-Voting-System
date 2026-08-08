package com.voting;

import java.io.IOException;
import java.util.Random;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/SendOtpServlet")
public class SendOtpServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        String otp = String.valueOf(100000 + new Random().nextInt(900000));

        session.setAttribute("otp", otp);
        session.setAttribute("otp_time", System.currentTimeMillis());

        String email = (String) session.getAttribute("reg_email");

        System.out.println("================================");
        System.out.println("🔥 OTP GENERATED");
        System.out.println("EMAIL: " + email);
        System.out.println("OTP: " + otp);
        System.out.println("================================");

        response.sendRedirect("verify-otp.html");
    }
}