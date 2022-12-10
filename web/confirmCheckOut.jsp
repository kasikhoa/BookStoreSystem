<%-- 
    Document   : confirmCheckOut
    Created on : Oct 20, 2021, 4:12:10 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Confirm Check Out</title>
    </head>
    <body>
        <c:set var="list" value="${sessionScope.CHECK_OUT_ITEMS}" />

        <c:if test="${not empty list}">
            <form action="checkOutAction">
                <h1>Check Out Your Cart</h1>
                Name *<input type="text" name="txtName" value=""
                             required/> <br/> 
                Address *<input type="text" name="txtAdress" value="" 
                                required/> <br/>
                <table border="1">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>SKU</th>
                            <th>Name</th>
                            <th>Quantity</th>
                            <th>Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${list}" varStatus="counter">
                            <c:set var="dto" value="${item.key}" />
                            <c:set var="price" value="${dto.price}" />
                            <c:set var="quantity" value="${item.value}" />                            
                            <c:set var="total" value="${total + quantity * price}" />
                            <tr>
                                <td style="text-align: center">
                                    ${counter.count}
                                </td>
                                <td>
                                    ${dto.SKU}
                                </td>
                                <td>
                                    ${dto.name}
                                </td>
                                <td style="text-align: center">
                                    ${quantity}
                                </td>
                                <td>
                                    <fmt:formatNumber value="${price}" 
                                                      maxFractionDigits="0"/>đ
                                </td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="4" style="text-align: center">
                                Total
                            </td>
                            <td>
                                <fmt:formatNumber value="${total}" maxFractionDigits="0"/>đ
                                <input type="hidden" name="txtTotal" value="${total}" />
                            </td>
                        </tr>
                    </tbody>
                </table> 
                <input type="submit" value="Check Out" /><br/>
                <a href="viewCartPage">Back to your Cart</a>
            </form>    
        </c:if>
    </body>
</html>
