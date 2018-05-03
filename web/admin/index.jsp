<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="description"
          content="We know how important it is to keep the growling tummy fed through the day. We bring you Eatopedia, a small venture by us that focuses on making online food ordering easier and lighter on pockets.">
    <meta name="keywords"
          content="food delivery, food, food delivery in bidholi, eatopedia , food delivery in prem nagar , restaurants in premnagar , eatopedia dehradun , night food delivery , online food ordering , budget restaurants, restaurants near upes ">
    <meta name="author" content="Sandeep Babbar , Pranjal Jain">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library | Login</title>
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
    <link href="css/bootstrap.css" type="text/css" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css"
          rel="stylesheet">
    <link href="css/join.css" type="text/css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="container-fluid" id="login">
    <div class="row close_btn visibility" id="close_login">
        <div class="col-md-2 col-md-offset-10">
            <h2>X</h2>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <h1><b>Authentication</b></h1>
        </div>
    </div>
    <div class="row flex" id="login_col">
        <div class="col-md-4 col-md-offset-4">
            <form method="post" action="/LoginAdmin">
                <input class="input"  type="text" name="username" required placeholder="Username" value=""
                       autocomplete="on">
                <input class="input" id="loginPassword" type="password" name="password" required placeholder="Password"
                       value="" autocomplete="on">
                <%--<p><span id="remember"><input type="checkbox" name="remember" value="1"> Remember Me</span></p>--%>
                <button type="submit" name="loginSubmit" value="Login">Go</button>
            </form>
            <br>
        </div>
    </div>
</div>
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/join.js"></script>
</body>
</html>

