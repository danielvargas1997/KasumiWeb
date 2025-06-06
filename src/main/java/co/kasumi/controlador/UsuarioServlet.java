package co.kasumi.controlador;

import co.kasumi.dao.UsuarioDAO;
import co.kasumi.modelo.Usuario;
import co.kasumi.dao.RolDAO; // vamos a necesitar listar roles
import co.kasumi.modelo.Rol;   // modelo para rol

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "UsuarioServlet", urlPatterns = {"/UsuarioServlet"})
public class UsuarioServlet extends HttpServlet {
    private UsuarioDAO usuarioDAO;
    private RolDAO rolDAO; // para obtener lista de roles

    @Override
    public void init() throws ServletException {
        super.init();
        usuarioDAO = new UsuarioDAO();
        rolDAO     = new RolDAO(); // asume que existe un DAO para Rol
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                showNewForm(request, response);
                break;

            case "insert":
                insertUsuario(request, response);
                break;

            case "edit":
                showEditForm(request, response);
                break;

            case "update":
                updateUsuario(request, response);
                break;

            case "delete":
                deleteUsuario(request, response);
                break;

            case "search":
                searchUsuario(request, response);
                break;

            default: // "list"
                listUsuarios(request, response);
                break;
        }
    }

    /** Redirige POST a GET */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /** Mostrar formulario vacío para nuevo usuario */
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Cargar lista de roles para el <select> en el form
        List<Rol> listaRoles = rolDAO.selectAll();
        request.setAttribute("listaRoles", listaRoles);

        request.getRequestDispatcher("usuario_form.jsp").forward(request, response);
    }

    /** Insertar nuevo usuario */
    private void insertUsuario(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String nombreUsuario = request.getParameter("nombreUsuario").trim();
        String contrasena    = request.getParameter("contrasena").trim();
        int idRol            = Integer.parseInt(request.getParameter("idRol"));

        Usuario nuevo = new Usuario();
        nuevo.setNombreUsuario(nombreUsuario);
        nuevo.setContrasena(contrasena);
        nuevo.setIdRol(idRol);

        boolean agregado = usuarioDAO.insert(nuevo);
        if (agregado) {
            response.sendRedirect("UsuarioServlet?action=list");
        } else {
            request.setAttribute("error", "No se pudo crear el usuario.");
            // Recargar roles para el form
            List<Rol> listaRoles = rolDAO.selectAll();
            request.setAttribute("listaRoles", listaRoles);

            request.getRequestDispatcher("usuario_form.jsp").forward(request, response);
        }
    }

    /** Mostrar formulario con datos existentes para editar */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Usuario existing = usuarioDAO.selectById(id);
        request.setAttribute("usuario", existing);

        // Roles para <select>
        List<Rol> listaRoles = rolDAO.selectAll();
        request.setAttribute("listaRoles", listaRoles);

        request.getRequestDispatcher("usuario_form.jsp").forward(request, response);
    }

    /** Actualizar usuario existente */
    private void updateUsuario(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int idUsuario      = Integer.parseInt(request.getParameter("idUsuario"));
        String nombreUsuario = request.getParameter("nombreUsuario").trim();
        String contrasena    = request.getParameter("contrasena").trim();
        int idRol            = Integer.parseInt(request.getParameter("idRol"));

        Usuario u = new Usuario();
        u.setIdUsuario(idUsuario);
        u.setNombreUsuario(nombreUsuario);
        u.setContrasena(contrasena);
        u.setIdRol(idRol);

        usuarioDAO.update(u);
        response.sendRedirect("UsuarioServlet?action=list");
    }

    /** Eliminar usuario por ID */
    private void deleteUsuario(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        usuarioDAO.delete(id);
        response.sendRedirect("UsuarioServlet?action=list");
    }

    /** Listar todos los usuarios */
    private void listUsuarios(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Usuario> lista = usuarioDAO.selectAll();
        request.setAttribute("listaUsuarios", lista);
        request.getRequestDispatcher("usuarios.jsp").forward(request, response);
    }

    /** Buscar usuarios por nombre de usuario o rol */
    private void searchUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String criterio = request.getParameter("criterio");
        List<Usuario> lista = usuarioDAO.searchByUsernameOrRol(criterio);
        request.setAttribute("listaUsuarios", lista);
        request.getRequestDispatcher("usuarios.jsp").forward(request, response);
    }
}
