<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Kasumi - Login</title>

  <!-- 1) Bootstrap CSS -->
  <link
    rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
  />

  <!-- 2) Bootstrap Icons (para iconos si los usas) -->
  <link
    rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
  />

  <!-- 3) styles.css: variables y estilos globales -->
  <link
    rel="stylesheet"
    href="${pageContext.request.contextPath}/css/styles.css"
  />

  <!-- 4) login.css: estilos específicos de login -->
  <link
    rel="stylesheet"
    href="${pageContext.request.contextPath}/css/login.css"
  />
</head>
<body style="background-color: var(--background-color);">

  <div
    class="d-flex justify-content-center align-items-center vh-100"
  >
    <div
      class="card shadow-sm p-4"
      style="width: 360px; border-radius: 12px; background-color: #fff;"
    >
      <div class="text-center mb-4">
        <img
          src="${pageContext.request.contextPath}/img/logo_kasumi_bgpink.png"
          alt="Kasumi"
          style="height: 80px;"
        />
      </div>
      <h4 class="text-center mb-3" style="color: var(--accent-color);">
        Iniciar Sesión
      </h4>

      <!-- Mostrar mensaje de error si existe -->
      <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">
          ${error}
        </div>
      </c:if>

      <form
        action="${pageContext.request.contextPath}/LoginServlet"
        method="post"
        novalidate
      >
        <div class="mb-3">
          <label for="tipo_usuario" class="form-label"
            >Tipo de usuario</label
          >
          <select
            name="tipo_usuario"
            id="tipo_usuario"
            class="form-select"
            required
          >
            <option value="" disabled selected>— Elige tu perfil —</option>
            <option value="Administrador">Administrador</option>
            <option value="Recepcionista">Recepcionista</option>
            <option value="Contador">Contador</option>
          </select>
          <div class="invalid-feedback">Selecciona tu perfil</div>
        </div>

        <div class="mb-3">
          <label for="username" class="form-label">Usuario</label>
          <input
            type="text"
            class="form-control"
            name="username"
            id="username"
            placeholder="Ingresa tu usuario"
            required
          />
          <div class="invalid-feedback">Por favor ingresa tu usuario.</div>
        </div>

        <div class="mb-3">
          <label for="password" class="form-label">Contraseña</label>
          <input
            type="password"
            class="form-control"
            name="password"
            id="password"
            placeholder="Ingresa tu contraseña"
            required
          />
          <div class="invalid-feedback">Por favor ingresa tu contraseña.</div>
        </div>

        <button type="submit" class="btn btn-primary w-100">
          Entrar
        </button>
      </form>
    </div>
  </div>

  <!-- 5) Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <!-- 6) (Opcional) Si deseas validación con JS, agréguelo aquí -->
</body>
</html>


