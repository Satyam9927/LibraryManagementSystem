<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>

<%
    String start = request.getParameter("count");
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "");
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM books WHERE Availability>'0' LIMIT " + start + ",24");
        while (rs.next()) {%>

<div class="col-md-2" style="padding-top: 20px;">
    <a href="book.jsp?isbn=<%= rs.getString("ISBN") %>"><img class="img-fluid" src="img/<%=rs.getString("ISBN")%>.jpg"><br></a>
</div>
<%
        }
        conn.close();
    } catch (Exception e) {
        System.out.println(e);
    }

%>
