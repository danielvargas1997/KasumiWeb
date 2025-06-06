package co.kasumi.controlador;

import co.kasumi.dao.ServicioDAO;
import co.kasumi.modelo.Servicio;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServicioServlet", urlPatterns = {"/ServicioServlet"})
public class ServicioServlet extends HttpServlet {
    private ServicioDAO servicioDAO;

    @Override
    public void init() {
        servicioDAO = new ServicioDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";
        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "insert":
                insertServicio(request, response);
                break;
            case "delete":
                deleteServicio(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "update":
                updateServicio(request, response);
                break;
            default:
                listServicio(request, response);
                break;
        }
    }

    private void listServicio(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Servicio> lista = servicioDAO.selectAll();
        request.setAttribute("listaServicios", lista);
        RequestDispatcher rd = request.getRequestDispatcher("servicios.jsp");
        rd.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("servicio_form.jsp");
        rd.forward(request, response);
    }

    private void insertServicio(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String nombre = request.getParameter("nombreServicio");
        int duracion = Integer.parseInt(request.getParameter("duracionServicio"));
        double precio = Double.parseDouble(request.getParameter("precioServicio"));
        Servicio s = new Servicio(0, nombre, duracion, precio);
        servicioDAO.insert(s);
        response.sendRedirect("ServicioServlet?action=list");
    }

    private void deleteServicio(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        servicioDAO.delete(id);
        response.sendRedirect("ServicioServlet?action=list");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Servicio s = servicioDAO.selectById(id);
        request.setAttribute("servicio", s);
        RequestDispatcher rd = request.getRequestDispatcher("servicio_form.jsp");
        rd.forward(request, response);
    }

    private void updateServicio(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("idServicio"));
        String nombre = request.getParameter("nombreServicio");
        int duracion = Integer.parseInt(request.getParameter("duracionServicio"));
        double precio = Double.parseDouble(request.getParameter("precioServicio"));
        Servicio s = new Servicio(id, nombre, duracion, precio);
        servicioDAO.update(s);
        response.sendRedirect("ServicioServlet?action=list");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
