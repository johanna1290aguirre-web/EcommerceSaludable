<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ecommercesaludable.model.*" %>
<%@ page import="com.ecommercesaludable.dao.*" %>
<%@ page import="java.util.*" %>
<%
    // Obtener productos destacados desde MySQL
    ProductoDAO productoDAO = new ProductoDAO();
    List<Producto> productosDestacados = productoDAO.obtenerTodosProductos();
    
    // Limitar a 4 productos para la sección destacados
    if(productosDestacados.size() > 4) {
        productosDestacados = productosDestacados.subList(0, 4);
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ecommerce Saludable</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <div class="header-content">
            <h1><i class="fas fa-heartbeat"></i> ECOMMERCE SALUDABLE</h1>
            
            <div class="search-bar">
                <input type="text" placeholder="Buscar productos saludables...">
                <button class="search-btn">
                    <i class="fas fa-search"></i>
                </button>
            </div>

            <nav>
                <a href="index.jsp"><i class="fas fa-home"></i> Inicio</a>
                <a href="catalog.jsp"><i class="fas fa-store"></i> Catálogo</a>
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
        <section class="hero">
            <div class="hero-content">
                <h2>Transforma tu Vida con Alimentos Saludables</h2>
                <p>Productos 100% naturales para tu bienestar integral</p>
                <div class="hero-buttons">
                    <button class="cta-button" onclick="scrollToProducts()">
                        <i class="fas fa-seedling"></i> Descubrir Productos
                    </button>
                    <a href="catalog.jsp" class="secondary-button">
                        <i class="fas fa-store"></i> Ver Catálogo Completo
                    </a>
                </div>
            </div>
        </section>

        <section class="products" id="products-section">
            <h2><i class="fas fa-star"></i> Productos Destacados</h2>
            
            <div class="products-grid">
                <%-- PRODUCTOS DINÁMICOS DESDE MYSQL --%>
                <% for(Producto producto : productosDestacados) { %>
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
                        <button onclick="addToCart(<%= producto.getIdProducto() %>, <%= producto.getPrecio() %>, '<%= producto.getNombre() %>')">
                            <i class="fas fa-cart-plus"></i> Agregar al carrito
                        </button>
                        <a href="producto.jsp?id=<%= producto.getIdProducto() %>" style="display: block; text-align: center; margin-top: 10px; color: #E02B59; text-decoration: none;">
                            <i class="fas fa-eye"></i> Ver detalles
                        </a>
                    </div>
                <% } %>
            </div>

            <div class="view-more-container">
                <a href="catalog.jsp" class="view-more-btn">
                    <i class="fas fa-eye"></i> Ver Todos los Productos
                </a>
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
        // Función para agregar productos al carrito
        function addToCart(productId, price, productName) {
            // Mostrar notificación
            showNotification(`¡${productName} agregado al carrito!`, 'success');
            
            // Incrementar contador del carrito
            const cartCount = document.querySelector('.cart-count');
            let currentCount = parseInt(cartCount.textContent);
            cartCount.textContent = currentCount + 1;
            
            // Guardar en localStorage (para persistencia entre páginas)
            let cart = JSON.parse(localStorage.getItem('cart')) || {};
            
            if (cart[productId]) {
                cart[productId].quantity += 1;
            } else {
                cart[productId] = {
                    name: productName,
                    price: price,
                    quantity: 1
                };
            }
            
            localStorage.setItem('cart', JSON.stringify(cart));
            
            // Efecto de animación en el botón
            const button = event.currentTarget;
            button.classList.add('added-to-cart');
            setTimeout(() => {
                button.classList.remove('added-to-cart');
            }, 1000);
        }
        
        // Función para mostrar notificaciones
        function showNotification(message, type) {
            // Crear elemento de notificación
            const notification = document.createElement('div');
            notification.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 15px 20px;
                border-radius: 10px;
                color: white;
                font-weight: 600;
                z-index: 1000;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
                transform: translateX(100%);
                transition: transform 0.5s;
            `;
            
            notification.style.background = type === 'success' ? '#27ae60' : '#e74c3c';
            notification.textContent = message;
            
            document.body.appendChild(notification);
            
            // Mostrar notificación
            setTimeout(() => {
                notification.style.transform = 'translateX(0)';
            }, 100);
            
            // Ocultar después de 3 segundos
            setTimeout(() => {
                notification.style.transform = 'translateX(100%)';
                setTimeout(() => {
                    document.body.removeChild(notification);
                }, 500);
            }, 3000);
        }
        
        // Función para scroll a productos
        function scrollToProducts() {
            document.getElementById('products-section').scrollIntoView({
                behavior: 'smooth'
            });
        }
        
        // Cargar contador del carrito al iniciar
        document.addEventListener('DOMContentLoaded', function() {
            const cart = JSON.parse(localStorage.getItem('cart')) || {};
            let totalItems = 0;
            
            for (const productId in cart) {
                totalItems += cart[productId].quantity;
            }
            
            document.querySelector('.cart-count').textContent = totalItems;
        });
    </script>

    <style>
        /* Estilos adicionales para las animaciones */
        .added-to-cart {
            animation: pulse 0.5s ease;
            background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%) !important;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }
        
        .cart-icon a {
            display: flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s ease;
        }
        
        .cart-icon a:hover {
            transform: scale(1.1);
        }
    </style>
</body>
</html>