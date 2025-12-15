<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/books">📚 BookStore</a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/books">Каталог</a>
                </li>

                <c:if test="${pageContext.request.isUserInRole('ADMIN')}">
                    <li class="nav-item">
                        <a class="nav-link text-warning" href="/admin/orders">
                            ⚙️ Управление заказами
                        </a>
                    </li>
                    <li class="nav-item">
                         <a class="nav-link text-warning" href="/admin/books/new">
                            + Книга
                         </a>
                    </li>
                </c:if>
            </ul>

            <div class="d-flex align-items-center gap-3">

                <c:if test="${empty pageContext.request.userPrincipal}">
                    <a href="/users/login" class="btn btn-outline-light btn-sm">Войти</a>
                    <a href="/users/register" class="btn btn-primary btn-sm">Регистрация</a>
                </c:if>

                <c:if test="${not empty pageContext.request.userPrincipal}">

                    <a href="/cart" class="btn btn-outline-light position-relative border-0">
                        🛒 Корзина
                        <c:if test="${cartItemCount > 0}">
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                ${cartItemCount}
                            </span>
                        </c:if>
                    </a>

                    <div class="dropdown">
                        <button class="btn btn-secondary dropdown-toggle btn-sm" type="button" data-bs-toggle="dropdown">
                            👤 Личный кабинет
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="/users/profile">Мой профиль</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <form action="/logout" method="post" class="px-2 py-1">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                    <button type="submit" class="btn btn-danger btn-sm w-100">Выйти</button>
                                </form>
                            </li>
                        </ul>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</nav>