import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Date;
import java.sql.*;

@WebServlet(urlPatterns = "/ReturnBook")
public class ReturnBook extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ISBN = request.getParameter("isbn");
        String email = request.getParameter("email");
        String SapID = request.getParameter("SapId");
        Date date = new Date();
        long ret = date.getTime();

        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","");
            Statement stmt=conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT Title FROM books WHERE ISBN = '" + ISBN + "'");
            while (rs.next()) {
                String Title = rs.getString("Title");
            stmt.executeUpdate("UPDATE records set ReturnDate ='"+ret+"' WHERE ISBN='"+ISBN+"' AND Email='"+email+"'");
            stmt.executeUpdate("Update books set Availability = Availability + 1 WHERE  ISBN = '"+ISBN+"'");
            stmt.executeUpdate("INSERT INTO logs values(0,'" + SapID + "','" + ISBN + "','" + Title + "','Returned',CURRENT_TIMESTAMP())");
            }
            conn.close();
        }
        catch(Exception e){ System.out.println(e);}
        response.sendRedirect("admin/return.jsp");
    }
}
