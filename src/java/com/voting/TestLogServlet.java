package com.voting;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/TestLogServlet")
public class TestLogServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("🔥 TEST SYSTEM OUT - LOG CHECK STARTED");
        System.err.println("🔥 TEST ERROR OUT - ERROR STREAM CHECK");

        System.out.println("✔ Servlet executed successfully");
        System.out.println("✔ If you see this in logs, Tomcat logging works");

        response.setContentType("text/html");
        response.getWriter().println(
                "<h2>Test Servlet Executed</h2>" +
                "<p>Check Tomcat logs / NetBeans output window</p>"
        );
    }
}