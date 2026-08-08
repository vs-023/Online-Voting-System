package com.voting;

import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(true);

        session.setAttribute("reg_name", request.getParameter("name"));
        session.setAttribute("reg_email", request.getParameter("email"));
        session.setAttribute("reg_mobile", request.getParameter("mobile"));
        session.setAttribute("reg_dob", request.getParameter("dob"));
        session.setAttribute("reg_gender", request.getParameter("gender"));
        session.setAttribute("reg_voterid", request.getParameter("voterid"));
        session.setAttribute("reg_aadhaar", request.getParameter("aadhaar"));
        session.setAttribute("reg_address", request.getParameter("address"));
        session.setAttribute("reg_password", request.getParameter("password"));
        session.setAttribute("otp_method", request.getParameter("otpMethod"));

        System.out.println("🔥 REGISTER HIT EMAIL: " + request.getParameter("email"));

        response.sendRedirect("SendOtpServlet");
    }
}