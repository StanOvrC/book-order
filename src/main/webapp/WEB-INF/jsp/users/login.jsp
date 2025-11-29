<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Вход</title>
</head>
<body>

<h2>Вход в аккаунт</h2>

<c:if test="${param.error != null}">
    <p style="color:red;">Неверный email или пароль.</p>
</c:if>

<c:if test="${param.registered != null}">
    <p style="color:green;">Регистрация успешна. Теперь войдите.</p>
</c:if>

<form action="/users/login" method="post">
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
