package com.ecommercesaludable.model;

public class Usuario {
    // Atributos
    private int idUsuario;
    private String email;
    private String passwordHash;
    private String nombre;
    private String telefono;
    private String rol;
    
    // Constructor vacío
    public Usuario() {
    }
    
    // Constructor con parámetros
    public Usuario(String email, String passwordHash, String nombre, String telefono) {
        this.email = email;
        this.passwordHash = passwordHash;
        this.nombre = nombre;
        this.telefono = telefono;
        this.rol = "cliente"; // Valor por defecto
    }
    
    // Métodos GET (obtener valores)
    public int getIdUsuario() {
        return idUsuario;
    }
    
    public String getEmail() {
        return email;
    }
    
    public String getPasswordHash() {
        return passwordHash;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public String getTelefono() {
        return telefono;
    }
    
    public String getRol() {
        return rol;
    }
    
    // Métodos SET (asignar valores)
    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
    
    public void setRol(String rol) {
        this.rol = rol;
    }
}