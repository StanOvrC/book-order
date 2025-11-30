<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Ошибка</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<%@ include file="/WEB-INF/jsp/navbar.jsp" %>

    <h1 style="color:red;">Произошла ошибка</h1>
    <a href="/books">Вернуться</a>
</body>
</html>