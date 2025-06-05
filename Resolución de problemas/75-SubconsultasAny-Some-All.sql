-- 1- Elimine las tablas "socios" e "inscriptos" si existen:

IF OBJECT_ID('socios') IS NOT NULL
DROP TABLE socios;

IF OBJECT_ID('inscriptos') IS NOT NULL
DROP TABLE inscriptos;

-- 2- Cree las tablas:

CREATE TABLE socios(
  numero    INT IDENTITY,
  documento CHAR(8),
  nombre    VARCHAR(30),
  domicilio VARCHAR(30),
  PRIMARY KEY(numero)
 );
 
CREATE TABLE inscriptos (
  numerosocio INT NOT NULL,
  deporte VARCHAR(20) NOT NULL,
  cuotas TINYINT
  CONSTRAINT CK_inscriptos_cuotas
  CHECK(cuotas>=0 and cuotas<=10)
  CONSTRAINT DF_inscriptos_cuotas DEFAULT 0,
  PRIMARY KEY(numerosocio,deporte),
  CONSTRAINT FK_inscriptos_socio
  FOREIGN KEY(numerosocio)
  REFERENCES socios(numero)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
 );

-- 3- Ingrese algunos registros:

INSERT INTO socios
VALUES('23333333','Alberto Paredes','Colon 111'),
      ('24444444','Carlos Conte','Sarmiento 755'),
      ('25555555','Fabian Fuentes','Caseros 987'),
      ('26666666','Hector Lopez','Sucre 344');

INSERT INTO inscriptos
VALUES(1,'tenis',1),
      (1,'basquet',2),
      (1,'natacion',1),
      (2,'tenis',9),
      (2,'natacion',1),
      (2,'basquet',default),
      (2,'futbol',2),
      (3,'tenis',8),
      (3,'basquet',9),
      (3,'natacion',0),
      (4,'basquet',10);

/* 4- Muestre el número de socio, el nombre del socio y el deporte en que está inscripto con un join de 
      ambas tablas. */

SELECT s.numero, s.nombre, i.deporte
FROM socios AS s
JOIN inscriptos AS i
ON s.numero=i.numerosocio;

/* 5- Muestre los socios que se serán compañeros en tenis y también en natación (empleando 
      subconsulta) */

SELECT nombre
FROM socios
JOIN inscriptos AS i
ON numero=numerosocio
WHERE deporte='natacion' AND 
      numero= ANY
(SELECT numerosocio
FROM inscriptos AS i
WHERE deporte='tenis');

-- 6- vea si el socio 1 se ha inscripto en algún deporte en el cual se haya inscripto el socio 2.

SELECT deporte
FROM inscriptos AS i
WHERE numerosocio=1 AND
      deporte= ANY
(SELECT deporte
FROM inscriptos AS i
WHERE numerosocio=2);

-- 7- Obtenga el mismo resultado anterior pero empleando join.


SELECT i1.deporte
FROM inscriptos AS i1
JOIN inscriptos AS i2
ON i1.deporte=i2.deporte
WHERE i1.numerosocio=1 AND
      i2.numerosocio=2;

/* 8- Muestre los deportes en los cuales el socio 2 pagó más cuotas que ALGUN deporte en los que se
      inscribió el socio 1. */

SELECT deporte
FROM inscriptos AS s
WHERE numerosocio=2 AND
      cuotas>ANY
(SELECT cuotas
FROM inscriptos
WHERE numerosocio=1);

/* 9- Muestre los deportes en los cuales el socio 2 pagó más cuotas que TODOS los deportes en que se 
      inscribió el socio 1. */ 

SELECT deporte
FROM inscriptos AS s
WHERE numerosocio=2 AND
      cuotas>ALL
(SELECT cuotas
FROM inscriptos
WHERE numerosocio=1);

/* 10- Cuando un socio no ha pagado la matrícula de alguno de los deportes en que se ha inscripto, se 
       lo borra de la inscripción de todos los deportes. Elimine todos los socios que no pagaron ninguna 
       cuota en algún deporte. */

DELETE FROM inscriptos
WHERE numerosocio=ANY
(SELECT numerosocio 
FROM inscriptos
WHERE cuotas=0);

SELECT * FROM inscriptos;
