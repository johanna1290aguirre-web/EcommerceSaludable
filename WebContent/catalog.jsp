<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ecommercesaludable.model.*" %>
<%@ page import="com.ecommercesaludable.dao.*" %>
<%@ page import="java.util.*" %>
<%
    // Obtener parámetros del Servlet
    List<Producto> productos = (List<Producto>) request.getAttribute("productos");
    
    // Si no hay productos del Servlet, cargar todos
    if(productos == null) {
        ProductoDAO productoDAO = new ProductoDAO();
        productos = productoDAO.obtenerTodosProductos();
    }
    
    // Parámetros para filtros
    String searchQuery = request.getParameter("search");
    String categoriaFilter = request.getParameter("categoria");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo Completo - Ecommerce Saludable</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <div class="header-content">
            <h1><i class="fas fa-heartbeat"></i> ECOMMERCE SALUDABLE</h1>
            
            <!-- FORMULARIO CON MÉTODO GET -->
            <form action="productos" method="get" class="search-bar">
                <input type="text" name="search" placeholder="Buscar productos saludables..." 
                       value="<%= searchQuery != null ? searchQuery : "" %>">
                <input type="hidden" name="action" value="buscar">
                <button type="submit" class="search-btn">
                    <i class="fas fa-search"></i>
                </button>
            </form>

            <nav>
                <a href="index.jsp"><i class="fas fa-home"></i> Inicio</a>
                <a href="catalog.jsp" class="active"><i class="fas fa-store"></i> Catálogo</a>
                <a href="#"><i class="fas fa-spa"></i> Bienestar</a>
                <a href="#"><i class="fas fa-seedling"></i> Orgánico</a>
            </nav>

            <div class="header-actions">
                <a href="login.jsp" class="login-btn">
                    <i class="fas fa-user"></i> Ingresar
                </a>
                
                <div class="cart-icon">
                    <a href="cart.jsp" style="color: inherit; text-decoration: none;">
                        <i class="fas fa-shopping-cart"></i>
                        <span class="cart-count">0</span>
                    </a>
                </div>
            </div>
        </div>
    </header>

    <main>
        <section class="catalog-hero">
            <div class="catalog-hero-content">
                <h2><i class="fas fa-store"></i> Catálogo de Productos</h2>
                <p>Descubre nuestra selección de productos saludables</p>
            </div>
        </section>

        <section class="catalog-filters">
            <div class="filters-container">
                <!-- FORMULARIO FILTROS CON MÉTODO GET -->
                <form action="productos" method="get" style="display: contents;">
                    <div class="filter-group">
                        <label for="categoria"><i class="fas fa-filter"></i> Categoría:</label>
                        <select id="categoria" name="idCategoria">
                            <option value="0">Todos los productos</option>
                            <option value="1">Orgánicos</option>
                            <option value="2">Sin Gluten</option>
                            <option value="3">Veganos</option>
                            <option value="4">Suplementos</option>
                        </select>
                    </div>

                    <input type="hidden" name="action" value="categoria">
                    <button type="submit" class="filter-btn">
                        <i class="fas fa-sliders-h"></i> Aplicar Filtros
                    </button>
                </form>
            </div>
        </section>

        <section class="catalog-products">
            <div class="products-grid">
                <%-- PRODUCTOS DINÁMICOS DESDE MYSQL --%>
                <% for(Producto producto : productos) { %>
                    <div class="producto">
                        <div class="product-icon">
                            <%
                                // Icono según categoría
                                String icono = "fa-seedling"; // default
                                switch(producto.getIdCategoria()) {
                                    case 1: icono = "fa-apple-alt"; break; // Orgánicos
                                    case 2: icono = "fa-bread-slice"; break; // Sin Gluten
                                    case 3: icono = "fa-leaf"; break; // Veganos
                                    case 4: icono = "fa-capsules"; break; // Suplementos
                                }
                            %>
                            <i class="fas <%= icono %>"></i>
                        </div>
                        <h3><%= producto.getNombre() %></h3>
                        <p class="description"><%= producto.getDescripcion() %></p>
                        <p class="price">$<%= String.format("%.2f", producto.getPrecio()) %> COP</p>
                        <p class="shipping"><i class="fas fa-truck"></i> Envío gratis</p>
                        <button onclick="window.location.href='producto.jsp?id=<%= producto.getIdProducto() %>'">
                            <i class="fas fa-cart-plus"></i> Ver Detalles
                        </button>
                    </div>
                <% } %>
            </div>
        </section>
    </main>

    <footer>
        <div class="footer-content">
            <p>&copy; 2025 Ecommerce Saludable. Todos los derechos reservados.</p>
            <div class="social-icons">
                <a href="#"><i class="fab fa-facebook"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-whatsapp"></i></a>
                <a href="#"><i class="fab fa-tiktok"></i></a>
            </div>
        </div>
    </footer>

    <script>
        // Funcionalidad básica para el catálogo
        document.addEventListener('DOMContentLoaded', function() {
            // Cargar contador del carrito
            const cart = JSON.parse(localStorage.getItem('cart')) || {};
            let totalItems = 0;
            
            for (const productId in cart) {
                totalItems += cart[productId].quantity;
            }
            
            document.querySelector('.cart-count').textContent = totalItems;
        });
    </script>
</body>
</html>