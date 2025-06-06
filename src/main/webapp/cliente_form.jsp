<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="co.kasumi.modelo.Cliente" %>
<%
    if (session == null || session.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Cliente cliente = (Cliente) request.getAttribute("cliente");
    boolean isEdit = (cliente != null);
    String titulo = isEdit ? "Editar Cliente" : "Nuevo Cliente";
    String actionUrl = isEdit ? "ClienteServlet?action=update" : "ClienteServlet?action=insert";
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title><%= titulo %></title>

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

  <!-- Formulario de cliente -->
  <main class="container mt-5" style="margin-top:120px; max-width: 600px;">
    <h2><%= titulo %></h2>
    <form action="<%= actionUrl %>" method="post" class="needs-validation" novalidate>
      <% if (isEdit) { %>
        <input type="hidden" name="idCliente" value="<%= cliente.getIdCliente() %>" />
      <% } %>

      <div class="mb-3">
        <label for="nombre" class="form-label">Nombre</label>
        <input
          type="text"
          class="form-control"
          id="nombre"
          name="nombre"
          value="<%= isEdit ? cliente.getNombre() : "" %>"
          required
        />
        <div class="invalid-feedback">
          Por favor, ingresa un nombre válido.
        </div>
      </div>

      <div class="mb-3">
        <label for="apellido" class="form-label">Apellido</label>
        <input
          type="text"
          class="form-control"
          id="apellido"
          name="apellido"
          value="<%= isEdit ? cliente.getApellido() : "" %>"
          required
        />
        <div class="invalid-feedback">
          Por favor, ingresa un apellido válido.
        </div>
      </div>

      <div class="mb-3">
        <label for="telefono" class="form-label">Teléfono</label>
        <input
          type="text"
          class="form-control"
          id="telefono"
          name="telefono"
          value="<%= isEdit ? cliente.getTelefono() : "" %>"
        />
      </div>

      <div class="mb-3">
        <label for="email" class="form-label">Email</label>
        <input
          type="email"
          class="form-control"
          id="email"
          name="email"
          value="<%= isEdit ? cliente.getEmail() : "" %>"
        />
      </div>

      <div class="mb-3">
        <label for="fechaNacimiento" class="form-label"
          >Fecha de Nacimiento</label
        >
        <input
          type="date"
          class="form-control"
          id="fechaNacimiento"
          name="fechaNacimiento"
          value="<%= isEdit ? cliente.getFechaNacimiento() : "" %>"
          required
        />
        <div class="invalid-feedback">
          Por favor, ingresa una fecha válida.
        </div>
      </div>

      <button type="submit" class="btn btn-primary">
        <%= isEdit ? "Actualizar" : "Guardar" %>
      </button>
      <a href="ClienteServlet?action=list" class="btn btn-secondary">Cancelar</a>
    </form>
  </main>

  <!-- Pie de página -->
  <footer>
    <p>© Kasumi - D2JL Inc ® 2025</p>
  </footer>

  <!-- 6) Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <!-- 7) Validación de Bootstrap en tiempo real -->
  <script>
    // Ejemplo de validación nativa de Bootstrap para .needs-validation
    (() => {
      'use strict';
      const forms = document.querySelectorAll('.needs-validation');
      Array.from(forms).forEach((form) => {
        form.addEventListener(
          'submit',
          (event) => {
            if (!form.checkValidity()) {
              event.preventDefault();
              event.stopPropagation();
            }
            form.classList.add('was-validated');
          },
          false
        );
      });
    })();
  </script>
</body>
</html>


