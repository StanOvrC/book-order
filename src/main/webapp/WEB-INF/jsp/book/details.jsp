<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>${book.title}</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>

<body class="bg-light">

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>
<div class="container mt-5">

    <div class="card shadow-lg p-4">

        <div class="row">

            <div class="col-md-4 text-center">
                <c:choose>
                    <c:when test="${not empty book.imagePath}">
                        <img src="${book.imagePath}"
                             alt="${book.title}"
                             class="img-fluid rounded">
                    </c:when>
                    <c:otherwise>
                        <img src="/images/no-image.png"
                             class="img-fluid rounded"
                             alt="No image">
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="col-md-8">

                <h2 class="fw-bold">${book.title}</h2>

                <p class="text-muted mb-1">
                    <strong>Автор:</strong> ${book.author}
                </p>

                <p class="text-muted mb-1">
                    <strong>ISBN:</strong> ${book.isbn}
                </p>

                <p class="text-muted mb-1">
                    <strong>Страницы:</strong> ${book.pageCount}
                </p>

                <p class="text-muted mb-1">
                    <strong>Год:</strong>
                    <c:out value="${book.publicationYear}"/>
                </p>

                <p class="text-muted mb-1">
                    <strong>Жанры:</strong>
                    <c:forEach var="g" items="${book.genres}">
                        <span class="badge bg-primary">${g.name}</span>
                    </c:forEach>
                </p>

                <p class="h4 mt-3">
                    <span class="text-success">${book.price} BYN</span>
                </p>

                <c:if test="${book.stock > 0}">
                    <form action="/cart/add" method="post" class="mt-3">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <input type="hidden" name="bookId" value="${book.id}">
                        <input type="hidden" name="quantity" value="1">
                        <button type="submit" class="btn btn-success">Добавить в корзину</button>
                    </form>
                    <p class="text-success mt-2">Есть на складе</p>
                </c:if>

                <c:if test="${book.stock == 0}">
                    <p class="text-danger">Нет на складе</p>
                </c:if>

                <hr>

                <h5>Description</h5>
                <p>${book.description}</p>

                <a href="/books" class="btn btn-secondary mt-3">Назад</a>

            </div>
        </div>

    </div>
</div>

</body>
</html>
