<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Админ: Заказы</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container mt-4 mb-5">
    <h2 class="mb-4">Управление заказами</h2>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card p-3 mb-4 shadow-sm border-0">
        <form action="/admin/orders" method="get" class="row g-3 align-items-end">
            <div class="col-md-5">
                <label for="email" class="form-label small text-muted">Поиск по Email</label>
                <input type="text" name="email" id="email" class="form-control" value="${criteria.email}" placeholder="Email пользователя">
            </div>
            <div class="col-md-3">
                <label for="orderId" class="form-label small text-muted">Поиск по ID</label>
                <input type="number" name="orderId" id="orderId" class="form-control" value="${criteria.orderId}" placeholder="ID заказа">
            </div>
            <div class="col-md-2 d-grid">
                <button type="submit" class="btn btn-primary">Найти</button>
            </div>
            <div class="col-md-2 d-grid">
                <a href="/admin/orders" class="btn btn-outline-secondary">Сброс</a>
            </div>
        </form>
    </div>

    <div class="table-responsive">
        <table class="table table-striped table-hover align-middle shadow-sm">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th style="width: 20%">Пользователь / Адрес</th>
                    <th>Сумма</th>
                    <th style="width: 15%">Статус</th>
                    <th style="width: 30%">Действие</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach items="${ordersPage.content}" var="order">
                <tr>
                    <td>${order.id}</td>
                    <td>
                        <strong class="d-block">${order.user.email}</strong>
                        <small class="text-muted">${order.address}</small>
                    </td>
                    <td>${order.totalCost} BYN</td>
                    <td>
                        <c:choose>
                            <c:when test="${order.status == 'PENDING'}"><span class="badge bg-info text-dark">В ожидании</span></c:when>
                            <c:when test="${order.status == 'PAID'}"><span class="badge bg-warning text-dark">Оплачен</span></c:when>
                            <c:when test="${order.status == 'DELIVERED'}"><span class="badge bg-success">Доставлен</span></c:when>
                            <c:when test="${order.status == 'CANCELED'}"><span class="badge bg-danger">Отменен</span></c:when>
                            <c:otherwise><span class="badge bg-secondary">${order.status}</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <form action="/admin/orders/${order.id}/status" method="post" class="d-flex">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                            <select name="status" class="form-select form-select-sm me-2">
                                <c:forEach items="${statuses}" var="st">
                                    <c:if test="${st != 'IN_CART'}">
                                        <option value="${st}" ${order.status == st ? 'selected' : ''}>${st}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                            <button type="submit" class="btn btn-sm btn-outline-primary">Обновить</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <c:if test="${ordersPage.totalPages > 1}">
        <nav class="d-flex justify-content-center mt-4">
            <ul class="pagination">
                <c:forEach begin="0" end="${ordersPage.totalPages - 1}" var="i">
                    <li class="page-item ${i == ordersPage.number ? 'active' : ''}">
                        <a class="page-link" href="/admin/orders?page=${i}&email=${criteria.email}&orderId=${criteria.orderId}">
                            ${i + 1}
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>