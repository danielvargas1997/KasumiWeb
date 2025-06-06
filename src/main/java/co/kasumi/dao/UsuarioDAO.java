package co.kasumi.dao;

import co.kasumi.modelo.Usuario;
import co.kasumi.util.DbUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    /** 1) Listar todos los usuarios (incluyendo nombreRol) */
    public List<Usuario> selectAll() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT u.idUsuario, u.nombreUsuario, u.contrasena, u.idRol, r.nombreRol " +
                     "FROM Usuario u JOIN Rol r ON u.idRol = r.idRol " +
                     "ORDER BY u.idUsuario";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("idUsuario"));
                u.setNombreUsuario(rs.getString("nombreUsuario"));
                u.setContrasena(rs.getString("contrasena"));
                u.setIdRol(rs.getInt("idRol"));
                u.setNombreRol(rs.getString("nombreRol"));
                lista.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    /** 2) Buscar usuario por ID (para precargar en edición) */
    public Usuario selectById(int id) {
        Usuario usuario = null;
        String sql = "SELECT u.idUsuario, u.nombreUsuario, u.contrasena, u.idRol, r.nombreRol " +
                     "FROM Usuario u JOIN Rol r ON u.idRol = r.idRol " +
                     "WHERE u.idUsuario = ?";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt("idUsuario"));
                    usuario.setNombreUsuario(rs.getString("nombreUsuario"));
                    usuario.setContrasena(rs.getString("contrasena"));
                    usuario.setIdRol(rs.getInt("idRol"));
                    usuario.setNombreRol(rs.getString("nombreRol"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuario;
    }

    /** 3) Insertar nuevo usuario */
    public boolean insert(Usuario usuario) {
        String sql = "INSERT INTO Usuario (nombreUsuario, contrasena, idRol) VALUES (?, ?, ?)";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, usuario.getNombreUsuario());
            ps.setString(2, usuario.getContrasena());
            ps.setInt(3, usuario.getIdRol());
            int filas = ps.executeUpdate();
            return filas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** 4) Actualizar usuario existente */
    public boolean update(Usuario usuario) {
        String sql = "UPDATE Usuario SET nombreUsuario = ?, contrasena = ?, idRol = ? " +
                     "WHERE idUsuario = ?";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, usuario.getNombreUsuario());
            ps.setString(2, usuario.getContrasena());
            ps.setInt(3, usuario.getIdRol());
            ps.setInt(4, usuario.getIdUsuario());
            int filas = ps.executeUpdate();
            return filas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** 5) Eliminar usuario por ID */
    public boolean delete(int id) {
        String sql = "DELETE FROM Usuario WHERE idUsuario = ?";
        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            int filas = ps.executeUpdate();
            return filas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** 6) Buscar usuarios por nombre de usuario o nombre de rol */
    public List<Usuario> searchByUsernameOrRol(String criterio) {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT u.idUsuario, u.nombreUsuario, u.contrasena, u.idRol, r.nombreRol " +
                     "FROM Usuario u JOIN Rol r ON u.idRol = r.idRol " +
                     "WHERE u.nombreUsuario LIKE ? OR r.nombreRol LIKE ? " +
                     "ORDER BY u.idUsuario";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String filtro = "%" + criterio + "%";
            ps.setString(1, filtro);
            ps.setString(2, filtro);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Usuario u = new Usuario();
                    u.setIdUsuario(rs.getInt("idUsuario"));
                    u.setNombreUsuario(rs.getString("nombreUsuario"));
                    u.setContrasena(rs.getString("contrasena"));
                    u.setIdRol(rs.getInt("idRol"));
                    u.setNombreRol(rs.getString("nombreRol"));
                    lista.add(u);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    /**
     * 7) Validar login: busca un usuario cuyo nombreUsuario, contrasena y rol coincidan.
     *    Retorna un objeto Usuario si lo encuentra, o null si no.
     */
    public Usuario checkLogin(String username, String password, String tipoUsuario) {
        Usuario usuario = null;
        String sql = "SELECT u.idUsuario, u.nombreUsuario, u.contrasena, u.idRol, r.nombreRol " +
                     "FROM Usuario u " +
                     "JOIN Rol r ON u.idRol = r.idRol " +
                     "WHERE u.nombreUsuario = ? AND u.contrasena = ? AND r.nombreRol = ?";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, tipoUsuario);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt("idUsuario"));
                    usuario.setNombreUsuario(rs.getString("nombreUsuario"));
                    usuario.setContrasena(rs.getString("contrasena"));
                    usuario.setIdRol(rs.getInt("idRol"));
                    usuario.setNombreRol(rs.getString("nombreRol"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuario;
    }
}
