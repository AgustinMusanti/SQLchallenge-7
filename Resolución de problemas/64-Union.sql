-- 1- Elimine las tablas proveedores, clientes y empleados, si existen:

IF OBJECT_ID('proveedores') IS NOT NULL
DROP TABLE proveedores;

IF OBJECT_ID('clientes') IS NOT NULL
DROP TABLE clientes;

IF OBJECT_ID('empleados') IS NOT NULL
DROP TABLE empleados;

-- 2- Cree las tablas:

CREATE TABLE proveedores(
  codigo    INT IDENTITY,
  nombre    VARCHAR(30),
  domicilio VARCHAR(30),
  PRIMARY KEY(codigo)
 );

CREATE TABLE clientes(
  codigo    INT IDENTITY,
  nombre    VARCHAR(30),
  domicilio VARCHAR(30),
  PRIMARY KEY(codigo)
 );

CREATE TABLE empleados(
  documento CHAR(8) NOT NULL,
  nombre    VARCHAR(20),
  apellido  VARCHAR(20),
  domicilio VARCHAR(30),
  PRIMARY KEY(documento)
 );

-- 3- Ingrese algunos registros:

INSERT INTO proveedores
VALUES('Bebida cola','Colon 123'),
      ('Carnes Unica','Caseros 222'),
      ('Lacteos Blanca','San Martin 987');

INSERT INTO clientes
VALUES('Supermercado Lopez','Avellaneda 34'),
      ('Almacen Anita','Colon 987'),
      ('Garcia Juan','Sucre 345');

INSERT INTO empleados
VALUES('23333333','Federico','Lopez','Colon 987'),
      ('28888888','Ana','Marquez','Sucre 333'),
      ('30111111','Luis','Perez','Caseros 956');

/* 4- El supermercado quiere enviar una tarjeta de salutación a todos los proveedores, clientes y 
      empleados y necesita el nombre y domicilio de todos ellos. Emplee el operador "union" para obtener 
      dicha información de las tres tablas. */

SELECT nombre, domicilio FROM proveedores
UNION
SELECT nombre, domicilio FROM clientes
UNION
SELECT (apellido+' '+nombre), domicilio FROM empleados;

/* 5- Agregue una columna con un literal para indicar si es un proveedor, un cliente o un empleado y 
      ordene por dicha columna */

SELECT nombre, domicilio, 'Proveedor' AS categoria FROM proveedores
UNION
SELECT nombre, domicilio, 'Cliente' FROM clientes
UNION
SELECT (apellido+' '+nombre), domicilio , 'Empleado' FROM empleados
ORDER BY categoria;
