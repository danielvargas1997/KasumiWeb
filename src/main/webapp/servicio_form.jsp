<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Kasumi - Formulario Servicio</title>
    <!-- CSS global y específico del formulario de servicios -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/gestion-servicios.css" />
</head>
<body>
    <% 
       co.kasumi.modelo.Usuario usr = (co.kasumi.modelo.Usuario) session.getAttribute("usuarioLogueado");
       if (usr == null) {
           response.sendRedirect("login.jsp");
           return;
       }
    %>
    <div class="container" style="margin-top:100px;">
        <h1 class="text-center mb-4">
            <c:choose>
                <c:when test="${not empty servicio}">Editar Servicio</c:when>
                <c:otherwise>Nuevo Servicio</c:otherwise>
            </c:choose>
        </h1>
        <form action="ServicioServlet" method="post" novalidate>
            <input type="hidden" name="action" value="${not empty servicio ? 'update' : 'insert'}" />
            <c:if test="${not empty servicio}">
                <input type="hidden" name="idServicio" value="${servicio.idServicio}" />
            </c:if>

            <div class="mb-3">
                <label for="nombreServicio" class="form-label">Nombre del Servicio</label>
                <input type="text" class="form-control" name="nombreServicio" id="nombreServicio"
                       value="${servicio.nombreServicio}" required />
                <div class="invalid-feedback">Por favor, ingresa un nombre válido.</div>
            </div>
            <div class="mb-3">
                <label for="duracionServicio" class="form-label">Duración (minutos)</label>
                <input type="number" class="form-control" name="duracionServicio" id="duracionServicio"
                       value="${servicio.duracionMin}" required min="1" />
                <div class="feedback">La duración debe ser al menos 1 minuto.</div>
            </div>
            <div class="mb-3">
                <label for="precioServicio" class="form-label">Precio</label>
                <input type="number" step="0.01" class="form-control" name="precioServicio" id="precioServicio"
                       value="${servicio.precio}" required min="0" />
                <div class="feedback">Introduce un precio válido.</div>
            </div>
            <button type="submit" class="btn btn-primary">Guardar</button>
            <a href="ServicioServlet?action=list" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>
