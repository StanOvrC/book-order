<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Вход</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/navbar.jsp" %>
<h2>Вход в аккаунт</h2>

<c:if test="${param.error == 'true'}">
    <p style="color:red;">Неверный email или пароль.</p>
</c:if>

<c:if test="${param.registered == 'true'}">
    <p style="color:green;">Регистрация успешна. Теперь войдите.</p>
</c:if>

<form action="/users/login" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
    <label>Email:</label><br>
    <input type="email" name="username" required><br><br>

    <label>Пароль:</label><br>
    <input type="password" name="password" required><br><br>

    <button type="submit">Войти</button>
</form>

<p>
    Нет аккаунта?
    <a href="/users/register">Зарегистрироваться</a>
</p>

</body>
</html>
