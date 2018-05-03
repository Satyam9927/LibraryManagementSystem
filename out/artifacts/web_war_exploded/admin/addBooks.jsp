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
        th,td {
            width:20%;
            padding: 5px;
            /*border-bottom: 1px solid black;*/
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
            <form method="post">
                <li><a onclick="addbook()" href="#">Add Books</a></li>
            </form>
            <form method="post">
                <li><a onclick="deletebook()" href="#">Delete Books</a></li>
            </form>
            <form method="post">
                <li><a href="return.jsp" target="_blank">Return Books</a></li>
            </form>
            <form action="/IssuedBooks" method="post">
                <li><a onclick="issuedbooks()" href="#">Issued Books</a></li>
            </form>
            <form action="/AllUsers" method="post">
                <li><a onclick="users()" href="#">All Users</a></li>
            </form>
            <form action="/Defaulters" method="post">
                <li><a onclick="defaulters()" href="#">Defaulters</a></li>
            </form>
            <form method="post">
                <li><a onclick="logs()" href="#">View Logs</a></li>
            </form>

        </ul>
    </div>
    <div id="welcome"><h3>Welcome Administrator!</h3></div>
    <script type="text/javascript">
        function addbook() {
            document.getElementById("welcome").style.display="none";
            document.getElementById("deletebook").style.display="none";
            document.getElementById("returnbook").style.display="none";
            document.getElementById("logs").style.display="none";
            document.getElementById("addbook").style.display="block";
            document.getElementById("issuedbooks").style.display="none";
            document.getElementById("users").style.display="none";
            document.getElementById("defaulters").style.display="none";
        }
        function deletebook() {
            document.getElementById("welcome").style.display="none";
            document.getElementById("deletebook").style.display="block";
            document.getElementById("returnbook").style.display="none";
            document.getElementById("logs").style.display="none";
            document.getElementById("addbook").style.display="none";
            document.getElementById("issuedbooks").style.display="none";
            document.getElementById("allusers").style.display="none";
            document.getElementById("defaulters").style.display="none";
        }
        function returnbook() {
            document.getElementById("welcome").style.display="none";
            document.getElementById("deletebook").style.display="none";
            document.getElementById("returnbook").style.display="block";
            document.getElementById("logs").style.display="none";
            document.getElementById("addbook").style.display="none";
            document.getElementById("issuedbooks").style.display="none";
            document.getElementById("allusers").style.display="none";
            document.getElementById("defaulters").style.display="none";
        }
        function issuedbooks() {
            document.getElementById("welcome").style.display="none";
            document.getElementById("deletebook").style.display="none";
            document.getElementById("returnbook").style.display="none";
            document.getElementById("logs").style.display="none";
            document.getElementById("addbook").style.display="none";
            document.getElementById("issuedbooks").style.display="block";
            document.getElementById("allusers").style.display="none";
            document.getElementById("defaulters").style.display="none";
        }
        function users() {
            document.getElementById("welcome").style.display="none";
            document.getElementById("deletebook").style.display="none";
            document.getElementById("returnbook").style.display="none";
            document.getElementById("logs").style.display="none";
            document.getElementById("addbook").style.display="none";
            document.getElementById("issuedbooks").style.display="none";
            document.getElementById("allusers").style.display="block";
            document.getElementById("defaulters").style.display="none";
        }
        function defaulters() {
            document.getElementById("welcome").style.display="none";
            document.getElementById("deletebook").style.display="none";
            document.getElementById("returnbook").style.display="none";
            document.getElementById("logs").style.display="none";
            document.getElementById("addbook").style.display="none";
            document.getElementById("issuedbooks").style.display="none";
            document.getElementById("allusers").style.display="none";
            document.getElementById("defaulters").style.display="block";
        }
        function logs() {
            document.getElementById("welcome").style.display="none";
            document.getElementById("deletebook").style.display="none";
            document.getElementById("returnbook").style.display="none";
            document.getElementById("logs").style.display="block";
            document.getElementById("addbook").style.display="none";
            document.getElementById("issuedbooks").style.display="none";
            document.getElementById("allusers").style.display="none";
            document.getElementById("defaulters").style.display="none";
        }

    </script>

    <div id="addbook" style="display:none">
        <div class="row">
            <div class="col-md-10">
                <br>
                <h4>ADD BOOKS</h4>
                <form action="/upload" method="post" enctype="multipart/form-data">
                    <input class="w-75" type="text" name="Title" placeholder="Title"><br>
                    <input class="w-75" type="text" name="ISBN" placeholder="ISBN"><br>
                    <input class="w-75" type="text" name="Author" placeholder="Author"><br>
                    <input class="w-75" type="text" name="Genre" placeholder="Genre"><br>
                    <input class="w-75" type="text" name="Availability" placeholder="Availability"><br>
                    Cover : <input type="file" name="file" placeholder="Cover">
                    <textarea class="w-75" name="Description" placeholder="Description"></textarea><br>
                    <br>
                    <button class="btn btn-primary w-75" >Add</button>
                </form>
            </div>
        </div>
    </div>

    <div id="deletebook" style="display:none">
        <div class="row">
            <div class="col-md-10">
                <br>
                <h4>DELETE BOOKS</h4>
                <form action="/delete" method="post" enctype="multipart/form-data">
                    <input class="w-75" type="text" name="ISBN" placeholder="ISBN"><br>
                    <br>
                    <button class="btn btn-primary w-75" >Delete</button>
                </form>
            </div>
        </div>
    </div>

    <div id="returnbook" style="display:none">
        <div class="row">
            <div class="col-md-10">
                <br>
                <h4>Return Panel</h4>
                <form action="/ReturnBook" method="post">
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
                            <form action="/ReturnBook?isbn=<%= rs.getString("ISBN") %>&email=<%= rs.getString("Email") %>" method="Post">
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

    <div id="issuedbooks" style="display:none">
        <div class="row">
            <div class="col-md-10">
                <br>
                <h4>ISSUED BOOKS</h4>
                <%
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","");
                        Statement stmt=conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM logs where Operation = 'Issued'");

                %>

                <table data-toggle="table">
                    <thead>
                    <tr>
                        <th data-field="SNO">SNO</th>
                        <th data-field="SapID">SapID</th>
                        <th data-field="ISBN">ISBN</th>
                        <th data-field="Title">Title</th>
                        <th data-field="Operation">Operation</th>
                    </tr>
                    <%--<%--%>
                    <%--while(rs.next())--%>
                    <%--{--%>
                    <%--%>--%>
                    <tr>
                        <%while (rs.next()){
                        %>
                        <td><%= rs.getString(1)%></td>
                        <td><%= rs.getString(2)%></td>
                        <td><%= rs.getString(3)%></td>
                        <td><%= rs.getString(4)%></td>
                        <td><%= rs.getString(5)%></td>
                    </tr>
                    <% }%>
                    </thead>
                </table>

                <%
                        conn.close();
                    }
                    catch(Exception e){ System.out.println(e);}
                %>



            </div>
        </div>
    </div>

    <div id="allusers" style="display:none">
        <div class="row">
            <div class="col-md-10">
                <br>
                <h4>ALL USERS</h4>

                <%
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","");
                        Statement stmt=conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM users");

                %>

                <table data-toggle="table">
                    <thead>
                    <tr>
                        <th data-field="SNO">UserID</th>
                        <th data-field="SapID">SapID</th>
                        <th data-field="ISBN">Email</th>

                    </tr>
                    <%--<%--%>
                    <%--while(rs.next())--%>
                    <%--{--%>
                    <%--%>--%>
                    <tr>
                        <%while (rs.next()){
                        %>
                        <td><%= rs.getString(1)%></td>
                        <td><%= rs.getString(2)%></td>
                        <td><%= rs.getString(3)%></td>
                    </tr>
                    <% }%>
                    </thead>
                </table>

                <%
                        conn.close();
                    }
                    catch(Exception e){ System.out.println(e);}
                %>



            </div>
        </div>
    </div>

    <div id="defaulters" style="display:none">
        <div class="row">
            <div class="col-md-10">
                <br>
                <h4>Defaulters Panel</h4>
                <br>
                <table>
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
                            long current1 = date.getTime();
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","");
                            Statement stmt=conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * from records INNER JOIN books on records.ISBN=books.ISBN INNER JOIN users on records.email=users.email WHERE  records.ReturnDate='NA'");
                            while(rs.next()){
                                long issue = rs.getLong("IssueDate");
                                long days = (current1 - issue)/(24*60*60*1000);
                                if(days>7){
                                    long fine1 = (days-7)*50;
                    %>
                    <tr>
                        <td><%= rs.getString("Email")%></td>
                        <td><%= rs.getString("SapId")%></td>
                        <td><%= rs.getString("ISBN")%></td>
                        <td><%= rs.getString("Title")%></td>
                        <td> &#8377 <%= fine1 %></td>
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

    <div id="logs" style="display:none">
        <div class="row">
            <div class="col-md-10">
                <br>
                <h4>LOGS</h4>
                <%
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","");
                        Statement stmt=conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM logs");

                %>

                <table data-toggle="table">
                    <thead>
                    <tr>
                        <th data-field="SNO">SNO</th>
                        <th data-field="SapID">SapID</th>
                        <th data-field="ISBN">ISBN</th>
                        <th data-field="Title">Title</th>
                        <th data-field="Operation">Operation</th>
                        <th data-field="Operation">Time</th>
                    </tr>
                    <%--<%--%>
                    <%--while(rs.next())--%>
                    <%--{--%>
                    <%--%>--%>
                    <tr>
                        <%while (rs.next()){
                        %>
                        <td><%= rs.getString(1)%></td>
                        <td><%= rs.getString(2)%></td>
                        <td><%= rs.getString(3)%></td>
                        <td><%= rs.getString(4)%></td>
                        <td><%= rs.getString(5)%></td>
                        <td><%= rs.getString(6)%></td>
                    </tr>
                    <% }%>
                    </thead>
                </table>

                <%
                        conn.close();
                    }
                    catch(Exception e){ System.out.println(e);}
                %>

            </div>
        </div>
    </div>


</div>
</body>
</html>
