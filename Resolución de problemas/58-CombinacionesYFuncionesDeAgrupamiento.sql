-- 1- Elimine las tablas si existen:

IF OBJECT_ID('visitantes') IS NOT NULL
DROP TABLE visitantes;

IF OBJECT_ID('ciudades') IS NOT NULL
DROP TABLE ciudades;

-- 2- Cree las tablas:

CREATE TABLE visitantes(
  nombre       VARCHAR(30),
  edad         TINYINT,
  sexo         CHAR(1) DEFAULT 'f',
  domicilio    VARCHAR(30),
  codigociudad TINYINT NOT NULL,
  mail         VARCHAR(30),
  montocompra  DECIMAL(6,2)
 );

CREATE TABLE ciudades(
  codigo TINYINT IDENTITY,
  nombre VARCHAR(20)
 );
 
/* 3- Ingrese algunos registros:

('Cordoba');
('Carlos Paz');
('La Falda');
('Cruz del Eje');

('Susana Molina', 35,'f','Colon 123', 1, null,59.80);
('Marcos Torres', 29,'m','Sucre 56', 1, 'marcostorres@hotmail.com',150.50);
('Mariana Juarez', 45,'f','San Martin 111',2,null,23.90);
('Fabian Perez',36,'m','Avellaneda 213',3,'fabianperez@xaxamail.com',0);
('Alejandra Garcia',28,'f',null,2,null,280.50);
('Gaston Perez',29,'m',null,5,'gastonperez1@gmail.com',95.40);
('Mariana Juarez',33,'f',null,2,null,90); */

INSERT INTO ciudades
VALUES('Cordoba'),
      ('Carlos Paz'),
      ('La Falda'),
      ('Cruz del Eje');

INSERT INTO visitantes
VALUES('Susana Molina', 35,'f','Colon 123', 1, null,59.80),
      ('Marcos Torres', 29,'m','Sucre 56', 1, 'marcostorres@hotmail.com',150.50),
      ('Mariana Juarez', 45,'f','San Martin 111',2,null,23.90),
      ('Fabian Perez',36,'m','Avellaneda 213',3,'fabianperez@xaxamail.com',0),
      ('Alejandra Garcia',28,'f',null,2,null,280.50),
      ('Gaston Perez',29,'m',null,5,'gastonperez1@gmail.com',95.40),
      ('Mariana Juarez',33,'f',null,2,null,90);

-- 4- Cuente la cantidad de visitas por ciudad mostrando el nombre de la ciudad.

SELECT c.nombre,
       COUNT(*) AS cantidad
FROM ciudades AS c
JOIN visitantes AS v
ON c.codigo=v.codigociudad
GROUP BY c.nombre;

-- 5- Muestre el promedio de gastos de las visitas agrupados por ciudad y sexo.

SELECT c.nombre, v.sexo,
       AVG(montocompra) AS 'Promedio de gastos'
FROM ciudades AS c
JOIN visitantes AS v
ON c.codigo=v.codigociudad
GROUP BY c.nombre,v.sexo;

-- 6- Muestre la cantidad de visitantes con mail, agrupados por ciudad.

SELECT c.nombre,
       COUNT(mail) AS 'Tienen mail'
FROM ciudades AS c
JOIN visitantes AS v
ON c.codigo=v.codigociudad
GROUP BY c.nombre;

-- 7- Obtenga el monto de compra más alto de cada ciudad.

SELECT c.nombre,
       MAX(montocompra) AS 'Compra más alta'
FROM ciudades AS c
JOIN visitantes AS v
ON c.codigo=v.codigociudad
GROUP BY c.nombre;
