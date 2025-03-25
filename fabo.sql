-- Creación de la base de datos
CREATE DATABASE vtaszfs;
USE vtaszfs;
-- Tabla Clientes
CREATE TABLE Clientes (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100),
email VARCHAR(100) UNIQUE
);
-- Tabla TelefonosCliente
CREATE TABLE TelefonosCliente (
id INT AUTO_INCREMENT PRIMARY KEY,
cliente_id INT,
telefono VARCHAR(20),
tipo_telefono VARCHAR(50), -- Ej: 'Personal', 'Trabajo', 'Móvil'
FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);
-- Tabla UbicacionCliente
CREATE TABLE UbicacionCliente (
id INT PRIMARY KEY AUTO_INCREMENT,
cliente_id INT,
direccion VARCHAR(100),
ciudad VARCHAR(100),
departamento VARCHAR(50),
codigo_postal VARCHAR(10),
pais VARCHAR(50),
FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);
-- Tabla Puestos
CREATE TABLE Puestos (
id INT AUTO_INCREMENT PRIMARY KEY,
nombre_puesto VARCHAR(50)
);

-- Tabla Empleados
CREATE TABLE Empleados (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100),
puesto_id INT,
puesto VARCHAR(50),
salario DECIMAL(10, 2),
fecha_contratacion DATE,
FOREIGN KEY (puesto_id) REFERENCES Puestos(id)
);
-- Tabla Proveedores
CREATE TABLE Proveedores (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100)
);
-- Tabla EmpleadosProveedores
CREATE TABLE EmpleadosProveedores (
id INT AUTO_INCREMENT PRIMARY KEY,
empleado_id INT,
proveedor_id INT,
rol VARCHAR(50), -- Ej: 'Gestor', 'Supervisor'
FOREIGN KEY (empleado_id) REFERENCES Empleados(id),
FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id)
);
-- Tabla ContactoProveedores
CREATE TABLE ContactoProveedores (
id INT AUTO_INCREMENT PRIMARY KEY,
proveedor_id INT, 
nombre_contacto VARCHAR(100),
telefono VARCHAR(20),
direccion VARCHAR(100),
ciudad VARCHAR(50),
FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id)
);

-- Tabla TiposProductos
CREATE TABLE TiposProductosJerarquia (
 id INT AUTO_INCREMENT PRIMARY KEY,
tipo_nombre VARCHAR(100),
descripcion TEXT,
tipo_padre_id INT, -- Esta columna apunta al ID del tipo padre
FOREIGN KEY (tipo_padre_id) REFERENCES TiposProductosJerarquia(id)
);
-- Tabla Productos
CREATE TABLE Productos (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100),
precio DECIMAL(10, 2),
proveedor_id INT,
tipo_id INT,
stock INT DEFAULT 10,
FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id),
FOREIGN KEY (tipo_id) REFERENCES TiposProductosJerarquia(id)
);
-- Tabla Pedidos
CREATE TABLE Pedidos (
id INT PRIMARY KEY AUTO_INCREMENT,
cliente_id INT,
empleado_id INT,
fecha DATE,
total DECIMAL(10, 2),
FOREIGN KEY (cliente_id) REFERENCES Clientes(id),
FOREIGN KEY (empleado_id) REFERENCES Empleados(id)
);
-- Tabla DetallesPedido
CREATE TABLE DetallesPedido (
id INT PRIMARY KEY AUTO_INCREMENT,
pedido_id INT,
producto_id INT,
cantidad INT,
precio_unitario DECIMAL(10, 2),
FOREIGN KEY (pedido_id) REFERENCES Pedidos(id),
FOREIGN KEY (producto_id) REFERENCES Productos(id)
);

-- Creamos la tabla HistorialPedidos para guardar los cambios en los pedidos
CREATE TABLE HistorialPedidos (
id INT AUTO_INCREMENT PRIMARY KEY,
pedido_id INT,                    
fecha_anterior DATE,            
total_anterior DECIMAL(10,2),    
 fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (pedido_id) REFERENCES Pedidos(id)
);

-- Creamos una tabla para guardar las ubicaciones
CREATE TABLE Ubicaciones (
id INT AUTO_INCREMENT PRIMARY KEY,
direccion VARCHAR(255),
ciudad VARCHAR(100),
estado VARCHAR(50),
codigo_postal VARCHAR(10),
pais VARCHAR(50)
);

-- Creamos una tabla para asociar ubicaciones con entidades (clientes, empleados, etc.)
CREATE TABLE UbicacionEntidad (
 id INT AUTO_INCREMENT PRIMARY KEY,
entidad_tipo VARCHAR(50),  -- Ej: 'Cliente', 'Empleado', 'Proveedor'
entidad_id INT,
ubicacion_id INT,
FOREIGN KEY (ubicacion_id) REFERENCES Ubicaciones(id)
);


-- Insertar Clientes
INSERT INTO Clientes (nombre, email) VALUES
('Juan Pérez', 'juan.perez@email.com'),
('María Gómez', 'maria.gomez@email.com'),
('Carlos Ruiz', 'carlos.ruiz@email.com'),
('Ana Torres', 'ana.torres@email.com'),
('Luis Fernández', 'luis.fernandez@email.com');

-- Insertar Ubicaciones de Clientes (Luis Fernández ahora está en Medellín)
INSERT INTO UbicacionCliente (cliente_id, direccion, ciudad, departamento, codigo_postal, pais) VALUES
(1, 'Calle 123', 'Bogotá', 'Cundinamarca', '110111', 'Colombia'),
(2, 'Av. Central 456', 'Medellín', 'Antioquia', '050022', 'Colombia'),
(4, 'Carrera 7 #50-20', 'Cali', 'Valle del Cauca', '760010', 'Colombia'),
(5, 'Carrera 45 #12-34', 'Medellín', 'Antioquia', '050023', 'Colombia'); -- Nueva ubicación para Luis Fernández

-- Insertar Puestos de Empleados
INSERT INTO Puestos (nombre_puesto) VALUES
('Vendedor'),
('Administrador'),
('Asistente'),
('Gerente');

-- Insertar Empleados (Corrección: Se agregó la coma que faltaba antes de 'Sofía Ramírez')
INSERT INTO Empleados (nombre, puesto_id, salario, fecha_contratacion) VALUES
('Laura Sánchez', 1, 2000.00, '2023-01-15'),
('Andrés Torres', 2, 3000.00, '2022-05-20'),
('Lucía Martínez', 3, 1800.00, '2024-02-10'),
('Pedro Ramírez', 4, 5000.00, '2021-07-05'),
('Sofía Ramírez', 3, 1900.00, '2025-04-01');

-- Insertar Proveedores
INSERT INTO Proveedores (nombre) VALUES
('Proveedor A'),
('Proveedor B'),
('Proveedor C'),
('Proveedor D');

-- Insertar Contacto de Proveedores (Proveedor B ahora está en Medellín)
INSERT INTO ContactoProveedores (proveedor_id, nombre_contacto, telefono, direccion, ciudad) VALUES
(1, 'Ana López', '3210001111', 'Cra 10 #45-30', 'Bogotá'),
(2, 'Pedro Jiménez', '3201112222', 'Av. 9 #33-21', 'Medellín'),
(3, 'Luis Fernández', '3102233445', 'Calle 5 #10-22', 'Cali'),
(4, 'Elena Ríos', '3156677889', 'Av. Libertad 100', 'Barranquilla');

-- Insertar Categorías de Productos
INSERT INTO TiposProductosJerarquia (tipo_nombre, descripcion, tipo_padre_id) VALUES
('Electrónica', 'Dispositivos electrónicos', NULL),
('Computadoras', 'Laptops y PCs', 1),
('Accesorios', 'Teclados, mouse, etc.', 1),
('Ropa', 'Prendas de vestir', NULL),
('Hombre', 'Ropa para hombre', 4),
('Mujer', 'Ropa para mujer', 4);

-- Insertar Productos 
INSERT INTO Productos (nombre, precio, proveedor_id, tipo_id, stock) VALUES
('Laptop', 2500.00, 1, 2, 15),
('Mouse', 50.00, 2, 3, 30),
('Teclado', 80.00, 2, 3, 25),
('Monitor 27"', 300.00, 3, 1, 10),
('Disco SSD 512GB', 110.00, 3, 1, 20),
('Cable HDMI', 15.00, 4, 3, 50),
('Soporte para Laptop', 25.00, 4, 3, 30),
('Lámpara LED USB', 10.00, 4, 3, 20);

-- Insertar Pedidos
INSERT INTO Pedidos (cliente_id, fecha, total, empleado_id) VALUES
(1, '2025-03-01', 2630.00, 1),
(2, '2025-03-10', 130.00, 2),
(3, '2025-03-15', 90.00, 3),
(4, '2025-03-20', 80.00, 4),
(1, '2025-03-22', 150.00, 2),
(1, '2025-03-23', 200.00, 3);

-- Insertar Detalles de Pedidos
INSERT INTO DetallesPedido (pedido_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 1, 2500.00), -- 1 Laptop
(1, 2, 6, 50.00),   -- 1 Mouse
(2, 3, 1, 80.00),   -- 1 Teclado
(3, 4, 1, 300.00),  -- 1 Monitor 27"
(3, 5, 2, 110.00),  -- 2 Discos SSD 512GB
(4, 6, 3, 15.00),   -- 3 Cables HDMI
(4, 7, 1, 25.00);   -- 1 Soporte para Laptop


