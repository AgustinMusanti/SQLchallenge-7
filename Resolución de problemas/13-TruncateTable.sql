-- 1- Elimine la tabla "alumnos" si existe:

IF OBJECT_ID('alumnos') IS NOT NULL
DROP TABLE alumnos;

-- 2- Cree la tabla con la siguiente estructura:

CREATE TABLE alumnos(
  legajo    INT IDENTITY,
  documento VARCHAR(8),
  nombre    VARCHAR(30),
  domicilio VARCHAR(30)
 );

/* 3- Ingrese los siguientes registros y muéstrelos para ver la secuencia de códigos:

('22345345','Perez Mariana','Colon 234');
('23545345','Morales Marcos','Avellaneda 348');
('24356345','Gonzalez Analia','Caseros 444');
('25666777','Torres Ramiro','Dinamarca 209'); */

INSERT INTO alumnos(documento, nombre, domicilio)
VALUES('22345345','Perez Mariana','Colon 234'),
      ('23545345','Morales Marcos','Avellaneda 348'),
      ('24356345','Gonzalez Analia','Caseros 444'),
      ('25666777','Torres Ramiro','Dinamarca 209');

SELECT * FROM alumnos;

-- 4- Elimine todos los registros con "delete".

DELETE FROM alumnos;

/* 5- Ingrese los siguientes registros y selecciónelos para ver cómo SQL Server generó los códigos:

('22345345','Perez Mariana','Colon 234');
('23545345','Morales Marcos','Avellaneda 348');
('24356345','Gonzalez Analia','Caseros 444');
('25666777','Torres Ramiro','Dinamarca 209'); */

INSERT INTO alumnos(documento, nombre, domicilio)
VALUES('22345345','Perez Mariana','Colon 234'),
      ('23545345','Morales Marcos','Avellaneda 348'),
      ('24356345','Gonzalez Analia','Caseros 444'),
      ('25666777','Torres Ramiro','Dinamarca 209');

SELECT * FROM alumnos;

/* Se observa que la lista de legajos sigue el orden anterior.
   Si queremos modificarlo, podemos emplear la siguiente consulta: */

DBCC CHECKIDENT ('alumnos', RESEED, 0);

-- Si vuelvo a hacer un INSERT, comenzará de nuevo en "1"

-- 6- Elimine todos los registros con "truncate table".

TRUNCATE TABLE alumnos;

/* 7- Ingrese los siguientes registros y muestre todos los registros para ver que SQL Server reinició 
      la secuencia del campo "identity":

('22345345','Perez Mariana','Colon 234');
('23545345','Morales Marcos','Avellaneda 348');
('24356345','Gonzalez Analia','Caseros 444');
('25666777','Torres Ramiro','Dinamarca 209'); */

INSERT INTO alumnos (documento, nombre, domicilio)
VALUES('22345345','Perez Mariana','Colon 234'),
      ('23545345','Morales Marcos','Avellaneda 348'),
      ('24356345','Gonzalez Analia','Caseros 444'),
      ('25666777','Torres Ramiro','Dinamarca 209');

SELECT * FROM alumnos;

-- Efectivamente comienza desde "1" nuevamente.
