<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Каталог книг</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .book-img {
            height: 250px;
            object-fit: cover; /* Чтобы картинки не растягивались */
            width: 100%;
        }
        .card:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: 0.3s;
        }
    </style>
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container py-4">

    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <form method="get" action="/books" class="row g-3 align-items-center">
                <div class="col-md-8">
                    <div class="input-group">
                        <span class="input-group-text">🔍</span>
                        <input type="text" class="form-control" name="query" value="${query}" placeholder="Название или автор...">
                        <button type="submit" class="btn btn-primary">Поиск</button>
                    </div>
                </div>
                <div class="col-md-4 text-end">
                    <c:if test="${pageContext.request.isUserInRole('ADMIN')}">
                        <a href="/admin/books/new" class="btn btn-success">+ Добавить книгу</a>
                    </c:if>
                </div>
            </form>

            <div class="mt-3">
                <strong>Жанры:</strong>
                <a href="/books" class="badge bg-secondary text-decoration-none mx-1">Все</a>
                <c:forEach var="g" items="${genres}">
                    <a href="/books?genre=${g.id}" class="badge bg-primary text-decoration-none mx-1">${g.name}</a>
                </c:forEach>
            </div>
        </div>
    </div>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
        <c:forEach var="book" items="${books.content}">
            <div class="col">
                <div class="card h-100">
                    <a href="/books/${book.id}">
                        <img src="/images/books/${book.id}.jpg"
                             class="card-img-top book-img"
                             alt="${book.title}"
                             onerror="this.src='https://via.placeholder.com/150x220?text=No+Cover'">
                    </a>
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title text-truncate" title="${book.title}">${book.title}</h5>
                        <p class="card-text text-muted small mb-1">${book.author}</p>
                        <h6 class="text-primary fw-bold mb-2">${book.price} BYN</h6>

                        <div class="mb-2">
                            <c:if test="${book.stock > 0}">
                                <span class="badge bg-success">В наличии</span>
                            </c:if>
                            <c:if test="${book.stock == 0}">
                                <span class="badge bg-danger">Нет на складе</span>
                            </c:if>
                        </div>

                        <div class="mt-auto">
                            <form action="/cart/add" method="post" class="d-grid gap-2">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                <input type="hidden" name="bookId" value="${book.id}">
                                <input type="hidden" name="quantity" value="1">
                                <button class="btn btn-outline-primary btn-sm" ${book.stock == 0 ? 'disabled' : ''}>
                                    В корзину
                                </button>
                            </form>

                            <c:if test="${pageContext.request.isUserInRole('ADMIN')}">
                                <div class="d-flex justify-content-between mt-2 pt-2 border-top">
                                    <a href="/admin/books/${book.id}/edit" class="text-decoration-none text-primary small">Ред.</a>

                                    <form action="/admin/books/${book.id}/delete" method="post" onsubmit="return confirm('Удалить?');" style="display:inline;">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                        <button type="submit" class="btn btn-link text-danger p-0 small" style="text-decoration:none;">Удл.</button>
                                    </form>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="mt-4 d-flex justify-content-center">
        <c:if test="${books.totalPages > 1}">
            <nav>
                <ul class="pagination">
                    <c:forEach var="p" begin="0" end="${books.totalPages - 1}">
                        <li class="page-item ${books.number == p ? 'active' : ''}">
                            <a class="page-link" href="/books?page=${p}&query=${query}&genre=${selectedGenre}">
                                ${p + 1}
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </c:if>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>