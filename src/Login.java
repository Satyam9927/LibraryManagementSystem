import org.apache.commons.codec.digest.DigestUtils;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet(urlPatterns = "/Login")
public class Login extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            int rows=0;
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            password = DigestUtils.md5Hex(password);
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","");
            Statement stmt=conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * from users WHERE Email = '" + email + "' AND Password ='" + password + "'");
            if(rs.next()){
                rows = 1;
            }
            if(rows==1){
                String SapID = rs.getString("SapID");
                HttpSession session = request.getSession();
                session.setAttribute("email",email);
                session.setAttribute("SapID",SapID);
                conn.close();
                response.sendRedirect("index.jsp");
            }
            else{
                response.sendRedirect("login.jsp");
            }
        }
        catch(Exception e){ System.out.println(e);}
    }
}
