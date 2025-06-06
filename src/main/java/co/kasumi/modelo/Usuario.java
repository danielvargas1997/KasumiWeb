package co.kasumi.modelo;

public class Usuario {
    private int idUsuario;
    private String nombreUsuario;
    private String contrasena;
    private int idRol;
    private String nombreRol; // campo extra para mostrar el nombre del rol

    public Usuario() {}

    // Constructor completo
    public Usuario(int idUsuario, String nombreUsuario, String contrasena, int idRol, String nombreRol) {
        this.idUsuario     = idUsuario;
        this.nombreUsuario = nombreUsuario;
        this.contrasena    = contrasena;
        this.idRol         = idRol;
        this.nombreRol     = nombreRol;
    }

    // Getters y Setters
    public int getIdUsuario() {
        return idUsuario;
    }
    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }
    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public String getContrasena() {
        return contrasena;
    }
    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public int getIdRol() {
        return idRol;
    }
    public void setIdRol(int idRol) {
        this.idRol = idRol;
    }

    public String getNombreRol() {
        return nombreRol;
    }
    public void setNombreRol(String nombreRol) {
        this.nombreRol = nombreRol;
    }
}
