-- 1- Elimine la tabla "empleados", si existe, y luego créela:

IF OBJECT_ID('empleados') IS NOT NULL
DROP TABLE empleados;

CREATE TABLE empleados(
  legajo        INT NOT NULL,
  documento     CHAR(7) NOT NULL,
  nombre        VARCHAR(10),
  domicilio     VARCHAR(30),
  ciudad        VARCHAR(20) DEFAULT 'Buenos Aires',
  sueldo        DECIMAL(6,2),
  cantidadhijos TINYINT DEFAULT 0,
  PRIMARY KEY(legajo)
 );

-- 2- Modifique el campo "nombre" extendiendo su longitud.

ALTER TABLE empleados
ALTER COLUMN nombre VARCHAR(15);

-- 3- Controle la modificación:

EXEC sp_columns empleados;

-- 4- Modifique el campo "sueldo" para que no admita valores nulos.

ALTER TABLE empleados
ALTER COLUMN sueldo DECIMAL(6,2) NOT NULL;

-- 4- Modifique el campo "documento" ampliando su longitud a 8 caracteres.

ALTER TABLE empleados
ALTER COLUMN documento CHAR(8);

-- 5- Intente modificar el tipo de datos del campo "legajo" a "tinyint":

ALTER TABLE empleados
ALTER COLUMN legajo TINYINT;

-- No se puede porque tiene una restricción.

-- 6- Ingrese algunos registros, uno con "nombre" nulo:

INSERT INTO empleados
VALUES(1,'22222222','Juan Perez','Colon 123','Cordoba',500,3),
      (2,'30000000',null,'Sucre 456','Cordoba',600,2);

-- 7- Intente modificar el campo "nombre" para que no acepte valores nulos:

ALTER TABLE empleados
ALTER COLUMN nombre VARCHAR(15) NOT NULL;

-- No se puede porque hay registros con ese valor.

-- 8- Elimine el registro con "nombre" nulo y realice la modificación del punto 7:

DELETE FROM empleados WHERE nombre IS NULL;

ALTER TABLE empleados
ALTER COLUMN nombre VARCHAR(15) NOT NULL;

-- Ahora si se modifico.

-- 9- Modifique el campo "ciudad" a 10 caracteres.

ALTER TABLE empleados
ALTER COLUMN ciudad VARCHAR(10);

-- 10- Intente agregar un registro con el valor por defecto para "ciudad":

INSERT INTO empleados
VALUES(3,'33333333','Juan Perez','Sarmiento 856',default,500,4);

-- NO se puede ya que el DEFAULT posee 12 caracteres.

-- 11- Modifique el campo "ciudad" sin que afecte la restricción dándole una longitud de 15 caracteres.

ALTER TABLE empleados
ALTER COLUMN ciudad VARCHAR(15);

-- 12- Agregue el registro que no pudo ingresar en el punto 10:

INSERT INTO empleados
VALUES(3,'33333333','Juan Perez','Sarmiento 856',default,500,4);

-- 13- Intente agregar el atributo identity de "legajo".

ALTER TABLE empleados
ALTER COLUMN legajo INT IDENTITY;

-- NO se puede agregar ese atributo.
