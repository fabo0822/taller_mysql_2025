/*1. Obtener la lista de todos los pedidos con los nombres de clientes usando INNER JOIN*/
SELECT p.id AS  pedido_id, c.nombre AS cliente, p.fecha, p.total
FROM Pedidos As p
INNER JOIN Clientes AS c ON p.cliente_id = c.id;
/*2. Listar los productos y proveedores que los suministran con INNER JOIN .*/
SELECT pr.nombre AS producto, pv.nombre AS proveedor
FROM Productos AS pr
INNER JOIN Proveedores AS pv ON pr.proveedor_id = pv.id;

/*3. Mostrar los pedidos y las ubicaciones de los clientes con LEFT JOIN .*/
SELECT p.id AS  pedido_id, c.nombre AS cliente, u.direccion, u.ciudad , u.estado, u.codigo_postal, u.pais
FROM Pedidos AS p
LEFT JOIN Clientes AS c ON p.cliente_id = c.id
LEFT JOIN UbicacionCliente AS u ON c.id = u.cliente_id;

/*4. Consultar los empleados que han registrado pedidos, incluyendo empleados sin pedidos
( LEFT JOIN ).*/
SELECT e.nombre AS empleado, p.id AS pedido_id
FROM Empleados AS e
LEFT JOIN Pedidos AS p ON e.id = p.empleado_id;

/*5. Obtener el tipo de producto y los productos asociados con INNER JOIN .*/
SELECT tp.tipo_nombre AS tipo, pr.nombre AS producto
FROM Productos AS pr
INNER JOIN TiposProductosJerarquia AS tp ON pr.tipo_id = tp.id;

/*6. Listar todos los clientes y el número de pedidos realizados con COUNT y GROUP BY .*/
SELECT C.nombre AS cliente, COUNT(P.id) AS pedidos_realizados
FROM Clientes AS C
LEFT JOIN Pedidos AS P ON C.id = P.cliente_id
GROUP BY C.nombre;
/*7. Combinar Pedidos y Empleados para mostrar qué empleados gestionaron pedidos
específicos.*/
 SELECT p.id AS pedido_id, e.nombre AS empleado 
FROM Pedidos AS p
INNER JOIN Empleados AS e ON  p.empleado_id = e.id;

/*8. Mostrar productos que no han sido pedidos ( RIGHT JOIN ).*/
SELECT pr.nombre AS producto 
FROM DetallesPedido AS de
inner JOIN Productos AS pr ON de.producto_id = pr.id
WHERE de.producto_id IS NULL;

/*9. Mostrar el total de pedidos y ubicación de clientes usando múltiples JOIN .*/
SELECT p.id AS pedido_id, c.nombre AS cliente, u.direccion, u.ciudad, u.estado, u.codigo_postal, u.pais
FROM Pedidos AS p
INNER JOIN Clientes AS c ON p.cliente_id = c.id
INNER JOIN UbicacionCliente AS u ON c.id = u.cliente_id;

/*10. Unir Proveedores , Productos , y TiposProductos para un listado completo de inventario.*/
SELECT pv.nombre AS proveedor, pr.nombre AS producto, tp.tipo_nombre AS tipo
FROM Proveedores AS pv
INNER JOIN Productos AS pr ON pv.id = pr.proveedor_id
INNER JOIN TiposProductosJerarquia AS tp ON pr.tipo_id = tp.id;

/*3. Consultas Simples*/
/*1. Seleccionar todos los productos con precio mayor a $50. */
SELECT nombre, precio
FROM Productos
WHERE precio > 50;
/*2. Consultar clientes registrados en una ciudad específica. */
SELECT c.nombre, u.ciudad
FROM Clientes AS c
INNER JOIN UbicacionCliente AS u ON c.id = u.cliente_id
WHERE ciudad = 'Bogota';
/*3. Mostrar empleados contratados en los últimos 2 años. */
SELECT nombre, fecha_contratacion
FROM Empleados
WHERE fecha_contratacion >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);
/*4. Seleccionar proveedores que suministran más de 5 productos. */
SELECT pv.nombre, COUNT(pr.id) AS total_productos
FROM Proveedores AS pv
INNER JOIN Productos AS pr ON pv.id = pr.proveedor_id
GROUP BY pv.nombre
HAVING COUNT(pr.id) > 5;
/*5. Listar clientes que no tienen dirección registrada en UbicacionCliente. */
SELECT c.nombre
FROM Clientes AS c
LEFT JOIN UbicacionCliente AS u ON c.id = u.cliente_id
WHERE u.cliente_id IS NULL;
/*6. Calcular el total de ventas por cada cliente.  */
SELECT c.nombre, SUM(p.total) AS total_ventas
FROM Clientes AS c
INNER JOIN Pedidos AS p ON c.id = p.cliente_id
GROUP BY c.nombre;
/*7. Mostrar el salario promedio de los empleados. */
SELECT AVG(salario) AS salario_promedio
FROM Empleados;
/*8. Consultar el tipo de productos disponibles en TiposProductos . */
SELECT tipo_nombre
FROM TiposProductosJerarquia;
/*9. Seleccionar los 3 productos más caros. */
SELECT nombre, precio
FROM Productos 
ORDER BY precio DESC
LIMIT 3;
/*10. Consultar el cliente con el mayor número de pedidos.  */
SELECT c.nombre, COUNT(p.id) AS total_pedidos
FROM Clientes AS c
INNER JOIN Pedidos AS p ON c.id = p.cliente_id
GROUP BY c.nombre
ORDER BY total_pedidos DESC
LIMIT 1;

--4. Consultas Multitabla
--1. Listar todos los pedidos y el cliente asociado.
SELECT p.id AS pedido_id, c.nombre AS cliente, p.fecha, p.total
FROM Pedidos AS p
INNER JOIN Clientes AS c ON p.cliente_id = c.id;
--2. Mostrar la ubicación de cada cliente en sus pedidos.
SELECT p.id AS pedido_id, c.nombre AS cliente, u.direccion, u.ciudad, u.estado, u.pais
FROM Pedidos AS p
INNER JOIN Clientes AS c ON p.cliente_id = c.id
LEFT JOIN UbicacionCliente AS u ON c.id = u.cliente_id;

--3. Listar productos junto con el proveedor y tipo de producto.
SELECT prod.nombre AS producto, prov.nombre AS proveedor, tipo.tipo_nombre AS categoria
FROM Productos AS prod
INNER JOIN Proveedores AS prov ON prod.proveedor_id = prov.id
INNER JOIN TiposProductosJerarquia AS tipo ON prod.tipo_id = tipo.id;
--4. Co nsultar todos los empleados que gestionan pedidos de clientes en una ciudad específica.
SELECT e.nombre AS empleado, p.id AS pedido_id, u.ciudad
FROM Pedidos AS p
INNER JOIN Clientes AS c ON p.cliente_id = c.id
INNER JOIN UbicacionCliente AS u ON c.id = u.cliente_id
INNER JOIN Empleados AS e ON p.empleado_id = e.id
WHERE u.ciudad = 'Bogotá';
--5. Consultar los 5 productos más vendidos.
SELECT prod.nombre AS producto, SUM(dp.cantidad) AS total_vendido
FROM DetallesPedido AS dp
INNER JOIN Productos AS prod ON dp.producto_id = prod.id
GROUP BY prod.id, prod.nombre
ORDER BY total_vendido DESC
LIMIT 5;
--6. Obtener la cantidad total de pedidos por cliente y ciudad.
SELECT c.nombre AS cliente, u.ciudad, COUNT(p.id) AS total_pedidos
FROM Clientes AS c
LEFT JOIN Pedidos AS p ON c.id = p.cliente_id
LEFT JOIN UbicacionCliente AS u ON c.id = u.cliente_id
GROUP BY c.id, u.ciudad;
--7. Listar clientes y proveedores en la misma ciudad.
SELECT c.nombre AS cliente, u.ciudad, prov.nombre AS proveedor
FROM Clientes AS c
INNER JOIN UbicacionCliente AS u ON c.id = u.cliente_id
INNER JOIN ContactoProveedores AS cp ON u.ciudad = cp.direccion
INNER JOIN Proveedores AS prov ON cp.proveedor_id = prov.id;
--8. Mostrar el total de ventas agrupado por tipo de producto.
SELECT tipo.tipo_nombre AS categoria, SUM(dp.precio_unitario * dp.cantidad) AS total_ventas
FROM DetallesPedido AS dp
INNER JOIN Productos AS prod ON dp.producto_id = prod.id
INNER JOIN TiposProductosJerarquia AS tipo ON prod.tipo_id = tipo.id
GROUP BY tipo.id, tipo.tipo_nombre;
--9. Listar empleados que gestionan pedidos de productos de un proveedor específico.
SELECT e.nombre AS empleado, prov.nombre AS proveedor
FROM Pedidos AS p
INNER JOIN DetallesPedido AS dp ON p.id = dp.pedido_id
INNER JOIN Productos AS prod ON dp.producto_id = prod.id
INNER JOIN Proveedores AS prov ON prod.proveedor_id = prov.id
INNER JOIN Empleados AS e ON p.empleado_id = e.id
WHERE prov.nombre = 'Proveedor A';
--10. Obtener el ingreso total de cada proveedor a partir de los productos vendidos.
SELECT prov.nombre AS proveedor, SUM(dp.precio_unitario * dp.cantidad) AS total_ingreso
FROM DetallesPedido AS dp
INNER JOIN Productos AS prod ON dp.producto_id = prod.id
INNER JOIN Proveedores AS prov ON prod.proveedor_id = prov.id
GROUP BY prov.id, prov.nombre;
--5. Subconsultas
--1. Consultar el producto más caro en cada categoría.
SELECT prod.nombre AS producto, tipo.tipo_nombre AS categoria, prod.precio
FROM Productos AS prod
INNER JOIN TiposProductosJerarquia AS tipo ON prod.tipo_id = tipo.id
WHERE prod.precio = (SELECT MAX(precio) FROM Productos WHERE tipo_id = prod.tipo_id);
--2. Encontrar el cliente con mayor total en pedidos.
SELECT c.nombre AS cliente, SUM(p.total) AS total_gastado
FROM Clientes AS c
INNER JOIN Pedidos AS p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre
HAVING SUM(p.total) = (SELECT MAX(total_gastado) FROM (SELECT SUM(total) AS total_gastado FROM Pedidos GROUP BY cliente_id) AS sub);

--3. Listar empleados que ganan más que el salario promedio.
SELECT nombre, salario
FROM DatosEmpleados
WHERE salario > (SELECT AVG(salario) FROM DatosEmpleados);
--4. Consultar productos que han sido pedidos más de 5 veces.
SELECT nombre
FROM Productos
WHERE id IN (SELECT producto_id FROM DetallesPedido GROUP BY producto_id HAVING SUM(cantidad) > 5);
--5. Listar pedidos cuyo total es mayor al promedio de todos los pedidos.
SELECT id, cliente_id, total
FROM Pedidos
WHERE total > (SELECT AVG(total) FROM Pedidos);
--6. Seleccionar los 3 proveedores con más productos.
SELECT prov.nombre, COUNT(prod.id) AS total_productos
FROM Proveedores AS prov
INNER JOIN Productos AS prod ON prov.id = prod.proveedor_id
GROUP BY prov.id, prov.nombre
ORDER BY total_productos DESC
LIMIT 3;
--7. Consultar productos con precio superior al promedio en su tipo.
SELECT nombre, precio
FROM Productos AS prod
WHERE precio > (SELECT AVG(precio) FROM Productos WHERE tipo_id = prod.tipo_id);
--8. Mostrar clientes que han realizado más pedidos que la media.
SELECT c.nombre, COUNT(p.id) AS total_pedidos
FROM Clientes AS c
INNER JOIN Pedidos AS p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre
HAVING COUNT(p.id) > (SELECT AVG(total_pedidos) FROM (SELECT COUNT(id) AS total_pedidos FROM Pedidos GROUP BY cliente_id) AS sub);
--9. Encontrar productos cuyo precio es mayor que el promedio de todos los productos.
SELECT nombre, precio
FROM Productos
WHERE precio > (SELECT AVG(precio) FROM Productos);
--10. Mostrar empleados cuyo salario es menor al promedio del departamento
SELECT e.nombre, e.salario, p.nombre_puesto
FROM DatosEmpleados AS e
INNER JOIN Puestos AS p ON e.puesto_id = p.id
WHERE e.salario < (SELECT AVG(salario) FROM DatosEmpleados WHERE puesto_id = e.puesto_id);
