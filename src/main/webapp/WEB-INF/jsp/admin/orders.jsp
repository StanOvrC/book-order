<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Админ: Заказы</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container mt-4">
    <h2>Управление заказами</h2>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>

    <div class="card p-3 mb-4 bg-light">
        <form action="/admin/orders" method="get" class="row g-3">
            <div class="col-md-4">
                <input type="text" name="email" class="form-control" value="${criteria.email}" placeholder="Поиск по Email">
            </div>
            <div class="col-md-3">
                <input type="number" name="orderId" class="form-control" value="${criteria.orderId}" placeholder="Поиск по ID заказа">
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100">Найти</button>
            </div>
            <div class="col-md-2">
                <a href="/admin/orders" class="btn btn-outline-secondary w-100">Сброс</a>
            </div>
        </form>
    </div>

    <table class="table table-bordered table-hover">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Дата</th>
            <th>Email / Адрес</th>
            <th>Сумма</th>
            <th>Статус</th>
            <th>Сменить статус</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${ordersPage.content}" var="order">
            <tr>
                <td>${order.id}</td>
                <td>
                    <strong>${order.user.email}</strong><br>
                    <small>${order.address}</small>
                </td>
                <td>${order.totalCost} BYN</td>
                <td>
                    <c:choose>
                        <c:when test="${order.status == 'PENDING'}"><span class="badge bg-info">В ожидании</span></c:when>
                        <c:when test="${order.status == 'PAID'}"><span class="badge bg-warning">Оплачен</span></c:when>
                        <c:when test="${order.status == 'DELIVERED'}"><span class="badge bg-success">Доставлен</span></c:when>
                        <c:when test="${order.status == 'CANCELED'}"><span class="badge bg-danger">Отменен</span></c:when>
                        <c:otherwise><span class="badge bg-secondary">${order.status}</span></c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <form action="/admin/orders/${order.id}/status" method="post" class="d-flex" style="max-width: 200px;">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                        <select name="status" class="form-select form-select-sm me-2">
                            <c:forEach items="${statuses}" var="st">
                                <c:if test="${st != 'IN_CART'}">
                                    <option value="${st}" ${order.status == st ? 'selected' : ''}>${st}</option>
                                </c:if>
                            </c:forEach>
                        </select>
                        <button type="submit" class="btn btn-sm btn-outline-dark">OK</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <c:if test="${ordersPage.totalPages > 1}">
        <nav>
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

</body>
</html>