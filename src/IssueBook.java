import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.Date;


@WebServlet(urlPatterns = "/IssueBook")
public class IssueBook extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String)session.getAttribute("email");
        String isbn = request.getParameter("isbn");
        String SapID = (String) session.getAttribute("SapID");
        Date date = new Date();
        long issue = date.getTime();

        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","");
            Statement stmt=conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT Title FROM books WHERE ISBN = '" + isbn + "'");
            while (rs.next()) {
                String Title = rs.getString("Title");
                stmt.executeUpdate("INSERT INTO records values(0,'" + isbn + "','" + email + "','" + issue + "','NA')");
                stmt.executeUpdate("Update books set Availability = Availability -1 WHERE  ISBN = '" + isbn + "'");
                stmt.executeUpdate("INSERT INTO logs values(0,'" + SapID + "','" + isbn + "','" + Title + "','Issued',CURRENT_TIMESTAMP())");
            }
            conn.close();
        }
        catch(Exception e){ System.out.println(e);}
        response.sendRedirect("book.jsp?isbn="+isbn);
    }
}
