-- 1- Elimine las tablas "clientes" y "provincias", si existen y luego creelas:

IF OBJECT_ID('clientes') IS NOT NULL
DROP TABLE clientes;

IF OBJECT_ID('provincias') IS NOT NULL
DROP TABLE provincias;


CREATE TABLE clientes (
  codigo          INT IDENTITY,
  nombre          VARCHAR(30),
  domicilio       VARCHAR(30),
  ciudad          VARCHAR(20),
  codigoprovincia TINYINT NOT NULL,
  PRIMARY KEY(codigo)
 );

 CREATE TABLE provincias(
  codigo TINYINT IDENTITY,
  nombre VARCHAR(20),
  PRIMARY KEY(codigo)
 );

/* 2- Ingrese algunos registros para ambas tablas:

('Cordoba');
('Santa Fe');
('Corrientes');

('Lopez Marcos','Colon 111','Córdoba',1);
('Perez Ana','San Martin 222','Cruz del Eje',1);
('Garcia Juan','Rivadavia 333','Villa Maria',1);
('Perez Luis','Sarmiento 444','Rosario',2);
('Gomez Ines','San Martin 666','Santa Fe',2);
('Torres Fabiola','Alem 777','La Plata',4);
('Garcia Luis','Sucre 475','Santa Rosa',5); */

INSERT INTO provincias(nombre)
VALUES('Cordoba'),
      ('Santa Fe'),
      ('Corrientes');

INSERT INTO clientes
VALUES('Lopez Marcos','Colon 111','Córdoba',1),
      ('Perez Ana','San Martin 222','Cruz del Eje',1),
      ('Garcia Juan','Rivadavia 333','Villa Maria',1),
      ('Perez Luis','Sarmiento 444','Rosario',2),
      ('Gomez Ines','San Martin 666','Santa Fe',2),
      ('Torres Fabiola','Alem 777','La Plata',4),
      ('Garcia Luis','Sucre 475','Santa Rosa',5);

-- 3- Muestre todos los datos de los clientes, incluido el nombre de la provincia:

SELECT c.nombre, domicilio, ciudad, p.nombre AS 'Provincia'
FROM clientes AS c
LEFT JOIN provincias AS p
ON c.codigoprovincia=p.codigo;

-- 4- Realice la misma consulta anterior pero alterando el orden de las tablas:

SELECT c.nombre, domicilio, ciudad, p.nombre AS 'Provincia'
FROM provincias AS p
LEFT JOIN clientes AS c
ON c.codigoprovincia=p.codigo;

-- 5- Muestre solamente los clientes de las provincias que existen en "provincias":

SELECT c.nombre, domicilio, ciudad, p.nombre AS 'Provincia'
FROM clientes AS c
LEFT JOIN provincias AS p
ON c.codigoprovincia=p.codigo
WHERE p.nombre IS NOT NULL;

/* 6- Muestre todos los clientes cuyo código de provincia NO existe en "provincias" ordenados por 
      nombre del cliente: */

SELECT c.nombre, domicilio, ciudad, p.nombre AS 'Provincia'
FROM clientes AS c
LEFT JOIN provincias AS p
ON c.codigoprovincia=p.codigo
WHERE p.codigo IS NULL
ORDER BY c.nombre;

-- 7- Obtenga todos los datos de los clientes de "Cordoba":

SELECT c.nombre, domicilio, ciudad, p.nombre AS 'Provincia'
FROM clientes AS c
LEFT JOIN provincias AS p
ON c.codigoprovincia=p.codigo
WHERE p.nombre='Cordoba';
