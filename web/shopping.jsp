<%-- 
    Document   : shopping
    Created on : Oct 18, 2021, 8:33:58 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book Store</title>
    </head>
    <body>
        <h1>Book Mart</h1>

        <c:set var="result" value="${requestScope.BOOK_LIST}"/>
        <c:if test="${not empty result}">
            <table border="1">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>SKU</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Description</th>
                        <th>Quantity</th>
                        <th>Add to Cart</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="dto" items="${result}" varStatus="counter">
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
                                <fmt:formatNumber value="${dto.price}" maxFractionDigits="0"/>đ
                            </td>
                            <td>
                                ${dto.description}
                            </td>
                            <td style="text-align: center">
                                <c:set var="quantity" value="${dto.quantity}" />
                                <c:set var="cart" value="${sessionScope.CART}" />
                                <c:set var="remainQuantity" value="${quantity - cart.getQuantityBySKU(dto.SKU)}" /> 
                                ${remainQuantity}
                            </td>
                            <td style="text-align: center">
                                <c:if test="${quantity eq 0}">
                                    <font color="red">SOLD-OUT</font>
                                </c:if>

                                <c:if test="${quantity ne 0}">
                                    <form action="addBookToCartAction">
                                        <input type="submit" value="Add" "
                                               <c:if test="${remainQuantity eq 0}">
                                                   style="visibility: hidden"   
                                               </c:if>
                                               />                                               
                                        <input type="hidden" name="pk" value="${dto.SKU}" />
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <form action="viewCartPage">
            <input type="submit" value="View Your Cart"/>
        </form>

        <c:if test="${empty result}">
            <h2>No book is in store!</h2>
        </c:if>
    </body>
</html>