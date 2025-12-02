<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Оформление заказа</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container mb-5">
    <div class="py-3 text-center">
        <h2>Оформление заказа</h2>
        <p class="lead">Пожалуйста, проверьте данные доставки и выберите способ оплаты.</p>
    </div>

    <div class="row g-5">
        <div class="col-md-5 col-lg-4 order-md-last">
            <h4 class="d-flex justify-content-between align-items-center mb-3">
                <span class="text-primary">Ваша корзина</span>
                <span class="badge bg-primary rounded-pill">${cart.items.size()}</span>
            </h4>
            <ul class="list-group mb-3 shadow-sm">
                <c:forEach var="item" items="${cart.items}">
                    <li class="list-group-item d-flex justify-content-between lh-sm">
                        <div>
                            <h6 class="my-0">${item.bookTitle}</h6>
                            <small class="text-muted">${item.quantity} шт. x ${item.price}</small>
                        </div>
                        <span class="text-muted">${item.price * item.quantity}</span>
                    </li>
                </c:forEach>
                <li class="list-group-item d-flex justify-content-between bg-light">
                    <span>Итого (BYN)</span>
                    <strong>${cart.totalCost}</strong>
                </li>
            </ul>
        </div>

        <div class="col-md-7 col-lg-8">
            <h4 class="mb-3">Адрес доставки</h4>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">${errorMessage}</div>
            </c:if>

            <div class="card shadow-sm border-0">
                <div class="card-body">
                    <form action="/cart/checkout" method="post" class="needs-validation">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                        <div class="mb-3">
                            <label for="address" class="form-label">Адрес</label>
                            <input type="text" class="form-control" id="address" name="address" placeholder="Улица, дом, квартира" required>
                            <div class="form-text">Курьер доставит заказ по этому адресу.</div>
                        </div>

                        <hr class="my-4">

                        <h4 class="mb-3">Оплата</h4>

                        <div class="my-3">
                            <label for="paymentMethod" class="form-label">Способ оплаты</label>
                            <select class="form-select" id="paymentMethod" name="paymentMethod" required>
                                <option value="">Выберите способ...</option>
                                <option value="card_online">Банковская карта (онлайн)</option>
                                <option value="cash_delivery">Наличными при получении</option>
                                <option value="card_delivery">Картой при получении</option>
                            </select>
                        </div>

                        <hr class="my-4">

                        <button class="w-100 btn btn-success btn-lg" type="submit">Подтвердить заказ</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>