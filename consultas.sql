-- 2. JOIN
-- 1. Obtener la lista de todos los pedidos con los nombres de clientes usando INNER JOIN
SELECT p.id AS  pedido_id, c.nombre AS cliente, p.fecha, p.total
FROM Pedidos As p
INNER JOIN Clientes AS c ON p.cliente_id = c.id;
-- 2. Listar los productos y proveedores que los suministran con INNER JOIN .
SELECT pr.nombre AS producto, pv.nombre AS proveedor
FROM Productos AS pr
INNER JOIN Proveedores AS pv ON pr.proveedor_id = pv.id;

-- 3. Mostrar los pedidos y las ubicaciones de los clientes con LEFT JOIN .*/
SELECT p.id AS  pedido_id, c.nombre AS cliente, u.direccion, u.ciudad , u.departamento, u.codigo_postal, u.pais
FROM Pedidos AS p
LEFT JOIN Clientes AS c ON p.cliente_id = c.id
LEFT JOIN UbicacionCliente AS u ON c.id = u.cliente_id;

-- 4. Consultar los empleados que han registrado pedidos, incluyendo empleados sin pedidos ( LEFT JOIN ).
SELECT e.nombre AS empleado, p.id AS pedido_id
FROM Empleados AS e
LEFT JOIN Pedidos AS p ON e.id = p.empleado_id;

-- 5. Obtener el tipo de producto y los productos asociados con INNER JOIN .
SELECT tp.tipo_nombre AS tipo, pr.nombre AS producto
FROM Productos AS pr
INNER JOIN TiposProductosJerarquia AS tp ON pr.tipo_id = tp.id;

-- 6. Listar todos los clientes y el número de pedidos realizados con COUNT y GROUP BY .
SELECT C.nombre AS cliente, COUNT(P.id) AS pedidos_realizados
FROM Clientes AS C
LEFT JOIN Pedidos AS P ON C.id = P.cliente_id
GROUP BY C.nombre;
-- 7. Combinar Pedidos y Empleados para mostrar qué empleados gestionaron pedidos específicos.
 SELECT p.id AS pedido_id, e.nombre AS empleado 
FROM Pedidos AS p
INNER JOIN Empleados AS e ON  p.empleado_id = e.id;

-- 8. Mostrar productos que no han sido pedidos ( RIGHT JOIN ).
SELECT pr.nombre AS producto
FROM DetallesPedido AS de
RIGHT JOIN Productos AS pr ON de.producto_id = pr.id
WHERE de.producto_id IS NULL;


-- 9. Mostrar el total de pedidos y ubicación de clientes usando múltiples JOIN .
SELECT p.id AS pedido_id, c.nombre AS cliente, u.direccion, u.ciudad, u.departamento, u.codigo_postal, u.pais
FROM Pedidos AS p
INNER JOIN Clientes AS c ON p.cliente_id = c.id
INNER JOIN UbicacionCliente AS u ON c.id = u.cliente_id;

-- 10. Unir Proveedores , Productos , y TiposProductosJerarquia para un listado completo de inventario.
SELECT pv.nombre AS proveedor, pr.nombre AS producto, tp.tipo_nombre AS tipo
FROM Proveedores AS pv
INNER JOIN Productos AS pr ON pv.id = pr.proveedor_id
INNER JOIN TiposProductosJerarquia AS tp ON pr.tipo_id = tp.id;

-- 3. Consultas Simples

-- 1. Seleccionar todos los productos con precio mayor a $50. 
SELECT nombre, precio
FROM Productos
WHERE precio > 50;
-- 2. Consultar clientes registrados en una ciudad específica. 
SELECT c.nombre, u.ciudad
FROM Clientes AS c
INNER JOIN UbicacionCliente AS u ON c.id = u.cliente_id
WHERE ciudad = 'Bogota'; -- Cambiar por la ciudad deseada
-- 3. Mostrar empleados contratados en los últimos 2 años. 
SELECT nombre, fecha_contratacion
FROM Empleados
WHERE fecha_contratacion >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);
-- 4. Seleccionar proveedores que suministran más de 5 productos. 
SELECT pv.nombre, COUNT(pr.id) AS total_productos
FROM Proveedores AS pv
INNER JOIN Productos AS pr ON pv.id = pr.proveedor_id
GROUP BY pv.nombre
HAVING COUNT(pr.id) > 5;
-- 5. Listar clientes que no tienen dirección registrada en UbicacionCliente. 
SELECT c.nombre
FROM Clientes AS c
LEFT JOIN UbicacionCliente AS u ON c.id = u.cliente_id
WHERE u.cliente_id IS NULL;
-- 6. Calcular el total de ventas por cada cliente.  
SELECT c.nombre, SUM(p.total) AS total_ventas
FROM Clientes AS c
INNER JOIN Pedidos AS p ON c.id = p.cliente_id
GROUP BY c.nombre;
-- 7. Mostrar el salario promedio de los empleados. 
SELECT AVG(salario) AS salario_promedio
FROM Empleados;
-- 8. Consultar el tipo de productos disponibles en TiposProductos . 
SELECT tipo_nombre
FROM TiposProductosJerarquia;
-- 9. Seleccionar los 3 productos más caros. 
SELECT nombre, precio
FROM Productos 
ORDER BY precio DESC
LIMIT 3;
-- 10. Consultar el cliente con el mayor número de pedidos.  
SELECT c.nombre, COUNT(p.id) AS total_pedidos
FROM Clientes AS c
INNER JOIN Pedidos AS p ON c.id = p.cliente_id
GROUP BY c.nombre
ORDER BY total_pedidos DESC
LIMIT 1;

-- 4. Consultas Multitabla

-- 1. Listar todos los pedidos y el cliente asociado.
SELECT p.id AS pedido_id, c.nombre AS cliente, p.fecha, p.total
FROM Pedidos AS p
INNER JOIN Clientes AS c ON p.cliente_id = c.id;
-- 2. Mostrar la ubicación de cada cliente en sus pedidos.
SELECT p.id AS pedido_id, c.nombre AS cliente, u.direccion, u.ciudad, u.departamento, u.pais
FROM Pedidos AS p
INNER JOIN Clientes AS c ON p.cliente_id = c.id
LEFT JOIN UbicacionCliente AS u ON c.id = u.cliente_id;

-- 3. Listar productos junto con el proveedor y tipo de producto.
SELECT prod.nombre AS producto, prov.nombre AS proveedor, tipo.tipo_nombre AS categoria
FROM Productos AS prod
INNER JOIN Proveedores AS prov ON prod.proveedor_id = prov.id
INNER JOIN TiposProductosJerarquia AS tipo ON prod.tipo_id = tipo.id;
-- 4. Co nsultar todos los empleados que gestionan pedidos de clientes en una ciudad específica.
SELECT e.nombre AS empleado, p.id AS pedido_id, u.ciudad
FROM Pedidos AS p
INNER JOIN Clientes AS c ON p.cliente_id = c.id
INNER JOIN UbicacionCliente AS u ON c.id = u.cliente_id
INNER JOIN Empleados AS e ON p.empleado_id = e.id
WHERE u.ciudad = 'Bogotá';
-- 5. Consultar los 5 productos más vendidos.
SELECT prod.nombre AS producto, SUM(dp.cantidad) AS total_vendido
FROM DetallesPedido AS dp
INNER JOIN Productos AS prod ON dp.producto_id = prod.id
GROUP BY prod.id, prod.nombre
ORDER BY total_vendido DESC
LIMIT 5;
-- 6. Obtener la cantidad total de pedidos por cliente y ciudad.
SELECT c.nombre AS cliente, u.ciudad, COUNT(p.id) AS total_pedidos
FROM Clientes AS c
LEFT JOIN Pedidos AS p ON c.id = p.cliente_id
LEFT JOIN UbicacionCliente AS u ON c.id = u.cliente_id
GROUP BY c.id, u.ciudad;
-- 7. Listar clientes y proveedores en la misma ciudad.
SELECT c.nombre AS cliente, u.ciudad, prov.nombre AS proveedor
FROM Clientes AS c
INNER JOIN UbicacionCliente AS u ON c.id = u.cliente_id
INNER JOIN ContactoProveedores AS cp ON u.ciudad = cp.ciudad
INNER JOIN Proveedores AS prov ON cp.proveedor_id = prov.id;
-- 8. Mostrar el total de ventas agrupado por tipo de producto.
SELECT tipo.tipo_nombre AS categoria, SUM(dp.precio_unitario * dp.cantidad) AS total_ventas
FROM DetallesPedido AS dp
INNER JOIN Productos AS prod ON dp.producto_id = prod.id
INNER JOIN TiposProductosJerarquia AS tipo ON prod.tipo_id = tipo.id
GROUP BY tipo.id, tipo.tipo_nombre;
-- 9. Listar empleados que gestionan pedidos de productos de un proveedor específico.
SELECT e.nombre AS empleado, prov.nombre AS proveedor
FROM Pedidos AS p
INNER JOIN DetallesPedido AS dp ON p.id = dp.pedido_id
INNER JOIN Productos AS prod ON dp.producto_id = prod.id
INNER JOIN Proveedores AS prov ON prod.proveedor_id = prov.id
INNER JOIN Empleados AS e ON p.empleado_id = e.id
WHERE prov.nombre = 'Proveedor A';
-- 10. Obtener el ingreso total de cada proveedor a partir de los productos vendidos.
SELECT prov.nombre AS proveedor, SUM(dp.precio_unitario * dp.cantidad) AS total_ingreso
FROM DetallesPedido AS dp
INNER JOIN Productos AS prod ON dp.producto_id = prod.id
INNER JOIN Proveedores AS prov ON prod.proveedor_id = prov.id
GROUP BY prov.id, prov.nombre;
-- 5. Subconsultas

-- 1. Consultar el producto más caro en cada categoría.
SELECT prod.nombre AS producto, tipo.tipo_nombre AS categoria, prod.precio
FROM Productos AS prod
INNER JOIN TiposProductosJerarquia AS tipo ON prod.tipo_id = tipo.id
WHERE prod.precio = (SELECT MAX(precio) FROM Productos WHERE tipo_id = prod.tipo_id);
-- 2. Encontrar el cliente con mayor total en pedidos.
SELECT c.nombre AS cliente, SUM(p.total) AS total_gastado
FROM Clientes AS c
INNER JOIN Pedidos AS p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre
HAVING SUM(p.total) = (SELECT MAX(total_gastado) FROM (SELECT SUM(total) AS total_gastado FROM Pedidos GROUP BY cliente_id) AS sub);

-- 3. Listar empleados que ganan más que el salario promedio.
SELECT nombre, salario
FROM Empleados
WHERE salario > (SELECT AVG(salario) FROM Empleados);
-- 4. Consultar productos que han sido pedidos más de 5 veces.
SELECT nombre
FROM Productos
WHERE id IN (SELECT producto_id FROM DetallesPedido GROUP BY producto_id HAVING SUM(cantidad) > 5);
-- 5. Listar pedidos cuyo total es mayor al promedio de todos los pedidos.
SELECT id, cliente_id, total
FROM Pedidos
WHERE total > (SELECT AVG(total) FROM Pedidos);
-- 6. Seleccionar los 3 proveedores con más productos.
SELECT prov.nombre, COUNT(prod.id) AS total_productos
FROM Proveedores AS prov
INNER JOIN Productos AS prod ON prov.id = prod.proveedor_id
GROUP BY prov.id, prov.nombre
ORDER BY total_productos DESC
LIMIT 3;
-- 7. Consultar productos con precio superior al promedio en su tipo.
SELECT nombre, precio
FROM Productos AS prod
WHERE precio > (SELECT AVG(precio) FROM Productos WHERE tipo_id = prod.tipo_id);
-- 8. Mostrar clientes que han realizado más pedidos que la media.
SELECT c.nombre, COUNT(p.id) AS total_pedidos
FROM Clientes AS c
INNER JOIN Pedidos AS p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre
HAVING COUNT(p.id) > (SELECT AVG(total_pedidos) FROM (SELECT COUNT(id) AS total_pedidos FROM Pedidos GROUP BY cliente_id) AS sub);
-- 9. Encontrar productos cuyo precio es mayor que el promedio de todos los productos.
SELECT nombre, precio
FROM Productos
WHERE precio > (SELECT AVG(precio) FROM Productos);
-- 10. Mostrar empleados cuyo salario es menor al promedio del departamento
SELECT e.nombre, e.salario, p.nombre_puesto
FROM Empleados AS e
INNER JOIN Puestos AS p ON e.puesto_id = p.id
WHERE e.salario < (SELECT AVG(salario) FROM Empleados WHERE puesto_id = e.puesto_id);

-- 6. Procedimientos Almacenados
-- 1. Crear un procedimiento para actualizar el precio de todos los productos de un proveedor.
DELIMITER //
CREATE PROCEDURE ActualizarPrecioProveedor(IN proveedorID INT, IN porcentaje DECIMAL(5,2))
BEGIN
    UPDATE Productos 
    SET precio = precio * (1 + porcentaje / 100)
    WHERE proveedor_id = proveedorID;
END //
DELIMITER ;
CALL ActualizarPrecioProveedor(1, 10); -- Aumenta 10% a productos del proveedor 1.
-- 2. Un procedimiento que devuelva la dirección de un cliente por ID.
DELIMITER //
CREATE PROCEDURE ObtenerDireccionCliente(IN clienteID INT)
BEGIN
    SELECT direccion, ciudad, departamento, pais
    FROM UbicacionCliente
    WHERE cliente_id = clienteID;
END //
DELIMITER ;
CALL ObtenerDireccionCliente(2);

-- 3. Crear un procedimiento que registre un pedido nuevo y sus detalles.
DELIMITER //
CREATE PROCEDURE RegistrarPedido(
    IN clienteID INT, 
    IN total DECIMAL(10,2)
)
BEGIN
    INSERT INTO Pedidos (cliente_id, fecha, total) 
    VALUES (clienteID, CURDATE(), total);
END //
DELIMITER ;
CALL RegistrarPedido(1, 500.00);

-- 4. Un procedimiento para calcular el total de ventas de un cliente.
DELIMITER //
CREATE PROCEDURE TotalVentasCliente(IN clienteID INT)
BEGIN
    SELECT SUM(total) AS total_ventas 
    FROM Pedidos 
    WHERE cliente_id = clienteID;
END //
DELIMITER ;
CALL TotalVentasCliente(1);

-- 5. Crear un procedimiento para obtener los empleados por puesto.
DELIMITER //
CREATE PROCEDURE EmpleadosPorPuesto(IN puestoID INT)
BEGIN
    SELECT nombre, salario, fecha_contratacion
    FROM Empleados
    WHERE puesto_id = puestoID;
END //
DELIMITER ;
CALL EmpleadosPorPuesto(2);

-- 6. Un procedimiento que actualice el salario de empleados por puesto.
DELIMITER //
CREATE PROCEDURE ActualizarSalarioPorPuesto(IN puestoID INT, IN porcentaje DECIMAL(5,2))
BEGIN
    UPDATE Empleados
    SET salario = salario * (1 + porcentaje / 100)
    WHERE puesto_id = puestoID;
END //
DELIMITER ;
CALL ActualizarSalarioPorPuesto(1, 5); -- Aumenta 5% a empleados de puesto 1.

-- 7. Crear un procedimiento que liste los pedidos entre dos fechas.
DELIMITER //
CREATE PROCEDURE PedidosEntreFechas(IN fechaInicio DATE, IN fechaFin DATE)
BEGIN
    SELECT * FROM Pedidos 
    WHERE fecha BETWEEN fechaInicio AND fechaFin;
END //
DELIMITER ;
CALL PedidosEntreFechas('2025-03-01 ', '2025-03-20');

-- 8. Un procedimiento para aplicar un descuento a productos de una categoría.
DELIMITER //
CREATE PROCEDURE DescuentoPorCategoria(IN categoriaID INT, IN descuento DECIMAL(5,2))
BEGIN
    UPDATE Productos 
    SET precio = precio * (1 - descuento / 100)
    WHERE tipo_id = categoriaID;
END //
DELIMITER ;
CALL DescuentoPorCategoria(2, 15); -- Aplica 15% de descuento a la categoría 2.

-- 9. Crear un procedimiento que liste todos los proveedores de un tipo de producto.
DELIMITER //
CREATE PROCEDURE ProveedoresPorTipoProducto(IN tipoID INT)
BEGIN
    SELECT DISTINCT prov.nombre
    FROM Proveedores AS prov
    INNER JOIN Productos AS prod ON prov.id = prod.proveedor_id
    WHERE prod.tipo_id = tipoID;
END //
DELIMITER ;
CALL ProveedoresPorTipoProducto(1);

-- 10. Un procedimiento que devuelva el pedido de mayor valor.
DELIMITER //
CREATE PROCEDURE PedidoMayorValor()
BEGIN
    SELECT * FROM Pedidos 
    ORDER BY total DESC 
    LIMIT 1;
END //
DELIMITER ;
CALL PedidoMayorValor();

-- 7. Funciones Definidas por el Usuario
-- 1. Crear una función que reciba una fecha y devuelva los días transcurridos.
DELIMITER //
CREATE FUNCTION DiasTranscurridos(fecha DATE) RETURNS INT
DETERMINISTIC
BEGIN
    RETURN DATEDIFF(CURDATE(), fecha);
END //
DELIMITER ;
SELECT DiasTranscurridos('2024-01-01'); -- Devuelve cuántos días han pasado desde esa fecha.

-- 2. Crear una función para calcular el total con impuesto de un monto.
DELIMITER //
CREATE FUNCTION CalcularImpuesto(monto DECIMAL(10,2)) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN monto * 1.15; -- Aplica un 15% de impuesto.
END //
DELIMITER ;
SELECT CalcularImpuesto(100); 
-- 3. Una función que devuelva el total de pedidos de un cliente específico. revisar!
DELIMITER //
CREATE FUNCTION TotalPedidosCliente(clienteID INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(total) INTO total FROM Pedidos WHERE cliente_id = clienteID;
    RETURN IFNULL(total, 0);
END //
DELIMITER ;
SELECT TotalPedidosCliente(1);

-- 4. Crear una función para aplicar un descuento a un producto.
DELIMITER //
CREATE FUNCTION AplicarDescuento(precio DECIMAL(10,2), descuento DECIMAL(5,2)) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN precio * (1 - descuento / 100);
END //
DELIMITER ;
SELECT AplicarDescuento(100, 10); 

-- 5. Una función que indique si un cliente tiene dirección registrada.
DELIMITER //
CREATE FUNCTION ClienteTieneDireccion(clienteID INT) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE existe INT;
    SELECT COUNT(*) INTO existe FROM UbicacionCliente WHERE cliente_id = clienteID;
    RETURN existe > 0;
END //
DELIMITER ;
SELECT ClienteTieneDireccion(1);

-- 6. Crear una función que devuelva el salario anual de un empleado.
DELIMITER //
CREATE FUNCTION SalarioAnual(salario_mensual DECIMAL(10,2)) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN salario_mensual * 12;
END //
DELIMITER ;
SELECT SalarioAnual(2500);

-- 7. Una función para calcular el total de ventas de un tipo de producto.
DELIMITER //
CREATE FUNCTION TotalVentasPorTipo(tipoID INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(dp.precio_unitario * dp.cantidad) INTO total
    FROM DetallesPedido AS dp
    INNER JOIN Productos AS p ON dp.producto_id = p.id
    WHERE p.tipo_id = tipoID;
    RETURN IFNULL(total, 0);
END //
DELIMITER ;
SELECT TotalVentasPorTipo(1);

-- 8. Crear una función para devolver el nombre de un cliente por ID.
DELIMITER //
CREATE FUNCTION ObtenerNombreCliente(clienteID INT) RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE nombre VARCHAR(100);
    SELECT nombre INTO nombre FROM Clientes WHERE id = clienteID;
    RETURN nombre;
END //
DELIMITER ;
SELECT ObtenerNombreCliente(1);

-- 9. Una función que reciba el ID de un pedido y devuelva su total.  revisar!
DELIMITER //
CREATE FUNCTION TotalPedido(pedidoID INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT total INTO total FROM Pedidos WHERE id = pedidoID;
    RETURN IFNULL(total, 0);
END //
DELIMITER ;
SELECT TotalPedido(2);

-- 10. Crear una función que indique si un producto está en inventario.
DELIMITER //
CREATE FUNCTION ProductoEnInventario(productoID INT) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE existe INT;
    SELECT COUNT(*) INTO existe FROM Productos WHERE id = productoID;
    RETURN existe > 0;
END //
DELIMITER ;
SELECT ProductoEnInventario(5);

-- 8. Triggers
-- 1. Crear un trigger que registre en HistorialSalarios cada cambio de salario de empleados.
CREATE TABLE HistorialSalarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empleado_id INT,
    salario_anterior DECIMAL(10,2),
    salario_nuevo DECIMAL(10,2),
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (empleado_id) REFERENCES Empleados(id)
);

DELIMITER //
CREATE TRIGGER trg_HistorialSalarios
BEFORE UPDATE ON Empleados
FOR EACH ROW
BEGIN
    IF OLD.salario <> NEW.salario THEN
        INSERT INTO HistorialSalarios (empleado_id, salario_anterior, salario_nuevo)
        VALUES (OLD.id, OLD.salario, NEW.salario);
    END IF;
END //
DELIMITER ;

-- 2. Crear un trigger que evite borrar productos con pedidos activos.
DELIMITER //
CREATE TRIGGER trg_PrevenirBorrarProducto
BEFORE DELETE ON Productos
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM DetallesPedido WHERE producto_id = OLD.id) > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No puedes borrar un producto con pedidos activos.';
    END IF;
END //
DELIMITER ;

-- 3. Un trigger que registre en HistorialPedidos cada actualización en Pedidos .
CREATE TABLE HistorialPedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    fecha_anterior DATE,
    total_anterior DECIMAL(10,2),
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER trg_HistorialPedidos
BEFORE UPDATE ON Pedidos
FOR EACH ROW
BEGIN
    INSERT INTO HistorialPedidos (pedido_id, fecha_anterior, total_anterior)
    VALUES (OLD.id, OLD.fecha, OLD.total);
END //
DELIMITER ;

-- 4. Crear un trigger que actualice el inventario al registrar un pedido.
DELIMITER //
CREATE TRIGGER trg_ActualizarInventario
AFTER INSERT ON DetallesPedido
FOR EACH ROW
BEGIN
    UPDATE Productos
    SET stock = stock - NEW.cantidad
    WHERE id = NEW.producto_id;
END //
DELIMITER ;

-- 5. Un trigger que evite actualizaciones de precio a menos de $1.
DELIMITER //
CREATE TRIGGER trg_ValidarPrecioProducto
BEFORE UPDATE ON Productos
FOR EACH ROW
BEGIN
    IF NEW.precio < 1 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El precio del producto no puede ser menor a $1.';
    END IF;
END //
DELIMITER ;

-- 6. Crear un trigger que registre la fecha de creación de un pedido en HistorialPedidos .
DELIMITER //
CREATE TRIGGER trg_RegistrarPedidoHistorial
AFTER INSERT ON Pedidos
FOR EACH ROW
BEGIN
    INSERT INTO HistorialPedidos (pedido_id, fecha_anterior, total_anterior)
    VALUES (NEW.id, NEW.fecha, NEW.total);
END //
DELIMITER ;

-- 7. Un trigger que mantenga el precio total de cada pedido en Pedidos .
DELIMITER //
CREATE TRIGGER trg_ActualizarTotalPedido
AFTER INSERT ON DetallesPedido
FOR EACH ROW
BEGIN
    UPDATE Pedidos
    SET total = (SELECT SUM(precio_unitario * cantidad) FROM DetallesPedido WHERE pedido_id = NEW.pedido_id)
    WHERE id = NEW.pedido_id;
END //
DELIMITER ;

-- 8. Crear un trigger para validar que UbicacionCliente no esté vacío al crear un cliente.
DELIMITER //
CREATE TRIGGER trg_VerificarUbicacionCliente
AFTER INSERT ON Clientes
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM UbicacionCliente WHERE cliente_id = NEW.id) = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Todo cliente debe tener al menos una ubicación registrada.';
    END IF;
END //
DELIMITER ;

-- 9. Un trigger que registre en LogActividades cada modificación en Proveedores .
CREATE TABLE LogActividades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tabla VARCHAR(50),
    operacion VARCHAR(50),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER trg_LogProveedores
AFTER UPDATE ON Proveedores
FOR EACH ROW
BEGIN
    INSERT INTO LogActividades (tabla, operacion)
    VALUES ('Proveedores', 'Actualización');
END //
DELIMITER ;

-- 10. Crear un trigger que registre en HistorialContratos cada cambio en Empleados .
CREATE TABLE HistorialContratos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empleado_id INT,
    puesto_anterior VARCHAR(50),
    salario_anterior DECIMAL(10,2),
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER trg_HistorialContratos
BEFORE UPDATE ON Empleados
FOR EACH ROW
BEGIN
    IF OLD.puesto_id <> NEW.puesto_id OR OLD.salario <> NEW.salario THEN
        INSERT INTO HistorialContratos (empleado_id, puesto_anterior, salario_anterior)
        VALUES (OLD.id, (SELECT nombre_puesto FROM Puestos WHERE id = OLD.puesto_id), OLD.salario);
    END IF;
END //
DELIMITER ;

-- Ejercicios Combinados de Funciones y Consultas
-- Función de Descuento por Categoría de Producto
-- Objetivo: Crear una función que aplique un descuento sobre el precio de un producto si pertenece a una categoría específica. Pasos:
-- 1. Crear una función CalcularDescuento que reciba el tipo_id del producto y el precio original, y aplique un descuento del 10% si el tipo es "Electrónica".
DELIMITER //
CREATE FUNCTION CalcularDescuento(tipoID INT, precio DECIMAL(10,2)) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    IF tipoID = (SELECT id FROM TiposProductosJerarquia WHERE tipo_nombre = 'Electrónica') THEN
        RETURN precio * 0.90; -- Aplica 10% de descuento
    ELSE
        RETURN precio;
    END IF;
END //
DELIMITER ;

-- 2. Realizar una consulta para mostrar el nombre del producto, el precio original y el precio con descuento.
SELECT nombre, precio, CalcularDescuento(tipo_id, precio) AS precio_con_descuento
FROM Productos;

-- Función para Obtener la Edad de un Cliente y Filtrar Clientes Mayores de Edad
-- Objetivo: Crear una función que calcule la edad de un cliente en función de su fecha de nacimiento y luego usarla para listar solo los clientes mayores de 18 años. Pasos:
-- 1. Crear la función CalcularEdad que reciba la fecha de nacimiento y calcule la edad.
ALTER TABLE Clientes ADD COLUMN fecha_nacimiento DATE;
UPDATE Clientes 
SET fecha_nacimiento = '1990-05-10' WHERE nombre = 'Juan Pérez';

UPDATE Clientes 
SET fecha_nacimiento = '2005-08-22' WHERE nombre = 'María Gómez';

UPDATE Clientes 
SET fecha_nacimiento = '1985-11-15' WHERE nombre = 'Carlos Ruiz';

DELIMITER //
CREATE FUNCTION CalcularEdad(fecha_nacimiento DATE) RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE());
END //
DELIMITER ;

-- 2. Consultar todos los clientes y mostrar solo aquellos que sean mayores de 18 años.
-- Función de Cálculo de Impuesto y Consulta de Productos con Precio Final
SELECT nombre, fecha_nacimiento, CalcularEdad(fecha_nacimiento) AS edad
FROM Clientes
WHERE CalcularEdad(fecha_nacimiento) >= 18;


