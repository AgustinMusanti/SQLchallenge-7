-- 1- Elimine la tabla "vehiculos", si existe:

IF OBJECT_ID('vehiculos') IS NOT NULL
DROP TABLE vehiculos;

-- 2- Cree la tabla:

CREATE TABLE vehiculos(
  patente     CHAR(6) NOT NULL,
  tipo        CHAR(1),--'a'=auto, 'm'=moto
  horallegada DATETIME NOT NULL,
  horasalida  DATETIME
 );

/* 3- Establezca una restricción "check" que admita solamente los valores "a" y "m" para el campo 
"tipo": */

ALTER TABLE vehiculos
ADD CONSTRAINT CK_vehiculos_tipo
CHECK (tipo in ('a','m'));

/* 4- Establezca una restricción "default" para el campo "tipo" que almacene el valor "a" en caso de no 
ingresarse valor para dicho campo: */

ALTER TABLE vehiculos
ADD CONSTRAINT DF_vehiculos_tipo
DEFAULT 'a'
FOR tipo;

/* 5- Establezca una restricción "check" para el campo "patente" para que acepte 3 letras seguidas de 3 
      dígitos: */

ALTER TABLE vehiculos
ADD CONSTRAINT CK_vehiculos_patente_patron
CHECK (patente LIKE '[A-Z][A-Z][A-Z][0-9][0-9][0-9]');

-- 6- Agregue una restricción "primary key" que incluya los campos "patente" y "horallegada":

ALTER TABLE vehiculos
ADD CONSTRAINT PK_vehiculos
PRIMARY KEY(patente, horallegada);

/* 7- Ingrese un vehículo:

('SDR456','a','2005/10/10 10:10',null); */

INSERT INTO vehiculos
VALUES('SDR456','a','2005/10/10 10:10',null);

-- 8- Intente ingresar un registro repitiendo la clave primaria:

INSERT INTO vehiculos
VALUES('SDR456','e','2005/10/10 10:10',null);

-- NO es posible.

-- 9- Ingrese un registro repitiendo la patente pero no la hora de llegada:

INSERT INTO vehiculos
VALUES('SDR456','a','2005/10/10 10:15',null);

-- Ok la inserción.

-- 10- Ingrese un registro repitiendo la hora de llegada pero no la patente:

INSERT INTO vehiculos
VALUES('ABC999','a','2005/10/10 10:10',null);

-- Ok la inserción.

-- 11- Vea todas las restricciones para la tabla "vehiculos":

EXEC sp_helpconstraint vehiculos;

-- 12- Elimine la restricción "default" del campo "tipo".

ALTER TABLE vehiculos
DROP DF_vehiculos_tipo;

-- 13- Vea si se ha eliminado:

EXEC sp_helpconstraint vehiculos;

-- 14- Elimine la restricción "primary key" y "check".

ALTER TABLE vehiculos
DROP PK_vehiculos, CK_vehiculos_tipo;

-- 15- Vea si se han eliminado:

EXEC sp_helpconstraint vehiculos;
