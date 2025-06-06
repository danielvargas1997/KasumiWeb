<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="co.kasumi.modelo.Cliente" %>
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
  <title>Gestión de Clientes</title>

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

  <!-- 6) gestion-clientes.css (puede estar vacío o con ajustes mínimos) -->
  <link
    rel="stylesheet"
    href="${pageContext.request.contextPath}/css/gestion-clientes.css"
  />
</head>
<body>
  <!-- Barra de navegación -->
  <jsp:include page="navbar.jsp" />

  <!-- Contenido principal -->
  <main class="container mt-5" style="margin-top:120px;">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h2>Listado de Clientes</h2>
      <a href="ClienteServlet?action=new" class="btn btn-success">
        <i class="bi bi-plus-circle me-1"></i> Nuevo Cliente
      </a>
    </div>

    <!-- Búsqueda -->
    <form action="ClienteServlet" method="get" class="mb-4">
      <div class="input-group">
        <input type="hidden" name="action" value="search" />
        <input
          type="text"
          name="criterio"
          class="form-control"
          placeholder="Buscar por nombre o apellido"
        />
        <button class="btn btn-primary" type="submit">
          <i class="bi bi-search"></i> Buscar
        </button>
      </div>
    </form>

    <!-- Tabla de clientes -->
    <div class="table-responsive">
      <table class="table table-striped table-hover align-middle">
        <thead class="table-dark">
          <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Teléfono</th>
            <th>Email</th>
            <th>Fecha Nac.</th>
            <th class="text-center">Acciones</th>
          </tr>
        </thead>
        <tbody>
          <%
            List<Cliente> lista = (List<Cliente>) request.getAttribute("listaClientes");
            if (lista != null) {
              for (Cliente c : lista) {
          %>
          <tr>
            <td><%= c.getIdCliente() %></td>
            <td><%= c.getNombre() %></td>
            <td><%= c.getApellido() %></td>
            <td><%= c.getTelefono() %></td>
            <td><%= c.getEmail() %></td>
            <td><%= c.getFechaNacimiento() %></td>
            <td class="text-center">
              <a
                href="ClienteServlet?action=edit&id=<%= c.getIdCliente() %>"
                class="btn btn-sm btn-primary"
              >
                <i class="bi bi-pencil-fill"></i>
              </a>
              <a
                href="ClienteServlet?action=delete&id=<%= c.getIdCliente() %>"
                class="btn btn-sm btn-danger"
                onclick="return confirm('¿Eliminar este cliente?');"
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


