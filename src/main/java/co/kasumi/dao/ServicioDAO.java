package co.kasumi.dao;

import co.kasumi.modelo.Servicio;
import co.kasumi.util.DbUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServicioDAO {
    private static final String SQL_SELECT_ALL =
      "SELECT idServicio, nombreServicio, duracionMin, precio FROM Servicio";
    private static final String SQL_INSERT =
      "INSERT INTO Servicio(nombreServicio, duracionMin, precio) VALUES (?,?,?)";
    private static final String SQL_UPDATE =
      "UPDATE Servicio SET nombreServicio=?, duracionMin=?, precio=? WHERE idServicio=?";
    private static final String SQL_DELETE =
      "DELETE FROM Servicio WHERE idServicio=?";
    private static final String SQL_SELECT_BY_ID =
      "SELECT * FROM Servicio WHERE idServicio=?";

    public List<Servicio> selectAll() {
        List<Servicio> lista = new ArrayList<>();
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Servicio s = new Servicio(
                  rs.getInt("idServicio"),
                  rs.getString("nombreServicio"),
                  rs.getInt("duracionMin"),
                  rs.getDouble("precio")
                );
                lista.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public Servicio selectById(int id) {
        Servicio s = null;
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_SELECT_BY_ID)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    s = new Servicio(
                      rs.getInt("idServicio"),
                      rs.getString("nombreServicio"),
                      rs.getInt("duracionMin"),
                      rs.getDouble("precio")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return s;
    }

    public void insert(Servicio s) {
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_INSERT)) {
            ps.setString(1, s.getNombreServicio());
            ps.setInt(2, s.getDuracionMin());
            ps.setDouble(3, s.getPrecio());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Servicio s) {
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_UPDATE)) {
            ps.setString(1, s.getNombreServicio());
            ps.setInt(2, s.getDuracionMin());
            ps.setDouble(3, s.getPrecio());
            ps.setInt(4, s.getIdServicio());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_DELETE)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
