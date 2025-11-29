package com.ecommercesaludable.dao;

import com.ecommercesaludable.model.Producto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {
    
    // Método para OBTENER todos los productos
    public List<Producto> obtenerTodosProductos() {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT * FROM productos WHERE activo = 1";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            
            while (resultSet.next()) {
                Producto producto = new Producto();
                producto.setIdProducto(resultSet.getInt("id_producto"));
                producto.setNombre(resultSet.getString("nombre"));
                producto.setDescripcion(resultSet.getString("descripcion"));
                producto.setPrecio(resultSet.getDouble("precio"));
                producto.setStock(resultSet.getInt("stock"));
                producto.setIdCategoria(resultSet.getInt("id_categoria"));
                
                productos.add(producto);
            }
            
        } catch (SQLException e) {
            System.out.println("❌ Error al obtener productos");
            e.printStackTrace();
        }
        
        return productos;
    }
    
    // Método para BUSCAR productos por nombre
    public List<Producto> buscarProductos(String nombre) {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT * FROM productos WHERE nombre LIKE ? AND activo = 1";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setString(1, "%" + nombre + "%");
            ResultSet resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Producto producto = new Producto();
                producto.setIdProducto(resultSet.getInt("id_producto"));
                producto.setNombre(resultSet.getString("nombre"));
                producto.setDescripcion(resultSet.getString("descripcion"));
                producto.setPrecio(resultSet.getDouble("precio"));
                producto.setStock(resultSet.getInt("stock"));
                producto.setIdCategoria(resultSet.getInt("id_categoria"));
                
                productos.add(producto);
            }
            
        } catch (SQLException e) {
            System.out.println("❌ Error al buscar productos");
            e.printStackTrace();
        }
        
        return productos;
    }
    
    // Método para INSERTAR un nuevo producto
    public void insertarProducto(Producto producto) {
        String sql = "INSERT INTO productos (nombre, descripcion, precio, stock, id_categoria) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setString(1, producto.getNombre());
            statement.setString(2, producto.getDescripcion());
            statement.setDouble(3, producto.getPrecio());
            statement.setInt(4, producto.getStock());
            statement.setInt(5, producto.getIdCategoria());
            
            statement.executeUpdate();
            System.out.println("✅ Producto insertado correctamente");
            
        } catch (SQLException e) {
            System.out.println("❌ Error al insertar producto");
            e.printStackTrace();
        }
    }
}