package com.ecommercesaludable.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/carrito")
public class CarritoServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // MÉTODO GET - Mostrar carrito
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        System.out.println("GET /carrito - Mostrando carrito");

        // Inicializar carrito si no existe
        if (session.getAttribute("carrito") == null) {
            inicializarCarrito(session);
        }

        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    // MÉTODO POST - Manejar acciones del carrito
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String productoId = request.getParameter("productoId");
        String cupon = request.getParameter("cupon");
        HttpSession session = request.getSession();

        System.out.println("POST /carrito - Action: " + action + ", Producto: " + productoId);

        if (session.getAttribute("carrito") == null) {
            inicializarCarrito(session);
        }

        @SuppressWarnings("unchecked")
        Map<String, Object> carrito = (Map<String, Object>) session.getAttribute("carrito");
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> productosCarrito = (List<Map<String, Object>>) carrito.get("productos");

        switch (action) {
            case "eliminar":
                eliminarProducto(productosCarrito, productoId);
                actualizarTotales(carrito, productosCarrito);
                request.setAttribute("success", "Producto eliminado del carrito");
                break;

            case "aplicarCupon":
                aplicarCupon(carrito, cupon);
                request.setAttribute("success", "Cupón '" + cupon + "' aplicado correctamente");
                break;
        }

        session.setAttribute("carrito", carrito);
        response.sendRedirect("carrito");
    }

    private void inicializarCarrito(HttpSession session) {
        Map<String, Object> carrito = new HashMap<>();
        carrito.put("items", 0);
        carrito.put("subtotal", 0);
        carrito.put("total", 0);
        carrito.put("shipping", 0);
        carrito.put("descuento", 0);
        carrito.put("productos", new ArrayList<Map<String, Object>>());
        session.setAttribute("carrito", carrito);
    }

    private void eliminarProducto(List<Map<String, Object>> productos, String productoId) {
        productos.removeIf(producto -> productoId.equals(producto.get("id")));
    }

    private void aplicarCupon(Map<String, Object> carrito, String cupon) {
        if ("SALUDABLE20".equals(cupon)) {
            int subtotal = (int) carrito.get("subtotal");
            int descuento = (int) (subtotal * 0.2); // 20% descuento
            carrito.put("descuento", descuento);
            carrito.put("total", (int) carrito.get("total") - descuento);
        }
    }

    private void actualizarTotales(Map<String, Object> carrito, List<Map<String, Object>> productos) {
        int subtotal = 0;
        int totalItems = 0;

        for (Map<String, Object> producto : productos) {
            int precio = (int) producto.get("precio");
            int cantidad = (int) producto.get("cantidad");
            subtotal += precio * cantidad;
            totalItems += cantidad;
        }

        int descuento = (int) carrito.get("descuento");
        int total = subtotal - descuento;

        carrito.put("subtotal", subtotal);
        carrito.put("total", total);
        carrito.put("items", totalItems);
    }
}
