-- 1- Elimine la tabla "vehiculos", si existe:

IF OBJECT_ID('vehiculos') IS NOT NULL
DROP TABLE vehiculos;

-- 2- Elimine las siguientes reglas, si existen:

IF OBJECT_ID('RG_patente_patron') IS NOT NULL
DROP RULE RG_patente_patron;

IF OBJECT_ID('RG_vehiculos_tipo') IS NOT NULL
DROP RULE RG_vehiculos_tipo;

IF OBJECT_ID('RG_vehiculos_tipo2') IS NOT NULL
DROP RULE RG_vehiculos_tipo2;

-- 3- Cree la tabla:

CREATE TABLE vehiculos(
  patente     CHAR(6) NOT NULL,
  tipo        CHAR(1),--'a'=auto, 'm'=moto
  horallegada DATETIME NOT NULL,
  horasalida  DATETIME
 );

/* 4- Cree una regla para restringir los valores que se pueden ingresar en un campo "patente" (3 letras 
      seguidas de 3 dígitos): */

CREATE RULE RG_patente_patron
AS @patente LIKE '[A-Z][A-Z][A-Z][0-9][0-9][0-9]';

-- 5-Asocie la regla al campo "patente":

EXEC sp_bindrule RG_patente_patron,'vehiculos.patente';

-- 6- Intente ingresar un registro con valor para el campo "patente" que no cumpla con la regla:

INSERT INTO vehiculos 
VALUES('FGHIJK','a','1990-02-01 18:00',null);

-- NO es posible debido a la regla.

/*7- Cree otra regla que controle los valores para el campo "tipo" para que solamente puedan 
     ingresarse los caracteres "a" y "m": */

CREATE RULE RG_vehiculos_tipo
AS @tipo IN ('a','m');

-- 8- Asocie la regla al campo "tipo":

EXEC sp_bindrule RG_vehiculos_tipo,'vehiculos.tipo';

-- 9- Intente ingresar un registro con el valor 'c' para "tipo":

INSERT INTO vehiculos 
VALUES('FGH123','c','1990-02-01 18:00',null);

-- NO es posible debido a la regla.

/* 10- Cree otra regla llamada "RG_vehiculos_tipo2" que controle los valores para el campo "tipo" para 
       que solamente puedan ingresarse los caracteres "a", "c" y "m": */

CREATE RULE RG_vehiculos_tipo2
AS @tipo IN ('a','m', 'c');

/* 11- Si la asociamos a un campo que ya tiene asociada otra regla, la nueva regla reeemplaza la 
       asociación anterior. Asocie la regla creada en el punto anterior al campo "tipo". */

EXEC sp_bindrule RG_vehiculos_tipo2,'vehiculos.tipo';

-- 12- Ingrese el registro que no pudo ingresar en el punto 9.

INSERT INTO vehiculos 
VALUES('FGH123','c','1990-02-01 18:00',null);

-- Ahora si es posible.

-- 13- Intente eliminar la regla "RG_vehiculos_tipo2".

DROP RULE RG_vehiculos_tipo2;

-- No se puede porque esta asociada a una columna.

-- 14- Elimine la regla "RG_vehiculos_tipo".

DROP RULE RG_vehiculos_tipo;

-- 15- Intente eliminar la regla "RG_patente_patron".

DROP RULE RG_patente_patron;

-- No se puede porque esta asociada a una columna.

-- 16- Quite la asociación de la regla con el campo "patente" de "vehiculos".

EXEC sp_unbindrule 'vehiculos.patente';

-- 17- Vea si la regla "RG_patente_patron" está asociada a algún campo de "vehiculos".

EXEC sp_helpconstraint vehiculos;

-- Ya no esta asociada.

-- 18- Verifique que la regla aún existe en la base de datos activa:

EXEC sp_help;

-- 19- Elimine la regla que no pudo eliminar en el punto 15.

DROP RULE RG_patente_patron;

-- 20- Verifique que la regla ya no existe en la base de datos activa.

EXEC sp_help;
