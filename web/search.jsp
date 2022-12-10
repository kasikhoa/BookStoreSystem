<%-- 
    Document   : search
    Created on : Oct 5, 2021, 11:37:23 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search</title>
    </head>
    <body>
        <c:set var="properties" value="${applicationScope.SITE_MAP}" />
        <c:set var="adminUserName" value="${properties.getProperty('admin')}" />
        <c:set var="isAdmin" value="${sessionScope.ADMIN}" />
        <c:set var="dto" value="${sessionScope.USER}" />  
        <c:set var="user" value="${dto.username}"/>

        <c:if test="${isAdmin}">
            <font color="red">
            Welcome, ${dto.fullname} 
            </font> <br/>
            <a href="logoutAction">Log Out</a>

            <h1>Search Account</h1>
            <form action="searchAction">
                Search Value
                <input type="text" name="txtSearchValue" 
                       value="${param.txtSearchValue}" /> 
                <input type="submit" value="Search" />
            </form> 

            <c:set var="searchValue" value="${param.txtSearchValue}" />
            <c:if test="${not empty searchValue}" >
                <c:set var="result" value="${requestScope.SEARCH_RESULT}" />
                <c:if test="${not empty result}">

                    <c:set var="error" value="${requestScope.UPDATE_ERR}" />
                    <c:if test="${not empty error.passwordError}">
                        <font color="red">
                        ${error.passwordError}
                        </font>
                    </c:if>
                    <table border="1">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Username</th>
                                <th>Password</th>
                                <th>Full name</th>
                                <th>Role</th>
                                <th>Delete</th>
                                <th>Update</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="dto" items="${result}" varStatus="counter">
                            <form action="updateAction">
                                <tr>
                                    <td style="text-align: center">
                                        ${counter.count}
                                    </td>
                                    <td>
                                        ${dto.username}
                                        <input type="hidden" name="txtUsername" value="${dto.username}" />
                                    </td>
                                    <td>
                                        <input type="text" name="txtPassword" value="${dto.password}" />
                                    </td>
                                    <td>
                                        ${dto.fullname}
                                    </td>
                                    <td style="text-align: center">
                                        <input type="checkbox" name="chkAdmin" value="ON" 
                                               <c:if test="${dto.role}">
                                                   checked="checked"
                                               </c:if>
                                               />
                                    </td>
                                    <td>
                                        <c:url var="urlRewriting" value="confirmDeleteAction">
                                            <c:param name="pk" value="${dto.username}" />
                                            <c:param name="lastSearchValue" value="${searchValue}" />
                                        </c:url>
                                        <c:if test="${user eq adminUserName}">
                                            <c:if test="${dto.username ne adminUserName}">
                                                <a href="${urlRewriting}" >Delete</a>
                                            </c:if>
                                        </c:if>
                                        <c:if test="${user ne adminUserName}">
                                            <c:if test="${!dto.role}">
                                                <a href="${urlRewriting}" >Delete</a>
                                            </c:if>
                                        </c:if>
                                    </td>
                                    <%--
                                    1) mọi admin chỉ có thể delete update những thằng có role != admin, k thể delete chính mình
                                    k dc update delete thằng admin trùm (admin)
                                    --%>
                                    <td>
                                        <c:if test="${user eq adminUserName}">
                                            <input type="submit" value="Update"
                                                   <c:if test="${dto.username eq adminUserName}">
                                                       style="visibility: hidden"
                                                   </c:if>
                                                   />
                                            <input type="hidden" name="lastSearchValue" 
                                                   value="${searchValue}" />
                                        </c:if>
                                        <c:if test="${user ne adminUserName}">
                                            <input type="submit" value="Update"
                                                   <c:if test="${user ne dto.username}">
                                                       <c:if test="${dto.role}">
                                                           style="visibility: hidden"
                                                       </c:if>
                                                   </c:if>
                                                   />
                                            <input type="hidden" name="lastSearchValue" 
                                                   value="${searchValue}" />
                                        </c:if>
                                    </td>
                                </tr>
                            </form>
                        </c:forEach>
                    </tbody>
                </table> 
            </c:if>
            <c:if test="${empty result}">
                <h2>No record is matched!!!</h2>
            </c:if>
        </c:if>
    </c:if>

    <c:if test="${!isAdmin}">
        <font color="red">
        Welcome, ${dto.fullname}  <br/>
        </font>
        <a href="logoutAction">Log Out</a>
        <h1>Your Profile</h1>
        <c:set var="dto" value="${sessionScope.SHOW_PROFILE}" />
        <c:if test="${not empty dto}">
            <p>Username: ${dto.username}</p>
            <p>Password: ${dto.password} </p>
            <p>Full Name: ${dto.fullname}</p>
            <p>Role: Not Admin!</p>        
        </c:if>
    </c:if>
</body>
</html>
