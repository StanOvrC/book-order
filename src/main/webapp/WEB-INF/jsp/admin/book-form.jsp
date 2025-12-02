<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <title>${isEdit ? 'Редактирование книги' : 'Новая книга'}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

<div class="container mt-5 mb-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-lg border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h4 class="mb-0">
                        ${isEdit ? 'Редактирование книги' : 'Добавление новой книги'}
                    </h4>
                </div>
                <div class="card-body">

                    <form:form modelAttribute="book" method="post" enctype="multipart/form-data" class="needs-validation">

                        <div class="mb-3">
                            <label class="form-label fw-bold">Обложка книги</label>
                            <form:input path="image" type="file" cssClass="form-control" accept="image/*"/>
                            <form:errors path="image" cssClass="text-danger small"/>

                            <c:if test="${isEdit && not empty currentImagePath}">
                                <div class="mt-2 p-2 border rounded bg-white">
                                    <small class="text-muted d-block mb-1">Текущая обложка:</small>
                                    <img src="${currentImagePath}" alt="Current Cover" style="height: 100px; width: auto; object-fit: contain;">
                                </div>
                            </c:if>
                        </div>

                        <hr>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Название</label>
                            <form:input path="title" cssClass="form-control" required="true"/>
                            <form:errors path="title" cssClass="text-danger small"/>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Автор</label>
                            <form:input path="author" cssClass="form-control" required="true"/>
                            <form:errors path="author" cssClass="text-danger small"/>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">ISBN</label>
                            <form:input path="isbn" cssClass="form-control" required="true"/>
                            <form:errors path="isbn" cssClass="text-danger small"/>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Количество страниц</label>
                                <form:input path="pageCount" type="number" cssClass="form-control" required="true"/>
                                <form:errors path="pageCount" cssClass="text-danger small"/>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-bold">Цена (BYN)</label>
                                <form:input path="price" type="number" step="0.01" cssClass="form-control" required="true"/>
                                <form:errors path="price" cssClass="text-danger small"/>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Год публикации</label>
                            <form:input path="publicationYear" type="date" cssClass="form-control"/>
                            <form:errors path="publicationYear" cssClass="text-danger small"/>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Количество на складе</label>
                            <form:input path="stock" type="number" cssClass="form-control" required="true"/>
                            <form:errors path="stock" cssClass="text-danger small"/>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">Жанры</label>
                            <form:select path="genreIds" cssClass="form-select" multiple="true" size="5">
                                <form:options items="${genres}" itemValue="id" itemLabel="name"/>
                            </form:select>
                            <div class="form-text">Удерживайте Ctrl (Cmd) для выбора нескольких жанров.</div>
                            <form:errors path="genreIds" cssClass="text-danger small"/>
                        </div>

                        <div class="d-flex justify-content-between pt-3 border-top">
                            <a href="/books" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left"></i> Отмена
                            </a>
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-check-lg"></i> Сохранить
                            </button>
                        </div>

                    </form:form>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>