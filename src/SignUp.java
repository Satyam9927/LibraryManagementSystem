import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import org.apache.commons.codec.digest.DigestUtils;

@WebServlet(urlPatterns = "/SignUp")
public class SignUp extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            String sapid = request.getParameter("sapId");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            password = DigestUtils.md5Hex(password);
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","");
            Statement stmt=conn.createStatement();
            stmt.executeUpdate("INSERT INTO users VALUES(0,'"+sapid+"','"+email+"','"+password+"')");
            conn.close();
            HttpSession session = request.getSession();
            session.setAttribute("email",email);
            response.sendRedirect("index.jsp");
        }
        catch(Exception e){ System.out.println(e);}
    }

}
