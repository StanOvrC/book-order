<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Профиль пользователя</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container py-5">
    <div class="row g-4">

        <div class="col-md-4">
            <div class="card shadow-sm sticky-top" style="top: 20px;">
                <div class="card-header bg-primary text-white text-center py-3">
                    <h4 class="mb-0">Мой профиль</h4>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item d-flex justify-content-between">
                            <span class="text-muted">Имя</span>
                            <strong>${user.firstName} ${user.lastName}</strong>
                        </li>
                        <li class="list-group-item d-flex justify-content-between">
                            <span class="text-muted">Email</span>
                            <span>${user.email}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between">
                            <span class="text-muted">Роль</span>
                            <span class="badge bg-secondary">${user.role}</span>
                        </li>
                        <c:if test="${not empty user.birthdate}">
                            <li class="list-group-item d-flex justify-content-between">
                                <span class="text-muted">Дата рождения</span>
                                <span>${user.birthdate}</span>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-8">
            <h3 class="mb-3 border-bottom pb-2">Текущие заказы</h3>

            <c:set var="hasActiveOrders" value="false" />
            <c:forEach var="order" items="${orders}">
                <c:if test="${order.status == 'IN_CART' || order.status == 'PENDING' || order.status == 'PAID'}">
                    <c:set var="hasActiveOrders" value="true" />
                    <div class="card mb-4 border-primary">
                        <div class="card-header bg-primary bg-opacity-10 d-flex justify-content-between align-items-center">
                            <strong>Заказ #${order.id}</strong>
                            <span class="badge bg-warning text-dark">${order.status}</span>
                        </div>
                        <div class="card-body">
                            <p class="mb-2"><small class="text-muted">Адрес доставки:</small> ${order.address}</p>

                            <div class="table-responsive">
                                <table class="table table-sm table-hover mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Книга</th>
                                            <th>Цена</th>
                                            <th class="text-center">Кол-во</th>
                                            <th class="text-end">Сумма</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${order.items}">
                                            <tr>
                                                <td>${item.bookTitle}</td>
                                                <td>${item.price}</td>
                                                <td class="text-center">${item.quantity}</td>
                                                <td class="text-end">${item.price * item.quantity}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot class="table-group-divider">
                                        <tr>
                                            <td colspan="3" class="text-end fw-bold">Итого:</td>
                                            <td class="text-end fw-bold text-primary">${order.totalCost} BYN</td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>

            <c:if test="${not hasActiveOrders}">
                <div class="alert alert-info">Активных заказов нет.</div>
            </c:if>

            <h3 class="mb-3 border-bottom pb-2 mt-5">История заказов</h3>

            <c:set var="hasHistoryOrders" value="false" />
            <c:forEach var="order" items="${orders}">
                <c:if test="${order.status == 'DELIVERED' || order.status == 'CANCELED'}">
                    <c:set var="hasHistoryOrders" value="true" />
                    <div class="card mb-3 bg-light">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <span>Заказ #${order.id}</span>
                            <span class="badge ${order.status == 'DELIVERED' ? 'bg-success' : 'bg-danger'}">${order.status}</span>
                        </div>
                        <div class="card-body p-0">
                            <div class="accordion" id="accordionOrder${order.id}">
                                <div class="accordion-item">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button collapsed py-2" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${order.id}">
                                            Показать детали (Итого: ${order.totalCost} BYN)
                                        </button>
                                    </h2>
                                    <div id="collapse${order.id}" class="accordion-collapse collapse" data-bs-parent="#accordionOrder${order.id}">
                                        <div class="accordion-body">
                                            <p class="small text-muted mb-2">Адрес: ${order.address}</p>
                                            <table class="table table-sm text-muted">
                                                <thead><tr><th>Книга</th><th>Кол-во</th></tr></thead>
                                                <tbody>
                                                <c:forEach var="item" items="${order.items}">
                                                    <tr>
                                                        <td>${item.bookTitle}</td>
                                                        <td>${item.quantity}</td>
                                                    </tr>
                                                </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>

            <c:if test="${not hasHistoryOrders}">
                <p class="text-muted">История заказов пуста.</p>
            </c:if>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>