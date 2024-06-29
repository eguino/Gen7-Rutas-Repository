<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Resultado de Operación</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2>Resultado de la Operación</h2>
        <%
            String errorMessage = (String) request.getAttribute("error");
            String successMessage = (String) request.getAttribute("message");
            String path = (String) request.getAttribute("path");
            if (errorMessage != null) {
        %>
            <div class="alert alert-danger">
                <%= errorMessage %>
            </div>
            <script>
                alert("<%= errorMessage %>");
            </script>
        <%
            } else if (successMessage != null) {
        %>
            <div class="alert alert-success">
                <%= successMessage %>
            </div>
            <script>
                alert("<%= successMessage %>");
            </script>
        <%
            }
        %>
        <a href="<%=path%>" class="btn btn-primary">Volver a la Lista de Choferes</a>
    </div>
</body>
</html>