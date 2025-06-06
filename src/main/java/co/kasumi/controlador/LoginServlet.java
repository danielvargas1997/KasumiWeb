package co.kasumi.controlador;

import co.kasumi.dao.UsuarioDAO;
import co.kasumi.modelo.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
    private UsuarioDAO usuarioDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        usuarioDAO = new UsuarioDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println(">>> LoginServlet.doPost invocado");

        // 1) Obtener parámetros del formulario
        String tipoUsuario = request.getParameter("tipo_usuario"); // ahora sí leemos el rol
        String username    = request.getParameter("username");
        String password    = request.getParameter("password");
        System.out.println("  Parámetros recibidos: tipo_usuario=" + tipoUsuario
                           + ", username=" + username + ", password=" + password);

        // 2) Validar que no estén nulos o vacíos
        if (tipoUsuario == null || tipoUsuario.isEmpty()
         || username    == null || username.trim().isEmpty()
         || password    == null || password.trim().isEmpty()) {
            // Falta alguno de los campos
            request.setAttribute("error", "Por favor completa todos los campos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // 3) Llamar a checkLogin con tres parámetros (username, password, tipoUsuario)
        Usuario user = usuarioDAO.checkLogin(username.trim(), password.trim(), tipoUsuario);
        System.out.println("  Resultado checkLogin: " + (user != null ? "ENCONTRADO" : "NO encontrado"));

        if (user != null) {
            // 4) Login exitoso: guardamos objeto Usuario en sesión y redirigimos
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", user);
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        } else {
            // 5) Login fallido: volvemos a login.jsp con mensaje
            request.setAttribute("error", "Credenciales inválidas");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Si acceden por GET a /LoginServlet, simplemente redirigimos a login.jsp
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}
