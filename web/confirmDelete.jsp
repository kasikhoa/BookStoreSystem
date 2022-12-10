<%-- 
    Document   : confirmDelete
    Created on : Oct 29, 2021, 10:47:47 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Confirm Delete</title>
    </head>
    <body>
        <c:set var="dto" value="${sessionScope.SHOW_PROFILE}" />
        <c:if test="${not empty dto}">
            <h1>Confirm Delete</h1>
            <div>
                Username: ${dto.username}
            </div>
            <div>
                Password: ${dto.password} 
            </div>
            <div>
                Full Name: ${dto.fullname}
            </div>
            <div>
                Role: 
                <c:if test="${dto.role}">
                    Admin
                </c:if>
                <c:if test="${!dto.role}">
                    Not Admin
                </c:if>

                <form action="deleteAction">
                    <input type="submit" value="Confirm"/>
                    <input type="hidden" name="pk" value="${dto.username}" />
                    <input type="hidden" name="lastSearchValue" value="${param.lastSearchValue}" />                   
                </form>
                <c:url var="urlReWriting" value="searchAction">
                    <c:param name="txtSearchValue" value="${param.lastSearchValue}" />
                </c:url>
                <a href="${urlReWriting}">
                    <input type="submit" value="Cancel"/>
                </a>
            </c:if>
            <c:if test="${empty dto}">
                <h1>No profile for Delete!</h1>
                <div>
                    <a href="loginPage">Go Back To Login Page!</a>
                </div>
            </c:if>
        </div>
    </body>
</html>
