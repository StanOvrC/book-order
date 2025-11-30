<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title>Регистрация</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/navbar.jsp" %>
<h2>Регистрация</h2>

<c:if test="${not empty errorMessage}">
    <p style="color:red;">${errorMessage}</p>
</c:if>

<spring:hasBindErrors name="user">
    <c:forEach var="err" items="${errors.allErrors}">
        <p style="color:red;">${err.defaultMessage}</p>
    </c:forEach>
</spring:hasBindErrors>

<form action="/users/register" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

    <label>Имя:</label><br>
    <input type="text" name="firstName" value="${user.firstName}">
    <br><br>

    <label>Фамилия:</label><br>
    <input type="text" name="lastName" value="${user.lastName}">
    <br><br>

    <label>Email:</label><br>
    <input type="email" name="email" value="${user.email}">
    <br><br>

    <label>Пароль:</label><br>
    <input type="password" name="password">
    <br><br>

    <button type="submit">Создать аккаунт</button>
</form>

<p>
    Уже есть аккаунт?
    <a href="/users/login">Войти</a>
</p>

</body>
</html>
