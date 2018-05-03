<%-- Created by IntelliJ IDEA. --%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="java.util.Date" %>

<html>
<head>
    <title>Library</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <style>
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
        .active{
            color: black;
            border-left: 1px solid black;
        }
        td{
            padding: 10px;
        }

    </style>

</head>
<body>
<%
    String loggedIn = (String) session.getAttribute("loggedIn");
    if(StringUtils.isEmpty(loggedIn)) {
        response.sendRedirect("../admin/index.jsp");
    }

%>
<div class="container-fluid">
    <div class="row navbar navbar-expand-lg navbar-light bg-light">
        <div class="col-md-2 ">
            <a class="navbar-brand" href="#">Control Panel </a>
        </div>
    </div>
    <div style="float: left">
        <ul>
            <li><a href="addBooks.jsp">Add Books </a></li>
            <li><a href="return.jsp">Return</a></li>
            <li><a href="#" class="active">Defaulters</a></li>
        </ul>
    </div>
    <div>
        <div class="row">
            <div class="col-md-10">
                <br>
                <h4>Defaulters Panel</h4>
                <br>
                <table border="2">
                    <tr>
                        <td>Email</td>
                        <td>SapID</td>
                        <td>ISBN</td>
                        <td>Title</td>
                        <td>Fine</td>
                    </tr>

                <%
                    try{
                        Date date = new Date();
                        long current = date.getTime();
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","");
                        Statement stmt=conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * from records INNER JOIN books on records.ISBN=books.ISBN INNER JOIN users on records.email=users.email WHERE  records.ReturnDate='NA'");
                        while(rs.next()){
                            long issue = rs.getLong("IssueDate");
                            long days = (current - issue)/(24*60*60*1000);
                            if(days>7){
                                long fine = (days-7)*50;
                                %>
                                    <tr>
                                        <td><%= rs.getString("Email")%></td>
                                        <td><%= rs.getString("SapId")%></td>
                                        <td><%= rs.getString("ISBN")%></td>
                                        <td><%= rs.getString("Title")%></td>
                                        <td> &#8377 <%= fine %></td>
                                    </tr>
                                <%
                            }
                        }
                        conn.close();
                    }
                    catch(Exception e){ System.out.println(e);}
                %>
                </table>
            </div>
        </div>
    </div>

</div>
</body>
</html>
