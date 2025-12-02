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

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow">
                <div class="card-header bg-dark text-white">
                    <h4 class="mb-0">${isEdit ? 'Редактирование книги' : 'Добавление новой книги'}</h4>
                </div>
                <div class="card-body">

                    <form:form modelAttribute="book" method="post">

                        <!-- TITLE -->
                        <div class="mb-3">
                            <label class="form-label">Название</label>
                            <form:input path="title" cssClass="form-control" required="true"/>
                            <form:errors path="title" cssClass="text-danger"/>
                        </div>

                        <!-- AUTHOR -->
                        <div class="mb-3">
                            <label class="form-label">Автор</label>
                            <form:input path="author" cssClass="form-control" required="true"/>
                            <form:errors path="author" cssClass="text-danger"/>
                        </div>

                        <!-- ISBN -->
                        <div class="mb-3">
                            <label class="form-label">ISBN</label>
                            <form:input path="isbn" cssClass="form-control" required="true"/>
                            <form:errors path="isbn" cssClass="text-danger"/>
                        </div>

                        <div class="row">
                            <!-- PAGE COUNT -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Количество страниц</label>
                                <form:input path="pageCount" type="number" cssClass="form-control" required="true"/>
                                <form:errors path="pageCount" cssClass="text-danger"/>
                            </div>

                            <!-- PRICE -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Цена (BYN)</label>
                                <form:input path="price" type="number" step="0.01" cssClass="form-control" required="true"/>
                                <form:errors path="price" cssClass="text-danger"/>
                            </div>
                        </div>

                        <!-- PUBLICATION YEAR -->
                        <div class="mb-3">
                            <label class="form-label">Год публикации</label>
                            <form:input path="publicationYear" type="date" cssClass="form-control"/>
                            <form:errors path="publicationYear" cssClass="text-danger"/>
                        </div>

                        <div class="row">
                            <!-- STOCK -->
                            <div class="col-md-12 mb-3">
                                <label class="form-label">Количество на складе</label>
                                <form:input path="stock" type="number" cssClass="form-control" required="true"/>
                                <form:errors path="stock" cssClass="text-danger"/>
                            </div>
                        </div>

                        <!-- GENRES (MULTI SELECT) -->
                        <div class="mb-3">
                            <label class="form-label">Жанры</label>
                            <form:select path="genreIds" cssClass="form-select" multiple="true">
                                <form:options items="${genres}" itemValue="id" itemLabel="name"/>
                            </form:select>
                            <form:errors path="genreIds" cssClass="text-danger"/>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="/books" class="btn btn-secondary">Отмена</a>
                            <button type="submit" class="btn btn-success">Сохранить</button>
                        </div>

                    </form:form>

                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
