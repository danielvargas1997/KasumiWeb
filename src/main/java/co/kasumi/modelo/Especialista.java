package co.kasumi.modelo;

public class Especialista {
    private int idEspecialista;
    private String nombre;
    private String especialidad;

    public Especialista() {
    }

    public Especialista(int idEspecialista, String nombre, String especialidad) {
        this.idEspecialista = idEspecialista;
        this.nombre = nombre;
        this.especialidad = especialidad;
    }

    public int getIdEspecialista() {
        return idEspecialista;
    }

    public void setIdEspecialista(int idEspecialista) {
        this.idEspecialista = idEspecialista;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEspecialidad() {
        return especialidad;
    }

    public void setEspecialidad(String especialidad) {
        this.especialidad = especialidad;
    }
}
