# Proyecto Integrador MySQL
## Introducción

Una empresa de tecnología decide utilizar SQL para generar una base de datos en la que va a almacenar información sobre sus clientes, los artículos que comercializa y las ventas que realiza. Para ello, se generarán tablas en las cuales se almacenará la información solicitada.
Luego, se llevarán a cabo modificaciones en su estructura y se cargarán datos en ellas.

#### Acciones que se llevaran a cabo:

1. Importación de tablas desde archivos externos a la base de datos para completar la información y se harán modificaciones en las estructuras de las tablas importadas.
2. Generación de distintos tipos de consultas para obtener información específica de cada una de las tablas, utilizando distintos operadores de comparación y operadores lógicos.
3. Generar funciones sobre los datos contenidos en las tablas y consultas para actualizar y eliminar distintos registros de las tablas.

### Entorno
- Sistema operativo: Ubuntu 22.04.2

### Configuración Ubuntu Server

Conexión por SSH como root
```
$ ssh root@server_ip
```

Creación de un nuevo usuario
```
# adduser alekadmin
```

Otorgamos privilegios administrativos al usuario creado anteriormente
```
# usermod -aG sudo alekadmin
```

Configuración de firewall básico

> Las aplicaciones pueden registrar sus perfiles con UFW tras la instalación. Estos perfiles permiten a UFW administrar estas aplicaciones por su nombre. OpenSSH, el servicio que nos permite conectarnos a nuestro servidor ahora, tiene un perfil registrado con UFW.
```
# ufw app list
```
```
Output
Available applications:
  OpenSSH
```

Damos permisos de ejecución mediante SSH
```
# ufw allow OpenSSH
```

Habilitamos firewall
```
# ufw enable
```

Comprobamos estado
```
# ufw status
```

```
Output
Status: active

To                         Action      From
--                         ------      ----
OpenSSH                    ALLOW       Anywhere
OpenSSH (v6)               ALLOW       Anywhere (v6)
```

Deslogeamos y ingresamos mediante SSH con autenticación de contraseña
```
$ ssh alekadmin@server_ip
```
> Para mejorar la seguridad de sus servidores, recomendamos encarecidamente configurar claves SSH en lugar de utilizar la autenticación de contraseña.

### Instalación de MySQL

Primero actualizamos paquetes del servidor
```
$ sudo apt update
```

Luego instalamos mysql-server
```
$ sudo apt install mysql-server
```

Aseguramos que el servicio se este ejecutando mediate el siguiente comando
```
$ sudo systemctl start mysql.service
```

### Configuración de MySQL

Establecemos contraseña de root
```
mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
```

Ejecutamos script de seguridad
```
$ sudo apt mysql_secure_installation
```

Si deseamos autenticarnos como root ingresamos el siguiente comando
```
$ mysql -u root -p
```

Una vez finalizado el script, puedes volver a cambiar el método de autenticación que está disponible por defecto:
```
mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH auth_socket;
```

Creación de un nuevo usuario en MySQL

> Al instalar MySQL se crea un usuario root que dispone de todos los privilegios para el servidor MySQL. Este también tiene control total sobre cualquier base de datos, tablas y usuarios. Para mejorar el nivel de seguridad, te recomendamos crear un usuario con derechos restringidos.

Accedemos a MySQL
```
$ sudo mysql
```

Creamos el nuevo usuario
```
mysql> CREATE USER 'alekadmin'@'localhost' IDENTIFIED WITH BY 'password';
```

Administración de privilegios al nuevo usuario
```
mysql> GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT on *.* TO 'alekadmin'@'localhost' WITH GRANT OPTION;
```

Actualizamos los privilegios
```
mysql> FLUSH PRIVILEGES;
```

 




## Etapa 1.1: Crear base de datos

1. Creamos la base de datos con el nombre "LABORATORIO":
```sh
CREATE DATEBASE LABORATORIO;
```
2. Ponemos en uso la base de datos creada en el paso anterior:
```sh
USE LABORATORIO;
```

3. Creamos una tabla con el nombre FACTURAS dentro de la base de datos con la estructura que se detalla en la imagen

| FACTURAS | | |
| ------ | ------ | ------ |
| Letra | char | PK |
| Número | integer | PK |
| ClienteID | integer | |
| ArticuloID | integer |
| Fecha | date |
| Monto | double |

Comando:
```sh
CREATE TABLE Facturas (
Letra CHAR,
Número INT,
ClienteID INT,
ArticuloID INT),
Fecha DATE,
Monto  DOUBLE
PRIMARY KEY(Letra, Numero)
);
```
4. Creamos una tabla con el nombre Articulos dentro de la base de datos con la estructura que se detalla en la imagen

| ARTICULOS | | |
| ------ | ------ | ------ |
| ArticuloID | integer | PK |
| Nombre| varchar(50) | |
| Precio | double | |
| Stock | integer |

Comando:

```sh
CREATE TABLE Articulos (
ArticuloID INT PRIMARY KEY,
Nombre VARCHAR(50),
Precio DOUBLE,
Stock INT
);
```
5. Creamos una tabla con el nombre CLIENTES dentro de la base de datos con la estructura que se detalla en la imagen

| CLIENTES| | |
| ------ | ------ | ------ |
| ClienteID| integer | PK |
| Nombre | varchar(25) | |
| Apellido | varchar(25) | |
| CUIT | char(16) |
| Direccion | varchar(50) |
| Comentarios | varchar(50) |

Comando:
```sh
CREATE TABLE CLIENTES (
ClienteID INT(20) PRIMARY KEY,
Nombre VARCHAR(25),
Apellido VARCHAR(25),
CUIT CHAR(16),
Direccion VARCHAR(50),
Comentarios VARCHAR(50)
);
```
6. Mostramos un listado de todas las bases de datos alojadas en el servidor mediante el siguiente comando:
```sh
SHOW DATABASES;
```

7. Mostramos un listado de todas las tablas generadas en los pasos anteriores dentro de la base de datos con el siguiente comando:
```sh
SHOW TABLES;
```

8. Comando para describir la estructura de la tabla CLIENTES.
```sh
DESCRIBE CLIENTES;
```

## Etapa 1.2: Modificar estructuras

1. Modificaremos la tabla FACTURAS tomando en cuenta las siguientes consideraciones:
- Cambiar el nombre del campo ClienteID por IDCliente, manteniendo su tipo de dato y restricciones ya definidas.
- Cambiar el nombre del campo ArticuloID por IDArticulo, manteniendo su tipo de dato y restricciones ya definidas.
- Asignamos la restricción UNSIGNED al campo Monto, manteniendo el tipo de dato ya definido para el campo.
Comando:
```sh
ALTER TABLE Facturas
CHANGE ClienteID IDCliente INT(20),
CHANGE ArticuloID IDArticulo INT(10),
MODIFY Monto DOUBLE UNSIGNED;
```

2. Modificaremos la tabla ARTICULOS tomando en cuenta la siguientes consideraciones:
- Cambiar el nombre del campo ArticuloID por IDArticulo, manteniendo su tipo de dato y restricciones ya definidas.
- Cambiar el tipo de dato del campo Nombre para que admita hasta 75 caracteres.
- Asignar las restricciones UNSIGNED y NOT NULL al campo Precio, manteniendo el tipo de dato ya definido para el campo.
- Asignar las restricciones UNSIGNED y NOT NULL al campo Stock, manteniendo el tipo de dato ya definido para el campo.
Comando:
```sh
ALTER TABLE Articulos
CHANGE ArticuloID IDArticulo,
MODIFY Nombre VARCHAR(75),
MODIFY Precio DOUBLE UNSIGNED NOT NULL,
MODIFY Stock INT UNSIGNED NOT NULL;
```

3. Modificaremos la tabla CLIENTES. Tomar en cuentas las siguientes consideraciones:
- Cambiar el nombre del campo ClienteID por IDCliente, manteniendo su tipo de dato y restricciones ya definidas.
- Cambiar el tipo de dato del campo Nombre para que admita hasta 30 caracteres y asigne la restricción correspondiente para que su carga sea obligatoria.
- Cambiar el tipo de dato del campo Apellido para que admita hasta 35 caracteres y asigne la restricción correspondiente para qaue su carga sea obligatoria.
- Cambiar el nombre del campo Comentarios por Observaciones y su tipo de dato para que admita hasta 255 caracteres.
Comando:
```sh
ALTER TABLE Clientes
CHANGE ClienteID IDCliente,
MODIFY Nombre VARCHAR(30) NOT NULL,
MODIFY Apellido VARCHAR(35) NOT NULL,
CHANGE Comentarios Observaciones VARCHAR(255);
```

## Etapa 1.3: Insertar registros

1. Cargar 5 registros en la tabla FACTURAS, tal como se detallan en la siguiente imagen:

| Primera factura| Segunda factura | Tercera factura | Cuarta factura | Quinta factura
| ------ | ------ | ------ | ------ | ------ |                 
| Letra: A | Letra: A | Letra: B | Letra: B | Letra B |
| Numero: 28 |  Numero: 39 | Numero: 8 | Numero: 12 | Numero: 19 |
| IDCliente: 14|  IDCliente:26 | IDCliente: 17 | IDCliente: 5 | IDCliente: 50 |
| IDArticulo: 335 | IDArticulo: 157 | IDArticulo: 95 | IDArticulo: 411 | IDArticulo: 157 |
| Fecha: 2021-03-18 | Fecha: 2021-04-12 | Fecha 2021-04-25 | Fecha: 2021-05-03 | Fecha: 2021-05-26 |
| Monto: 1589.50 | Monto: 979.75 | Monto: 513.35 | Monto: 2385.70 | Monto: 979.75 |

Comando:
```sh
INSERT INTO Facturas
VALUES
    ('A', 28, 14, 35, '2021-03-18', 1589.50),
    ('A', 39, 26, 157, '2021-04-12', 979,75),
    ('B', 8, 17, 95, '2021-04-25', 513.35),
    ('B', 12, 5, 411, '2021-05-03', 2385.70),
    ('B', 19, 50, 157, '2021-05-26', 979.75);
```

2. Cargar 4 registros en la tabla Articulos tal como se detallan en la siguiente imagen:

| Primer articulo | Segundo articulo | Tercer articulo | Cuarto articulo | 
| ------ | ------ | ------ | ------ |                 
| IDArticulo: 95 | IDArticulo: 157| IDArticulo: 335| IDArticulo: 441| 
| Nombre: Webcam con Microfono Plug & Play |  Nombre: Apple AirPods Pro | Nombre: Lavasecarropas Aujtomatico Samsung | Nombre: Gloria Trevi / Gloria / CD+DVD | 
| Precio: 513.35 |  Precio: 979.75 | Precio: 1589.50 | Precio: 2385.70 | 
| Stock: 39 | Stock: 152| Stock: 12 | Stock: 2 | 

Comando:
```sh
INSERT TO Articulos
VALUES
    (95, 'Webcam con Microfono Plug & Play', 513.35, 39),
    (157, 'Apple AirPods Pro', 979.75, 152),
    (335, 'Lavasecarropas Automatico Samsung', 1589.50, 12),
    (441, 'Gloria Trevi / Gloria / CD+DVD', 2385.70, 2);
```

3. Cargar 5 registros en la tabla Clientes, tal como se detalla en la siguiente imagen:

| Primera factura| Segunda factura | Tercera factura | Cuarta factura | Quinta factura
| ------ | ------ | ------ | ------ | ------ |                 
| IDCliente: 5 | IDCliente: 14 | IDCliente: 17 | IDCliente: 26| IDCliente: 50 |
| Nombre: Santiago |  Nombre: Gloria | Nombre: Gonzalo| Nombre: Carlos | Nombre: Micaela |
| Apellido: Gonzalez|  Apellido: Fernandez | Apellido: Lopez| Apellido: Garcia | Apellido: Altieri |
| CUIT: 23-24582359-9 | CUIT: 23-35965852-5| CUIT: 23-33587416-0 | CUIT: 23-42321230-9 | CUIT: 23-22885566-5 |
| Direccion: Uriburu 558- 7ºA| Direccion: Constitucion 323| Direccion: Arias 2624| Direccion: Pasteur 322 - 2ºC| Direccion: Santamarina 1255 |
| Comentarios: VIP| Comentarios: GBA | Comentarios: GBA| Comentarios: GBA | Comentarios: VIP | Comentarios: GBA |

Comando:
```sh
INSERT TO Clientes
VALUES
    (5, 'Santiago', 'Gonzalez', '23-24582359-9', 'Uriburu 558- 7ºA', 'VIP'),
    (14, 'Gloria', 'Fernandez', '23-35965852-5', 'Constitucion 323', 'GBA'),
    (17, 'Gonzalo', 'Lopez', '23-33587416-0', 'Arias 2624', 'GBA'),
    (26, 'Carlos', 'Garcia', '23-42321230-9', 'Pasteur 322 - 2ºC', 'GBA'),
    (50, 'Micaela', 'Altieri', '23-22885566-5', 'Santamarina 1255', 'VIP');
```

## Etapa 2.1: Importar tablas externas

1. Importamos el achivo CSV con el nombre CLIENTES_NEPTUNO a la base de datos con el nombre LABORATORIO. Y tener en cuenta las siguientes indicaciones:
A. No cambiar el nombre de la tabla.
B. Eliminar la tabla en el caso de que ya exista dentro de la base de datos.
C. Mantener los tipos de datos asignados al momento de la importación.

```
$ mysqlimport -u alekadmin -p --local --delete --ignore-lines=1 LABORATORIO CLIENTES_NEPTUNO.csv
```

3. Llevar a cabo los siguientes cambios en la tabla CLIENTES_NEPTUNO importada anteriormente. Respetar las consignas detalladas a continuación y utilizar el comando ALTER TABLE:
A. Campo IDCliente: debe ser de tipo VARCHAR, debe admitir hasta 5 caracteres como máximo y debe ser el campo PRIMARY KEY de la tabla.
B. Campo NombreCompania: debe ser de tipo VARCHAR, debe admitir hasta 100 caracteres como máximo y no puede quedar vacío.
C. Campo Pais: debe ser de tipo VARCHAR, debe admitir hasta 15 carateres como máximo y no puede quedar vacio.

Comando:
```sh
ALTER TABLE clientes_neptuno 
    MODIFY IDCliente VARCHAR(5) PRIMARY KEY,
    MODIFY NombreCompania VARCHAR (100) NOT NULL,
    MODIFY Pais VARCHAR(15) NOT NULL;
```

3. Cambiar el nombre de la tabla CLIENTES por CONTACTOS.

Comando:
```sh
ALTER TABLE CLIENTES RENAME Contactos;
```

4. Importar el archivo CSV con el nombre CLIENTES a la base de datos LABORATORIO. Y tener en cuenta las siguientes indicaciones:
A. No cambiar el nombre de la tabla
B. Mantener los tipos de datos asignados al momento de la importación.
```
$ mysqlimport -u alekadmin -p --local --delete --ignore-lines=1 LABORATORIO CLIENTES.csv
```


6. Llevar a cabo los siguientes cambios en la tabla CLIENTES importada anteriormente. Respetar las consignas detalladas a continuación:
A. Campo Cod_Cliente: debe ser de tipo VARCHAR, debe admitir hasta 7 carateres como máximo y debe ser el campo PRIMARY KEY de la tabla.
B. Campo Empresa: debe ser de tipo VARCHAR, debe admitir hasta 100 caracteres como máximo y no puede quedar vacío.
C. Campo Ciudad: debe ser de tipo VARCHAR, debe admitir hasta 25 caracteres como máximo y no puede quedar vacío.
D. Campo Telefono: debe ser de tipo INT y no debe admitir valores númericos negativos.
E. Campo Responsable: debe ser de tipo VARCHAR y debe admitir como máximo hasta 30 caracteres.

Comando:
```sh
ALTER TABLE clientes
MODIFY Cod_Cliente VARCHAR(7) PRIMARY KEY,
MODIFY Empresa VARCHAR(100) NOT NULL,
MODIFY Ciudad VARCHAR(25) NOT NULL,
MODIFY Telefono INT NOT NULL,
MODIFY Responsable VARCHAR(30);
```

6. Importar el archivo CSV con el nombre PEDIDOS a la base de datos LABORATORIO. Y tener en cuenta las siguientes indicaciones:
A. No cambiar el nombre de la tabla.
B. Mantener los tipos de datos asignados al momento de la importación.
```
$ mysqlimport -u alekadmin -p --local --delete --ignore-lines=1 LABORATORIO Pedidos.csv
```

8. Llevar a cabo los siguientes cambios en la tabla PEDIDOS importada anteriormente. Respetar las consignas detalladas a continuación:
A. Campo Numero_Pedido: debe ser de tipo INT, sólo debe aceptar valores numéricos enteros y debe ser el campo PRIMARY KEY de la tabla.
B. Campo Codigo_Cliente: debe ser de tipo VARCHAR, debe admitir hasta 7 caracteres como máximo y no puede quedar vacío.
C. Campo Fecha_Pedido: debe ser de tipo DATE y su carga es obligatorio.
D. Campo Forma_Pago: sólo debe admitir la carga de los valores APLAZADO, CONTADO o TARJETA.
E. Campo Enviado: sólo debe admitir la carga de los valores SI o NO.

Comando:
```sh
ALTER TABLE Pedidos
MODIFY Numero_Pedido INT PRIMARY KEY,
MODIFY Codigo_Cliente VARCHAR(7) NOT NULL,
MODIFY Fecha_Pedido DATE NOT NULL,
MODIFY Forma_Pago ENUM('APLAZADO', 'CONTADO', 'TARJETA'),
MODIFY Enviado ENUM('SI', 'NO');
```

8. Importar el achivo CSV: PRODUCTOS a la base de datos LABORATORIO. Y tener en cuenta las siguientes indicaciones:
A. No cambiar el nombre de la tabla.
B. Mantener los tipos de datos asignados al momento de la importación.
```
$ mysqlimport -u alekadmin -p --local --delete --ignore-lines=1 Productos.csv
```

10. Llevar a cabo los siguientes cambios en la tabla PRODUCTOS importada en el paso anterior. Respetar las consignas detalladas a continuación, utilizando el comando ALTER TABLE:
A. Campo Cod_Producto: debe ser de tipo INT, sólo debe aceptar valores numéricos enteros y debe ser el campo PRIMARY KEY de la tabla.
B. Campo Sección: debe ser de tipo VARCHAR, debe admitir hastas 20 caracteres como máximo y no puede quedar vacío.
C. Campo Nombre: debe ser de tipo VARCHAR, debe admitir hasta 40 carateres como máximo y no puede quedar vacío.
D. Campo Importado: sólo debe admitir la carga de los valores VERDADERO O FALSO.
E. Campo Origen: debe ser de tipo VARCHAR, admitir hasta 25 caracteres y ser de carga obligatoria.
F. Campos Dia.Mes y Año: deben ser de tipo INT, positivos y de carga obligatoria.

Comando:
```sh
ALTER TABLE Productos
MODIFY Cod_Producto INT PRIMARY KEY,
MODIFY Seccion VARCHAR(20) NOT NULL,
MODIFY Nombre VARCHAR(40) NOT NULL,
MODIFY Importado ENUM('VERDADERO', 'FALSO'),
MODIFY Origen VARCHAR(25) NOT NULL,
MODIFY Dia INT UNSIGNED NOT NULL,
MODIFY Mes INT UNSIGNED NOT NULL,
MODIFY Ano INT UNSIGNED NOT NULL;
```

## Etapa 2.2: Generar tablas desde scripts

1. Abrir el archivo con formato SQL con el nombre NACIMIENTOS desde MySQL.
2. Ejectuar el código.
3. Actualizar los esquemas para corroborar la generación de la tabla NACIMIENTOS dentro de la base de datos LABORATORIO.
4. Abrir el archivo con formato SQL con el nombre PEDIDOS_NEPTUNO desde MySQL.
5. Ejectuar el código.
6. Abrir el archivo con formato SQL con el nombre TABLA_EXTRAS desde MySQL.
7. Ejecutar el código.
8. Actualizar los esquemas para corroborar la generación de la tabla PEDIDOS_NEPTUNO dentro de la base de datos LABORATORIO.
9. Cerrar los scripts con los nombre NACIMIENTOS, PEDIDOS NEPTUNO Y TABLAS EXTRAS.

```
mysql> source /home/alekadmin/Nacimientos.sql
mysql> source /home/alekadmin/Pedidos_Neptuno.sql
mysql> source /home/alekadmin/Tablas_Extras.sql
```

```
SHOW TABLES;
DESCRIBE NACIMIENTOS;
DESCRIBE Pedidos_Neptuno;
DESCRIBE Tablas_Extras;
```


## Etapa 2.3: Consultar tablas

1. Mostrar todo el contenido de la tabla CLIENTES_NEPTUNO importada en el laboratorio anterior.
Comando:
```sh
SELECT * FROM clientes_neptuno;
```

2. Mostrar todos los registros de la tabla CLIENTES_NEPTUNO. En el resultado de la consulta sólo se deben observar las columnas NOMBRECOMPANIA, CIUDAD y PAIS.
Comando:
```sh
SELECT nombrecompania, ciudad, pais 
FROM clientes_neptuno;
```

3. Mostrar todos los registros de la tabla CLIENTES_NEPTUNO. En el resultado de la consulta sólo se deben observar las columnas NOMBRECOMPANIA, CIUDAD y PAIS. Luego, ordenar alfabéticamente en el resultado de la consulta por los nombres de los países.
Comando:
```sh
SELECT nombrecompania, ciudad, pais 
FROM clientes_neptuno 
ORDER BY pais;
```

4. Mostrar todos los registros de la tabla CLIENTES_NEPTUNO. En el resultado de la consulta sólo se deben observar las columnas NOMBRECOMPANIA, CIUDAD, y PAIS. Ordenar el resultado de la consulta alfabéticamente por los nombres de los paises. Para aquellos países que se repiten, ordenar las ciudades alfabéticamente.
Comando:
```sh
SELECT nombrecompania, ciudad, pais 
FROM clientes_neptuno 
ORDER BY pais, ciudad;
```
5. Mostrar todos los registros de la tabla CLIENTES_NEPTUNO. En el resultado de la consulta sólo se deben observar las columnas NOMBRECOMPANIA, CIUDAD y PAIS. Ordenar de manera alfabética el resultado de la consulta, por los nombres de los paises. Mostrar únicamente los 10 primeros clientes.
Comando:
```sh
SELECT NOMBRECOMPANIA, CIUDAD, PAIS
FROM clientes_neptuno
ORDER BY PAIS
LIMIT 10;
```

6. Mostra todos los registros de la tabla CLIENTES_NEPTUNO. En el resultado de la consulta sólo se deben observar las columnas NOMBRECOMPANI, CIUDAD y PAIS. Ordenar de manera alfabética el resultado de la consulta, por los nombres de los países. Mostrar únicamente los clientes ubicados desde la posición 11 hasta la 15.
Comando:
```sh
SELECT NOMBRECOMPANI, CIUDAD PAIS
FROM clientes_neptuno
ORDER BY PAIS
LIMIT 5 OFFSET 10;
```

## Etapa 2.4: Predicado de consultas

1. De la tabla NACIMIENTOS, obtener una lista de todos aquellos bebés nacidos de madres extranjeras. Mostrar todos los campos de la tabla en el resultado de la consulta.
Comando:
```sh
SELECT * FROM NACIMIENTOS WHERE NACIONALIDAD = 'Extranjera';
```

2. De la tabla NACIMIENTOS, obtener una lista de todos aquellos bebés nacidos de madres menores de edad. Mostrar todos los campos de la tabla en el resultado de la consulta y ordenar el resultado de menor a mayor por la edad de las madres.
Comando:
```sh
SELECT * FROM NACIMIENTOS WHERE EDAD_MADRE < 18 ORDER BY EDAD_MADRE;
```

3. De la tabla NACIMIENTOS, obtener una lista de todos aquellos bebés nacidos de madres que tengan la misma edad que el padre. Mostrar todos los campos de la tabla en el resultado de la consulta.
Comando:
```sh
SELECT * FROM NACIMIENTOS WHERE EDAD_MADRE = EDAD_PADRE;
```

4. De la tabla NACIMIENTOS, obtener una lista de todos aquellos bebés nacidos de madres que, con respecto al padre, tengan 40 años o menos que el padre.
Comando:
```sh
SELECT EDAD_MADRE, EDAD_PADRE FROM NACIMIENTOS WHERE EDAD_MADRE <= EDAD_PADRE -40;
```

5. De la tabla CLIENTES_NEPTUNO, obtener una lista de todos aquellos clientes que residen en Argentina. Mostrar todos los campos de la tabla en el resultado de la consulta.
Comando:
```sh
SELECT * FROM CLIENTES_NEPTUNO WHERE CLIENTES = 'Argentina';
```

6. De la tabla CLIENTES_NEPTUNO, obtener una lista de todos los clientes, con excepción de los que residen en Argentina. Mostrar todos los campos de la tabla en el resultado de la consulta y ordenar alfabéticamente dicho resultado por los nombres de los países.
Comando:
```sh
SELECT * FROM CLIENTES_NEPTUNO WHERE PAIS != 'Argentina' ORDER BY PAIS;
```

7. De la tabla NACIMIENTOS, obtener una lista de todos aquellos bebés que nacieron con menos de 20 semanas de gestación. Mostrar todos los campos de la tabla en el resultado de la consulta y ordenar dicho resultado de mayor a menor, por los valores de la columna SEMANAS.
Comando:
```sh
SELECT * FROM NACIMIENTOS WHERE SEMANAS < 20 ORDER BY SEMANAS DESC;
```
8. De la tabla NACIMIENTOS, obtener una lista de todos los bebés de sexo femenino, nacidos de madres extranjeras solteras, de más de 40 años. Mostrar todos los campos de la tabla en el resultado de la consulta.
Comando:
```sh
SELECT * FROM NACIMIENTOS
WHERE SEXO = 'FEMENINO' AND NACIONALIDAD = 'EXTRANJERA' AND ESTADO_CIVIL_MADRE = 'SOLTERA' AND EDAD_MADRE > 40;
```

9. De la tabla CLIENTES_NEPTUNO, obtener una lista de todos aquellos clientes que residan en países sudamericanos.
Mostrar todos los campos de la tabla en el resultado de la consulta y ordenar de manera alfabética los registros, por lo nombres de los países y las ciudades.

> Los países sudamericanos que figuran en esta tabla son Argentina, Brasil y Venezuela.

Comando:
```sh
SELECT * FROM CLIENTES_NEPTUNO
WHERE PAIS IN ('ARGENTINA', 'BRASIL', 'VENEZUELA')
ORDER BY PAIS CIUDAD;
```

10. De la tabla NACMIENTOS, obtener una lista de todos aquellos bebés que hayan nacido con una cantidad de semanas de gestación de entre 20 y 25 semanas, inclusive. Mostrar todos los campos de la tabla en el resultado de la consulta y ordenar el resultado según las semanas de gestación de los recién nacidos, de menor a mayor.
Comando:
```sh
SELECT * FROM NACIMIENTOS
WHERE SEMANAS BETWEEN 20 AND 25
ORDER BY SEMANAS;
```
11. De la tabla NACIMIENTOS, obtener una lista de todos los bebés que nacieron en las comunas 1101, 3201, 5605, 8108, 9204, 13120 y 15202. Mostrar todos los campos de la tabla en el resultado de la consulta y ordenar de menor a mayor los registros, por los números de comuna.
Comando.
```sh
SELECT * FROM NACIMIENTOS
WHERE COMUNA IN (1101, '3201, 5605, 8108, 9204, 13120, 15202)
ORDER BY COMUNA;
```

12. De la tabla CLIENTES_NEPTUNO, obtener una lista de todos aquellos clientes cuyo ID comience con la letra C. Mostrar todos los campos de la tabla, en el resultado de la consulta.
Comando:
```sh
SELECT * FROM CLIENTES_NEPTUNO WHERE IDCliente LIKE 'C%';
```

13. De la tabla CLIENTES_NEPTUNO, obtener una lista de todos aquellos clientes que residan en una ciudad que comience con la letra B y en total posea 5 carateres. Mostrar todos los campos de la tabla en el resultado de la consulta
Comando:
```sh
SELECT *FROM CLIENTES_NEPTUNO
WHERE Ciudad LIKE 'B____';
```

14. De la tabla NACIMIENTOS, obtener una lista de todos aquellos padres que tengan más de 10 hijos.
Comando:
```sh
SELECT * FROM NACIMIENTOS WHERE HIJOS_TOTAL > 10;
```

## Etapa 3.1: Respaldar Base de Datos




Dillinger is a cloud-enabled, mobile-ready, offline-storage compatible,
AngularJS-powered HTML5 Markdown editor.

- Type some Markdown on the left
- See HTML in the right
- ✨Magic ✨

## Features

- Import a HTML file and watch it magically convert to Markdown
- Drag and drop images (requires your Dropbox account be linked)
- Import and save files from GitHub, Dropbox, Google Drive and One Drive
- Drag and drop markdown and HTML files into Dillinger
- Export documents as Markdown, HTML and PDF

Markdown is a lightweight markup language based on the formatting conventions
that people naturally use in email.
As [John Gruber] writes on the [Markdown site][df1]

> The overriding design goal for Markdown's
> formatting syntax is to make it as readable
> as possible. The idea is that a
> Markdown-formatted document should be
> publishable as-is, as plain text, without
> looking like it's been marked up with tags
> or formatting instructions.

This text you see here is *actually- written in Markdown! To get a feel
for Markdown's syntax, type some text into the left window and
watch the results in the right.

## Tech

Dillinger uses a number of open source projects to work properly:

- [AngularJS] - HTML enhanced for web apps!
- [Ace Editor] - awesome web-based text editor
- [markdown-it] - Markdown parser done right. Fast and easy to extend.
- [Twitter Bootstrap] - great UI boilerplate for modern web apps
- [node.js] - evented I/O for the backend
- [Express] - fast node.js network app framework [@tjholowaychuk]
- [Gulp] - the streaming build system
- [Breakdance](https://breakdance.github.io/breakdance/) - HTML
to Markdown converter
- [jQuery] - duh

And of course Dillinger itself is open source with a [public repository][dill]
 on GitHub.

## Installation

Dillinger requires [Node.js](https://nodejs.org/) v10+ to run.

Install the dependencies and devDependencies and start the server.

```sh
cd dillinger
npm i
node app
```

For production environments...

```sh
npm install --production
NODE_ENV=production node app
```

## Plugins

Dillinger is currently extended with the following plugins.
Instructions on how to use them in your own application are linked below.

| Plugin | README |
| ------ | ------ |
| Dropbox | [plugins/dropbox/README.md][PlDb] |
| GitHub | [plugins/github/README.md][PlGh] |
| Google Drive | [plugins/googledrive/README.md][PlGd] |
| OneDrive | [plugins/onedrive/README.md][PlOd] |
| Medium | [plugins/medium/README.md][PlMe] |
| Google Analytics | [plugins/googleanalytics/README.md][PlGa] |

## Development

Want to contribute? Great!

Dillinger uses Gulp + Webpack for fast developing.
Make a change in your file and instantaneously see your updates!

Open your favorite Terminal and run these commands.

First Tab:

```sh
node app
```

Second Tab:

```sh
gulp watch
```

(optional) Third:

```sh
karma test
```

#### Building for source

For production release:

```sh
gulp build --prod
```

Generating pre-built zip archives for distribution:

```sh
gulp build dist --prod
```

## Docker

Dillinger is very easy to install and deploy in a Docker container.

By default, the Docker will expose port 8080, so change this within the
Dockerfile if necessary. When ready, simply use the Dockerfile to
build the image.

```sh
cd dillinger
docker build -t <youruser>/dillinger:${package.json.version} .
```

This will create the dillinger image and pull in the necessary dependencies.
Be sure to swap out `${package.json.version}` with the actual
version of Dillinger.

Once done, run the Docker image and map the port to whatever you wish on
your host. In this example, we simply map port 8000 of the host to
port 8080 of the Docker (or whatever port was exposed in the Dockerfile):

```sh
docker run -d -p 8000:8080 --restart=always --cap-add=SYS_ADMIN --name=dillinger <youruser>/dillinger:${package.json.version}
```

> Note: `--capt-add=SYS-ADMIN` is required for PDF rendering.

Verify the deployment by navigating to your server address in
your preferred browser.

```sh
127.0.0.1:8000
```

## License

MIT

**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

   [dill]: <https://github.com/joemccann/dillinger>
   [git-repo-url]: <https://github.com/joemccann/dillinger.git>
   [john gruber]: <http://daringfireball.net>
   [df1]: <http://daringfireball.net/projects/markdown/>
   [markdown-it]: <https://github.com/markdown-it/markdown-it>
   [Ace Editor]: <http://ace.ajax.org>
   [node.js]: <http://nodejs.org>
   [Twitter Bootstrap]: <http://twitter.github.com/bootstrap/>
   [jQuery]: <http://jquery.com>
   [@tjholowaychuk]: <http://twitter.com/tjholowaychuk>
   [express]: <http://expressjs.com>
   [AngularJS]: <http://angularjs.org>
   [Gulp]: <http://gulpjs.com>

   [PlDb]: <https://github.com/joemccann/dillinger/tree/master/plugins/dropbox/README.md>
   [PlGh]: <https://github.com/joemccann/dillinger/tree/master/plugins/github/README.md>
   [PlGd]: <https://github.com/joemccann/dillinger/tree/master/plugins/googledrive/README.md>
   [PlOd]: <https://github.com/joemccann/dillinger/tree/master/plugins/onedrive/README.md>
   [PlMe]: <https://github.com/joemccann/dillinger/tree/master/plugins/medium/README.md>
   [PlGa]: <https://github.com/RahulHP/dillinger/blob/master/plugins/googleanalytics/README.md>
