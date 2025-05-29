-- 1- Elimine la tabla "empleados", si existe, y luego créela:

IF OBJECT_ID('empleados') IS NOT NULL
DROP TABLE empleados;

CREATE TABLE empleados(
  documento CHAR(8) NOT NULL,
  nombre    VARCHAR(10),
  domicilio VARCHAR(30),
  ciudad    VARCHAR(20) DEFAULT 'Buenos Aires'
 );

-- 2- Agregue el campo "legajo" de tipo int identity y una restricción "primary key":

ALTER TABLE empleados
ADD legajo INT IDENTITY
CONSTRAINT PK_legajo PRIMARY KEY;

-- 3- Vea si la estructura cambió y si se agregó la restricción:

EXEC sp_columns empleados;
EXEC sp_helpconstraint empleados;

/* 4- Agregue el campo "hijos" de tipo tinyint y en la misma sentencia una restricción "check" que no 
      permita valores superiores a 30: */

ALTER TABLE empleados
ADD hijos TINYINT
CONSTRAINT CK_hijos CHECK(hijos<=30);

-- 5- Ingrese algunos registros:

INSERT INTO empleados
VALUES('22222222','Juan Lopez','Colon 123','Cordoba',2),
      ('23333333','Ana Garcia','Sucre 435','Cordoba',3);

/* 6- Intente agregar el campo "sueldo" de tipo decimal(6,2) no nulo y una restricción "check" que no 
      permita valores negativos para dicho campo: */ 

ALTER TABLE empleados
ADD sueldo DECIMAL(6,2) NOT NULL
CONSTRAINT CK_sueldo CHECK(sueldo>0); 

/* No lo permite porque no damos un valor por defecto para dicho campo no nulo y los registros 
   existentes necesitan cargar un valor */

/* 7- Agregue el campo "sueldo" de tipo decimal(6,2) no nulo, una restricción "check" que no permita 
      valores negativos para dicho campo y una restricción "default" que almacene el valor "0": */

ALTER TABLE empleados
ADD sueldo DECIMAL(6,2) NOT NULL DEFAULT(0)
CONSTRAINT CK_sueldo CHECK(sueldo>=0); 

-- 8- Recupere los registros:

SELECT * FROM empleados;

-- 9- Vea la nueva estructura de la tabla:

EXEC sp_columns empleados;

-- 10- Vea las restricciones:

EXEC sp_helpconstraint;
