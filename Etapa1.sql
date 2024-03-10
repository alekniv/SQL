CREATE DATABASE LABORATORIO;

USE LABORATORIO;

CREATE TABLE Facturas (
Letra CHAR,
Numero INT,
ClienteID INT,
ArticuloID INT,
Fecha DATE,
Monto DOUBLE,
PRIMARY KEY(Letra, Numero)
);

CREATE TABLE Articulos (
ArticuloID INT PRIMARY KEY,
Nombre VARCHAR(50),
Preci DOUBLE,
Stock INT
);

CREATE TABLE CLIENTES (
ClienteID INT(20) PRIMARY KEY,
Nombre VARCHAR(25),
CUIT CHAR(16),
Direccion VARCHAR(50),
Comentarios VARCHAR(50),
);

SHOW DATABSES;

SHOW TABLES;

DESCRIBE CLIENTES;

ALTER TABLE Facturas
CHANGE ClienteID IDCliente INT(20),
CHANGE ArticuloID IDArticulo INT(10),
MODIFY Monto DOUBLE UNSIGNED;

ALTER TABLE Articulos
CHANGE ArticuloID IDArticulo,
MODIFY Nombre VARCHAR(75),
MODIFY Precio DOUBLE UNSIGNED NOT NULL,
MODIFY Stock INT UNSIGNED NOT NULL;

ALTER TABLE Clientes
CHANGE ClienteID IDCliente,
MODIFY Nombre VARCHAR(30) NOT NULL,
MODIFY Apellido VARCHAR(35) NOT NULL,
CHANGE Comentarios Observaciones VARCHAR(255);

INSERT TO Facturas
VALUES
	('A', 28, 14, 35, '2021-03-18', 1589.50),
	('A', 39, 26, 157, '2021-04-12', 979.75),
	('B', 8, 17, 95, '2021-04.25', 513.35),
	('B', 12, 5, 411, '2021-05-03', 2385.70),
	('B', 19, 50, 157, '2021-05-26', 979.75);

INSERT TO Articulos
VALUES
	(95, 'Webcam con Microfono Plug & Play', 513.35, 39),
	(157, 'Apple AirPods Pro', 979.75, 152),
	(335, 'Lavasecarropas Automatico Samsung', 1589.50, 12),
	(441, 'Gloria Trevi / Gloria / CD+DVD', 2385.70, 2);

INSERT TO Clientes
VALUES
	(5, 'Santiago', 'Gonzalez', '23-24582359-9', 'Uriburu 558-7ºA', 'VIP'),
	(14, 'Gloria', 'Fernandez', '23-35965852-5', 'Constitucion 323', 'GBA'),
	(17, 'Gonzalo', 'Lopez', '23-33587416-0', 'Arias 2624', 'GBA'),
	(26, 'Carlos', 'Garcia', '23-42321230-9', 'Pasteur 322 -  2ºC', 'GBA'),
	(50, 'Micaela', 'Altieri', '23-22885566-5', 'Santamarina 1255', 'VIP');

