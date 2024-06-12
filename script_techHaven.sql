/* CREANDO Y USANDO LA BASE DE DATOS tiendaonline */
DROP DATABASE IF EXISTS tiendaonline;
CREATE DATABASE IF NOT EXISTS tiendaonline;
USE tiendaonline;



/* CREANDO LAS TABLAS PERTINENTES */
-- Creando la tabla "usuarios"
CREATE TABLE IF NOT EXISTS usuarios(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL,
    fecha_registro DATE NOT NULL,
    CONSTRAINT pk_usuarios PRIMARY KEY(id)
);


-- Creando la tabla "pedidos"
CREATE TABLE IF NOT EXISTS pedidos(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    id_usuario INT UNSIGNED NOT NULL,
    fecha DATE NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    CONSTRAINT pk_pedidos PRIMARY KEY(id),
    CONSTRAINT fk_pedidos_id_usuario FOREIGN KEY(id_usuario) REFERENCES usuarios(id)
);


-- Creando la tabla "productos"
CREATE TABLE IF NOT EXISTS productos(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    descripcion TEXT NOT NULL,
    CONSTRAINT pk_productos PRIMARY KEY(id)
);


-- Creando la tabla "detallespedidos"
CREATE TABLE IF NOT EXISTS detallespedidos(
    id_pedido INT UNSIGNED NOT NULL,
    id_producto INT UNSIGNED NOT NULL,
    cantidad INT NOT NULL CHECK(cantidad >= 0),
    precio_unitario DECIMAL(10, 2) NOT NULL,
    CONSTRAINT pk_detallespedidos PRIMARY KEY(id_pedido, id_producto),
    CONSTRAINT fk_detallespedidos_id_pedido FOREIGN KEY(id_pedido) REFERENCES pedidos(id),
    CONSTRAINT fk_detallespedidos_id_producto FOREIGN KEY(id_producto) REFERENCES productos(id)
);



/* INSERTANDO INFORMACIÓN A LA BASE DE DATOS EN SUS RESPECTIVAS TABLAS */
-- Insertando 12 datos a la tabla "productos"
INSERT INTO productos(nombre, precio, descripcion) VALUES
('iPhone 13', 799.99, 'Apple iPhone 13 con pantalla de 6.1 pulgadas y cámara dual.'),
('Samsung Galaxy S21', 699.99, 'Samsung Galaxy S21 con pantalla de 6.2 pulgadas y càmara triple.'),
('Sony WH-1000XM4', 349.99, 'Auriculares inalámbricos Sony con cancelación de ruido.'),
('MacBook Pro', 1299.99, 'Apple MacBook Pro con pantalla Retina de 13 pulgadas.'),
('Dell XPS 13', 999.99, 'Portátil Dell XPS 13 con pantalla de 13.3 pulgadas y procesador Intel i7.'),
('GoPro HERO9', 399.99, 'Cámara de acción GoPro HERO9 con resolución 5K.'),
('Amazon Echo Dot', 49.99, 'Altavoz inteligente Amazon Echo Dot con Alexa.'),
('Kindle Paperwhite', 129.99, 'Amazon Kindle Paperwhite con pantalla de 6 pulgadas y luz ajustable.'),
('Apple Watch Series 7', 399.99, 'Apple Watch Series 7 con GPS y pantalla Retina siempre activa.'),
('Bose QuietComfort 35 II', 299.99, 'Auriculares inalàmbricos Bose con cancelaciòn de ruido.'),
('Nintendo Switch', 299.99, 'Consola de videojuegos Nintendo Switch con controles Joy-Con.'),
('Fitbit Charge 5', 179.95, 'Monitor de actividad fìsica Fitbit Charge 5 con GPS y seguimiento del sueño.');


-- Insertando 6 datos a la tabla "usuarios"
INSERT INTO usuarios(nombre, correo_electronico, fecha_registro) VALUES
('Juan Perez', 'juan.perez@example.com', '2024-01-01'),
('Maria Lopez', 'maria.lopez@example.com', '2024-01-05'),
('Carlos Mendoza', 'carlos.mendoza@example.com', '2024-02-10'),
('Ana González', 'ana.gonzalez@example.com', '2024-02-20'),
('Luis Torres', 'luis.torres@example.com', '2024-03-05'),
('Laura Rivera', 'laura.rivera@example.com', '2024-03-15');


-- Insertando 6 datos a la tabla "pedidos"
INSERT INTO pedidos(id_usuario, fecha, total) VALUES
(1, '2024-02-25', 1049.98),
(2, '2024-03-10', 1349.98),
(3, '2024-03-20', 1249.99),
(4, '2024-03-25', 449.98),
(5, '2024-04-05', 699.99),
(6, '2024-04-10', 399.99);


-- Insertando 11 datos a la tabla "detallespedidos"
INSERT INTO detallespedidos(id_pedido, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 1, 799.99),
(1, 7, 5, 49.99),
(2, 4, 1, 1299.99),
(2, 8, 1, 129.99),
(3, 2, 1, 699.99),
(3, 9, 1, 399.99),
(4, 5, 1, 999.99),
(4, 10, 1, 299.99),
(5, 11, 1, 299.99),
(5, 3, 1, 349.99),
(6, 6, 1, 399.99);
