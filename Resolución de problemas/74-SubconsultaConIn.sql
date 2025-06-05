-- 1- Elimine las tablas "clientes" y "ciudades", si existen:

IF OBJECT_ID('clientes') IS NOT NULL
DROP TABLE clientes;

IF OBJECT_ID('ciudades') IS NOT NULL
DROP TABLE ciudades;

-- 2- Cree ambas tablas

CREATE TABLE ciudades(
  codigo TINYINT IDENTITY,
  nombre VARCHAR(20),
  PRIMARY KEY(codigo)
 );

CREATE TABLE clientes (
  codigo       INT IDENTITY,
  nombre       VARCHAR(30),
  domicilio    VARCHAR(30),
  codigociudad TINYINT NOT NULL,
  PRIMARY KEY(codigo),
  CONSTRAINT FK_clientes_ciudad 
  FOREIGN KEY(codigociudad)
  REFERENCES ciudades(codigo) 
  ON UPDATE CASCADE,
 );

-- 3- Ingrese algunos registros para ambas tablas:

INSERT INTO ciudades
VALUES('Cordoba'),
      ('Cruz del Eje'),
      ('Carlos Paz'),
      ('La Falda'),
      ('Villa Maria');

INSERT INTO clientes
VALUES('Lopez Marcos','Colon 111',1),
      ('Lopez Hector','San Martin 222',1),
      ('Perez Ana','San Martin 333',2),
      ('Garcia Juan','Rivadavia 444',3),
      ('Perez Luis','Sarmiento 555',3),
      ('Gomez Ines','San Martin 666',4),
      ('Torres Fabiola','Alem 777',5),
      ('Garcia Luis','Sucre 888',5);

/* 4- Necesitamos conocer los nombres de las ciudades de aquellos clientes cuyo domicilio es en calle 
      "San Martin", empleando subconsulta. */

SELECT nombre
FROM ciudades
WHERE codigo IN
(SELECT codigociudad
FROM clientes
WHERE domicilio LIKE 'San Martin %');

-- 5- Obtenga la misma salida anterior pero empleando join.

SELECT c.nombre 
FROM ciudades AS c
JOIN clientes AS cl
ON c.codigo=cl.codigociudad
WHERE domicilio LIKE 'San Martin %';

/* 6- Obtenga los nombre de las ciudades de los clientes cuyo apellido no comienza con una letra 
      específica, empleando subconsulta. */


SELECT nombre
FROM ciudades
WHERE codigo NOT IN
(SELECT codigociudad
FROM clientes
WHERE nombre LIKE 'G%');

/* 7- Pruebe la subconsulta del punto 6 separada de la consulta exterior para verificar que retorna una 
      lista de valores de un solo campo. */

SELECT codigociudad
FROM clientes
WHERE nombre LIKE 'G%';
