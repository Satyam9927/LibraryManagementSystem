<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<html>
<head>
    <title>Library</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"
            integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
    <style>
        img {
            width: 75%;
        }
    </style>
</head>
<body>
<%
    String email = (String) session.getAttribute("email");
    if (StringUtils.isEmpty(email)) {
%>
<div class="container-fluid">
    <div class="row navbar navbar-expand-lg navbar-light bg-light">
        <div class="col-md-2 ">
            <a class="navbar-brand" href="index.jsp">L I B R A R Y </a>
        </div>
        <div class="col-md-8">
            <form action="search.jsp" method="post" class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2 w-75" name="Search" type="search" placeholder="Search"
                       aria-label="Search">
                <button class="btn btn-outline-dark my-2 my-sm-0 " type="submit">Search</button>
            </form>
        </div>
        <div class="col-md-2">
            <span class="links"><a href="login.jsp"><i class="fa fa-sign-in fa-2x"></i></a></span>
        </div>
    </div>
</div>

<%
} else {
%>
<div class="container-fluid">
    <div class="row navbar navbar-expand-lg navbar-light bg-light">
        <div class="col-md-2 ">
            <a class="navbar-brand" href="index.jsp">L I B R A R Y </a>
        </div>
        <div class="col-md-8">
            <form action="search.jsp" method="post" class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2 w-75" name="Search" type="search" placeholder="Search"
                       aria-label="Search">
                <button class="btn btn-outline-dark my-2 my-sm-0 " type="submit">Search</button>
            </form>
        </div>
        <div class="col-md-2">
            <span class="links"><a href="profile/index.jsp"><i class="fa fa-user-circle fa-2x"></i></a><a
                    href="/Logout"><i class="fa fa-sign-out fa-2x"></i></a></span>
        </div>
    </div>
</div>
<%
    }
    String isbn = request.getParameter("isbn");
    int Availability=0;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "");
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM books WHERE ISBN='" + isbn + "'");
        rs.next();
        String Description = rs.getString("Description").replaceAll("(\\\\r\\\\n|\\\\r|\\\\n|\\\\n\\\\r)", "<br>&nbsp;&nbsp;&nbsp;&nbsp;");
        Description = Description.replaceAll("\\\\u0092", "'");
        Description = Description.replaceAll("\\\\u0097", "&#151;");
%>
<div class="container">
    <br>
    <div class="row">
        <div class="col-md-5">
            <img src="img/<%= isbn %>.jpg">
        </div>
        <div class="col-md-6">
            <h3><%= rs.getString("Title") %>
            </h3>
            <p><%= rs.getString("Author") %>
            </p>
            <br>
            <p><%= Description %>
            </p>
            <br>
            <%
                if (!StringUtils.isEmpty(email)) {
                    rs = stmt.executeQuery("SELECT * FROM books WHERE ISBN='" + isbn + "'");
                    rs.next();
                    Availability = rs.getInt("Availability");
                    rs = stmt.executeQuery("SELECT * FROM records WHERE ISBN='" + isbn + "' AND " + "Email='" + email + "'");

                }
                if (StringUtils.isEmpty(email)) {
            %>
            <form action="login.jsp" method="post">
                <button class="btn btn-warning w-100">Login</button>
             </form>
            <%
            }
            else if (rs.next()) {
            %>
            <form action="/profile" method="post">
                <button class="btn btn-dark w-100">Issued</button>
            </form>
            <%
            }
            else if(Availability==0){
            %>
            <form action="#" method="post">
                <button  type="button" class="btn btn-dark w-100">Out of Stock</button>
            </form>
            <%
            }
            else {
            %>
            <form action="/IssueBook" method="post">
                <input type="text" value="<%=isbn%>" name="isbn" hidden>
                <button class="btn btn-primary w-100">Issue Book</button>
            </form>
            <%
                }
            %>
            <br><br><br><br>
        </div>
    </div>
</div>
<%
        conn.close();
    } catch (Exception e) {
        System.out.println(e);
    }
%>

</body>
</html>
