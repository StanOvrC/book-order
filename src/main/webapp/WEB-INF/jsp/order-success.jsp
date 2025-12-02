<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Заказ оформлен</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container py-5 text-center">
    <div class="card shadow border-0 mx-auto" style="max-width: 600px;">
        <div class="card-body p-5">
            <div style="font-size: 4rem; color: green; margin-bottom: 20px;">✓</div>
            <h1 class="display-5 fw-bold text-success mb-3">Спасибо!</h1>
            <p class="lead mb-4">Ваш заказ успешно оформлен.</p>

            <div class="bg-light p-4 rounded text-start mb-4">
                <div class="row">
                    <div class="col-6 text-muted">Номер заказа:</div>
                    <div class="col-6 fw-bold text-end">#${createdOrder.id}</div>
                </div>
                <div class="row mt-2">
                    <div class="col-6 text-muted">Статус:</div>
                    <div class="col-6 fw-bold text-end text-primary">${createdOrder.status}</div>
                </div>
                <div class="row mt-2">
                    <div class="col-6 text-muted">Сумма:</div>
                    <div class="col-6 fw-bold text-end">${createdOrder.totalCost} BYN</div>
                </div>
                <div class="row mt-2">
                    <div class="col-6 text-muted">Адрес:</div>
                    <div class="col-6 text-end">${createdOrder.address}</div>
                </div>
            </div>

            <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                <a href="/books" class="btn btn-primary btn-lg px-4 gap-3">В каталог</a>
                <a href="/users/profile" class="btn btn-outline-secondary btn-lg px-4">В личный кабинет</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>