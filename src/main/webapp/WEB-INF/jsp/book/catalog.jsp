<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Каталог книг</title>
    <style>
        .container { width: 80%; margin: 20px auto; }
        .search-box { margin-bottom: 20px; }
        .genre-list a { margin-right: 15px; }
        .books { display: flex; flex-wrap: wrap; gap: 20px; }
        .book-card {
            border: 1px solid #ccc;
            padding: 15px;
            width: 180px;
            text-align: center;
        }
        .book-card img {
            width: 150px;
            height: 220px;
            object-fit: cover;
        }
        .btn { padding: 5px 10px; background: #333; color: white; text-decoration: none; }
        .btn:hover { background: #555; }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container">

    <form method="get" action="/books" class="search-box">
        <input type="text" name="query" value="${query}" placeholder="Название или автор" />
        <button type="submit">Поиск</button>
    </form>

    <div class="genre-list">
        <strong>Жанры:</strong>
        <a href="/books">Все</a>
        <c:forEach var="g" items="${genres}">
            <a href="/books?genre=${g.id}">${g.name}</a>
        </c:forEach>
    </div>

    <hr/>

    <div class="books">
        <c:forEach var="book" items="${books.content}">
            <div class="book-card">
                <a href="/books/${book.id}">
                    <img src="/images/books/${book.id}.jpg" alt="${book.title}">
                </a>

                <h4>${book.title}</h4>
                <div>${book.author}</div>
                <div><strong>${book.price} BYN</strong></div>

                <c:if test="${book.stock > 0}">
                    <div style="color: green">В наличии</div>
                </c:if>
                <c:if test="${book.stock == 0}">
                    <div style="color: red">Нет на складе</div>
                </c:if>

                <form action="/cart/add" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    <input type="hidden" name="bookId" value="${book.id}">
                    <input type="hidden" name="quantity" value="1">
                    <button class="btn">Добавить в корзину</button>
                </form>
            </div>
        </c:forEach>
    </div>

    <div style="margin-top: 20px;">
        <c:if test="${books.totalPages > 1}">
            <c:forEach var="p" begin="0" end="${books.totalPages - 1}">
                <a class="btn" href="/books?page=${p}&query=${query}&genre=${selectedGenre}">
                    ${p + 1}
                </a>
            </c:forEach>
        </c:if>
    </div>

</div>

</body>
</html>
