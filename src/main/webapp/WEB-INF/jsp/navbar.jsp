<%@ page contentType="text/html;charset=UTF-8" %>
<header style="display: flex; justify-content: space-between; padding: 10px 20px; background: #f5f5f5;">
    <div>
        <a href="/books">Каталог</a>

        <c:if test="${empty pageContext.request.userPrincipal}">
            <a href="/users/login">Войти</a>
        </c:if>

        <c:if test="${not empty pageContext.request.userPrincipal}">
            <a href="/users/profile">Личный кабинет</a>

            <a href="/cart">Корзина</a>
            <c:if test="${cartItemCount > 0}">
                <span style="background: red; color: white; border-radius: 50%; padding: 2px 6px;">
                    ${cartItemCount}
                </span>
            </c:if>

            <form action="/logout" method="post" style="display:inline;">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                <button type="submit">Выйти</button>
            </form>

        </c:if>
    </div>
</header>