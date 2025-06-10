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

/* 4- Emplee una subconsulta con el operador "exists" para devolver la lista de socios que se 
      inscribieron en un determinado deporte. */

SELECT nombre
FROM socios AS s
WHERE EXISTS
   (SELECT * FROM inscriptos AS i
    WHERE s.numero=i.numerosocio
    AND i.deporte='natacion');

-- Se hace mas facil mediante un JOIN como muestro abajo

	SELECT nombre
	FROM socios AS s
	JOIN inscriptos AS i
	ON s.numero=i.numerosocio
	WHERE i.deporte='natacion';

-- 5- Busque los socios que NO se han inscripto en un deporte determinado empleando "not exists".

SELECT nombre
FROM socios AS s
WHERE NOT EXISTS
   (SELECT * FROM inscriptos AS i
    WHERE s.numero=i.numerosocio
    AND i.deporte='natacion');

-- 6- Muestre todos los datos de los socios que han pagado todas las cuotas.

SELECT s.*
FROM socios AS s
WHERE EXISTS
   (SELECT * FROM inscriptos AS i
    WHERE s.numero=i.numerosocio
    AND i.cuotas=10);
