-- 1- Elimine las tablas "clientes" y "provincias", si existen:

IF OBJECT_ID('clientes') IS NOT NULL
DROP TABLE clientes;

IF OBJECT_ID('provincias') IS NOT NULL
DROP TABLE provincias;

-- 2- Créelas con las siguientes estructuras:

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

/* 3- Ingrese algunos registros para ambas tablas:

('Cordoba');
('Santa Fe');
('Corrientes');

('Lopez Marcos','Colon 111','Córdoba',1);
('Perez Ana','San Martin 222','Cruz del Eje',1);
('Garcia Juan','Rivadavia 333','Villa Maria',1);
('Perez Luis','Sarmiento 444','Rosario',2);
('Pereyra Lucas','San Martin 555','Cruz del Eje',1);
('Gomez Ines','San Martin 666','Santa Fe',2);
('Torres Fabiola','Alem 777','Ibera',3); */

INSERT INTO provincias(nombre)
VALUES('Cordoba'),
      ('Santa Fe'),
      ('Corrientes');

INSERT INTO clientes
VALUES('Lopez Marcos','Colon 111','Córdoba',1),
      ('Perez Ana','San Martin 222','Cruz del Eje',1),
      ('Garcia Juan','Rivadavia 333','Villa Maria',1),
      ('Perez Luis','Sarmiento 444','Rosario',2),
      ('Pereyra Lucas','San Martin 555','Cruz del Eje',1),
      ('Gomez Ines','San Martin 666','Santa Fe',2),
      ('Torres Fabiola','Alem 777','Ibera',3);

-- 4- Obtenga los datos de ambas tablas, usando alias:

SELECT c.nombre,domicilio,ciudad,p.nombre AS 'Provincia'
FROM clientes AS c
JOIN provincias AS p
ON c.codigoprovincia=p.codigo;

-- 5- Obtenga la misma información anterior pero ordenada por nombre de provincia.

SELECT c.nombre,domicilio,ciudad,p.nombre AS 'Provincia'
FROM clientes AS c
JOIN provincias AS p
ON c.codigoprovincia=p.codigo
ORDER BY Provincia;

-- 6- Recupere los clientes de la provincia "Santa Fe"

SELECT c.nombre,domicilio,ciudad,p.nombre AS 'Provincia'
FROM clientes AS c
JOIN provincias AS p
ON c.codigoprovincia=p.codigo
WHERE p.nombre='Cordoba';
