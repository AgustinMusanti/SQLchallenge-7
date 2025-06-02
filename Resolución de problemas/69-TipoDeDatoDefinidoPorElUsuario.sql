-- 1- Elimine la tabla "empleados", si existe:

IF OBJECT_ID('empleados') IS NOT NULL
DROP TABLE empleados;

/* 2- Defina un nuevo tipo de dato llamado "tipo_legajo". Primero debe eliminarlo (si existe) para 
      volver a crearlo: */

IF EXISTS (SELECT NAME FROM SYSTYPES
WHERE NAME = 'tipo_legajo')
EXEC sp_droptype tipo_legajo;

/* 3- Cree un tipo de dato definido por el usuario llamado "tipo_legajo" basado en el tipo "char" de 4 
      caracteres que no permita valores nulos. */

EXEC sp_addtype tipo_legajo, 'char(4)','not null';

/* 4- Ejecute el procedimiento almacenado "sp_help" junto al nombre del tipo de dato definido 
      anteriormente para obtener información del mismo. */

EXEC sp_help tipo_legajo;

/* 5- Cree la tabla "empleados" con 3 campos: legajo (tipo_legajo), documento (char de 8) y nombre (30 
      caracteres): */

CREATE TABLE empleados(
 legajo tipo_legajo,
 documento CHAR(8),
 nombre VARCHAR(30)
 );

-- 6- Intente ingresar un registro con valores por defecto:

INSERT INTO empleados DEFAULT VALUES;

-- NO hay valores por defecto seteados.

-- 7- Ingrese un registro con valores válidos.

INSERT INTO empleados 
VALUES('A111','22222222','Juan Perez');
