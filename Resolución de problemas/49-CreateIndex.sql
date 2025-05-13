-- 1- Elimine la tabla "alumnos" si existe y créela con la siguiente estructura:

IF OBJECT_ID('alumnos') IS NOT NULL
DROP TABLE alumnos;

CREATE TABLE alumnos(
  legajo    CHAR(5) NOT NULL,
  documento CHAR(8) NOT NULL,
  apellido  VARCHAR(30),
  nombre    VARCHAR(30),
  notafinal DECIMAL(4,2)
 );

/* 2- Ingresamos algunos registros:

('A123','22222222','Perez','Patricia',5.50);
('A234','23333333','Lopez','Ana',9);
('A345','24444444','Garcia','Carlos',8.5);
('A348','25555555','Perez','Daniela',7.85);
('A457','26666666','Perez','Fabian',3.2);
('A589','27777777','Gomez','Gaston',6.90); */

INSERT INTO alumnos
VALUES('A123','22222222','Perez','Patricia',5.50),
      ('A234','23333333','Lopez','Ana',9),
      ('A345','24444444','Garcia','Carlos',8.5),
      ('A348','25555555','Perez','Daniela',7.85),
      ('A457','26666666','Perez','Fabian',3.2),
      ('A589','27777777','Gomez','Gaston',6.90);

-- 3- Intente crear un índice agrupado único para el campo "apellido".

CREATE UNIQUE CLUSTERED INDEX I_alumnos_apellido
ON alumnos(apellido);

-- NO se puede porque hay un valor duplicado.

-- 4- Cree un índice agrupado, no único, para el campo "apellido".

CREATE CLUSTERED INDEX I_alumnos_apellido
ON alumnos(apellido);

/* 5- Intente establecer una restricción "primary key" al campo "legajo" especificando que cree un 
      índice agrupado. */

ALTER TABLE alumnos
ADD CONSTRAINT PK_alumnos_legajo
PRIMARY KEY CLUSTERED (legajo);

-- NO puede haber mas de un clustered index por tabla.

/* 6- Establezca la restricción "primary key" al campo "legajo" especificando que cree un índice NO 
      agrupado. */

ALTER TABLE alumnos
ADD CONSTRAINT PK_alumnos_legajo
PRIMARY KEY NONCLUSTERED(legajo);

-- 7- Vea los índices de "alumnos":

EXEC sp_helpindex alumnos;

-- 8- Analice la información que muestra "sp_helpconstraint":

EXEC sp_helpconstraint alumnos;

-- 9- Cree un índice unique no agrupado para el campo "documento".

CREATE UNIQUE NONCLUSTERED INDEX I_alumnos_documento
ON alumnos(documento);

-- 10- Intente ingresar un alumno con documento duplicado.


INSERT INTO alumnos
VALUES('A789','27777777','Morales','Hector',8);

-- No se puede por el indice que creamos.

-- 11- Veamos los indices de "alumnos".

EXEC sp_helpindex alumnos;

-- 12- Cree un índice compuesto para el campo "apellido" y "nombre".

CREATE INDEX I_alumnos_apellidonombre
ON alumnos(apellido,nombre);

/* 13- Consulte la tabla "sysindexes", para ver los nombres de todos los índices creados para 
       "alumnos": */

SELECT NAME FROM sysindexes
WHERE NAME LIKE '%alumnos%';

-- 14- Cree una restricción unique para el campo "documento".

ALTER TABLE alumnos
ADD CONSTRAINT UQ_alumnos_documento
UNIQUE (documento);

-- 15- Vea la información de "sp_helpconstraint".

EXEC sp_helpconstraint alumnos;

-- 16- Vea los índices de "alumnos".

EXEC sp_helpindex alumnos;

/* 17- Consulte la tabla "sysindexes", para ver los nombres de todos los índices creados para 
       "alumnos": */

SELECT NAME FROM sysindexes
WHERE NAME LIKE '%alumnos%';

-- 18- Consulte la tabla "sysindexes", para ver los nombres de todos los índices creados por usted:

SELECT NAME FROM sysindexes
WHERE NAME LIKE 'I_%';
