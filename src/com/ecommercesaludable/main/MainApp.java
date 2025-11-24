package com.ecommercesaludable.main;

import com.ecommercesaludable.dao.ProductoDAO;
import com.ecommercesaludable.model.Producto;

public class MainApp {
    public static void main(String[] args) {
        System.out.println("INICIANDO E-COMMERCE SALUDABLE");
        System.out.println("==============================");
        
        // Probar la conexión a la base de datos
        System.out.println("1. Probando conexión a BD...");
        ProductoDAO productoDAO = new ProductoDAO();
        
        // Crear un producto de prueba
        System.out.println("2. Creando producto de prueba...");
        Producto productoPrueba = new Producto(
            "Manzana Organica", 
            "Manzana fresca cultivada organicamente", 
            2.50, 
            100, 
            1
        );
        
        // Intentar insertar el producto (comentado por ahora)
        System.out.println("3. Intentando insertar producto...");
        // productoDAO.insertarProducto(productoPrueba);
        
        // Obtener todos los productos
        System.out.println("4. Obteniendo lista de productos...");
        var productos = productoDAO.obtenerTodosProductos();
        System.out.println("   Productos encontrados: " + productos.size());
        
        System.out.println("PRUEBA COMPLETADA");
        System.out.println("NOTA: Para pruebas reales, necesitamos:");
        System.out.println("   - Base de datos MySQL creada");
        System.out.println("   - Driver MySQL agregado al proyecto");
    }
}