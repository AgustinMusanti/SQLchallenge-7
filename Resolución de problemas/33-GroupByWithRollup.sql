-- 1- Elimine la tabla "clientes", si existe:

IF OBJECT_ID('clientes') IS NOT NULL
DROP TABLE clientes;

-- 2- Créela con la siguiente estructura:

CREATE TABLE clientes (
  codigo    INT IDENTITY,
  nombre    VARCHAR(30) not null,
  domicilio VARCHAR(30),
  ciudad    VARCHAR(20),
  estado    VARCHAR(20),
  pais      VARCHAR(20),
  PRIMARY KEY(codigo)
 );

/* 3- Ingrese algunos registros:

('Lopez Marcos','Colon 111', 'Cordoba','Cordoba','Argentina');
('Perez Ana','San Martin 222', 'Carlos Paz','Cordoba','Argentina');
('Garcia Juan','Rivadavia 333', 'Carlos Paz','Cordoba','Argentina');
('Perez Luis','Sarmiento 444', 'Rosario','Santa Fe','Argentina');
('Gomez Ines','San Martin 987', 'Santa Fe','Santa Fe','Argentina');
('Gomez Ines','San Martin 666', 'Santa Fe','Santa Fe','Argentina');
('Lopez Carlos','Irigoyen 888', 'Cordoba','Cordoba','Argentina');
('Ramos Betina','San Martin 999', 'Cordoba','Cordoba','Argentina');
('Fernando Salas','Mariano Osorio 1234', 'Santiago','Region metropolitana','Chile');
('German Rojas','Allende 345', 'Valparaiso','Region V','Chile');
('Ricardo Jara','Pablo Neruda 146', 'Santiago','Region metropolitana','Chile');
('Joaquin Robles','Diego Rivera 147', 'Guadalajara','Jalisco','Mexico'); */

INSERT INTO clientes
VALUES('Lopez Marcos','Colon 111', 'Cordoba','Cordoba','Argentina'),
      ('Perez Ana','San Martin 222', 'Carlos Paz','Cordoba','Argentina'),
      ('Garcia Juan','Rivadavia 333', 'Carlos Paz','Cordoba','Argentina'),
      ('Perez Luis','Sarmiento 444', 'Rosario','Santa Fe','Argentina'),
      ('Gomez Ines','San Martin 987', 'Santa Fe','Santa Fe','Argentina'),
      ('Gomez Ines','San Martin 666', 'Santa Fe','Santa Fe','Argentina'),
      ('Lopez Carlos','Irigoyen 888', 'Cordoba','Cordoba','Argentina'),
      ('Ramos Betina','San Martin 999', 'Cordoba','Cordoba','Argentina'),
      ('Fernando Salas','Mariano Osorio 1234', 'Santiago','Region metropolitana','Chile'),
      ('German Rojas','Allende 345', 'Valparaiso','Region V','Chile'),
      ('Ricardo Jara','Pablo Neruda 146', 'Santiago','Region metropolitana','Chile'),
      ('Joaquin Robles','Diego Rivera 147', 'Guadalajara','Jalisco','Mexico'); 

-- 4- Necesitamos la cantidad de clientes por país y la cantidad total de clientes en una sola consulta 

SELECT pais,
COUNT(*) AS 'Cantidad de clientes'
FROM clientes
GROUP BY pais WITH ROLLUP;

-- 5- Necesitamos la cantidad de clientes agrupados por pais y estado, incluyendo resultados parciales 

SELECT pais, estado,
COUNT(*) AS 'Cantidad de clientes'
FROM clientes
GROUP BY pais, estado WITH ROLLUP;

-- 6- Necesitamos la cantidad de clientes agrupados por pais, estado y ciudad, empleando "rollup".

SELECT pais, estado, ciudad,
COUNT(*) AS 'Cantidad de clientes'
FROM clientes
GROUP BY pais, estado, ciudad WITH ROLLUP;
