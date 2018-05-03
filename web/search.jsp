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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
    <style>
        .img-fluid {
            width: auto;
            height: 250px;
        }

        img:hover {
            opacity: 0.9;
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
            <a class="navbar-brand" href="index.jsp/?">L I B R A R Y </a>
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
%>
<div class="container">
    <div class="row">
        <%
            String search = request.getParameter("Search");
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM books WHERE Availability>'0' AND (Author LIKE '%" + search + "%' OR Title LIKE '%" + search + "%' OR Genre LIKE '%" + search + "%' )");
                while (rs.next()) {%>
        <div class="col-md-2" style="padding-top: 20px;">
            <a href="book.jsp?isbn=<%= rs.getString("ISBN") %>"><img class="img-fluid"
                                                                     src="img/<%=rs.getString("ISBN")%>.jpg"><br></a>
        </div>
        <%
                }
                conn.close();
            } catch (Exception e) {
                System.out.println(e);
            }

        %>
    </div>
</div>
</body>
</html>
