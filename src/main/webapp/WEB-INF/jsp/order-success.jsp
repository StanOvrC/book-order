<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Заказ оформлен</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<h1>Спасибо! Ваш заказ успешно оформлен.</h1>

    <div>
        <p><strong>Номер заказа:</strong> ${createdOrder.id}</p>
        <p><strong>Статус:</strong> ${createdOrder.status}</p>
        <p><strong>Адрес доставки:</strong> ${createdOrder.address}</p>
        <p><strong>Общая сумма:</strong> ${createdOrder.totalCost} BYN.</p>
    </div>

<a href="/">Вернуться на главную</a>
<a href="/users/profile">Посмотреть заказы в профиле</a>

</body>
</html>
