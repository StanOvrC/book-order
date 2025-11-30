<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Оформление заказа</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/navbar.jsp" %>


<h1>Оформление заказа</h1>

<c:if test="${not empty successMessage}">
    <div class="alert alert-success">${successMessage}</div>
</c:if>

<c:if test="${not empty errorMessage}">
    <div class="alert alert-danger">${errorMessage}</div>
</c:if>

<h3>Ваш заказ:</h3>

<table border="1" cellpadding="10">
    <tr>
        <th>Книга</th>
        <th>Цена</th>
        <th>Количество</th>
        <th>Сумма</th>
    </tr>

    <c:forEach var="item" items="${cart.items}">
        <tr>
            <td>${item.bookTitle}</td>
            <td>${item.price}</td>
            <td>${item.quantity}</td>
            <td>${item.price * item.quantity}</td>
        </tr>
    </c:forEach>
</table>

<h3>Итого: ${cart.totalCost}</h3>

<form action="/cart/checkout" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

    <label for="paymentMethod">Способ оплаты:</label><br>
        <select id="paymentMethod" name="paymentMethod" required style="width:300px;">
            <option value="card_online">Банковская карта (онлайн)</option>
            <option value="cash_delivery">Наличными при получении</option>
            <option value="card_delivery">Картой при получении</option>
        </select>
        <br><br>

    <label>Адрес доставки:</label><br>
    <input type="text" name="address" required style="width:300px;"/><br><br>

    <button type="submit">Подтвердить заказ</button>
</form>

</body>
</html>
