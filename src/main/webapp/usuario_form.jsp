<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="co.kasumi.modelo.Usuario" %>
<%@ page import="co.kasumi.modelo.Rol" %>
<%
    if (session == null || session.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Usuario usuario = (Usuario) request.getAttribute("usuario");
    boolean isEdit = (usuario != null);
    String titulo = isEdit ? "Editar Usuario" : "Nuevo Usuario";
    String actionUrl = isEdit ? "UsuarioServlet?action=update" : "UsuarioServlet?action=insert";

    // Lista de roles que el servlet colocó en "listaRoles"
    java.util.List<Rol> listaRoles = (java.util.List<Rol>) request.getAttribute("listaRoles");
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

  <!-- Formulario de usuario -->
  <main class="container mt-5" style="margin-top:120px; max-width: 600px;">
    <h2><%= titulo %></h2>
    <form action="<%= actionUrl %>" method="post" class="needs-validation" novalidate>
      <% if (isEdit) { %>
        <input type="hidden" name="idUsuario" value="<%= usuario.getIdUsuario() %>" />
      <% } %>

      <div class="mb-3">
        <label for="nombreUsuario" class="form-label">Usuario</label>
        <input
          type="text"
          id="nombreUsuario"
          name="nombreUsuario"
          class="form-control"
          value="<%= isEdit ? usuario.getNombreUsuario() : "" %>"
          required
        />
        <div class="invalid-feedback">Por favor, ingresa el nombre de usuario.</div>
      </div>

      <div class="mb-3">
        <label for="contrasena" class="form-label">Contraseña</label>
        <input
          type="text"
          id="contrasena"
          name="contrasena"
          class="form-control"
          value="<%= isEdit ? usuario.getContrasena() : "" %>"
          required
        />
        <div class="invalid-feedback">Por favor, ingresa la contraseña.</div>
      </div>

      <div class="mb-3">
        <label for="idRol" class="form-label">Rol</label>
        <select id="idRol" name="idRol" class="form-control" required>
          <option value="" disabled <%= isEdit ? "" : "selected" %>>
            — Selecciona Rol —
          </option>
          <%
            if (listaRoles != null) {
              for (Rol r : listaRoles) {
                boolean seleccionado = isEdit && (r.getIdRol() == usuario.getIdRol());
          %>
            <option value="<%= r.getIdRol() %>" <%= seleccionado ? "selected" : "" %>>
              <%= r.getNombreRol() %>
            </option>
          <%
              }
            }
          %>
        </select>
        <div class="invalid-feedback">Por favor, selecciona un rol.</div>
      </div>

      <button type="submit" class="btn btn-primary">
        <%= isEdit ? "Actualizar" : "Guardar" %>
      </button>
      <a href="UsuarioServlet?action=list" class="btn btn-secondary">Cancelar</a>
    </form>
  </main>

  <!-- Pie de página -->
  <footer>
    <p>© Kasumi - D2JL Inc ® 2025</p>
  </footer>

  <!-- 6) Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <!-- 7) Validación de Bootstrap -->
  <script>
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


