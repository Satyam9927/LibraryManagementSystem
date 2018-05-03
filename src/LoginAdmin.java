import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = "/LoginAdmin")
public class LoginAdmin extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if(username.equals("Admin")&&password.equals("qwerty")){
            HttpSession session = request.getSession();
            session.setAttribute("loggedIn","1");
            response.sendRedirect("admin/addBooks.jsp");
        }
        else{
            response.sendRedirect("admin/index.jsp");
        }
    }

}
