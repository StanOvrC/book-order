<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>${book.title}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .details-image-container {
            height: 400px; /* Фиксированная высота для области изображения */
            background-color: #f8f9fa;
            border-radius: .3rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .details-image {
            max-height: 100%;
            max-width: 100%;
            object-fit: contain;
        }
    </style>
</head>

<body class="bg-light">

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>
<div class="container mt-5 mb-5">

    <div class="card shadow p-4 border-0">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="details-image-container shadow-sm">
                     <c:choose>
                        <c:when test="${not empty book.imagePath}">
                            <img src="${book.imagePath}"
                                 alt="${book.title}"
                                 class="details-image">
                        </c:when>
                        <c:otherwise>
                            <img src="https://via.placeholder.com/300x450?text=No+Image"
                                 class="details-image"
                                 alt="No image">
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="col-md-8">
                <h1 class="fw-bold display-6 mb-3">${book.title}</h1>

                <table class="table table-borderless w-auto">
                    <tr>
                        <td class="text-muted ps-0">Автор:</td>
                        <td class="fw-bold">${book.author}</td>
                    </tr>
                    <tr>
                        <td class="text-muted ps-0">ISBN:</td>
                        <td>${book.isbn}</td>
                    </tr>
                    <tr>
                        <td class="text-muted ps-0">Страницы:</td>
                        <td>${book.pageCount}</td>
                    </tr>
                    <tr>
                        <td class="text-muted ps-0">Год:</td>
                        <td><c:out value="${book.publicationYear}"/></td>
                    </tr>
                    <tr>
                        <td class="text-muted ps-0">Жанры:</td>
                        <td>
                            <c:forEach var="g" items="${book.genres}">
                                <span class="badge bg-secondary me-1">${g.name}</span>
                            </c:forEach>
                        </td>
                    </tr>
                </table>

                <div class="d-flex align-items-center mt-3 mb-4">
                    <h2 class="text-primary fw-bold me-3 mb-0">${book.price} BYN</h2>

                    <c:if test="${book.stock > 0}">
                        <span class="badge bg-success px-3 py-2">Есть на складе</span>
                    </c:if>
                    <c:if test="${book.stock == 0}">
                        <span class="badge bg-danger px-3 py-2">Нет на складе</span>
                    </c:if>
                </div>

                <c:if test="${book.stock > 0}">
                    <form action="/cart/add" method="post" class="mb-4">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <input type="hidden" name="bookId" value="${book.id}">
                        <input type="hidden" name="quantity" value="1">
                        <button type="submit" class="btn btn-success btn-lg w-100 w-md-auto px-5">
                            <i class="bi bi-cart-plus"></i> Добавить в корзину
                        </button>
                    </form>
                </c:if>

                <hr>

                <h5 class="fw-bold">Описание</h5>
                <p class="text-secondary">${book.description}</p>

                <a href="/books" class="btn btn-outline-secondary mt-3">
                    &larr; Вернуться в каталог
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>