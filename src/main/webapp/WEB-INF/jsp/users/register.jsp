<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>Регистрация</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-5">
            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <h3 class="card-title text-center mb-4">Регистрация</h3>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">${errorMessage}</div>
                    </c:if>

                    <spring:hasBindErrors name="user">
                        <div class="alert alert-danger">
                            <ul class="mb-0 ps-3">
                            <c:forEach var="err" items="${errors.allErrors}">
                                <li>${err.defaultMessage}</li>
                            </c:forEach>
                            </ul>
                        </div>
                    </spring:hasBindErrors>

                    <form action="/users/register" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                        <div class="row mb-3">
                            <div class="col-6">
                                <label class="form-label">Имя</label>
                                <input type="text" class="form-control" name="firstName" value="${user.firstName}" required>
                            </div>
                            <div class="col-6">
                                <label class="form-label">Фамилия</label>
                                <input type="text" class="form-control" name="lastName" value="${user.lastName}" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" value="${user.email}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Пароль</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-success">Создать аккаунт</button>
                        </div>
                    </form>
                </div>
                <div class="card-footer text-center bg-white py-3">
                    <small>Уже есть аккаунт? <a href="/users/login">Войти</a></small>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>