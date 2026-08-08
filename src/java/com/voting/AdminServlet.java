package com.voting;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Get existing session only
        HttpSession session = request.getSession(false);

        // If session does not exist
        if (session == null) {

            response.sendRedirect("login.html");
            return;
        }

        // Get admin session attribute
        String admin = (String) session.getAttribute("admin");

        // If admin not logged in
        if (admin == null || admin.trim().isEmpty()) {

            response.sendRedirect("login.html");
            return;
        }

        // Prevent browser caching
        response.setHeader(
                "Cache-Control",
                "no-cache, no-store, must-revalidate"
        );

        response.setHeader("Pragma", "no-cache");

        response.setDateHeader("Expires", 0);

        // Redirect to admin dashboard
        response.sendRedirect("admin-dashboard.jsp");
    }
}