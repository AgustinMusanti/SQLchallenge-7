-- 1- Elimine las tablas si existen y cree las tablas:

IF OBJECT_ID('deportes') IS NOT NULL
DROP TABLE deportes;

IF OBJECT_ID('inscriptos') IS NOT NULL
DROP TABLE inscriptos;

CREATE TABLE deportes(
  codigo   TINYINT IDENTITY,
  nombre   VARCHAR(30),
  profesor VARCHAR(30),
  PRIMARY KEY(codigo)
 );
 
CREATE TABLE inscriptos(
  documento     CHAR(8),
  codigodeporte TINYINT NOT NULL,
  matricula     CHAR(1) --'s'=paga 'n'=impaga
 );

/* 2- Ingrese algunos registros para ambas tablas:

('tenis','Marcelo Roca');
('natacion','Marta Torres');
('basquet','Luis Garcia');
('futbol','Marcelo Roca');
 
('22222222',3,'s');
('23333333',3,'s');
('24444444',3,'n');
('22222222',2,'s');
('23333333',2,'s');
('22222222',4,'n'); 
('22222222',5,'n'); */

INSERT INTO deportes
VALUES('tenis','Marcelo Roca'),
      ('natacion','Marta Torres'),
      ('basquet','Luis Garcia'),
      ('futbol','Marcelo Roca');
 
INSERT INTO inscriptos
VALUES('22222222',3,'s'),
      ('23333333',3,'s'),
      ('24444444',3,'n'),
      ('22222222',2,'s'),
      ('23333333',2,'s'),
      ('22222222',4,'n'),
      ('22222222',5,'n'); 

/* 3- Muestre todos la información de la tabla "inscriptos", y consulte la tabla "deportes" para 
      obtener el nombre de cada deporte. */

SELECT documento, matricula, d.nombre AS 'Deporte'
FROM inscriptos AS i
JOIN deportes AS d
ON i.codigodeporte=d.codigo;

-- 4- Empleando un "left join" con "deportes" obtenga todos los datos de los inscriptos.

SELECT documento, matricula, d.nombre AS 'Deporte'
FROM inscriptos AS i
LEFT JOIN deportes AS d
ON i.codigodeporte=d.codigo;

-- 5- Obtenga la misma salida anterior empleando un "rigth join".

SELECT documento, matricula, d.nombre AS 'Deporte'
FROM deportes AS d
RIGHT JOIN inscriptos AS i
ON i.codigodeporte=d.codigo;

-- 6- Muestre los deportes para los cuales no hay inscriptos, empleando un "left join".

SELECT documento, matricula, d.nombre AS 'Deporte'
FROM deportes AS d
LEFT JOIN inscriptos AS i
ON i.codigodeporte=d.codigo
WHERE codigodeporte IS NULL;

-- 7- Muestre los documentos de los inscriptos a deportes que no existen en la tabla "deportes".

SELECT documento, matricula, d.nombre AS 'Deporte'
FROM inscriptos AS i
LEFT JOIN deportes AS d
ON i.codigodeporte=d.codigo
WHERE codigo IS NULL;

/* 8- Emplee un "full join" para obtener todos los datos de ambas tablas, incluyendo las inscripciones 
      a deportes inexistentes en "deportes" y los deportes que no tienen inscriptos. */

SELECT documento, matricula, d.nombre AS 'Deporte'
FROM inscriptos AS i
FULL JOIN deportes AS d
ON i.codigodeporte=d.codigo;
