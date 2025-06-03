-- 1- Elimine ambas tablas, si existen:

IF OBJECT_ID('empleados') IS NOT NULL
DROP TABLE empleados;

IF OBJECT_ID('clientes') IS NOT NULL
DROP TABLE clientes;

/* 2- Defina un nuevo tipo de dato llamado "tipo_año". Primero debe eliminarlo, si existe, para volver 
      a crearlo. */

IF EXISTS (SELECT * FROM SYSTYPES
           WHERE NAME = 'tipo_año')
EXEC sp_droptype tipo_año;

/* 3- Cree un tipo de dato definido por el usuario llamado "tipo_año" basado en el tipo "int" que 
      permita valores nulos: */

EXEC sp_addtype tipo_año, 'int','null';

/* 4- Ejecute el procedimiento almacenado "sp_help" junto al nombre del tipo de dato definido 
      anteriormente para obtener información del mismo: */

EXEC sp_help tipo_año;

/* 5- Cree la tabla "empleados" con 3 campos: documento (char de 8), nombre (30 caracteres) y 
      añoingreso (tipo_año): */

CREATE TABLE empleados(
documento CHAR(8),
nombre    VARCHAR(30),
añoingreso tipo_año
);

-- 6- Elimine el valor predeterminado "VP_añoactual" si existe:

IF OBJECT_ID('VP_añoactual') IS NOT NULL
DROP DEFAULT VP_añoactual;

-- 7- Cree el valor predeterminado "VP_añoactual" que almacene el año actual:

CREATE DEFAULT VP_añoactual
AS DATEPART(YEAR,GETDATE());

/* 8- Asocie el valor predeterminado al tipo de datos "tipo_año" especificando que solamente se aplique 
      a los futuros campos de este tipo: */

EXEC sp_bindefault VP_añoactual, 'tipo_año', 'futureonly';

-- 9- Vea si se aplicó a la tabla empleados:

EXEC sp_helpconstraint empleados;

-- NO ya que esta hecho para futuras tablas.

/* 10- Cree la tabla "clientes" con 3 campos: nombre (30 caracteres), añoingreso (tipo_año) y domicilio 
       (30 caracteres): */

CREATE TABLE clientes(
nombre    VARCHAR(30),
añoingreso tipo_año,
domicilio VARCHAR(30)
);

-- 11- Vea si se aplicó la regla en la nueva tabla:

EXEC sp_helpconstraint clientes;

-- Si se asocio.

/* 12- Ingrese un registro con valores por defecto en la tabla "empleados" y vea qué se almacenó en 
       "añoingreso": */

INSERT INTO empleados DEFAULT VALUES;

SELECT * FROM empleados;

-- Se almacenó "null" porque en esta tabla no se aplica el valor predeterminado.

-- 13- Ingrese en la tabla "clientes" un registro con valores por defecto y recupere los registros:

INSERT INTO clientes DEFAULT VALUES;

SELECT * FROM clientes;

-- Se almaceno el valor predeterminado.

-- 14- Elimine el valor predeterminado llamado "VP_año2000", si existe:

IF OBJECT_ID('VP_año2000') IS NOT NULL
DROP DEFAULT VP_año2000;

-- 15- Cree un valor predeterminado llamado "VP_año2000" con el valor 2000:

CREATE DEFAULT VP_año2000
AS 2000;

-- 16- Asócielo al tipo de dato definido sin especificar "futureonly":

EXEC sp_bindefault VP_año2000, 'tipo_año';

-- 17- Verifique que se asoció a la tabla "empleados":

EXEC sp_helpconstraint empleados;

-- 18- Verifique que reemplazó al valor predeterminado anterior en la tabla "clientes":

EXEC sp_helpconstraint clientes;

/* 19- Ingrese un registro en ambas tablas con valores por defecto y vea qué se almacenó en el año de 
       ingreso: */

INSERT INTO empleados DEFAULT VALUES;

SELECT * FROM empleados;

INSERT INTO clientes DEFAULT VALUES;

SELECT * FROM clientes;

-- 20- Vea la información del tipo de dato:

EXEC sp_help tipo_año;

-- 21- Intente agregar a la tabla "empleados" una restricción "default":

ALTER TABLE empleados
ADD CONSTRAINT DF_empleados_año
DEFAULT 1990
FOR añoingreso;

-- No lo permite porque el tipo de dato del campo ya tiene un valor predeterminado asociado.

-- 22- Quite la asociación del valor predeterminado al tipo de dato:

EXEC sp_unbindefault 'tipo_año';

-- 23- Agregue a la tabla "empleados" una restricción "default":

ALTER TABLE empleados
ADD CONSTRAINT DF_empleados_año
DEFAULT 1990
FOR añoingreso;

-- 24- Asocie el valor predeterminado "VP_añoactual" al tipo de dato "tipo_año":

EXEC sp_bindefault VP_añoactual, 'tipo_año';

-- 25- Verifique que el tipo de dato tiene asociado el valor predeterminado:

EXEC sp_help tipo_año;

-- 26- Verifique que la tabla "clientes" tiene asociado el valor predeterminado:

EXEC sp_helpconstraint clientes;

/* 27- Verifique que la tabla "empleados" no tiene asociado el valor predeterminado "VP_añoactual" 
       asociado al tipo de dato y tiene la restricción "default": */

EXEC sp_helpconstraint empleados;
