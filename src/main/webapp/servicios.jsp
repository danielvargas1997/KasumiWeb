<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Kasumi - Gestión de Servicios</title>
    <!-- CSS global y específico de servicios -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/gestion-servicios.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/nav-bar.css" />
</head>
<body>
    <% 
       co.kasumi.modelo.Usuario usr = (co.kasumi.modelo.Usuario) session.getAttribute("usuarioLogueado");
       if (usr == null) {
           response.sendRedirect("login.jsp");
           return;
       }
    %>
    <nav class="navbar fixed-top navbar-home">
        <!-- (igual que en dashboard.jsp) -->
    </nav>

    <main class="container" style="margin-top:100px;">
        <h1 class="text-center mb-4">Lista de Servicios</h1>
        <c:if test="${not empty listaServicios}">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th><th>Nombre</th><th>Duración (min)</th><th>Precio</th><th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${listaServicios}">
                        <tr>
                            <td>${s.idServicio}</td>
                            <td>${s.nombreServicio}</td>
                            <td>${s.duracionMin}</td>
                            <td>${s.precio}</td>
                            <td>
                                <a href="ServicioServlet?action=edit&id=${s.idServicio}" class="btn btn-sm btn-warning">Editar</a>
                                <a href="ServicioServlet?action=delete&id=${s.idServicio}" class="btn btn-sm btn-danger"
                                   onclick="return confirm('¿Eliminar este servicio?');">Eliminar</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <a href="ServicioServlet?action=new" class="btn btn-primary">Nuevo Servicio</a>
    </main>

    <footer>
        <p>Desarrollado por:</p>
        <p>D2JL Inc ®</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

