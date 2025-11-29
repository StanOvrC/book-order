<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Регистрация</title>
</head>
<body>

<h2>Регистрация</h2>

<c:if test="${not empty errorMessage}">
    <p style="color:red;">${errorMessage}</p>
</c:if>

<form action="/users/register" method="post">

    <label>Имя:</label><br>
    <input type="text" name="firstName" value="${user.firstName}" required>
    <br><br>

    <label>Фамилия:</label><br>
    <input type="text" name="lastName" value="${user.lastName}" required>
    <br><br>

    <label>Email:</label><br>
    <input type="email" name="email" value="${user.email}" required>
    <br><br>

    <label>Пароль:</label><br>
    <input type="password" name="password" required>
    <br><br>

    <button type="submit">Создать аккаунт</button>
</form>

<p>
    Уже есть аккаунт?
    <a href="/users/login">Войти</a>
</p>

</body>
</html>
