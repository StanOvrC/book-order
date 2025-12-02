<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Корзина</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container">
    <h2 class="mb-4">Корзина покупок</h2>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show">
            ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show">
            ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${empty cart.items}">
            <div class="text-center py-5">
                <div class="display-1 text-muted mb-3">🛒</div>
                <h3>Ваша корзина пуста</h3>
                <p class="text-muted">Но это легко исправить!</p>
                <a href="/books" class="btn btn-primary mt-3">Перейти в каталог</a>
            </div>
        </c:when>

        <c:otherwise>
            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="card shadow-sm border-0">
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th style="width: 40%">Товар</th>
                                            <th style="width: 20%">Цена</th>
                                            <th style="width: 25%">Количество</th>
                                            <th style="width: 15%">Удалить</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${cart.items}">
                                            <tr>
                                                <td>
                                                    <span class="fw-bold d-block">${item.bookTitle}</span>
                                                </td>
                                                <td>${item.price} BYN</td>
                                                <td>
                                                    <div class="btn-group btn-group-sm" role="group">
                                                        <form action="/cart/decrease" method="post">
                                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                                            <input type="hidden" name="bookId" value="${item.bookId}"/>
                                                            <input type="hidden" name="quantity" value="1"/>
                                                            <button type="submit" class="btn btn-outline-secondary">-</button>
                                                        </form>

                                                        <button type="button" class="btn btn-outline-secondary disabled text-dark fw-bold" style="min-width: 40px;">
                                                            ${item.quantity}
                                                        </button>

                                                        <form action="/cart/add" method="post">
                                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                                            <input type="hidden" name="bookId" value="${item.bookId}"/>
                                                            <input type="hidden" name="quantity" value="1"/>
                                                            <button type="submit" class="btn btn-outline-secondary">+</button>
                                                        </form>
                                                    </div>
                                                </td>
                                                <td>
                                                    <form action="/cart/remove" method="post">
                                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                                        <input type="hidden" name="orderItemId" value="${item.id}"/>
                                                        <button type="submit" class="btn btn-link text-danger text-decoration-none p-0">✕</button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="mt-3 text-end">
                        <form action="/cart/clear" method="post" style="display:inline;">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                            <button type="submit" class="btn btn-outline-danger btn-sm">Очистить корзину</button>
                        </form>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="card shadow-sm border-0 sticky-top" style="top: 20px;">
                        <div class="card-header bg-white py-3">
                            <h5 class="mb-0">Сумма заказа</h5>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-3">
                                <span>Товары (${cart.items.size()}):</span>
                                <span class="fw-bold">${cart.totalCost} BYN</span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between mb-4 fs-5">
                                <strong>Итого:</strong>
                                <strong class="text-primary">${cart.totalCost} BYN</strong>
                            </div>

                            <form action="/cart/checkout" method="get">
                                <button type="submit" class="btn btn-success w-100 btn-lg">Перейти к оформлению</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>