package co.kasumi.modelo;

public class Servicio {
    private int idServicio;
    private String nombreServicio;
    private int duracionMin;
    private double precio;

    public Servicio() { }
    public Servicio(int id, String nombre, int duracion, double precio) {
        this.idServicio = id;
        this.nombreServicio = nombre;
        this.duracionMin = duracion;
        this.precio = precio;
    }

    public int getIdServicio() {
        return idServicio;
    }

    public void setIdServicio(int idServicio) {
        this.idServicio = idServicio;
    }

    public String getNombreServicio() {
        return nombreServicio;
    }

    public void setNombreServicio(String nombreServicio) {
        this.nombreServicio = nombreServicio;
    }

    public int getDuracionMin() {
        return duracionMin;
    }

    public void setDuracionMin(int duracionMin) {
        this.duracionMin = duracionMin;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }
    
}
