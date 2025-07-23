import db.DBConnection;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/GenerateBillServlet_")
public class GenerateBillServlet_ extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get transaction ID from request parameter
        int tid = Integer.parseInt(request.getParameter("tid"));

        try (Connection con = DBConnection.getConnection()) {
            // Query to get buyer + transaction details
            PreparedStatement ps1 = con.prepareStatement(
                "SELECT b.name, b.address, b.phone, b.email, t.date, t.payment_method " +
                "FROM transactions t JOIN buyers b ON t.buyer_id = b.id WHERE t.id = ?");
            ps1.setInt(1, tid);
            ResultSet rs1 = ps1.executeQuery();

            // Query to get purchased items
            PreparedStatement ps2 = con.prepareStatement(
                "SELECT p.name, ti.quantity, p.unit_price, (ti.quantity * p.unit_price) AS total " +
                "FROM transaction_items ti JOIN products p ON ti.product_id = p.id WHERE ti.transaction_id = ?");
            ps2.setInt(1, tid);
            ResultSet rs2 = ps2.executeQuery();

            // Pass data to bill.jsp
            request.setAttribute("buyerDetails", rs1);
            request.setAttribute("productDetails", rs2);
            request.setAttribute("tid", tid);

            // Forward to bill.jsp
            RequestDispatcher rd = request.getRequestDispatcher("bill.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
