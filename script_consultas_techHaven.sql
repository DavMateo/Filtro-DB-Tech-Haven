/* USANDO LA BASE DE DATOS "tiendaonline" */
USE tiendaonline;



-- CONSULTAS
/* CONSULTA Nº1
Obtener la lista de todos los productos con sus precio
*/
SELECT nombre, precio
    FROM productos;


/* CONSULTA Nº2
Encontrar todos los pedidos realizados por un usuario específico, por ejemplo, Juan Perez
*/
SELECT U.id, P.fecha, P.total
    FROM pedidos AS P
    INNER JOIN usuarios AS U ON P.id_usuario = U.id
    WHERE U.nombre = 'Juan Perez';


/* CONSULTA Nº3
Listar los detalles de todos los pedidos, incluyendo el nombre del producto, cantidad y precio unitario
*/
SELECT Pe.id AS PedidoID, P.nombre AS Producto, DP.cantidad, DP.precio_unitario
    FROM detallespedidos AS DP
    INNER JOIN productos AS P ON DP.id_producto = P.id
    INNER JOIN pedidos AS Pe ON DP.id_pedido = Pe.id;


/* CONSULTA Nº4
Calcular el total gastado por cada usuario en todos sus pedidos
*/
SELECT U.nombre, SUM(P.total) AS TotalGastado
    FROM pedidos AS P
    INNER JOIN usuarios AS U ON P.id_usuario = U.id
    GROUP BY P.id_usuario;


/* CONSULTA Nº5
Encontrar los productos más caros (precio mayor a $500)
*/
SELECT nombre, precio
    FROM productos
    WHERE precio > 500;


/* CONSULTA Nº6
Listar los pedidos realizados en una fecha específica, por ejemplo, 2024-03-10
*/
SELECT id, id_usuario, fecha, total
    FROM pedidos
    WHERE fecha = '2024-03-10';


/* CONSULTA Nº7
Obtener el número total de pedidos realizados por cada usuario
*/
SELECT U.nombre, COUNT(P.id_usuario) AS NumeroDePedidos
    FROM pedidos AS P
    INNER JOIN usuarios AS U ON P.id_usuario = U.id
    GROUP BY U.nombre;


/* CONSULTA Nº8
Encontrar el nombre del producto más vendido (mayor cantidad total vendida)
*/
SELECT P.nombre, DP.cantidad AS CantidadTotal
    FROM detallespedidos AS DP
    INNER JOIN productos AS P ON DP.id_producto = P.id
    ORDER BY DP.cantidad DESC
    LIMIT 1;


/* CONSULTA Nº9
Listar todos los usuarios que han realizado al menos un pedido
*/
SELECT DISTINCT U.nombre, U.correo_electronico
    FROM pedidos AS P
    RIGHT JOIN usuarios AS U ON P.id_usuario = U.id
    WHERE P.id IS NOT NULL;


/* CONSULTA Nº10
Obtener los detalles de un pedido específico, incluyendo los productos y cantidades, por ejemplo, pedido con id 1
*/
SELECT Pe.id AS PedidoID, U.nombre AS Usuario, P.nombre AS Producto, DP.cantidad, DP.precio_unitario
    FROM detallespedidos AS DP
    INNER JOIN pedidos AS Pe ON DP.id_pedido = Pe.id
    INNER JOIN usuarios AS U ON Pe.id_usuario = U.id
    INNER JOIN productos AS P ON DP.id_producto = P.id
    WHERE DP.id_pedido = 1;




-- SUBCONSULTAS
/* CONSULTA Nº1 (11)
Encontrar el nombre del usuario que ha gastado más en total
*/
SELECT U.nombre
    FROM pedidos AS P
    INNER JOIN usuarios AS U ON P.id_usuario = U.id
    ORDER BY P.total DESC
    LIMIT 1;


/* CONSULTA Nº2 (12)
Listar los productos que han sido pedidos al menos una vez
*/
SELECT DISTINCT P.nombre
    FROM detallespedidos AS DP
    RIGHT JOIN productos AS P ON DP.id_producto = P.id
    WHERE DP.id_producto IS NOT NULL;


/* CONSULTA Nº3 (13)
Obtener los detalles del pedido con el total más alto
*/
SELECT id, id_usuario, fecha, total
    FROM pedidos
    ORDER BY total DESC
    LIMIT 1;


/* CONSULTA Nº4 (14)
Listar los usuarios que han realizado más de un pedido
*/
SELECT id_usuario, COUNT(id_usuario) AS Test
    FROM pedidos
    GROUP BY id_usuario
    HAVING Test > 1;


/* CONSULTA Nº5 (15)
Encontrar el producto más caro que ha sido pedido al menos una vez
*/
SELECT P.nombre, DP.precio_unitario AS precio
    FROM detallespedidos AS DP
    INNER JOIN productos AS P ON DP.id_producto = P.id
    ORDER BY DP.precio_unitario DESC
    LIMIT 1;




-- PROCEDIMIENTOS ALMACENADOS
/* PROCEDIMIENTO Nº1 (16)
Enunciado: Crea un procedimiento almacenado llamado AgregarProducto que reciba como parámetros el nombre, descripción y precio de un nuevo producto y lo inserte en la tabla Productos.
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS AgregarProducto;
CREATE PROCEDURE AgregarProducto(
  IN nombre VARCHAR(100),
  IN precio DECIMAL(10, 2),
  IN descripcion TEXT
)
BEGIN
  INSERT INTO productos(nombre, precio, descripcion) VALUES
    (nombre, precio, descripcion);
END $$
DELIMITER ;


/* PROCEDIMIENTO Nº2 (17)
Enunciado: Crea un procedimiento almacenado llamado ObtenerDetallesPedido que reciba como parámetro el ID del pedido y devuelva los detalles del pedido, incluyendo el nombre del producto, cantidad y precio unitario.
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS ObtenerDetallesPedido;
CREATE PROCEDURE ObtenerDetallesPedido(IN idPedido INT)
BEGIN
  SELECT DP.id_pedido, U.nombre AS Usuario, Pr.nombre AS Producto, DP.cantidad, P.fecha, DP.precio_unitario, P.total
    FROM detallespedidos AS DP
    INNER JOIN pedidos AS P ON DP.id_pedido = P.id
    INNER JOIN usuarios AS U ON P.id_usuario = U.id
    INNER JOIN productos AS Pr ON DP.id_producto = Pr.id
    WHERE DP.id_pedido = idPedido;
END $$
DELIMITER ;


/* PROCEDIMIENTO Nº3
Enunciado: Crea un procedimiento almacenado llamado ActualizarPrecioProducto que reciba como parámetros el ID del producto y el nuevo precio, y actualice el precio del producto en la tabla Productos.
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS ActualizarPrecioProducto;
CREATE PROCEDURE ActualizarPrecioProducto(
  IN IdProducto INT, 
  IN nuevoPrecio DECIMAL(10, 2)
)
BEGIN
  UPDATE productos
  SET precio = nuevoPrecio
  WHERE id = IdProducto;
END $$
DELIMITER ;


/* PROCEDIMIENTO Nº4
Enunciado: Crea un procedimiento almacenado llamado EliminarProducto que reciba como parámetro el ID del producto y lo elimine de la tabla Productos.
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS EliminarProducto;
CREATE PROCEDURE EliminarProducto(IN IdProducto INT)
BEGIN
  DELETE FROM productos
  WHERE id = IdProducto;
END $$
DELIMITER ;


/* PROCEDIMIENTO Nº5
Enunciado: Crea un procedimiento almacenado llamado TotalGastadoPorUsuario que reciba como parámetro el ID del usuario y devuelva el total gastado por ese usuario en todos sus pedidos.
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS TotalGastadoPorUsuario;
CREATE PROCEDURE TotalGastadoPorUsuario(IN IdUsuario INT)
BEGIN
  SELECT U.nombre, SUM(P.total) AS TotalGastado
    FROM pedidos AS P
    INNER JOIN usuarios AS U ON P.id_usuario = U.id
    GROUP BY P.id_usuario
    HAVING U.id = IdUsuario;
END$$
DELIMITER ;
