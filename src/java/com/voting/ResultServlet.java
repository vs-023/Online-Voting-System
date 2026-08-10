package com.voting;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ResultServlet")
public class ResultServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html><body>");
        out.println("<h1>Election Results</h1>");

        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/votingdb",
                    "root",
                    "adminmyy"
            );

            String query =
                    "SELECT c.name, COUNT(v.id) AS total " +
                    "FROM votes v " +
                    "JOIN candidates c ON v.candidate_id = c.id " +
                    "GROUP BY c.name";

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(query);

            while (rs.next()) {

                out.println("<h2>");
                out.println(rs.getString("name") + " : " +
                        rs.getInt("total") + " Votes");
                out.println("</h2>");
            }

        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
            e.printStackTrace();

        } finally {
            try {
                if (con != null) con.close();
            } catch (Exception ignored) {}
        }

        out.println("</body></html>");
    }
}