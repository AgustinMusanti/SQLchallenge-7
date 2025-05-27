-- 1- Elimine las tablas si existen:

IF OBJECT_ID('profesores') IS NOT NULL
DROP TABLE profesores;

IF OBJECT_ID('deportes') IS NOT NULL
DROP TABLE deportes;

IF OBJECT_ID('socios') IS NOT NULL
DROP TABLE socios;

IF OBJECT_ID('inscriptos') IS NOT NULL
DROP TABLE inscriptos;

/* 2- Considere que:

- un socio puede inscribirse en varios deportes, pero no dos veces en el mismo.
- un socio tiene un documento único y un número de socio único.
- el documento del socio debe contener 8 dígitos.
- un deporte debe tener asignado un profesor que exista en "profesores" o "null" si aún no tiene un 
  instructor definido.
- el campo "dia" de "deportes" puede ser: lunes, martes, miercoles, jueves, viernes o sabado.
- el campo "dia" de "deportes" por defecto debe almacenar 'sabado'.
- un profesor puede ser instructor de varios deportes o puede no dictar ningún deporte.
- un profesor no puede estar repetido en "profesores".
- el documento del profesor debe contener 8 dígitos.
- un inscripto debe ser socio, un socio puede no estar inscripto en ningún deporte.
- una inscripción debe tener un valor en socio existente en "socios" y un deporte que exista en 
  "deportes".
- el campo "matricula" de "inscriptos" debe aceptar solamente los caracteres 's' o 'n'. */

-- 3- Cree las tablas con las restricciones necesarias:

CREATE TABLE profesores(
  documento CHAR(8) NOT NULL,
  nombre    VARCHAR(30),
  domicilio VARCHAR(30),
CONSTRAINT CK_profesores_documento_patron CHECK (documento LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
CONSTRAINT PK_profesores_documento
PRIMARY KEY(documento)
 );

CREATE TABLE deportes(
  codigo TINYINT IDENTITY,
  nombre VARCHAR(20) NOT NULL,
  dia    VARCHAR(30)
CONSTRAINT DF_deportes_dia DEFAULT('sabado'),
           profesor CHAR(8),--documento del profesor
CONSTRAINT CK_deportes_dia_lista CHECK (dia IN ('lunes','martes','miercoles','jueves','viernes','sabado')),
CONSTRAINT PK_deportes_codigo
PRIMARY KEY(codigo)
 );

CREATE TABLE socios(
  numero    INT IDENTITY,
  documento CHAR(8),
  nombre    VARCHAR(30),
  domicilio VARCHAR(30),
CONSTRAINT CK_documento_patron CHECK (documento LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
CONSTRAINT PK_socios_numero
PRIMARY KEY NONCLUSTERED(numero),
CONSTRAINT UQ_socios_documento
UNIQUE CLUSTERED(documento)
 );

CREATE TABLE inscriptos(
  numerosocio INT NOT NULL,
  codigodeporte TINYINT,
  matricula CHAR(1),
CONSTRAINT PK_inscriptos_numerodeporte
PRIMARY KEY CLUSTERED (numerosocio,codigodeporte),
CONSTRAINT FK_inscriptos_deporte
FOREIGN KEY (codigodeporte) REFERENCES deportes(codigo)
ON UPDATE CASCADE,
CONSTRAINT FK_inscriptos_socios
FOREIGN KEY(numerosocio) REFERENCES socios(numero)
ON UPDATE CASCADE
ON DELETE CASCADE,
CONSTRAINT CK_matricula_valores CHECK (matricula IN ('s','n'))
);

-- 4- Ingrese registros en "profesores":

INSERT INTO profesores
VALUES('21111111','Andres Acosta','Avellaneda 111'),
      ('22222222','Betina Bustos','Bulnes 222'),
      ('23333333','Carlos Caseros','Colon 333');

/* 5- Ingrese registros en "deportes". Ingrese el mismo día para distintos deportes, un deporte sin día 
      confirmado, un deporte sin profesor definido: */
   
INSERT INTO deportes
VALUES('basquet','lunes',null),
      ('futbol','lunes','23333333'),
      ('natacion',null,'22222222'),
      ('padle',default,'23333333');
     

-- 6- Ingrese registros en "socios":

INSERT INTO socios
VALUES('30111111','Ana Acosta','America 111'),
      ('30222222','Bernardo Bueno','Bolivia 222'),
      ('30333333','Camila Conte','Caseros 333'),
      ('30444444','Daniel Duarte','Dinamarca 444');

/* 7- Ingrese registros en "inscriptos". Inscriba a un socio en distintos deportes, inscriba varios 
      socios en el mismo deporte. */

INSERT INTO inscriptos
VALUES(1,3,'s'),
      (2,1,'s'),
      (4,1,'n');

/* 8- Realice un "join" (del tipo que sea necesario) para mostrar todos los datos del socio junto con 
      el nombre de los deportes en los cuales está inscripto, el día que tiene que asistir y el nombre del 
      profesor que lo instruirá. */

SELECT s.*,d.nombre AS deporte,d.dia,p.nombre AS profesor
FROM socios AS s
JOIN inscriptos AS i
ON numero=i.numerosocio
JOIN deportes AS d
ON d.codigo=i.codigodeporte
LEFT JOIN profesores AS p
ON d.profesor=p.documento;

/* 9- Realice la misma consulta anterior pero incluya los socios que no están inscriptos en ningún 
      deporte. */

SELECT s.*,d.nombre AS deporte,d.dia,p.nombre AS profesor
FROM socios AS s
FULL JOIN inscriptos AS i
ON numero=i.numerosocio
LEFT JOIN deportes AS d
ON d.codigo=i.codigodeporte
LEFT JOIN profesores AS p
ON d.profesor=p.documento;

/* 10- Muestre todos los datos de los profesores, incluido el deporte que dicta y el día, incluyendo 
       los profesores que no tienen asignado ningún deporte. */

SELECT p.*,d.nombre AS deporte,d.dia
FROM profesores AS p
LEFT JOIN deportes AS d
ON d.profesor=p.documento;

/* 11- Muestre todos los deportes y la cantidad de inscriptos, incluyendo aquellos deportes para los 
       cuales no hay inscriptos. */

SELECT d.nombre,COUNT(i.codigodeporte) AS cantidad
FROM deportes AS d
LEFT JOIN inscriptos AS i
ON d.codigo=i.codigodeporte
GROUP BY d.nombre; 

-- 12- Muestre las restricciones de "socios".

EXEC sp_helpconstraint socios;

-- 13- Muestre las restricciones de "deportes".

EXEC sp_helpconstraint deportes;

-- 14- Muestre las restricciones de "profesores".

EXEC sp_helpconstraint profesores;

-- 15- Muestre las restricciones de "inscriptos".

EXEC sp_helpconstraint inscriptos;
