-- 1- Elimine la tabla "vehiculos", si existe:

IF OBJECT_ID('vehiculos') IS NOT NULL
DROP TABLE vehiculos;

-- 2- Elimine las siguientes reglas:

IF OBJECT_ID('RG_patente_patron') IS NOT NULL
DROP RULE RG_patente_patron;

IF OBJECT_ID('RG_horallegada') IS NOT NULL
DROP RULE RG_horallegada;

IF OBJECT_ID('RG_vehiculos_tipo') IS NOT NULL
DROP RULE RG_vehiculos_tipo;

IF OBJECT_ID('RG_vehiculos_tipo2') IS NOT NULL
DROP RULE RG_vehiculos_tipo2;

IF OBJECT_ID('RG_menor_fechaactual') IS NOT NULL
DROP RULE RG_menor_fechaactual;

-- 3- Cree la tabla:

CREATE TABLE vehiculos(
  patente     CHAR(6) NOT NULL,
  tipo        CHAR(1),--'a'=auto, 'm'=moto
  horallegada DATETIME NOT NULL,
  horasalida  DATETIME
 );

/* 4- Ingrese algunos registros:

('AAA111','a','1990-02-01 08:10',null);
('BCD222','m','1990-02-01 08:10','1990-02-01 10:10');
('BCD222','m','1990-02-01 12:00',null);
('CC1234','a','1990-02-01 12:00',null); */

INSERT INTO vehiculos
VALUES('AAA111','a','1990-02-01 08:10',null),
      ('BCD222','m','1990-02-01 08:10','1990-02-01 10:10'),
      ('BCD222','m','1990-02-01 12:00',null),
      ('CC1234','a','1990-02-01 12:00',null);

/* 5- Cree una regla para restringir los valores que se pueden ingresar en un campo "patente" (3 letras 
      seguidas de 3 dígitos): */

CREATE RULE RG_patente_patron
AS @patente LIKE '[A-Z][A-Z][A-Z][0-9][0-9][0-9]';

/* 6- Ejecute el procedimiento almacenado del sistema "sp_help" para ver que la regla creada 
      anteriormente existe: */

EXEC sp_help;

/* 7- Ejecute el procedimiento almacenado del sistema "sp_helpconstraint" para ver que la regla creada 
      anteriormente no está asociada aún a ningún campo de la tabla "vehiculos". */

EXEC sp_helpconstraint vehiculos;

-- 8-  Asocie la regla al campo "patente":

EXEC sp_bindrule RG_patente_patron,'vehiculos.patente';

-- 9- Intente ingresar un registro con valor para el campo "patente" que no cumpla con la regla.

INSERT INTO vehiculos 
VALUES('FGHIJK','a','1990-02-01 18:00',null);

-- NO cumple con la regla.

/*10- Cree otra regla que controle los valores para el campo "tipo" para que solamente puedan 
      ingresarse los caracteres "a" y "m". */

CREATE RULE RG_vehiculos_tipo
AS @tipo IN ('a','m');

-- 11- Asocie la regla al campo "tipo".

EXEC sp_bindrule RG_vehiculos_tipo,'vehiculos.tipo';

/* 12- Intente actualizar un registro cambiando el valor de "tipo" a un valor que no cumpla con la 
       regla anterior. */

UPDATE vehiculos SET tipo='c' 
WHERE patente='AAA111';

-- NO cumple con la regla.

/*13- Cree otra regla llamada "RG_vehiculos_tipo2" que controle los valores para el campo "tipo" para 
      que solamente puedan ingresarse los caracteres "a", "c" y "m". */

CREATE RULE RG_vehiculos_tipo2
AS @tipo IN ('a','c','m');

/* 14- Si la asociamos a un campo que ya tiene asociada otra regla, la nueva regla reeemplaza la 
       asociación anterior. Asocie la regla creada en el punto anterior al campo "tipo". */

EXEC sp_bindrule RG_vehiculos_tipo2,'vehiculos.tipo';

-- 15- Actualice el registro que no pudo actualizar en el punto 12:

UPDATE vehiculos SET tipo='c' 
WHERE patente='AAA111';

-- Ahora si es posible.

-- 16- Cree una regla que permita fechas menores o iguales a la actual.

CREATE RULE RG_menor_fechaactual
AS @fecha <= GETDATE();

-- 17- Asocie la regla anterior a los campos "horallegada" y "horasalida":

EXEC sp_bindrule RG_menor_fechaactual,'vehiculos.horallegada';

EXEC sp_bindrule RG_menor_fechaactual,'vehiculos.horasalida';

-- 18- Ingrese un registro en el cual la hora de entrada sea posterior a la hora de salida:

INSERT INTO vehiculos 
VALUES('NOP555','a','1990-02-01 10:10','1990-02-01 08:30');

/* 19- Intente establecer una restricción "check" que asegure que la fecha y hora de llegada a la playa 
       no sea posterior a la fecha y hora de salida: */

ALTER TABLE vehiculos
ADD CONSTRAINT CK_horallegada
CHECK(horallegada <= horasalida);

-- NO se puede por el registro que no cumple la condición.

-- 20- Elimine dicho registro:

DELETE FROM vehiculos
WHERE patente='NOP555';

-- 21- Establezca la restricción "check" que no pudo establecer en el punto 19:

ALTER TABLE vehiculos
ADD CONSTRAINT CK_horallegada
CHECK(horallegada <= horasalida);

-- 22- Cree una restricción "default" que almacene el valor "b" en el campo "tipo:

ALTER TABLE vehiculos
ADD CONSTRAINT DF_tipo
DEFAULT 'b'
FOR tipo;

-- 23- Intente ingresar un registro con el valor por defecto para el campo "tipo":

INSERT INTO vehiculos
VALUES('AAA343', DEFAULT,'1990-02-01 10:10', NULL);

-- NO se puede porque no cumple con la regla.

/*24- Vea las reglas asociadas a "empleados" y las restricciones aplicadas a la misma tabla ejecutando 
      "sp_helpconstraint". */

EXEC sp_helpconstraint vehiculos;
