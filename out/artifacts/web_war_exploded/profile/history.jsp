<%-- Created by IntelliJ IDEA. --%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="java.util.Date" %>
<html>
<head>
    <title>Library | Profile</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <style>
        img:hover{
            opacity: 0.9;
        }
        input{
            padding: 10px;
            margin-bottom: 10px;
        }
        textarea{
            padding: 10px;
        }
        ul{
            padding-top: 20px;
            padding-bottom: 20px;
            list-style: none;
            border-right: 1px solid #a3a3a3;
            padding-left: 0px;
            margin-right: 20px;
            margin-top: 5px;
        }
        ul li {
            padding: 0px 20px;
        }
        ul li a{
            padding-left: 20px;
            color: #0056b3;
        }
        ul li a:hover{
            text-decoration: none;
            color: #00b4e5;

        }
        img{
            height: 200px;
        }
        .active{
            color: black;
            border-left: 1px solid black;
        }
        .fa {
            color: grey;
            padding-left: 15px;
            padding-right: 15px;
            z-index: 1000;
        }

        .fa:hover {
            color: black;
        }
    </style>

</head>
<body>
<%
    String email = (String) session.getAttribute("email");
    if(StringUtils.isEmpty(email)) {
        response.sendRedirect("../index.jsp");
    }
    else {
%>
<div class="container-fluid">
    <div class="row navbar navbar-expand-lg navbar-light bg-light">
        <div class="col-md-2 ">
            <a class="navbar-brand" href="../index.jsp">L I B R A R Y </a>
        </div>
        <div class="col-md-8">
            <form action="../search.jsp" method="post" class="form-inline my-2 my-lg-0">
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
<div class="container-fluid">
    <div style="float: left">
        <ul>
            <li><a href="index.jsp">Issued Books </a></li>
            <li><a href="#" class="active">History</a></li>
        </ul>
    </div>
    <div>
        <div class="row">
            <%
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","");
                    Statement stmt=conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * from records INNER JOIN books on records.ISBN=books.ISBN WHERE records.Email = '"+email+"' order by IssueDate DESC");
                    while (rs.next()){
                        long issueDate = Long.parseLong(rs.getString("IssueDate"));
                        Date returnDate = new Date(issueDate);
                        returnDate.setTime(returnDate.getTime()+ (15* 1000 * 60 * 60 * 24));

            %>
            <div class="col-md-10">
                <br>
                <div class="row">
                    <div class="col-md-2 offset-md-1">
                        <a href="../book.jsp?isbn=<%=rs.getString("ISBN")%>"><img src="../img/<%=rs.getString("ISBN")%>.jpg"></a>
                    </div>
                    <div class="col-md-6">
                        <h4><%= rs.getString("Title")%></h4>
                        <p><%= rs.getString("Author")%></p>
                        <p>Due Date : <%= returnDate.toString() %></p>
                    </div>
                </div>
                <br>
            </div>
            <%
                    }
                    conn.close();
                }
                catch(Exception e){ System.out.println(e);}
            %>

        </div>
    </div>

</div>
</body>
</html>
