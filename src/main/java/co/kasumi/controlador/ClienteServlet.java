package co.kasumi.controlador;

import co.kasumi.dao.ClienteDAO;
import co.kasumi.modelo.Cliente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "ClienteServlet", urlPatterns = {"/ClienteServlet"})
public class ClienteServlet extends HttpServlet {
    private ClienteDAO clienteDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        clienteDAO = new ClienteDAO();
    }

    // ----------------------------
    // Sobrescribimos doGet
    // ----------------------------
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Determinar la acción (list, new, insert, edit, update, delete, search)
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                showNewForm(request, response);
                break;

            case "insert":
                insertCliente(request, response);
                break;

            case "edit":
                showEditForm(request, response);
                break;

            case "update":
                updateCliente(request, response);
                break;

            case "delete":
                deleteCliente(request, response);
                break;

            case "search":
                searchCliente(request, response);
                break;

            default: // "list"
                listClientes(request, response);
                break;
        }
    }

    // ----------------------------
    // Nuevo método: redirigir POST a doGet
    // ----------------------------
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Con esto, cualquier POST caerá en doGet(...) y se procesará igual
        doGet(request, response);
    }

    // ----------------------------
    // Métodos auxiliares
    // ----------------------------
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("cliente_form.jsp").forward(request, response);
    }

    private void insertCliente(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String nombre   = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String telefono = request.getParameter("telefono");
        String email    = request.getParameter("email");
        String fechaStr = request.getParameter("fechaNacimiento");

        // Convertir string YYYY-MM-DD a java.sql.Date
        Date fechaNacimiento = Date.valueOf(fechaStr);

        Cliente nuevo = new Cliente();
        nuevo.setNombre(nombre);
        nuevo.setApellido(apellido);
        nuevo.setTelefono(telefono);
        nuevo.setEmail(email);
        nuevo.setFechaNacimiento(fechaNacimiento);

        boolean agregado = clienteDAO.insert(nuevo);
        if (agregado) {
            response.sendRedirect("ClienteServlet?action=list");
        } else {
            request.setAttribute("error", "No se pudo agregar el cliente.");
            request.getRequestDispatcher("cliente_form.jsp").forward(request, response);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Cliente existing = clienteDAO.selectById(id);
        request.setAttribute("cliente", existing);
        request.getRequestDispatcher("cliente_form.jsp").forward(request, response);
    }

    private void updateCliente(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id           = Integer.parseInt(request.getParameter("idCliente"));
        String nombre    = request.getParameter("nombre");
        String apellido  = request.getParameter("apellido");
        String telefono  = request.getParameter("telefono");
        String email     = request.getParameter("email");
        String fechaStr  = request.getParameter("fechaNacimiento");
        Date fechaNacimiento = Date.valueOf(fechaStr);

        Cliente cliente = new Cliente(id, nombre, apellido, telefono, email, fechaNacimiento);
        clienteDAO.update(cliente);
        response.sendRedirect("ClienteServlet?action=list");
    }

    private void deleteCliente(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        clienteDAO.delete(id);
        response.sendRedirect("ClienteServlet?action=list");
    }

    private void listClientes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Cliente> lista = clienteDAO.selectAll();
        request.setAttribute("listaClientes", lista);
        request.getRequestDispatcher("clientes.jsp").forward(request, response);
    }

    private void searchCliente(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String criterio = request.getParameter("criterio");
        List<Cliente> lista = clienteDAO.searchByNameOrLastName(criterio);
        request.setAttribute("listaClientes", lista);
        request.getRequestDispatcher("clientes.jsp").forward(request, response);
    }
}
