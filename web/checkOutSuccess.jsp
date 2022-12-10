<%-- 
    Document   : checkOutSuccess
    Created on : Nov 1, 2021, 11:37:15 AM
    Author     : admin
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Check Out Success</title>
    </head>
    <body>
        <c:set var="order" value="${sessionScope.ORDER}" />
        <c:if test="${not empty order}">
            <h1>Your Receipt</h1>

            <c:set var="orderDetails" value="${sessionScope.LIST_ORDER_DETAILS}" />
            <c:if test="${not empty orderDetails}">
                Order ID: ${order.orderID} <br/>
                Date: ${order.date} <br/>
                Customer Name: ${order.name} <br/>
                Customer Address: ${order.address} <br/>
                <table border="1">
                    <thead>
                        <tr>
                            <th>SKU</th>
                            <th>Name</th>
                            <th>Quantity</th>
                            <th>Price</th>
                            <th>Money</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="dto" items="${orderDetails}">
                            <tr>
                                <td>
                                    ${dto.SKU}
                                </td>
                                <td>
                                    ${dto.name}
                                </td>
                                <td style="text-align: center">
                                    ${dto.quantity}
                                </td>
                                <td>
                                    <fmt:formatNumber value="${dto.price}" 
                                                      maxFractionDigits="0" />đ
                                </td>
                                <td>
                                    <fmt:formatNumber value="${dto.total}"
                                                      maxFractionDigits="0"/>đ
                                </td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="4" style="text-align: center">
                                Total
                            </td>
                            <td>
                                <fmt:formatNumber value="${order.total}"
                                                  maxFractionDigits="0"/>đ
                            </td>
                        </tr>
                    </tbody>
                </table>
            </c:if>
            <a href="showBookAction">
                <input type="submit" value="Go Shopping"/>
            </a> 
            <a href="viewCartPage">
                <input type="submit" value="View Cart" />
            </a>
        </c:if>
    </body>
</html>
