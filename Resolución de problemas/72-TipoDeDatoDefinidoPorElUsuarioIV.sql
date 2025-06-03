-- 1- Elimine la tabla "empleados" si existe:

IF OBJECT_ID('empleados') IS NOT NULL
DROP TABLE empleados;

/* 2- Defina un nuevo tipo de dato llamado "tipo_año". Primero debe eliminarlo, si existe para volver a 
      crearlo: */

IF EXISTS (SELECT * FROM SYSTYPES
           WHERE NAME = 'tipo_año')
EXEC sp_droptype tipo_año;

/* 3- Cree un tipo de dato definido por el usuario llamado "tipo_año" basado en el tipo "int" que 
      permita valores nulos: */

EXEC sp_addtype tipo_año, 'int','null';

-- 4- Elimine la regla llamada "RG_año" si existe:

IF OBJECT_ID('RG_año') IS NOT NULL
DROP RULE RG_año;

/* 5- Cree la regla que permita valores integer desde 1990 (fecha en que se inauguró el comercio) y el 
      año actual: */

CREATE RULE RG_año
AS @año BETWEEN 1990 AND DATEPART(YEAR,GETDATE());

-- 6- Asocie la regla al tipo de datos "tipo_año":

EXEC sp_bindrule RG_año, 'tipo_año';

-- 7- Cree la tabla "empleados" con un campo del tipo creado anteriormente:

CREATE TABLE empleados(
documento CHAR(8),
nombre    VARCHAR(30),
añoingreso tipo_año
 );

-- 8- Intente ingresar un registro con un valor inválido para el campo "añoingreso":

INSERT INTO empleados
VALUES('22222222','Juan Lopez',1980);

-- No lo permite.

-- 9- Ingrese un registro con un valor válido para el campo "añoingreso":

INSERT INTO empleados
VALUES('22222222','Juan Lopez',2000);

-- 10- Intente eliminar la regla asociada al tipo de datos:

DROP RULE RG_año;

-- No se puede porque está asociada a un tipo de datos.

-- 11- Elimine la asociación:

EXEC sp_unbindrule 'tipo_año';

-- 12- Verifique que la asociación ha sido eliminada pero la regla sigue existiendo:


EXEC sp_helpconstraint empleados;

-- 13- Elimine la regla:

DROP RULE RG_año;

-- 14- Verifique que la regla ya no existe:

EXEC sp_helpconstraint empleados;

-- 15- Ingrese el registro que no pudo ingresar en el punto 8:

INSERT INTO empleados
VALUES('22222222','Juan Lopez',1980);

-- 16- Intente eliminar el tipo de datos "tipo_año":

EXEC sp_droptype tipo_año;

-- No lo permite porque hay una tabla que lo utiliza.

-- 17- Elimine la tabla "empleados":

DROP TABLE empleados;

-- 18- Verifique que el tipo de dato "tipo_año" aún existe:

EXEC sp_help tipo_año;

-- 19- Elimine el tipo de datos:

EXEC sp_droptype tipo_año;

-- 20- Verifique que el tipo de dato "tipo_año" ya no existe:

EXEC sp_help tipo_año;
