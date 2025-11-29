package com.ecommercesaludable.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    // Datos de conexión a MySQL
    private static final String URL = "jdbc:mysql://localhost:3307/ecommercesaludable";
    private static final String USER = "appuser";
private static final String PASSWORD = "app123";

    // Método para obtener la conexión
    public static Connection getConnection() {
        Connection connection = null;

        try {
            // Cargar el driver de MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establecer la conexión
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Conexión exitosa a la base de datos");

        } catch (ClassNotFoundException e) {
            System.out.println("❌ Error: No se encontró el driver de MySQL");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("❌ Error al conectar con la base de datos");
            e.printStackTrace();
        }

        return connection;
    }

    // Método para cerrar la conexión
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("✅ Conexión cerrada correctamente");
            } catch (SQLException e) {
                System.out.println("❌ Error al cerrar la conexión");
                e.printStackTrace();
            }
        }
    }
}
