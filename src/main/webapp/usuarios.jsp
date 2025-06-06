<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="co.kasumi.modelo.Usuario" %>
<%
    if (session == null || session.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Gestión de Usuarios</title>

  <!-- 1) Bootstrap CSS -->
  <link
    rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
  />

  <!-- 2) Bootstrap Icons -->
  <link
    rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
  />

  <!-- 3) styles.css -->
  <link
    rel="stylesheet"
    href="${pageContext.request.contextPath}/css/styles.css"
  />

  <!-- 4) nav-bar.css -->
  <link
    rel="stylesheet"
    href="${pageContext.request.contextPath}/css/nav-bar.css"
  />

  <!-- 5) footer.css -->
  <link
    rel="stylesheet"
    href="${pageContext.request.contextPath}/css/footer.css"
  />
</head>
<body>
  <!-- Barra de navegación -->
  <jsp:include page="navbar.jsp" />

  <!-- Contenido principal -->
  <main class="container mt-5" style="margin-top:120px;">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h2>Listado de Usuarios</h2>
      <a href="UsuarioServlet?action=new" class="btn btn-success">
        <i class="bi bi-plus-circle me-1"></i> Nuevo Usuario
      </a>
    </div>

    <!-- Búsqueda -->
    <form action="UsuarioServlet" method="get" class="mb-4">
      <div class="input-group">
        <input type="hidden" name="action" value="search" />
        <input
          type="text"
          name="criterio"
          class="form-control"
          placeholder="Buscar por usuario o rol"
        />
        <button class="btn btn-primary" type="submit">
          <i class="bi bi-search"></i> Buscar
        </button>
      </div>
    </form>

    <!-- Tabla de usuarios -->
    <div class="table-responsive">
      <table class="table table-striped table-hover align-middle">
        <thead class="table-dark">
          <tr>
            <th>ID</th>
            <th>Usuario</th>
            <th>Contraseña</th>
            <th>Rol</th>
            <th class="text-center">Acciones</th>
          </tr>
        </thead>
        <tbody>
          <%
            List<Usuario> lista = (List<Usuario>) request.getAttribute("listaUsuarios");
            if (lista != null) {
              for (Usuario u : lista) {
          %>
          <tr>
            <td><%= u.getIdUsuario() %></td>
            <td><%= u.getNombreUsuario() %></td>
            <td><%= u.getContrasena() %></td>
            <td><%= u.getNombreRol() %></td>
            <td class="text-center">
              <a
                href="UsuarioServlet?action=edit&id=<%= u.getIdUsuario() %>"
                class="btn btn-sm btn-primary"
              >
                <i class="bi bi-pencil-fill"></i>
              </a>
              <a
                href="UsuarioServlet?action=delete&id=<%= u.getIdUsuario() %>"
                class="btn btn-sm btn-danger"
                onclick="return confirm('¿Eliminar este usuario?');"
              >
                <i class="bi bi-trash-fill"></i>
              </a>
            </td>
          </tr>
          <%
              }
            }
          %>
        </tbody>
      </table>
    </div>
  </main>

  <!-- Pie de página -->
  <footer>
    <p>© Kasumi - D2JL Inc ® 2025</p>
  </footer>

  <!-- 7) Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


