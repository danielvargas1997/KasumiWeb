package co.kasumi.dao;

import co.kasumi.modelo.Rol;
import co.kasumi.util.DbUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RolDAO {

    /** Listar todos los roles */
    public List<Rol> selectAll() {
        List<Rol> lista = new ArrayList<>();
        String sql = "SELECT idRol, nombreRol FROM Rol ORDER BY idRol";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Rol r = new Rol();
                r.setIdRol(rs.getInt("idRol"));
                r.setNombreRol(rs.getString("nombreRol"));
                lista.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
