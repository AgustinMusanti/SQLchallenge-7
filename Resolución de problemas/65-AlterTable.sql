-- 1- Elimine la tabla "empleados", si existe, créela y cargue un registro:

IF OBJECT_ID('empleados') IS NOT NULL
DROP TABLE empleados;

CREATE TABLE empleados(
  apellido     VARCHAR(20),
  nombre       VARCHAR(20),
  domicilio    VARCHAR(30),
  fechaingreso DATETIME
 );
 
INSERT INTO empleados(apellido, nombre)
VALUES('Rodriguez','Pablo');

-- 2- Agregue el campo "sueldo", de tipo decimal(5,2).

ALTER TABLE empleados
ADD sueldo decimal(5,2);

-- 3- Verifique que la estructura de la tabla ha cambiado.

EXEC sp_columns empleados;

-- 4- Agregue un campo "codigo", de tipo int con el atributo "identity".

ALTER TABLE empleados
ADD codigo INT IDENTITY;

-- 5- Intente agregar un campo "documento" no nulo.

ALTER TABLE empleados
ADD documento CHAR(8) NOT NULL;

-- No se puede.

-- 6- Agregue el campo del punto anterior especificando un valor por defecto:

ALTER TABLE empleados
ADD documento CHAR(8) NOT NULL DEFAULT(000000000);

-- 7- Verifique que la estructura de la tabla ha cambiado.

EXEC sp_columns empleados;

-- 8- Elimine el campo "sueldo".

ALTER TABLE empleados
DROP COLUMN sueldo;

-- 9- Verifique la eliminación:

EXEC sp_columns empleados;

-- 10- Intente eliminar el campo "documento".

ALTER TABLE empleados
DROP COLUMN documento;

-- No lo permite.

-- 11- Elimine los campos "codigo" y "fechaingreso" en una sola sentencia.

ALTER TABLE empleados
DROP COLUMN codigo,fechaingreso;

-- 12- Verifique la eliminación de los campos:

EXEC sp_columns empleados;
