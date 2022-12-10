<%-- 
    Document   : signUp
    Created on : Oct 21, 2021, 11:49:40 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Up</title>
    </head>
    <body>
        <h1>Create New Account</h1>

        <form action="signUpAction" method="POST">
            <c:set var="errors" value="${requestScope.SIGNUP_ERROR}" />

            Username * <input type="text" name="txtUsername" value="${param.txtUsername}"/> <br/>

            <c:if test="${not empty errors.userNameLengthErr}">
                <font color="red">
                ${errors.userNameLengthErr}<br/>
                </font>
            </c:if>
            Password * <input type="password" name="txtPassword" value="" /> <br/>

            <c:if test="${not empty errors.passwordLengthErr}">
                <font color="red">
                ${errors.passwordLengthErr}<br/>
                </font>
            </c:if>

            Confirm * <input type="password" name="txtConfirm" value=""/> </br>
            <c:if test="${not empty errors.confirmNotMatch}">
                <font color="red">
                ${errors.confirmNotMatch}<br/>
                </font>
            </c:if>

            Full Name * <input type="text" name="txtFullname" value="${param.txtFullname}"/> <br/>

            <c:if test="${not empty errors.fullNameLengthErr}">
                <font color="red">
                ${errors.fullNameLengthErr}<br/>
                </font>
            </c:if>
            <input type="submit" value="Sign Up"/>
            <input type="reset" value="Reset"/><br/>
            <c:if test="${not empty errors.userNameIsExisted}">
                <font color="red">
                ${errors.userNameIsExisted}
                </font>
            </c:if>
            Have already an account?
            <a href="loginPage">Login Here!</a>
        </form>
    </body>
</html>
