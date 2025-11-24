-- =============================================
-- BASE DE DATOS: ECOMMERCE SALUDABLE
-- Evidencia: GA7-220501096-AA2-EV01
-- =============================================

CREATE DATABASE IF NOT EXISTS ecommercesaludable;
USE ecommercesaludable;

-- Tabla de categorías
CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    activo TINYINT(1) DEFAULT 1
);

-- Tabla de productos (RF-01)
CREATE TABLE productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    imagen VARCHAR(255),
    stock INT NOT NULL DEFAULT 0,
    id_categoria INT,
    destacado TINYINT(1) DEFAULT 0,
    activo TINYINT(1) DEFAULT 1,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- Tabla de usuarios (RF-03)
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    rol ENUM('cliente', 'admin') DEFAULT 'cliente',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ultimo_login TIMESTAMP NULL,
    activo TINYINT(1) DEFAULT 1
);

-- Tabla de pedidos (RF-06, RF-08)
CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    numero_pedido VARCHAR(20) UNIQUE NOT NULL,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('pendiente', 'confirmado', 'enviado', 'entregado', 'cancelado') DEFAULT 'pendiente',
    subtotal DECIMAL(10,2) NOT NULL,
    costo_envio DECIMAL(10,2) DEFAULT 0,
    total DECIMAL(10,2) NOT NULL,
    notas TEXT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla de detalles de pedido
CREATE TABLE detalle_pedido (
    id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Datos de prueba
INSERT INTO categorias (nombre, descripcion) VALUES
('Orgánicos', 'Productos cultivados sin pesticidas'),
('Sin Gluten', 'Ideal para personas celíacas'),
('Veganos', '100% libres de productos animales'),
('Suplementos', 'Vitaminas y minerales naturales');

INSERT INTO productos (nombre, descripcion, precio, stock, id_categoria) VALUES
('Manzana Orgánica', 'Manzana fresca cultivada orgánicamente', 2.50, 100, 1),
('Almendras Naturales', 'Almendras crudas sin sal añadida', 5.75, 50, 1),
('Pan Sin Gluten', 'Pan elaborado sin gluten', 3.20, 30, 2),
('Leche de Almendras', 'Bebida vegetal de almendras', 4.10, 40, 3);

-- Verificar tablas creadas
SHOW TABLES;