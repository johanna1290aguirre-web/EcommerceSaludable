package com.ecommercesaludable.model;

public class Producto {
    // Atributos
    private int idProducto;
    private String nombre;
    private String descripcion;
    private double precio;
    private int stock;
    private int idCategoria;
    private boolean activo;
    
    // Constructor vacío
    public Producto() {
    }
    
    // Constructor con parámetros
    public Producto(String nombre, String descripcion, double precio, int stock, int idCategoria) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.precio = precio;
        this.stock = stock;
        this.idCategoria = idCategoria;
        this.activo = true;
    }
    
    // Métodos GET (obtener valores)
    public int getIdProducto() {
        return idProducto;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public String getDescripcion() {
        return descripcion;
    }
    
    public double getPrecio() {
        return precio;
    }
    
    public int getStock() {
        return stock;
    }
    
    public int getIdCategoria() {
        return idCategoria;
    }
    
    public boolean isActivo() {
        return activo;
    }
    
    // Métodos SET (asignar valores)
    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    public void setPrecio(double precio) {
        this.precio = precio;
    }
    
    public void setStock(int stock) {
        this.stock = stock;
    }
    
    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }
    
    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    
    @Override
    public String toString() {
        return "Producto [id=" + idProducto + ", nombre=" + nombre + ", precio=" + precio + 
               ", stock=" + stock + ", idCategoria=" + idCategoria + "]";
    }
}