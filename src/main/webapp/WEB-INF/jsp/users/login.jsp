<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Вход</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-4">
            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <h3 class="card-title text-center mb-4">Вход в систему</h3>

                    <c:if test="${param.error == 'true'}">
                        <div class="alert alert-danger" role="alert">
                            Неверный email или пароль.
                        </div>
                    </c:if>

                    <c:if test="${param.registered == 'true'}">
                        <div class="alert alert-success" role="alert">
                            Регистрация успешна. Теперь войдите.
                        </div>
                    </c:if>

                    <form action="/users/login" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                        <div class="mb-3">
                            <label for="username" class="form-label">Email</label>
                            <input type="email" class="form-control" id="username" name="username" required autofocus>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Пароль</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">Войти</button>
                        </div>
                    </form>
                </div>
                <div class="card-footer text-center bg-white py-3">
                    <small>Нет аккаунта? <a href="/users/register">Зарегистрироваться</a></small>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>