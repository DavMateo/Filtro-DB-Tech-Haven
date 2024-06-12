# Filtro Base de Datos MySQL - Tech Haven

**Realizado por**: David Mateo Carreño Diaz

**Fecha**: Miércoles, 12 de Junio del 2024

**Base de datos asignada**: Tech Haven



Las consultas se documentarán de la siguiente manera: Iniciará presentando como encabezado el tipo de consulta a realizar, luego estará especificado el enunciado donde se presentará el código SQL usado y debajo estará el resultado que dió MySQL con dicho código SQL.



## Consultas  

1. **Obtener la lista de todos los productos con sus precio**

   ~~~mysql
   SELECT nombre, precio
       FROM productos;
   ~~~

   <pre>+-------------------------+---------+
   | nombre                  | precio  |
   +-------------------------+---------+
   | iPhone 13               |  799.99 |
   | Samsung Galaxy S21      |  699.99 |
   | Sony WH-1000XM4         |  349.99 |
   | MacBook Pro             | 1299.99 |
   | Dell XPS 13             |  999.99 |
   | GoPro HERO9             |  399.99 |
   | Amazon Echo Dot         |   49.99 |
   | Kindle Paperwhite       |  129.99 |
   | Apple Watch Series 7    |  399.99 |
   | Bose QuietComfort 35 II |  299.99 |
   | Nintendo Switch         |  299.99 |
   | Fitbit Charge 5         |  179.95 |
   +-------------------------+---------+
   </pre>

   

2. **Encontrar todos los pedidos realizados por un usuario específico, por ejemplo, Juan Perez**

   ~~~mysql
   SELECT U.id, P.fecha, P.total
       FROM pedidos AS P
       INNER JOIN usuarios AS U ON P.id_usuario = U.id
       WHERE U.nombre = 'Juan Perez';
   ~~~

   <pre>+----+------------+---------+
   | id | fecha      | total   |
   +----+------------+---------+
   |  1 | 2024-02-25 | 1049.98 |
   +----+------------+---------+</pre>

   

3. **Listar los detalles de todos los pedidos, incluyendo el nombre del producto, cantidad y precio unitario**

  ~~~mysql
  SELECT Pe.id AS PedidoID, P.nombre AS Producto, DP.cantidad, DP.precio_unitario
      FROM detallespedidos AS DP
      INNER JOIN productos AS P ON DP.id_producto = P.id
      INNER JOIN pedidos AS Pe ON DP.id_pedido = Pe.id;
  ~~~

  <pre>+----------+-------------------------+----------+-----------------+
  | PedidoID | Producto                | cantidad | precio_unitario |
  +----------+-------------------------+----------+-----------------+
  |        1 | iPhone 13               |        1 |          799.99 |
  |        1 | Amazon Echo Dot         |        5 |           49.99 |
  |        2 | MacBook Pro             |        1 |         1299.99 |
  |        2 | Kindle Paperwhite       |        1 |          129.99 |
  |        3 | Samsung Galaxy S21      |        1 |          699.99 |
  |        3 | Apple Watch Series 7    |        1 |          399.99 |
  |        4 | Dell XPS 13             |        1 |          999.99 |
  |        4 | Bose QuietComfort 35 II |        1 |          299.99 |
  |        5 | Sony WH-1000XM4         |        1 |          349.99 |
  |        5 | Nintendo Switch         |        1 |          299.99 |
  |        6 | GoPro HERO9             |        1 |          399.99 |
  +----------+-------------------------+----------+-----------------+</pre>

  

4. **Calcular el total gastado por cada usuario en todos sus pedidos**

   ~~~mysql
   SELECT U.nombre, SUM(P.total) AS TotalGastado
       FROM pedidos AS P
       INNER JOIN usuarios AS U ON P.id_usuario = U.id
       GROUP BY P.id_usuario;
   ~~~

   <pre>+----------------+--------------+
   | nombre         | TotalGastado |
   +----------------+--------------+
   | Juan Perez     |      1049.98 |
   | Maria Lopez    |      1349.98 |
   | Carlos Mendoza |      1249.99 |
   | Ana González   |       449.98 |
   | Luis Torres    |       699.99 |
   | Laura Rivera   |       399.99 |
   +----------------+--------------+</pre>

   

5. **Encontrar los productos más caros (precio mayor a $500)**

   ~~~mysql
   SELECT nombre, precio
       FROM productos
       WHERE precio > 500;
   ~~~

   <pre>+--------------------+---------+
   | nombre             | precio  |
   +--------------------+---------+
   | iPhone 13          |  799.99 |
   | Samsung Galaxy S21 |  699.99 |
   | MacBook Pro        | 1299.99 |
   | Dell XPS 13        |  999.99 |
   +--------------------+---------+</pre>

   

6. **Listar los pedidos realizados en una fecha específica, por ejemplo, 2024-03-10**

   ~~~mysql
   SELECT id, id_usuario, fecha, total
       FROM pedidos
       WHERE fecha = '2024-03-10';
   ~~~

   <pre>+----+------------+------------+---------+
   | id | id_usuario | fecha      | total   |
   +----+------------+------------+---------+
   |  2 |          2 | 2024-03-10 | 1349.98 |
   +----+------------+------------+---------+</pre>

   

7. **Obtener el número total de pedidos realizados por cada usuario**

   ~~~mysql
   SELECT U.nombre, COUNT(P.id_usuario) AS NumeroDePedidos
       FROM pedidos AS P
       INNER JOIN usuarios AS U ON P.id_usuario = U.id
       GROUP BY U.nombre;
   ~~~

   <pre>+----------------+-----------------+
   | nombre         | NumeroDePedidos |
   +----------------+-----------------+
   | Juan Perez     |               1 |
   | Maria Lopez    |               1 |
   | Carlos Mendoza |               1 |
   | Ana González   |               1 |
   | Luis Torres    |               1 |
   | Laura Rivera   |               1 |
   +----------------+-----------------+</pre>

   

8. **Encontrar el nombre del producto más vendido (mayor cantidad total vendida)**

   ~~~mysql
   SELECT P.nombre, DP.cantidad AS CantidadTotal
       FROM detallespedidos AS DP
       INNER JOIN productos AS P ON DP.id_producto = P.id
       ORDER BY DP.cantidad DESC
       LIMIT 1;
   ~~~

   <pre>+-----------------+---------------+
   | nombre          | CantidadTotal |
   +-----------------+---------------+
   | Amazon Echo Dot |             5 |
   +-----------------+---------------+</pre>

   

9. **Listar todos los usuarios que han realizado al menos un pedido**

   ~~~mysql
   SELECT DISTINCT U.nombre, U.correo_electronico
       FROM pedidos AS P
       RIGHT JOIN usuarios AS U ON P.id_usuario = U.id
       WHERE P.id IS NOT NULL;
   ~~~

   <pre>+----------------+----------------------------+
   | nombre         | correo_electronico         |
   +----------------+----------------------------+
   | Juan Perez     | juan.perez@example.com     |
   | Maria Lopez    | maria.lopez@example.com    |
   | Carlos Mendoza | carlos.mendoza@example.com |
   | Ana González   | ana.gonzalez@example.com   |
   | Luis Torres    | luis.torres@example.com    |
   | Laura Rivera   | laura.rivera@example.com   |
   +----------------+----------------------------+</pre>

   

10. **Obtener los detalles de un pedido específico, incluyendo los productos y cantidades, por**
    **ejemplo, pedido con id 1**

~~~mysql
SELECT Pe.id AS PedidoID, U.nombre AS Usuario, P.nombre AS Producto, DP.cantidad, DP.precio_unitario
    FROM detallespedidos AS DP
    INNER JOIN pedidos AS Pe ON DP.id_pedido = Pe.id
    INNER JOIN usuarios AS U ON Pe.id_usuario = U.id
    INNER JOIN productos AS P ON DP.id_producto = P.id
    WHERE DP.id_pedido = 1;
~~~

<pre>+----------+------------+-----------------+----------+-----------------+
| PedidoID | Usuario    | Producto        | cantidad | precio_unitario |
+----------+------------+-----------------+----------+-----------------+
|        1 | Juan Perez | iPhone 13       |        1 |          799.99 |
|        1 | Juan Perez | Amazon Echo Dot |        5 |           49.99 |
+----------+------------+-----------------+----------+-----------------+</pre>





## Subconsultas

1. **Encontrar el nombre del usuario que ha gastado más en total**

   ~~~mysql
   SELECT U.nombre
       FROM pedidos AS P
       INNER JOIN usuarios AS U ON P.id_usuario = U.id
       ORDER BY P.total DESC
       LIMIT 1;
   ~~~

   <pre>+-------------+
   | nombre      |
   +-------------+
   | Maria Lopez |
   +-------------+</pre>

   

2. **Listar los productos que han sido pedidos al menos una vez**

   ~~~mysql
   SELECT DISTINCT P.nombre
       FROM detallespedidos AS DP
       RIGHT JOIN productos AS P ON DP.id_producto = P.id
       WHERE DP.id_producto IS NOT NULL;
   ~~~

   <pre>+-------------------------+
   | nombre                  |
   +-------------------------+
   | iPhone 13               |
   | Samsung Galaxy S21      |
   | Sony WH-1000XM4         |
   | MacBook Pro             |
   | Dell XPS 13             |
   | GoPro HERO9             |
   | Amazon Echo Dot         |
   | Kindle Paperwhite       |
   | Apple Watch Series 7    |
   | Bose QuietComfort 35 II |
   | Nintendo Switch         |
   +-------------------------+</pre>

   

3. **Obtener los detalles del pedido con el total más alto**

   ~~~mysql
   SELECT id, id_usuario, fecha, total
       FROM pedidos
       ORDER BY total DESC
       LIMIT 1;
   ~~~

   <pre>+----+------------+------------+---------+
   | id | id_usuario | fecha      | total   |
   +----+------------+------------+---------+
   |  2 |          2 | 2024-03-10 | 1349.98 |
   +----+------------+------------+---------+</pre>

   

4. **Listar los usuarios que han realizado más de un pedido**

   ~~~mysql
   SELECT id_usuario, COUNT(id_usuario) AS Test
       FROM pedidos
       GROUP BY id_usuario
       HAVING Test > 1;
   ~~~

   <pre>Empty set (0,00 sec)</pre>

   

5. **Encontrar el producto más caro que ha sido pedido al menos una vez**

   ~~~mysql
   SELECT P.nombre, DP.precio_unitario AS precio
       FROM detallespedidos AS DP
       INNER JOIN productos AS P ON DP.id_producto = P.id
       ORDER BY DP.precio_unitario DESC
       LIMIT 1;
   ~~~

   <pre>+-------------+---------+
   | nombre      | precio  |
   +-------------+---------+
   | MacBook Pro | 1299.99 |
   +-------------+---------+</pre>





## Procedimientos Almacenados

#### Crear un procedimiento almacenado para agregar un nuevo producto

**Enunciado**: Crea un procedimiento almacenado llamado AgregarProducto que reciba como
parámetros el nombre, descripción y precio de un nuevo producto y lo inserte en la tabla
Productos .

~~~mysql
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
~~~

<pre>mysql&gt; CALL AgregarProducto(&quot;Redmi Note 7&quot;, &quot;Dispositivo de 6.1 pulgadas con pantalla LED, SO Android 9 de fàbrica y 48mpx&quot;, 180.45);
Query OK, 1 row affected (0,01 sec)</pre>



#### Crear un procedimiento almacenado para obtener los detalles de un pedido

**Enunciado**: Crea un procedimiento almacenado llamado ObtenerDetallesPedido que reciba
como parámetro el ID del pedido y devuelva los detalles del pedido, incluyendo el nombre del
producto, cantidad y precio unitario.

~~~mysql
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
~~~

<pre>mysql&gt; CALL ObtenerDetallesPedido(2);
+-----------+-------------+-------------------+----------+------------+-----------------+---------+
| id_pedido | Usuario     | Producto          | cantidad | fecha      | precio_unitario | total   |
+-----------+-------------+-------------------+----------+------------+-----------------+---------+
|         2 | Maria Lopez | MacBook Pro       |        1 | 2024-03-10 |         1299.99 | 1349.98 |
|         2 | Maria Lopez | Kindle Paperwhite |        1 | 2024-03-10 |          129.99 | 1349.98 |
+-----------+-------------+-------------------+----------+------------+-----------------+---------+</pre>



#### Crea un procedimiento almacenado para actualizar el precio de un producto

**Enunciado**: Crea un procedimiento almacenado llamado ActualizarPrecioProducto que reciba
como parámetros el ID del producto y el nuevo precio, y actualice el precio del producto en la
tabla Productos.

~~~mysql
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
~~~

<pre>mysql&gt; CALL ActualizarPrecioProducto(12, 241.50);
Query OK, 1 row affected (0,00 sec)
</pre>



#### Crear un procedimiento almacenado para eliminar un producto

**Enunciado**: Crea un procedimiento almacenado llamado EliminarProducto que reciba como
parámetro el ID del producto y lo elimine de la tabla Productos .

~~~mysql
DELIMITER $$
DROP PROCEDURE IF EXISTS EliminarProducto;
CREATE PROCEDURE EliminarProducto(IN IdProducto INT)
BEGIN
  DELETE FROM productos
  WHERE id = IdProducto;
END $$  
DELIMITER ;
~~~

<pre>mysql&gt; CALL EliminarProducto(12);
Query OK, 1 row affected (0,00 sec)</pre>





#### Crear un procedimiento almacenado para obtener el total gastado por un usuario

**Enunciado**: Crea un procedimiento almacenado llamado TotalGastadoPorUsuario que reciba
como parámetro el ID del usuario y devuelva el total gastado por ese usuario en todos sus
pedidos.

~~~mysql
DELIMITER $$
DROP PROCEDURE IF EXISTS TotalGastadoPorUsuario;
CREATE PROCEDURE TotalGastadoPorUsuario(IN IdUsuario INT)
BEGIN
  SELECT U.nombre, SUM(P.total) AS TotalGastado
    FROM pedidos AS P
    INNER JOIN usuarios AS U ON P.id_usuario = U.id
    WHERE U.id = IdUsuario
    GROUP BY P.id_usuario;
END$$
DELIMITER ;
~~~

<pre>mysql&gt; CALL TotalGastadoPorUsuario(4);
+---------------+--------------+
| nombre        | TotalGastado |
+---------------+--------------+
| Ana González  |       449.98 |
+---------------+--------------+</pre>
