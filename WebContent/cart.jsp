<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ecommercesaludable.model.*" %>
<%@ page import="com.ecommercesaludable.dao.*" %>
<%@ page import="java.util.*" %>
<%
    // Simular carrito desde sesión (en producción vendría de la base de datos)
    Map<String, Object> carrito = new HashMap<>();
    
    // Ejemplo de datos del carrito - en producción esto vendría de la sesión/BD
    carrito.put("items", 3);
    carrito.put("subtotal", 267600);
    carrito.put("total", 267600);
    carrito.put("shipping", 0);
    
    // Lista de productos en el carrito
    List<Map<String, Object>> productosCarrito = new ArrayList<>();
    
    // Producto 1
    Map<String, Object> producto1 = new HashMap<>();
    producto1.put("id", "superfoods");
    producto1.put("nombre", "Pack Superfoods Orgánicos");
    producto1.put("descripcion", "Quinua, chía, maca y espirulina");
    producto1.put("precio", 89900);
    producto1.put("cantidad", 1);
    producto1.put("icono", "fa-apple-alt");
    productosCarrito.add(producto1);
    
    // Producto 2
    Map<String, Object> producto2 = new HashMap<>();
    producto2.put("id", "vitaminas");
    producto2.put("nombre", "Vitaminas Esenciales");
    producto2.put("descripcion", "Complejo vitamínico natural");
    producto2.put("precio", 65900);
    producto2.put("cantidad", 2);
    producto2.put("icono", "fa-capsules");
    productosCarrito.add(producto2);
    
    // Producto 3
    Map<String, Object> producto3 = new HashMap<>();
    producto3.put("id", "te");
    producto3.put("nombre", "Té Antioxidante Premium");
    producto3.put("descripcion", "Mezcla de hierbas orgánicas");
    producto3.put("precio", 45900);
    producto3.put("cantidad", 1);
    producto3.put("icono", "fa-mortar-pestle");
    productosCarrito.add(producto3);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrito de Compras - Ecommerce Saludable</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* ESTILOS ESPECÍFICOS PARA CARRITO */
        .cart-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }
        
        .cart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #E02B59;
        }
        
        .cart-title {
            font-size: 2.2rem;
            color: #FFFFFF;
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .cart-title i {
            color: #FFD700;
            font-size: 2.5rem;
        }
        
        .continue-shopping {
            color: #E02B59;
            text-decoration: none;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .continue-shopping:hover {
            color: #FFD700;
            transform: translateX(-5px);
        }
        
        /* CONTENIDO PRINCIPAL DEL CARRITO */
        .cart-content {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            margin-bottom: 3rem;
        }
        
        @media (max-width: 900px) {
            .cart-content {
                grid-template-columns: 1fr;
            }
        }
        
        /* LISTA DE PRODUCTOS */
        .cart-items {
            background: linear-gradient(145deg, #1A1A1A 0%, #2D2D2D 100%);
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.6);
        }
        
        .cart-item {
            display: grid;
            grid-template-columns: 100px 1fr auto;
            gap: 1.5rem;
            padding: 1.5rem 0;
            border-bottom: 1px solid #333;
            align-items: center;
        }
        
        .cart-item:last-child {
            border-bottom: none;
        }
        
        .item-image {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: white;
        }
        
        .item-details h3 {
            color: #FFFFFF;
            margin-bottom: 0.5rem;
            font-size: 1.2rem;
        }
        
        .item-details p {
            color: #CCCCCC;
            margin-bottom: 0.5rem;
        }
        
        .item-price {
            color: #FFD700;
            font-weight: 700;
            font-size: 1.2rem;
        }
        
        .item-quantity {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            margin-top: 0.8rem;
        }
        
        .quantity-btn {
            background: #333;
            border: none;
            color: white;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }
        
        .quantity-btn:hover {
            background: #E02B59;
        }
        
        .quantity-number {
            font-weight: 600;
            color: white;
            min-width: 30px;
            text-align: center;
        }
        
        .item-actions {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            align-items: center;
        }
        
        .remove-item {
            background: transparent;
            border: none;
            color: #E02B59;
            cursor: pointer;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }
        
        .remove-item:hover {
            color: #FF0000;
            transform: scale(1.2);
        }
        
        .item-total {
            font-size: 1.3rem;
            font-weight: 700;
            color: #FFD700;
        }
        
        /* RESUMEN DEL CARRITO */
        .cart-summary {
            background: linear-gradient(145deg, #1A1A1A 0%, #2D2D2D 100%);
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.6);
            height: fit-content;
            position: sticky;
            top: 2rem;
        }
        
        .summary-title {
            font-size: 1.5rem;
            color: #FFFFFF;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }
        
        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            color: #CCCCCC;
        }
        
        .summary-total {
            display: flex;
            justify-content: space-between;
            margin: 1.5rem 0;
            padding-top: 1rem;
            border-top: 2px solid #333;
            font-size: 1.3rem;
            font-weight: 700;
            color: #FFD700;
        }
        
        .coupon-section {
            margin: 1.5rem 0;
        }
        
        .coupon-input {
            display: flex;
            gap: 0.5rem;
            margin-top: 0.5rem;
        }
        
        .coupon-input input {
            flex: 1;
            background: #333;
            border: 1px solid #555;
            border-radius: 5px;
            padding: 0.8rem;
            color: white;
        }
        
        .apply-coupon {
            background: #27ae60;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 0 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .apply-coupon:hover {
            background: #2ecc71;
        }
        
        .checkout-btn {
            background: linear-gradient(135deg, #E02B59 0%, #C01A4A 100%);
            color: white;
            border: none;
            padding: 1.2rem;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.8rem;
        }
        
        .checkout-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(224, 43, 89, 0.6);
        }
        
        .secure-checkout {
            text-align: center;
            margin-top: 1rem;
            color: #27ae60;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }
        
        /* CARRITO VACÍO */
        .empty-cart {
            text-align: center;
            padding: 3rem;
            background: linear-gradient(145deg, #1A1A1A 0%, #2D2D2D 100%);
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.6);
        }
        
        .empty-cart i {
            font-size: 4rem;
            color: #E02B59;
            margin-bottom: 1.5rem;
        }
        
        .empty-cart h3 {
            font-size: 1.8rem;
            color: #FFFFFF;
            margin-bottom: 1rem;
        }
        
        .empty-cart p {
            color: #CCCCCC;
            margin-bottom: 2rem;
        }
        
        .shop-now-btn {
            background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
            color: #000;
            border: none;
            padding: 1rem 2rem;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            text-decoration: none;
        }
        
        .shop-now-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(39, 174, 96, 0.4);
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
                <a href="index.jsp"><i class="fas fa-home"></i> Inicio</a>
                <a href="catalog.jsp"><i class="fas fa-store"></i> Catálogo</a>
                <a href="#"><i class="fas fa-spa"></i> Bienestar</a>
                <a href="#"><i class="fas fa-seedling"></i> Orgánico</a>
            </nav>

            <div class="header-actions">
                <a href="dashboard.jsp" class="login-btn">
                    <i class="fas fa-user"></i> Mi Cuenta
                </a>
                
                <div class="cart-icon">
                    <a href="cart.jsp" style="color: inherit; text-decoration: none;">
                        <i class="fas fa-shopping-cart"></i>
                        <span class="cart-count"><%= carrito.get("items") %></span>
                    </a>
                </div>
            </div>
        </div>
    </header>

    <main class="cart-container">
        <div class="cart-header">
            <h2 class="cart-title"><i class="fas fa-shopping-cart"></i> Mi Carrito de Compras</h2>
            <a href="catalog.jsp" class="continue-shopping">
                <i class="fas fa-arrow-left"></i> Seguir comprando
            </a>
        </div>

        <!-- Carrito con productos -->
        <div class="cart-content" id="cart-with-items">
            <div class="cart-items">
                <%-- PRODUCTOS DINÁMICOS DEL CARRITO --%>
                <% for(Map<String, Object> producto : productosCarrito) { 
                    int totalProducto = (int)producto.get("precio") * (int)producto.get("cantidad");
                %>
                    <div class="cart-item">
                        <div class="item-image">
                            <i class="fas <%= producto.get("icono") %>"></i>
                        </div>
                        <div class="item-details">
                            <h3><%= producto.get("nombre") %></h3>
                            <p><%= producto.get("descripcion") %></p>
                            <div class="item-price">$<%= String.format("%,d", producto.get("precio")) %> COP</div>
                            <div class="item-quantity">
                                <button class="quantity-btn" onclick="updateQuantity('<%= producto.get("id") %>', -1)">-</button>
                                <span class="quantity-number" id="qty-<%= producto.get("id") %>"><%= producto.get("cantidad") %></span>
                                <button class="quantity-btn" onclick="updateQuantity('<%= producto.get("id") %>', 1)">+</button>
                            </div>
                        </div>
                        <div class="item-actions">
                            <!-- FORMULARIO PARA ELIMINAR CON MÉTODO POST -->
                            <form action="carrito" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="eliminar">
                                <input type="hidden" name="productoId" value="<%= producto.get("id") %>">
                                <button type="submit" class="remove-item">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </form>
                            <div class="item-total" id="total-<%= producto.get("id") %>">$<%= String.format("%,d", totalProducto) %></div>
                        </div>
                    </div>
                <% } %>
            </div>

            <div class="cart-summary">
                <h3 class="summary-title"><i class="fas fa-receipt"></i> Resumen de Compra</h3>
                
                <div class="summary-item">
                    <span>Subtotal</span>
                    <span id="subtotal">$<%= String.format("%,d", carrito.get("subtotal")) %></span>
                </div>
                
                <div class="summary-item">
                    <span>Envío</span>
                    <span id="shipping">$<%= carrito.get("shipping") %></span>
                </div>
                
                <div class="summary-item">
                    <span>Descuento</span>
                    <span id="discount">-$0</span>
                </div>
                
                <div class="summary-total">
                    <span>Total</span>
                    <span id="total">$<%= String.format("%,d", carrito.get("total")) %></span>
                </div>
                
                <div class="coupon-section">
                    <!-- FORMULARIO CUPÓN CON MÉTODO POST -->
                    <form action="carrito" method="post">
                        <label for="coupon">¿Tienes un cupón de descuento?</label>
                        <div class="coupon-input">
                            <input type="text" id="coupon" name="cupon" placeholder="Código de cupón">
                            <input type="hidden" name="action" value="aplicarCupon">
                            <button type="submit" class="apply-coupon">Aplicar</button>
                        </div>
                    </form>
                </div>
                
                <!-- FORMULARIO CHECKOUT CON MÉTODO POST -->
                <form action="checkout" method="post">
                    <button type="submit" class="checkout-btn">
                        <i class="fas fa-lock"></i> Proceder al Pago
                    </button>
                </form>
                
                <div class="secure-checkout">
                    <i class="fas fa-shield-alt"></i> Pago seguro garantizado
                </div>
            </div>
        </div>

        <!-- Carrito vacío (oculto inicialmente) -->
        <div class="empty-cart" id="empty-cart" style="display: none;">
            <i class="fas fa-shopping-cart"></i>
            <h3>Tu carrito está vacío</h3>
            <p>Parece que aún no has agregado productos a tu carrito.</p>
            <a href="catalog.jsp" class="shop-now-btn">
                <i class="fas fa-store"></i> Ir al Catálogo
            </a>
        </div>
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
        // Función para formatear moneda
        function formatCurrency(amount) {
            return amount.toLocaleString('es-CO');
        }
        
        // Función para proceder al pago
        function proceedToCheckout() {
            alert('¡Redirigiendo al proceso de pago!');
        }
    </script>
</body>
</html>