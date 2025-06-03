-- 1- Elimine ambas tablas "empleados" y "clientes", si existen:

IF OBJECT_ID ('empleados') IS NOT NULL
DROP TABLE empleados;

IF OBJECT_ID ('clientes') IS NOT NULL
DROP TABLE clientes;

/* 2- Defina un nuevo tipo de dato llamado "tipo_año". Primero debe eliminarlo, si existe, para volver 
      a crearlo: */

IF EXISTS (SELECT * FROM SYSTYPES
WHERE NAME = 'tipo_año')
EXEC sp_droptype tipo_año;

/* 3- Cree un tipo de dato definido por el usuario llamado "tipo_año" basado en el tipo "int" que 
      permita valores nulos: */

EXEC sp_addtype tipo_año, 'int','null';

/* 4- Ejecute el procedimiento almacenado "sp_help" junto al nombre del tipo de dato definido 
      anteriormente para obtener información del mismo: */

EXEC sp_help tipo_año;

/*5- Cree la tabla "empleados" con 3 campos: documento (char de 8), nombre (30 caracteres) y 
     añoingreso (tipo_año): */

CREATE TABLE empleados(
documento CHAR(8),
nombre    VARCHAR(30),
año_ingreso tipo_año
);

-- 6- Elimine la regla llamada "RG_año" si existe:

IF OBJECT_ID('RG_año') IS NOT NULL
DROP RULE RG_año;

/* 7- Cree la regla que permita valores integer desde 1990 (año en que se inauguró el comercio) y el 
      año actual: */

CREATE RULE RG_año
AS @año BETWEEN 1990 AND DATEPART(YEAR,GETDATE());

/* 8- Asocie la regla al tipo de datos "tipo_año" especificando que solamente se aplique a los futuros 
      campos de este tipo: */

EXEC sp_bindrule RG_año, 'tipo_año', 'futureonly';

-- 9- Vea si se aplicó a la tabla empleados:

EXEC sp_helpconstraint empleados;

-- No se aplicó porque especificamos la opción "futureonly"

/* 10- Cree la tabla "clientes" con 3 campos: nombre (30 caracteres), añoingreso (tipo_año) y domicilio 
       (30 caracteres): */

CREATE TABLE clientes(
nombre    VARCHAR(30),
año_ingreso tipo_año,
domicilio VARCHAR(30)
);

-- 11- Vea si se aplicó la regla en la nueva tabla:

EXEC sp_helpconstraint clientes;

-- Si aparece.

-- 12- Ingrese registros con valores para el año que infrinjan la regla en la tabla "empleados":

INSERT INTO empleados
VALUES('11111111','Ana Acosta',2050);

SELECT * FROM empleados;

-- Lo acepta porque en esta tabla no se aplica la regla.

-- 13- Intente ingresar en la tabla "clientes" un valor de fecha que infrinja la regla:

INSERT INTO clientes
VALUES('22222222','Juan Perez',2050);

-- No lo permite.

-- 14- Quite la asociación de la regla con el tipo de datos:

EXEC sp_unbindrule 'tipo_año';

-- 15- Vea si se quitó la asociación:

EXEC sp_helpconstraint clientes;

-- 16- Vuelva a asociar la regla, ahora sin el parámetro "futureonly":

EXEC sp_bindrule RG_año, 'tipo_año';

/* 17- Intente agregar una fecha de ingreso fuera del intervalo que admite la regla en cualquiera de 
       las tablas (ambas tienen la asociación): */

INSERT INTO empleados 
VALUES('33333333','Romina Guzman',1900);

-- Msj de error ya que ambas tablas mantienen la regla.

-- 18- Vea la información del tipo de dato:

EXEC sp_help tipo_año;

-- 19- Elimine la regla llamada "RG_añonegativo", si existe:

IF OBJECT_ID ('RG_añonegativo') IS NOT NULL
DROP RULE RG_añonegativo;

-- 20- Cree una regla llamada "RG_añonegativo" que admita valores entre -2000 y -1:

CREATE RULE RG_añonegativo
AS @año BETWEEN -2000 AND -1;

-- 21- Asocie la regla "RG_añonegativo" al campo "añoingreso" de la tabla "clientes":

EXEC sp_bindrule RG_añonegativo, 'clientes.año_ingreso';

-- 22- Vea si se asoció:

EXEC sp_helpconstraint clientes;

-- Se asoció.

-- 23- Verifique que no está asociada al tipo de datos "tipo_año":

EXEC sp_help tipo_año;

-- No, tiene asociada la regla "RG_año".

-- 24- Intente ingresar un registro con valor '-1900' para el campo "añoingreso" de "empleados":

INSERT INTO empleados
VALUES('44444444','Pedro Perez',-1900);

-- No lo permite por la regla asociada al tipo de dato.

/* 25- Ingrese un registro con valor '-1900' para el campo "añoingreso" de "clientes" y recupere los 
       registros de dicha tabla: */

INSERT INTO  clientes 
VALUES('Agustin Musanti',-1900,'MateoPaz243');

SELECT * FROM clientes;

/* Si bien el tipo de dato de "añoingreso" tiene asociada una regla que no admite 
   tal valor, el campo tiene asociada una regla que si lo admite y ésta prevalece. */
