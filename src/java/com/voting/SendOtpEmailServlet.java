package com.voting;

import java.io.IOException;
import java.util.Properties;
import java.util.Random;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import jakarta.mail.*;
import jakarta.mail.internet.*;

@WebServlet("/SendOtpEmailServlet")
public class SendOtpEmailServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        // Generate OTP
        int otp = 100000 + new Random().nextInt(900000);
        session.setAttribute("otp", String.valueOf(otp));

        String email = (String) session.getAttribute("reg_email");

        // Gmail SMTP configuration
        String from = "YOUR_EMAIL@gmail.com";
        String password = "YOUR_APP_PASSWORD";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session mailSession = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(from, password);
                    }
                });

        try {
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(email));

            message.setSubject("OTP Verification - Online Voting System");

            message.setText("Your OTP is: " + otp);

            Transport.send(message);

            System.out.println("Email OTP sent: " + otp);

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("verify-otp.html");
    }
}