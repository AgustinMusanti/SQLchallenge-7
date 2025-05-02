-- 1- Elimine la tabla "clientes", si existe:

IF OBJECT_ID('clientes') IS NOT NULL
DROP TABLE clientes;

-- 2- Créela con la siguiente estructura:

CREATE TABLE clientes (
  codigo    INT IDENTITY,
  nombre    VARCHAR(30) NOT NULL,
  domicilio VARCHAR(30),
  ciudad    VARCHAR(20),
  provincia VARCHAR(20),
  PRIMARY KEY(codigo)
);

/* 3- Ingrese algunos registros:

('Lopez Marcos','Colon 111','Cordoba','Cordoba');
('Perez Ana','San Martin 222','Cruz del Eje','Cordoba');
('Garcia Juan','Rivadavia 333','Villa del Rosario','Cordoba');
('Perez Luis','Sarmiento 444','Rosario','Santa Fe');
('Pereyra Lucas','San Martin 555','Cruz del Eje','Cordoba');
('Gomez Ines','San Martin 666','Santa Fe','Santa Fe');
('Torres Fabiola','Alem 777','Villa del Rosario','Cordoba');
('Lopez Carlos',null,'Cruz del Eje','Cordoba');
('Ramos Betina','San Martin 999','Cordoba','Cordoba');
('Lopez Lucas','San Martin 1010','Posadas','Misiones'); */

INSERT INTO clientes
VALUES('Lopez Marcos','Colon 111','Cordoba','Cordoba'),
      ('Perez Ana','San Martin 222','Cruz del Eje','Cordoba'),
      ('Garcia Juan','Rivadavia 333','Villa del Rosario','Cordoba'),
      ('Perez Luis','Sarmiento 444','Rosario','Santa Fe'),
      ('Pereyra Lucas','San Martin 555','Cruz del Eje','Cordoba'),
      ('Gomez Ines','San Martin 666','Santa Fe','Santa Fe'),
      ('Torres Fabiola','Alem 777','Villa del Rosario','Cordoba'),
      ('Lopez Carlos',null,'Cruz del Eje','Cordoba'),
      ('Ramos Betina','San Martin 999','Cordoba','Cordoba'),
      ('Lopez Lucas','San Martin 1010','Posadas','Misiones');

-- 4- Obtenga las provincias sin repetir

SELECT DISTINCT provincia
FROM clientes;

-- 5- Cuente las distintas provincias.

SELECT COUNT(DISTINCT provincia) AS 'Cantidad de provincias'
FROM clientes;

-- 6- Se necesitan los nombres de las ciudades sin repetir.

SELECT DISTINCT ciudad
FROM clientes;

-- 7- Obtenga la cantidad de ciudades distintas.

SELECT COUNT(DISTINCT ciudad) AS 'Cantidad de ciudades'
FROM clientes;

-- 8- Combine con "where" para obtener las distintas ciudades de la provincia de Cordoba

SELECT DISTINCT ciudad AS 'Ciudades de Cordoba'
FROM clientes
WHERE provincia='Cordoba';

-- 9- Contamos las distintas ciudades de cada provincia empleando "group by"

SELECT provincia,
       COUNT(DISTINCT ciudad) AS 'Cantidad de ciudades distintas'
FROM clientes
GROUP BY provincia;
