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
        }

        .fa:hover {
            color: black;
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

            <li><a href="#" class="active">Return</a></li>


        </ul>
    </div>
    <div>
        <div class="row">
            <div class="col-md-10">
                <br>
                <h4>Return Panel</h4>
                <form action="return.jsp" method="post">
                    <input type="text" name="SapId"  class="w-75" placeholder="SapID">
                    <button class="btn btn-primary" >Submit</button>
                </form>

        <%
            long fine=0;
            long current=0;
            String SapId = request.getParameter("SapId");
            if(StringUtils.isEmpty(SapId)) {

            }
            else{
                try {
                    Date date = new Date();
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/library", "root", "");
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * from records INNER JOIN books on records.ISBN=books.ISBN INNER JOIN users on records.email=users.email WHERE users.SapId = '" + SapId + "' AND records.ReturnDate='NA'");
                    int count = 0;
                    while (rs.next()){
                        current = date.getTime();
                        long issueDate = Long.parseLong(rs.getString("IssueDate"));
                        long days = (current - issueDate)/(24*60*60*1000);
                        if(days>7){
                            fine = (days-7)*50;
                        }
                        else {
                            fine=0;
                        }
                        Date returnDate = new Date(issueDate);
                        returnDate.setTime(returnDate.getTime()+ (15* 1000 * 60 * 60 * 24));
                        count++;
                        %>
                        <div class="col-md-10">
                            <br>
                            <div class="row">
                                <div class="col-md-2">
                                    <a href="#"><img src="../img/<%=rs.getString("ISBN")%>.jpg"></a>
                                </div>
                                <div class="col-md-6 offset-md-1">
                                    <h4><%= rs.getString("Title")%></h4>
                                    <p><%= rs.getString("Author")%></p>
                                    <p>Due Date : <%= returnDate.toString() %></p>
                                    <p>Fine : &#8377 <%= fine %></p>
                                    <form action="/ReturnBook?isbn=<%= rs.getString("ISBN") %>&email=<%= rs.getString("Email") %>&SapId=<%= rs.getString("SapId") %>" method="Post">
                                        <button class="btn btn-dark ">Return</button>
                                    </form>
                                </div>
                            </div>
                            <br>
                        </div>
                        <%
                                }
                                conn.close();
                            if(count==0){
                                out.print("<p><i>No Issued Books</p></i>");
                            }
                            }
                            catch(Exception e){ System.out.println(e);}
                            }
                        %>
            </div>
        </div>
    </div>
</div>
</body>
</html>
