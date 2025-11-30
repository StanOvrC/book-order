<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Корзина</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/navbar.jsp" %>


<h1>Корзина</h1>

<c:if test="${not empty successMessage}">
    <div class="alert alert-success">${successMessage}</div>
</c:if>

<c:if test="${not empty errorMessage}">
    <div class="alert alert-danger">${errorMessage}</div>
</c:if>

<c:if test="${empty cart.items}">
    <p>Корзина пуста.</p>
</c:if>

<c:if test="${not empty cart.items}">
    <table border="1" cellpadding="10">
        <tr>
            <th>Книга</th>
            <th>Цена</th>
            <th>Количество</th>
            <th>Сумма</th>
            <th>Действия</th>
        </tr>

        <c:forEach var="item" items="${cart.items}">
            <tr>
                <td>${item.bookTitle}</td>
                <td>${item.price}</td>
                <td>${item.quantity}</td>
                <td>${item.price * item.quantity}</td>

                <td>
                    <form action="/cart/add" method="post" style="display:inline;">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <input type="hidden" name="bookId" value="${item.bookId}"/>
                        <input type="hidden" name="quantity" value="1"/>
                        <button type="submit">+</button>
                    </form>

                    <form action="/cart/decrease" method="post" style="display:inline;">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <input type="hidden" name="bookId" value="${item.bookId}"/>
                        <input type="hidden" name="quantity" value="1"/>
                        <button type="submit">-</button>
                    </form>

                    <form action="/cart/remove" method="post" style="display:inline;">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <input type="hidden" name="orderItemId" value="${item.id}"/>
                        <button type="submit">Удалить</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>

    <h3>Итоговая стоимость: ${cart.totalCost}</h3>

    <form action="/cart/clear" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        <button type="submit">Очистить корзину</button>
    </form>

    <br>

    <form action="/cart/checkout" method="get">
        <button type="submit">Оформить заказ</button>
    </form>

</c:if>

</body>
</html>
