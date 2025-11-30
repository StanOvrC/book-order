<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Профиль пользователя</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<h1>Профиль пользователя</h1>

<h3>Информация о пользователе:</h3>
<ul>
    <li>Имя: ${user.firstName}</li>
    <li>Фамилия: ${user.lastName}</li>
    <li>Email: ${user.email}</li>
    <li>Роль: ${user.role}</li>
    <c:if test="${not empty user.birthdate}">
        <li>Дата рождения: ${user.birthdate}</li>
    </c:if>
</ul>

<hr>

<h3>Текущие заказы</h3>
<c:if test="${empty orders}">
    <p>Заказы отсутствуют.</p>
</c:if>

<c:forEach var="order" items="${orders}">
    <c:if test="${order.status == 'IN_CART' || order.status == 'PENDING' || order.status == 'PAID'}">
        <div style="border:1px solid #ccc; padding:10px; margin-bottom:10px;">
            <p><strong>Заказ #${order.id}</strong> | Статус: ${order.status}</p>
            <p>Адрес: ${order.address}</p>
            <table border="1" cellpadding="5">
                <tr>
                    <th>Книга</th>
                    <th>Цена</th>
                    <th>Количество</th>
                    <th>Сумма</th>
                </tr>
                <c:forEach var="item" items="${order.items}">
                    <tr>
                        <td>${item.bookTitle}</td>
                        <td>${item.price}</td>
                        <td>${item.quantity}</td>
                        <td>${item.price * item.quantity}</td>
                    </tr>
                </c:forEach>
            </table>
            <p><strong>Итого: ${order.totalCost}</strong></p>
        </div>
    </c:if>
</c:forEach>

<hr>

<h3>Завершённые заказы</h3>
<c:forEach var="order" items="${orders}">
    <c:if test="${order.status == 'DELIVERED' || order.status == 'CANCELED'}">
        <div style="border:1px solid #ccc; padding:10px; margin-bottom:10px; background-color:#f9f9f9;">
            <p><strong>Заказ #${order.id}</strong> | Статус: ${order.status}</p>
            <p>Адрес: ${order.address}</p>
            <table border="1" cellpadding="5">
                <tr>
                    <th>Книга</th>
                    <th>Цена</th>
                    <th>Количество</th>
                    <th>Сумма</th>
                </tr>
                <c:forEach var="item" items="${order.items}">
                    <tr>
                        <td>${item.bookTitle}</td>
                        <td>${item.price}</td>
                        <td>${item.quantity}</td>
                        <td>${item.price * item.quantity}</td>
                    </tr>
                </c:forEach>
            </table>
            <p><strong>Итого: ${order.totalCost}</strong></p>
        </div>
    </c:if>
</c:forEach>

</body>
</html>
