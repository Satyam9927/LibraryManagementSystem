<%--
  Created by IntelliJ IDEA.
  User: Babbar
  Date: 4/19/2018
  Time: 2:41 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="We know how important it is to keep the growling tummy fed through the day. We bring you Eatopedia, a small venture by us that focuses on making online food ordering easier and lighter on pockets.">
    <meta name="keywords" content="food delivery, food, food delivery in bidholi, eatopedia , food delivery in prem nagar , restaurants in premnagar , eatopedia dehradun , night food delivery , online food ordering , budget restaurants, restaurants near upes ">
    <meta name="author" content="Sandeep Babbar , Pranjal Jain">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library| SignUp</title>
    <link href="css/bootstrap.css" type="text/css" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css" rel="stylesheet">
    <link href="css/join.css" type="text/css" rel="stylesheet">

    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="container-fluid" id="signup">
    <div class="row close_btn visibility">
        <div class="col-md-2 col-md-offset-10">
            <h2>X</h2>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <h1><b>Sign up</b></h1>
        </div>
    </div>
    <div class="row flex" id="signup_col">
        <div class="col-md-4 col-md-offset-4">
            <form action="/SignUp" method="post" onsubmit="return validate(this)">
                <input type="text" name="sapId" value="" placeholder="SapID" required pattern="[0-9]{9}" required onblur="validateSapId(this)">
                <p class="error" id="sapIdError"></p>
                <input id="email" type="email" name="email" value="" placeholder="Email" required onblur="validateEmail(this)">
                <p class="error" id="userAvailability"></p>
                <p class="error" id="emailError"></p>
                <input id="password" type="password" name="password" placeholder="Password" required onblur="validatePassword(this)">
                <p class="error" id="passwordError" ></p>
                <input id="confirmPassword" type="password" name="password" placeholder="Confirm Password" required  onblur="validateConfirmPassword(this)">
                <p class="error" id="confirmPasswordError"><?php echo $confirmPasswordError ?></p>
                <button value="Submit" name="submit">Go</button>
            </form>
            <br>
            <p>I'm already a user, <a id="login_btn" href="login.jsp"><b>Log in</b></a></p>
        </div>

    </div>
</div>
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<script>
    var sapIdError=""
    var emailError=""
    var passwordError=""
    var confirmPasswordError=""
    var userAvailabilityError =""

            function validateSapId(field){
                if(field.value==""){
            document.getElementById('sapIdError').innerHTML="Please enter a valid SAP ID."
            sapIdError = "sapIderror";
        }
        else if(/[^0-9 ]/.test(field.value)){
            document.getElementById('sapIdError').innerHTML="Please enter a valid SAP ID."
            sapIdError = "sapIderror";
        }
        else if(field.value.length != 9){
            document.getElementById('sapIdError').innerHTML="Please enter a valid SAP ID."
            sapIdError = "sapIderror";
        }
        else{
            document.getElementById('sapIdError').innerHTML=""
            sapIdError = "";
        }
    }
    function validateEmail(field){
        if(field.value==""){
            document.getElementById('userAvailability').innerHTML = "";
            document.getElementById('emailError').innerHTML="An email address is required."
            emailError = "Emailerror";
        }
        else{
            document.getElementById('emailError').innerHTML=""
            emailError = "";
            userAvailability()
        }
    }
    function validatePassword(field){
        if(field.value==""){
            document.getElementById('passwordError').innerHTML="Choose a password."
            passwordError = "Passworderror"
        }
        else if(field.value.length < 6){
            document.getElementById('passwordError').innerHTML="Password should be atleast 6 characters long."
            passwordError = "Passworderror"
        }
        else{
            document.getElementById('passwordError').innerHTML=""
            passwordError = "";
        }
    }
    function validateConfirmPassword(field){
        var str1 = document.getElementById('confirmPassword').value
        var str2 = document.getElementById('password').value
        if(field.value==""){
            document.getElementById('confirmPasswordError').innerHTML="Confirm Password !"
            confirmPasswordError = "CPerror"
        }
        else if(str1 != str2){
            document.getElementById('confirmPasswordError').innerHTML="Passwords does not match."
            confirmPasswordError = "CPerror";
        }
        else{
            document.getElementById('confirmPasswordError').innerHTML=""
            confirmPasswordError = "";
        }
    }
    function validate(field){
        error =  sapIdError+emailError+passwordError+confirmPasswordError+userAvailabilityError
        //alert(error);
        if(error=="")
            return true
        else return false
    }
    function userAvailability(){
        params = "email="+document.getElementById('email').value
        request = new ajaxRequest()
        request.open("POST", "/CheckUser", true)
        request.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
        request.setRequestHeader("Content-length", params.length)
        request.setRequestHeader("Connection", "close")

        request.onreadystatechange = function()
        {
            if (this.readyState == 4)
                if (this.status == 200)
                    if (this.responseText != ""){
                        document.getElementById('userAvailability').innerHTML = "<span>This Email already exists.</span>"
                        userAvailabilityError="Availaerror";
                    }
                    else{
                        document.getElementById('userAvailability').innerHTML = "<span></span>";
                        userAvailabilityError="";
                    }
        }
        request.send(params)
    }

    function ajaxRequest()
    {
        try { var request = new XMLHttpRequest() }
        catch(e1) {
            try { request = new ActiveXObject("Msxml2.XMLHTTP") }
            catch(e2) {
                try { request = new ActiveXObject("Microsoft.XMLHTTP") }
                catch(e3) {
                    request = false
                } } }
        return request
    }
</script>
</body>
</html>
