package com.voting;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailUtil {

    public static void sendLoginAlert(String toEmail, String name) {

        final String fromEmail = "yourgmail@gmail.com";
        final String password = "your_app_password";

        try {

            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");

            Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(fromEmail, password);
                    }
                });

            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(fromEmail));
            msg.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(toEmail));

            msg.setSubject("Login Alert - Online Voting System");

            msg.setText(
                "Hello " + name +
                "\n\nYou have successfully logged into Online Voting System." +
                "\nIf this was not you, please reset your password immediately."
            );

            Transport.send(msg);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}