<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ошибка</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container mt-5 text-center">
    <div class="alert alert-danger shadow-sm p-5" role="alert">
        <h1 class="display-4 fw-bold">Упс! Произошла ошибка</h1>
        <p class="lead mt-3">Что-то пошло не так при обработке вашего запроса.</p>
        <hr>
        <a href="/books" class="btn btn-danger mt-3">Вернуться на главную</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>