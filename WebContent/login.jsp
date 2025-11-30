<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Verificar si ya está logueado y redirigir si es necesario
    Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
    if (isLoggedIn != null && isLoggedIn) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    
    // Manejar mensajes de error o éxito
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ecommerce Saludable - Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #f5fbf8 0%, #e0f7ed 100%);
            color: #2c3e50;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            display: flex;
            flex-wrap: wrap;
            max-width: 1000px;
            width: 100%;
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeIn 0.8s ease;
        }
        
        .brand {
            flex: 1;
            min-width: 300px;
            background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
            color: white;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .brand::before {
            content: "";
            position: absolute;
            width: 150%;
            height: 150%;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 200 200'%3E%3Cpath fill='%23ffffff' fill-opacity='0.1' d='M42.7,57.1c0,0,2.8-20.3,24.3-32.3s41-5.5,50.5,9.3c9.5,14.8,6,40-10.5,50.8s-37.3,7.8-47.3-5.5S42.7,57.1,42.7,57.1z'%3E%3C/path%3E%3C/svg%3E");
            animation: float 15s infinite linear;
        }
        
        .brand h1 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            font-weight: 700;
            position: relative;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }
        
        .brand p {
            font-size: 1.1rem;
            line-height: 1.6;
            margin-bottom: 30px;
            position: relative;
            max-width: 300px;
        }
        
        .brand-img {
            width: 200px;
            height: auto;
            margin-top: 20px;
            position: relative;
            filter: drop-shadow(0 5px 10px rgba(0, 0, 0, 0.2));
        }
        
        .forms {
            flex: 1;
            min-width: 300px;
            padding: 40px;
            position: relative;
        }
        
        .form-title {
            font-size: 1.8rem;
            margin-bottom: 10px;
            color: #27ae60;
            font-weight: 600;
        }
        
        .form-subtitle {
            color: #7f8c8d;
            margin-bottom: 30px;
            font-size: 1rem;
        }
        
        .form-group {
            margin-bottom: 20px;
            position: relative;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #2c3e50;
        }
        
        .form-group input {
            width: 100%;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s;
        }
        
        .form-group input:focus {
            border-color: #2ecc71;
            outline: none;
            box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.2);
            transform: translateY(-2px);
        }
        
        .form-group i {
            position: absolute;
            right: 15px;
            top: 42px;
            color: #7f8c8d;
        }
        
        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .remember {
            display: flex;
            align-items: center;
        }
        
        .remember input {
            margin-right: 8px;
            accent-color: #2ecc71;
        }
        
        .forgot {
            color: #3498db;
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.3s;
        }
        
        .forgot:hover {
            color: #2980b9;
            text-decoration: underline;
        }
        
        .btn {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
        }
        
        .btn-primary {
            background-color: #2ecc71;
            color: white;
            box-shadow: 0 4px 10px rgba(46, 204, 113, 0.4);
        }
        
        .btn-primary:hover {
            background-color: #27ae60;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(46, 204, 113, 0.5);
        }
        
        .btn-primary:active {
            transform: translateY(0);
        }
        
        .divider {
            text-align: center;
            margin: 25px 0;
            position: relative;
        }
        
        .divider::before {
            content: "";
            position: absolute;
            left: 0;
            top: 50%;
            width: 100%;
            height: 1px;
            background: #ddd;
        }
        
        .divider span {
            background: white;
            padding: 0 15px;
            position: relative;
            color: #7f8c8d;
        }
        
        .social-login {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 25px;
        }
        
        .social-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: #f5f5f5;
            color: #444;
            font-size: 1.2rem;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
        }
        
        .social-btn:hover {
            background: #e0e0e0;
            transform: translateY(-3px);
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.15);
        }
        
        .switch-form {
            text-align: center;
            margin-top: 20px;
            color: #7f8c8d;
        }
        
        .switch-form a {
            color: #2ecc71;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
        }
        
        .switch-form a:hover {
            color: #27ae60;
            text-decoration: underline;
        }
        
        .form-container {
            display: none;
            animation: slideIn 0.5s forwards;
        }
        
        .form-container.active {
            display: block;
        }
        
        .checkbox-group {
            display: flex;
            align-items: center;
            margin: 20px 0;
        }
        
        .checkbox-group input {
            margin-right: 10px;
            accent-color: #2ecc71;
        }
        
        .password-toggle {
            cursor: pointer;
        }
        
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            border-radius: 10px;
            color: white;
            font-weight: 500;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            transform: translateX(100%);
            transition: transform 0.5s;
            z-index: 1000;
        }
        
        .notification.success {
            background: #2ecc71;
        }
        
        .notification.error {
            background: #e74c3c;
        }
        
        .notification.show {
            transform: translateX(0);
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        @keyframes slideIn {
            from { opacity: 0; transform: translateX(30px); }
            to { opacity: 1; transform: translateX(0); }
        }
        
        @keyframes float {
            0% { transform: translate(0, 0) rotate(0deg); }
            50% { transform: translate(-10px, -10px) rotate(5deg); }
            100% { transform: translate(0, 0) rotate(0deg); }
        }
        
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }
            
            .brand {
                padding: 30px 20px;
            }
            
            .forms {
                padding: 30px 20px;
            }
            
            .brand h1 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="brand">
            <h1>ECOMMERCE SALUDABLE</h1>
            <p>Tu destino para una vida saludable. Encuentra los mejores productos naturales, orgánicos y sostenibles para tu bienestar.</p>
            <svg class="brand-img" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                <circle cx="50" cy="50" r="45" fill="#27ae60" opacity="0.2" />
                <path d="M30,40 L70,40 L65,65 L35,65 Z" fill="white" />
                <circle cx="40" cy="35" r="5" fill="white" />
                <circle cx="60" cy="35" r="5" fill="white" />
                <path d="M40,50 Q50,60 60,50" stroke="white" stroke-width="2" fill="none" />
            </svg>
        </div>
        
        <div class="forms">
            <!-- Login Form -->
            <div class="form-container active" id="login-form">
                <h2 class="form-title">Ingresa a tu Cuenta</h2>
                <p class="form-subtitle">Accede para gestionar tus compras y favoritos</p>
                
                <!-- Mostrar mensajes de error/éxito del servidor -->
                <% if (error != null) { %>
                    <div class="notification error show" style="position: relative; top: 0; right: 0; transform: none; margin-bottom: 20px;">
                        <%= error %>
                    </div>
                <% } %>
                <% if (success != null) { %>
                    <div class="notification success show" style="position: relative; top: 0; right: 0; transform: none; margin-bottom: 20px;">
                        <%= success %>
                    </div>
                <% } %>
                
                <!-- FORMULARIO DE LOGIN CON MÉTODO POST -->
                <form id="login" action="login" method="post">
                    <input type="hidden" name="action" value="login">
                    
                    <div class="form-group">
                        <label for="email">Correo Electrónico</label>
                        <input type="email" id="email" name="email" placeholder="tu.correo@ejemplo.com" required>
                        <i class="fas fa-envelope"></i>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Contraseña</label>
                        <input type="password" id="password" name="password" placeholder="Ingresa tu contraseña" required>
                        <i class="fas fa-lock"></i>
                        <i class="fas fa-eye password-toggle" id="toggleLoginPassword"></i>
                    </div>
                    
                    <div class="remember-forgot">
                        <div class="remember">
                            <input type="checkbox" id="remember" name="remember">
                            <label for="remember">Recordar sesión</label>
                        </div>
                        <a href="forgot-password.jsp" class="forgot">¿Olvidaste tu contraseña?</a>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">Iniciar Sesión</button>
                </form>
                
                <div class="divider">
                    <span>Ingresa con</span>
                </div>
                
                <div class="social-login">
                    <div class="social-btn">
                        <i class="fab fa-google"></i>
                    </div>
                    <div class="social-btn">
                        <i class="fab fa-facebook-f"></i>
                    </div>
                    <div class="social-btn">
                        <i class="fab fa-apple"></i>
                    </div>
                </div>
                
                <div class="switch-form">
                    ¿No tienes cuenta? <a href="#" id="to-register">Regístrate aquí</a>
                </div>
            </div>
            
            <!-- Register Form -->
            <div class="form-container" id="register-form">
                <h2 class="form-title">Crear Cuenta</h2>
                <p class="form-subtitle">Únete a nuestra comunidad saludable</p>
                
                <!-- FORMULARIO DE REGISTRO CON MÉTODO POST -->
                <form id="register" action="login" method="post">
                    <input type="hidden" name="action" value="register">
                    
                    <div class="form-group">
                        <label for="fullname">Nombre Completo</label>
                        <input type="text" id="fullname" name="fullname" placeholder="Tu nombre completo" required>
                        <i class="fas fa-user"></i>
                    </div>
                    
                    <div class="form-group">
                        <label for="reg-email">Correo Electrónico</label>
                        <input type="email" id="reg-email" name="email" placeholder="tu.correo@ejemplo.com" required>
                        <i class="fas fa-envelope"></i>
                    </div>
                    
                    <div class="form-group">
                        <label for="reg-password">Contraseña</label>
                        <input type="password" id="reg-password" name="password" placeholder="Crea una contraseña segura" required>
                        <i class="fas fa-lock"></i>
                        <i class="fas fa-eye password-toggle" id="toggleRegPassword"></i>
                    </div>
                    
                    <div class="form-group">
                        <label for="confirm-password">Confirmar Contraseña</label>
                        <input type="password" id="confirm-password" name="confirmPassword" placeholder="Repite tu contraseña" required>
                        <i class="fas fa-lock"></i>
                        <i class="fas fa-eye password-toggle" id="toggleConfirmPassword"></i>
                    </div>
                    
                    <div class="checkbox-group">
                        <input type="checkbox" id="terms" name="terms" required>
                        <label for="terms">Acepto los términos y condiciones y la política de privacidad</label>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">Crear Cuenta</button>
                </form>
                
                <div class="switch-form">
                    ¿Ya tienes cuenta? <a href="#" id="to-login">Inicia sesión aquí</a>
                </div>
            </div>
        </div>
    </div>

    <div id="notification" class="notification"></div>

    <script>
        // Toggle between login and register forms
        document.getElementById('to-register').addEventListener('click', function(e) {
            e.preventDefault();
            document.getElementById('login-form').classList.remove('active');
            setTimeout(() => {
                document.getElementById('register-form').classList.add('active');
            }, 50);
        });
        
        document.getElementById('to-login').addEventListener('click', function(e) {
            e.preventDefault();
            document.getElementById('register-form').classList.remove('active');
            setTimeout(() => {
                document.getElementById('login-form').classList.add('active');
            }, 50);
        });
        
        // Form validation
        document.getElementById('login').addEventListener('submit', function(e) {
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            
            if (!email || !password) {
                e.preventDefault();
                showNotification('Por favor, completa todos los campos', 'error');
            }
        });
        
        document.getElementById('register').addEventListener('submit', function(e) {
            const password = document.getElementById('reg-password').value;
            const confirmPassword = document.getElementById('confirm-password').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                showNotification('Las contraseñas no coinciden', 'error');
                return;
            }
            
            if (!document.getElementById('terms').checked) {
                e.preventDefault();
                showNotification('Debes aceptar los términos y condiciones', 'error');
                return;
            }
        });
        
        // Password visibility toggles
        document.getElementById('toggleLoginPassword').addEventListener('click', function() {
            togglePasswordVisibility('password', this);
        });
        
        document.getElementById('toggleRegPassword').addEventListener('click', function() {
            togglePasswordVisibility('reg-password', this);
        });
        
        document.getElementById('toggleConfirmPassword').addEventListener('click', function() {
            togglePasswordVisibility('confirm-password', this);
        });
        
        function togglePasswordVisibility(inputId, icon) {
            const passwordInput = document.getElementById(inputId);
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }
        
        function showNotification(message, type) {
            const notification = document.getElementById('notification');
            notification.textContent = message;
            notification.className = `notification ${type} show`;
            
            setTimeout(() => {
                notification.classList.remove('show');
            }, 3000);
        }
        
        // Add subtle animation to form elements
        const formInputs = document.querySelectorAll('input');
        formInputs.forEach(input => {
            input.addEventListener('focus', () => {
                input.parentElement.classList.add('focused');
            });
            
            input.addEventListener('blur', () => {
                input.parentElement.classList.remove('focused');
            });
        });
    </script>
</body>
</html>