<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.ecommercesaludable.ecommerce_spring.model.Producto" %>
<%
    // Obtener productos destacados desde el controlador Spring
    List<Producto> productosDestacados = (List<Producto>) request.getAttribute("productosDestacados");
    
    // Si no hay productos, crear lista vacía
    if(productosDestacados == null) {
        productosDestacados = new ArrayList<>();
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
    <style>
        /* ESTILOS GENERALES */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Montserrat', sans-serif;
            background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%);
            color: #fff;
            min-height: 100vh;
        }
        
        /* HEADER */
        header {
            background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%);
            padding: 1rem 2rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
            border-bottom: 2px solid #E02B59;
        }
        
        .header-content {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }
        
        header h1 {
            font-size: 1.8rem;
            color: #FFFFFF;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        header h1 i {
            color: #E02B59;
        }
        
        .search-bar {
            display: flex;
            align-items: center;
            background: #333;
            border-radius: 50px;
            padding: 0.3rem;
            flex: 1;
            max-width: 400px;
        }
        
        .search-bar input {
            flex: 1;
            background: transparent;
            border: none;
            padding: 0.5rem 1rem;
            color: white;
            font-size: 0.9rem;
        }
        
        .search-bar input::placeholder {
            color: #999;
        }
        
        .search-bar input:focus {
            outline: none;
        }
        
        .search-btn {
            background: #E02B59;
            border: none;
            color: white;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .search-btn:hover {
            background: #C01A4A;
            transform: scale(1.1);
        }
        
        nav {
            display: flex;
            gap: 1.5rem;
        }
        
        nav a {
            color: #CCCCCC;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        nav a:hover, nav a.active {
            color: #FFD700;
        }
        
        .header-actions {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }
        
        .login-btn {
            background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
            color: #000;
            text-decoration: none;
            padding: 0.6rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .login-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(39, 174, 96, 0.4);
        }
        
        .cart-icon a {
            color: #FFFFFF;
            text-decoration: none;
            font-size: 1.2rem;
            position: relative;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .cart-count {
            background: #E02B59;
            color: white;
            border-radius: 50%;
            padding: 0.2rem 0.6rem;
            font-size: 0.8rem;
            position: absolute;
            top: -10px;
            right: -15px;
        }
        
        /* HERO */
        .hero {
            background: linear-gradient(135deg, rgba(39, 174, 96, 0.9) 0%, rgba(46, 204, 113, 0.9) 100%), url('https://images.unsplash.com/photo-1543352634-a1c51ec9ad1e?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            min-height: 500px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: white;
            margin-bottom: 3rem;
        }

        .hero-content {
            max-width: 800px;
            padding: 2rem;
        }

        .hero-content h2 {
            font-size: 3rem;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .hero-content p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
        }

        .hero-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .cta-button {
            background: #E02B59;
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .cta-button:hover {
            background: #C01A4A;
            transform: translateY(-3px);
        }

        .secondary-button {
            background: transparent;
            color: white;
            border: 2px solid white;
            padding: 1rem 2rem;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .secondary-button:hover {
            background: white;
            color: #27ae60;
            transform: translateY(-3px);
        }

        /* PRODUCTOS */
        .products {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .products h2 {
            text-align: center;
            color: #FFFFFF;
            margin-bottom: 2rem;
            font-size: 2rem;
        }

        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .producto {
            background: linear-gradient(145deg, #1A1A1A 0%, #2D2D2D 100%);
            border-radius: 15px;
            padding: 1.5rem;
            text-align: center;
            transition: transform 0.3s ease;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.6);
        }

        .producto:hover {
            transform: translateY(-10px);
        }

        .product-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
            border-radius: 50%;
            margin: 0 auto 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: white;
        }

        .producto h3 {
            color: #FFFFFF;
            margin-bottom: 0.5rem;
            font-size: 1.2rem;
        }

        .producto .description {
            color: #CCCCCC;
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }

        .producto .price {
            color: #FFD700;
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .producto .shipping {
            color: #27ae60;
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }

        .producto button {
            background: #E02B59;
            color: white;
            border: none;
            padding: 0.8rem 1rem;
            border-radius: 50px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            width: 100%;
            margin-bottom: 0.5rem;
        }

        .producto button:hover {
            background: #C01A4A;
        }

        .producto a {
            display: block;
            text-align: center;
            margin-top: 10px;
            color: #E02B59;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .producto a:hover {
            color: #FFD700;
        }

        .view-more-container {
            text-align: center;
            margin: 2rem 0;
        }

        .view-more-btn {
            background: transparent;
            color: #E02B59;
            border: 2px solid #E02B59;
            padding: 1rem 2rem;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-block;
        }

        .view-more-btn:hover {
            background: #E02B59;
            color: white;
            transform: translateY(-3px);
        }

        /* FOOTER */
        footer {
            background: #111;
            padding: 2rem;
            margin-top: 3rem;
            border-top: 2px solid #E02B59;
        }
        
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
            color: #CCCCCC;
        }
        
        .social-icons {
            display: flex;
            gap: 1rem;
        }
        
        .social-icons a {
            color: #CCCCCC;
            font-size: 1.2rem;
            transition: all 0.3s ease;
        }
        
        .social-icons a:hover {
            color: #FFD700;
            transform: translateY(-3px);
        }
    </style>
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
                <a href="/"><i class="fas fa-home"></i> Inicio</a>
                <a href="productos"><i class="fas fa-store"></i> Catálogo</a>
                <a href="#"><i class="fas fa-spa"></i> Bienestar</a>
                <a href="#"><i class="fas fa-seedling"></i> Orgánico</a>
            </nav>

            <div class="header-actions">
                <a href="login" class="login-btn">
                    <i class="fas fa-user"></i> Ingresar
                </a>
                
                <div class="cart-icon">
                    <a href="carrito">
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
                    <a href="productos" class="secondary-button">
                        <i class="fas fa-store"></i> Ver Catálogo Completo
                    </a>
                </div>
            </div>
        </section>

        <section class="products" id="products-section">
            <h2><i class="fas fa-star"></i> Productos Destacados</h2>
            
            <div class="products-grid">
                <% if(productosDestacados.isEmpty()) { %>
                    <div style="grid-column: 1 / -1; text-align: center; padding: 3rem; background: linear-gradient(145deg, #1A1A1A 0%, #2D2D2D 100%); border-radius: 15px; color: #CCCCCC;">
                        <i class="fas fa-box-open" style="font-size: 3rem; color: #E02B59; margin-bottom: 1rem;"></i>
                        <h3>No hay productos destacados</h3>
                        <p>Pronto tendremos nuevos productos saludables para ti</p>
                    </div>
                <% } else { %>
                    <% for(Producto producto : productosDestacados) { %>
                        <div class="producto">
                            <div class="product-icon">
                                <i class="fas fa-seedling"></i>
                            </div>
                            <h3><%= producto.getNombre() %></h3>
                            <p class="description"><%= producto.getDescripcion() %></p>
                            <p class="price">$<%= String.format("%,.2f", producto.getPrecio()) %> COP</p>
                            <p class="shipping"><i class="fas fa-truck"></i> Envío gratis</p>
                            <form action="carrito/agregar" method="post" style="display: inline;">
                                <input type="hidden" name="productoId" value="<%= producto.getId() %>">
                                <input type="hidden" name="cantidad" value="1">
                                <button type="submit">
                                    <i class="fas fa-cart-plus"></i> Agregar al carrito
                                </button>
                            </form>
                            <a href="producto/<%= producto.getId() %>">
                                <i class="fas fa-eye"></i> Ver detalles
                            </a>
                        </div>
                    <% } %>
                <% } %>
            </div>

            <div class="view-more-container">
                <a href="productos" class="view-more-btn">
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
</body>
</html>