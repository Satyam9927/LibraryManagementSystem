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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"
            integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
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

        .fa {
            color: grey;
            padding-left: 15px;
            padding-right: 15px;
        }

        .fa:hover {
            color: black;
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
    <div class="row" id="books">
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM books WHERE Availability>'0' Order By AddedOn DESC LIMIT 24 ");
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
    <div class="row">
        <div class="col-md-12">
            <br><br>
            <button class="btn btn-primary w-100" onclick="viewMore()">View More</button>
            <br><br>
            <br><br>
        </div>
    </div>
</div>
<script>
    var count = 24;

    function viewMore() {
        params = "count=" + count;
        request = new ajaxRequest()
        request.open("POST", "view_more.jsp", true)
        request.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
        request.setRequestHeader("Content-length", params.length)
        request.setRequestHeader("Connection", "close")
        request.onreadystatechange = function () {
            if (this.readyState == 4)
                if (this.status == 200) {
                    $('#books').append(this.response);
                    count = count + 24;
                }
        }
        request.send(params)
    }

    function ajaxRequest() {
        try {
            var request = new XMLHttpRequest()
        }
        catch (e1) {
            try {
                request = new ActiveXObject("Msxml2.XMLHTTP")
            }
            catch (e2) {
                try {
                    request = new ActiveXObject("Microsoft.XMLHTTP")
                }
                catch (e3) {
                    request = false
                }
            }
        }
        return request
    }
</script>
</body>
</html>
