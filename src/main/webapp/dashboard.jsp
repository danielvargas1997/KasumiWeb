<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="co.kasumi.modelo.Usuario" %>
<%
    if (session == null || session.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
    String nombreUsuario = usuario.getNombreUsuario();
    String nombreRol     = usuario.getNombreRol();
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Kasumi - Panel de Control</title>

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

  <!-- 3) styles.css (variables y estilos globales) -->
  <link
    rel="stylesheet"
    href="${pageContext.request.contextPath}/css/styles.css"
  />

  <!-- 4) nav-bar.css (estilos del navbar) -->
  <link
    rel="stylesheet"
    href="${pageContext.request.contextPath}/css/nav-bar.css"
  />

  <!-- 5) home.css (estilos específicos de la página principal) -->
  <link
    rel="stylesheet"
    href="${pageContext.request.contextPath}/css/home.css"
  />

  <!-- 6) footer.css (para que footer se quede al fondo) -->
  <link
    rel="stylesheet"
    href="${pageContext.request.contextPath}/css/footer.css"
  />
</head>
<body>
  <!-- Barra de navegación -->
  <jsp:include page="navbar.jsp" />

  <!-- Encabezado grande con logo y bienvenida -->
  <header class="py-5 text-center text-white">
    <div class="container">
      <img
        src="${pageContext.request.contextPath}/img/logo_kasumi_bgpink.png"
        alt="Logo Kasumi"
        style="height:60px; margin-bottom:15px;"
      />
      <h1 class="display-5 fw-semibold">Bienvenido, <%= nombreUsuario %>!</h1>
      <p class="lead">Rol: <%= nombreRol %></p>
    </div>
  </header>

  <!-- Panel de control con cards -->
  <main class="container my-5">
    <div class="row gy-4">
      <%-- Gestión de Clientes --%>
      <% if ("Administrador".equals(nombreRol) || "Recepcionista".equals(nombreRol)) { %>
      <div class="col-md-4">
        <div class="card h-100 shadow-sm">
          <div class="card-body d-flex flex-column">
            <h5 class="card-title">Gestión de Clientes</h5>
            <p class="card-text flex-grow-1">
              Agrega, edita o elimina clientes de la base de datos.
            </p>
            <a
              href="${pageContext.request.contextPath}/ClienteServlet?action=list"
              class="btn btn-primary mt-auto"
            >
              Ir a Clientes
            </a>
          </div>
        </div>
      </div>
      <% } %>

      <%-- Gestión de Usuarios --%>
      <% if ("Administrador".equals(nombreRol) || "Contador".equals(nombreRol)) { %>
      <div class="col-md-4">
        <div class="card h-100 shadow-sm">
          <div class="card-body d-flex flex-column">
            <h5 class="card-title">Gestión de Usuarios</h5>
            <p class="card-text flex-grow-1">
              Crea, modifica o elimina cuentas de usuario y sus roles.
            </p>
            <a
              href="${pageContext.request.contextPath}/UsuarioServlet?action=list"
              class="btn btn-primary mt-auto"
            >
              Ir a Usuarios
            </a>
          </div>
        </div>
      </div>
      <% } %>

      <%-- Gestión de Servicios --%>
      <% if ("Administrador".equals(nombreRol) || "Recepcionista".equals(nombreRol)) { %>
      <div class="col-md-4">
        <div class="card h-100 shadow-sm">
          <div class="card-body d-flex flex-column">
            <h5 class="card-title">Gestión de Servicios</h5>
            <p class="card-text flex-grow-1">
              Administra los servicios: duraciones, precios y descripciones.
            </p>
            <a
              href="${pageContext.request.contextPath}/ServicioServlet?action=list"
              class="btn btn-primary mt-auto"
            >
              Ir a Servicios
            </a>
          </div>
        </div>
      </div>
      <% } %>
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

