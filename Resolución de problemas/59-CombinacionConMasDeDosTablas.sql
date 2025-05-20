-- 1- Elimine las tablas si existen:

IF OBJECT_ID('socios') IS NOT NULL
DROP TABLE socios;

IF OBJECT_ID('deportes') IS NOT NULL
DROP TABLE deportes;

IF OBJECT_ID('inscriptos') IS NOT NULL
DROP TABLE inscriptos;

-- 2- Cree las tablas con las siguientes estructuras:

CREATE TABLE socios(
  documento CHAR(8) NOT NULL, 
  nombre    VARCHAR(30),
  domicilio VARCHAR(30),
  PRIMARY KEY(documento)
 );
 
CREATE TABLE deportes(
  codigo   TINYINT IDENTITY,
  nombre   VARCHAR(20),
  profesor VARCHAR(15),
  PRIMARY KEY(codigo)
 );
 
CREATE TABLE inscriptos(
  documento     CHAR(8) NOT NULL, 
  codigodeporte TINYINT NOT NULL,
  anio          CHAR(4),
  matricula     CHAR(1),--'s'=paga, 'n'=impaga
  PRIMARY KEY(documento,codigodeporte,anio)
 );

-- 3- Ingrese algunos registros en "socios":

INSERT INTO socios
VALUES('22222222','Ana Acosta','Avellaneda 111'),
      ('23333333','Betina Bustos','Bulnes 222'),
      ('24444444','Carlos Castro','Caseros 333'),
      ('25555555','Daniel Duarte','Dinamarca 44');

-- 4- Ingrese algunos registros en "deportes":

INSERT INTO deportes
VALUES('basquet','Juan Juarez'),
      ('futbol','Pedro Perez'),
      ('natacion','Marina Morales'),
      ('tenis','Marina Morales');

-- 5- Inscriba a varios socios en el mismo deporte en el mismo año:

INSERT INTO inscriptos
VALUES('22222222',3,'2006','s'),
      ('23333333',3,'2006','s'),
      ('24444444',3,'2006','n');

-- 6- Inscriba a un mismo socio en el mismo deporte en distintos años:

INSERT INTO inscriptos
VALUES('22222222',3,'2005','s'),
      ('22222222',3,'2007','n');

-- 7- Inscriba a un mismo socio en distintos deportes el mismo año:

INSERT INTO inscriptos
VALUES('24444444',1,'2006','s'),
      ('24444444',2,'2006','s');

/* 8- Ingrese una inscripción con un código de deporte inexistente y un documento de socio que no 
      exista en "socios": */

INSERT INTO inscriptos
VALUES('26666666',0,'2006','s');

/* 9- Muestre el nombre del socio, el nombre del deporte en que se inscribió y el año empleando 
      diferentes tipos de join. */

SELECT s.nombre,d.nombre,anio
FROM deportes AS d
RIGHT JOIN inscriptos AS i
ON codigodeporte=d.codigo
LEFT JOIN socios AS s
ON i.documento=s.documento;

/* 10- Muestre todos los datos de las inscripciones (excepto los códigos) incluyendo aquellas 
       inscripciones cuyo código de deporte no existe en "deportes" y cuyo documento de socio 
	   no se ncuentra en "socios". */

SELECT s.nombre,d.nombre,anio,matricula
FROM deportes AS d
FULL JOIN inscriptos AS i
ON codigodeporte=d.codigo
FULL JOIN socios AS s
ON s.documento=i.documento;

-- 11- Muestre todas las inscripciones del socio con documento "22222222".

SELECT s.nombre,d.nombre,anio,matricula
FROM deportes AS d
JOIN inscriptos AS i
ON codigodeporte=d.codigo
JOIN socios AS s
ON s.documento=i.documento
WHERE s.documento='22222222';
