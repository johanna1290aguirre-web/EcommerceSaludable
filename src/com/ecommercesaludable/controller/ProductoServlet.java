package com.ecommercesaludable.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.ecommercesaludable.dao.ProductoDAO;
import com.ecommercesaludable.model.Producto;

@WebServlet("/productos")
public class ProductoServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ProductoDAO productoDAO;

    public void init() throws ServletException {
        productoDAO = new ProductoDAO();
    }

    // MÉTODO GET - Mostrar productos con filtros
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String search = request.getParameter("search");
        String idCategoriaParam = request.getParameter("idCategoria");

        System.out.println("GET /productos - Action: " + action + ", Search: " + search);

        List<Producto> productos;

        if ("buscar".equals(action) && search != null && !search.trim().isEmpty()) {
            // Búsqueda por texto
            productos = productoDAO.buscarProductos(search);
            request.setAttribute("searchQuery", search);
            System.out.println("Búsqueda realizada: " + search);
        } else if ("categoria".equals(action) && idCategoriaParam != null) {
            // Filtro por categoría - CORREGIDO
            int idCategoria = Integer.parseInt(idCategoriaParam);
            productos = productoDAO.obtenerTodosProductos(); // CAMBIADO AQUÍ
            request.setAttribute("categoriaFilter", idCategoriaParam);
            System.out.println("Filtro por categoría: " + idCategoria);
        } else {
            // Todos los productos
            productos = productoDAO.obtenerTodosProductos();
            System.out.println("Mostrando todos los productos");
        }

        request.setAttribute("productos", productos);
        request.getRequestDispatcher("/catalog.jsp").forward(request, response);
    }

    // MÉTODO POST - Agregar productos al carrito
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String productoId = request.getParameter("productoId");

        System.out.println("POST /productos - Action: " + action + ", Producto: " + productoId);

        if ("agregarCarrito".equals(action)) {
            // Aquí iría la lógica para agregar al carrito en sesión
            request.setAttribute("success", "Producto agregado al carrito: " + productoId);
        }

        response.sendRedirect("catalog.jsp");
    }
}
