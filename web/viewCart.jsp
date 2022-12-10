<%-- 
    Document   : viewCart
    Created on : Oct 15, 2022, 8:35:17 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart</title>
    </head>
    <body>
        <c:set var="cart" value="${sessionScope.CART}" />

        <c:if test="${not empty cart}">
            <h1>Your Cart</h1>
            
            <c:set var="items" value="${cart.items}" />           
            <c:if test="${not empty items}">
                <form action="cartAction">
                    <table border="1">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>SKU</th>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Quantity</th>
                                <th>Price</th>
                                <th>Remove</th>
                                <th>Check Out</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${items}" varStatus="counter">
                                <c:set var="dto" value="${item.key}" />
                                <c:set var="quantity" value="${item.value}" />
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
                                    <td>
                                        ${dto.description}
                                    </td>
                                    <td style="text-align: center">
                                        ${quantity}
                                    </td>
                                    <td>
                                        <fmt:formatNumber value="${dto.price}" 
                                                          maxFractionDigits="0"/>đ
                                    </td>
                                    <td style="text-align: center">
                                        <input type="checkbox" name="chkItem" 
                                               value="${dto.SKU}" />
                                    </td>
                                    <td style="text-align: center">
                                        <input type="checkbox" name="chkCheckOut" 
                                               value="${dto.SKU}" />
                                    </td>
                                </tr>
                            </c:forEach>
                            <tr>
                                <td colspan="6" style="text-align: center">
                                    <a href="showBookAction">
                                        Add More Books to Your Cart
                                    </a>
                                </td>
                                <td>
                                    <input type="submit" value="Remove Selected Books" 
                                           name="btAction" />
                                </td>
                                <td>
                                    <input type="submit" value="Check Out Selected Books"
                                           name="btAction" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </form>
            </c:if>

            <c:if test="${empty items}">
                <h2>
                    No item in your cart!
                </h2>
                <a href="showBookAction">Add More Books to Your Cart</a>
            </c:if>
        </c:if>

        <c:if test="${empty cart}">
            <h1>No cart is existed!!</h1>
            <a href="showBookAction">Go Shopping</a>
        </c:if>
    </body>
</html>
