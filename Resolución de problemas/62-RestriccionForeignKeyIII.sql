-- 1- Elimine las tablas "clientes" y "provincias", si existen:

IF OBJECT_ID('clientes') IS NOT NULL
DROP TABLE clientes;

IF OBJECT_ID('provincias') IS NOT NULL
DROP TABLE provincias;

-- 2- Créelas con las siguientes estructuras:

CREATE TABLE clientes (
  codigo          INT IDENTITY,
  nombre          VARCHAR(30),
  domicilio       VARCHAR(30),
  ciudad          VARCHAR(20),
  codigoprovincia TINYINT,
  PRIMARY KEY(codigo)
 );

CREATE TABLE provincias(
  codigo TINYINT,
  nombre VARCHAR(20),
  PRIMARY KEY(codigo)
 );

-- 3- Ingrese algunos registros para ambas tablas:

INSERT INTO provincias
VALUES(1,'Cordoba'),
      (2,'Santa Fe'),
      (3,'Misiones'),
      (4,'Rio Negro');

INSERT INTO clientes
VALUES('Perez Juan','San Martin 123','Carlos Paz',1),
      ('Moreno Marcos','Colon 234','Rosario',2),
      ('Garcia Juan','Sucre 345','Cordoba',1),
      ('Lopez Susana','Caseros 998','Posadas',3),
      ('Marcelo Moreno','Peru 876','Viedma',4),
      ('Lopez Sergio','Avellaneda 333','La Plata',5);

/* 4- Intente agregar una restricción "foreign key" para que los códigos de provincia de "clientes" 
      existan en "provincias" con acción en cascada para actualizaciones y eliminaciones, sin especificar 
      la opción de comprobación de datos: */

ALTER TABLE clientes ADD CONSTRAINT FK_clientes_codigoprovincia
FOREIGN KEY(codigoprovincia) REFERENCES provincias(codigo)
ON UPDATE CASCADE
ON DELETE CASCADE;

/* No se puede porque al no especificar opción para la comprobación de datos, por defecto es "check" y 
   hay un registro que no cumple con la restricción. */

-- 5- Agregue la restricción anterior pero deshabilitando la comprobación de datos existentes:

ALTER TABLE clientes
WITH NOCHECK
ADD CONSTRAINT FK_clientes_codigoprovincia
FOREIGN KEY(codigoprovincia) REFERENCES provincias(codigo)
ON UPDATE CASCADE
ON DELETE CASCADE;

-- 6- Vea las restricciones de "clientes":

EXEC sp_helpconstraint clientes;

-- 7- Vea las restricciones de "provincias":

EXEC sp_helpconstraint provincias;

-- 8- Deshabilite la restricción "foreign key" de "clientes":

ALTER TABLE clientes
NOCHECK CONSTRAINT FK_clientes_codigoprovincia;

-- 9- Vea las restricciones de "clientes":

EXEC sp_helpconstraint clientes;

-- 10- Vea las restricciones de "provincias":

EXEC sp_helpconstraint provincias;

-- 11- Agregue un registro que no cumpla la restricción "foreign key":

INSERT INTO clientes
VALUES('Garcia Omar','San Martin 100','La Pampa',6);

-- Se permite porque la restricción esta deshabilitada.

-- 12- Elimine una provincia de las cuales haya clientes:

DELETE FROM provincias
WHERE codigo=2;

-- 13- Corrobore que el registro se eliminó de "provincias" pero no se extendió a "clientes":

SELECT * FROM clientes;

SELECT * FROM provincias;

-- Comprobado.

-- 14- Modifique un código de provincia de la cual haya clientes:

UPDATE provincias SET codigo=9
WHERE codigo=3;

-- 15- Verifique que el cambio se realizó en "provincias" pero no se extendió a "clientes":

SELECT * FROM clientes;

SELECT * FROM provincias;

-- 16- Intente eliminar la tabla "provincias":

DROP TABLE provincias;

-- NO se puede por FK, aunque este deshabilitada.

-- 17- Habilite la restricción "foreign key".

ALTER TABLE clientes
CHECK CONSTRAINT FK_clientes_codigoprovincia;

-- 18- Intente agregar un cliente con código de provincia inexistente en "provincias":

INSERT INTO clientes
VALUES('Hector Ludueña','Paso 123','La Plata',8);

-- NO se permite por la restricción.

-- 19- Modifique un código de provincia al cual se haga referencia en "clientes":

UPDATE provincias SET codigo=20
WHERE codigo=4;

-- 20- Vea que se modificaron en ambas tablas:

SELECT * FROM CLIENTES;

SELECT * FROM provincias;

-- Ahora si se actualizo en cascada.

-- 21- Elimine una provincia de la cual haya referencia en "clientes":

DELETE FROM provincias
WHERE codigo=1;

-- 22- Vea que los registros de ambas tablas se eliminaron:

SELECT * FROM CLIENTES;

SELECT * FROM provincias; 

-- Se efectuó la eliminación en cascada.

-- 23- Elimine la restriccion "foreign key":

ALTER TABLE clientes
DROP CONSTRAINT FK_clientes_codigoprovincia;

-- 24- Vea las restriciones de la tabla "provincias":

EXEC sp_helpconstraint provincias;

-- 25- Elimine la tabla "provincias":

DROP TABLE provincias;

-- Puede eliminarse porque no hay restricción "foreign key" que la referencie.
