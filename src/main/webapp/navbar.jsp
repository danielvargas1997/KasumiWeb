<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    co.kasumi.modelo.Usuario usuario = (co.kasumi.modelo.Usuario) session.getAttribute("usuarioLogueado");
    String nombreUsuario = (usuario != null) ? usuario.getNombreUsuario() : "";
    String nombreRol     = (usuario != null) ? usuario.getNombreRol() : "";
%>
<nav
  class="navbar navbar-expand-lg navbar-home navbar-dark fixed-top"
  style="box-shadow: 0 2px 5px rgba(0,0,0,0.2);"
>
  <div class="container-fluid">
    <!-- Logo + Marca -->
    <a
      class="navbar-brand d-flex align-items-center"
      href="${pageContext.request.contextPath}/dashboard.jsp"
    >
      <img
        src="${pageContext.request.contextPath}/img/logo_kasumi_bgblue.png"
        alt="Logo Kasumi"
        class="navbar-img"
      />
      <span class="fw-semibold">Kasumi</span>
    </a>

    <button
      class="navbar-toggler"
      type="button"
      data-bs-toggle="collapse"
      data-bs-target="#navbarNav"
      aria-controls="navbarNav"
      aria-expanded="false"
      aria-label="Toggle navigation"
    >
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <%-- Clientes: Administrador o Recepcionista --%>
        <c:if test="${nombreRol == 'Administrador' || nombreRol == 'Recepcionista'}">
          <li class="nav-item">
            <a
              class="nav-link"
              href="${pageContext.request.contextPath}/ClienteServlet?action=list"
              >Clientes</a
            >
          </li>
        </c:if>

        <%-- Usuarios: Administrador o Contador --%>
        <c:if test="${nombreRol == 'Administrador' || nombreRol == 'Contador'}">
          <li class="nav-item">
            <a
              class="nav-link"
              href="${pageContext.request.contextPath}/UsuarioServlet?action=list"
              >Usuarios</a
            >
          </li>
        </c:if>

        <%-- Servicios: Administrador o Recepcionista --%>
        <c:if test="${nombreRol == 'Administrador' || nombreRol == 'Recepcionista'}">
          <li class="nav-item">
            <a
              class="nav-link"
              href="${pageContext.request.contextPath}/ServicioServlet?action=list"
              >Servicios</a
            >
          </li>
        </c:if>
      </ul>

      <ul class="navbar-nav">
        <li class="nav-item me-3 d-flex align-items-center">
          <i class="bi bi-person-fill text-light me-1"></i>
          <span class="navbar-text text-light">
            <%= nombreUsuario %>
          </span>
        </li>
        <li class="nav-item">
          <a
            class="nav-link btn btn-sm btn-outline-light"
            href="${pageContext.request.contextPath}/LogoutServlet"
            >Cerrar Sesión</a
          >
        </li>
      </ul>
    </div>
  </div>
</nav>

