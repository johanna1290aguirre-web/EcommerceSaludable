package com.ecommercesaludable.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // MÉTODO GET - Mostrar formulario de login
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("GET /login - Mostrando formulario de login");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    // MÉTODO POST - Procesar login y registro
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("POST /login - Action: " + action + ", Email: " + email);

        if ("login".equals(action)) {
            // Simulación de autenticación
            if ("usuario@test.com".equals(email) && "123456".equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", email);
                session.setAttribute("isLoggedIn", true);
                session.setAttribute("nombre", "Usuario Demo");

                System.out.println("Login exitoso para: " + email);
                response.sendRedirect("index.jsp");
            } else {
                request.setAttribute("error", "Credenciales incorrectas. Use: usuario@test.com / 123456");
                System.out.println("Login fallido para: " + email);
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } else if ("register".equals(action)) {
            // Simulación de registro
            String fullname = request.getParameter("fullname");
            String confirmPassword = request.getParameter("confirmPassword");

            System.out.println("Registro attempt - Nombre: " + fullname + ", Email: " + email);

            if (password.equals(confirmPassword)) {
                request.setAttribute("success", "¡Cuenta creada exitosamente! Ahora puedes iniciar sesión.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Las contraseñas no coinciden");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        }
    }
}
