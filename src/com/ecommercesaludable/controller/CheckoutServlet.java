package com.ecommercesaludable.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // MÉTODO GET - Mostrar formulario de checkout
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Verificar si hay usuario logueado
        if (session.getAttribute("isLoggedIn") == null || !(Boolean) session.getAttribute("isLoggedIn")) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Verificar si hay productos en el carrito
        if (session.getAttribute("carrito") == null) {
            response.sendRedirect("cart.jsp");
            return;
        }

        System.out.println("GET /checkout - Mostrando formulario de pago");
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }

    // MÉTODO POST - Procesar pedido
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String direccion = request.getParameter("direccion");
        String tarjeta = request.getParameter("tarjeta");

        System.out.println("POST /checkout - Procesando pedido para: " + nombre);
        System.out.println("Email: " + email + ", Dirección: " + direccion);

        // Simulación de procesamiento de pago
        HttpSession session = request.getSession();
        session.removeAttribute("carrito"); // Limpiar carrito

        request.setAttribute("pedidoExitoso", true);
        request.setAttribute("numeroPedido", "PED" + System.currentTimeMillis());
        request.getRequestDispatcher("/confirmacion.jsp").forward(request, response);
    }
}
