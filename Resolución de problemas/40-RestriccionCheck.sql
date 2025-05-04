-- 1- Elimine la tabla "empleados" si existe:

IF OBJECT_ID('empleados') IS NOT NULL
DROP TABLE empleados;

-- 2- Créela con la siguiente estructura:

CREATE TABLE empleados (
  documento       VARCHAR(8),
  nombre          VARCHAR(30),
  fechanacimiento DATETIME,
  cantidadhijos   TINYINT,
  seccion         VARCHAR(20),
  sueldo          DECIMAL(6,2)
 );

/* 3- Agregue una restricción "check" para asegurarse que no se ingresen valores negativos para el 
      sueldo: */

ALTER TABLE empleados
ADD CONSTRAINT CK_sueldo_positivo
CHECK (sueldo>=0);

/* 4- Ingrese algunos registros válidos:

('22222222','Alberto Lopez','1965/10/05',1,'Sistemas',1000);
('33333333','Beatriz Garcia','1972/08/15',2,'Administracion',3000);
('34444444','Carlos Caseres','1980/10/05',0,'Contaduría',6000); */

INSERT INTO empleados
VALUES('22222222','Alberto Lopez','1965/10/05',1,'Sistemas',1000),
      ('33333333','Beatriz Garcia','1972/08/15',2,'Administracion',3000),
      ('34444444','Carlos Caseres','1980/10/05',0,'Contaduría',6000);

/* 5- Intente agregar otra restricción "check" al campo sueldo para asegurar que ninguno supere el 
      valor 5000: */

ALTER TABLE empleados
ADD CONSTRAINT CK_sueldo_limite
CHECK (sueldo<=5000);

-- La consulta no se ejecuta ya que hay un sueldo que no cumple con la condición.

-- 6- Elimine el registro infractor y vuelva a crear la restricción:

DELETE FROM empleados
WHERE sueldo>5000;

ALTER TABLE empleados
ADD CONSTRAINT CK_sueldo_limite
CHECK (sueldo<=5000);

-- Ahora si se ejecuta

/* 7- Establezca una restricción para controlar que la fecha de nacimiento que se ingresa no supere la 
      fecha actual: */

ALTER TABLE empleados
ADD CONSTRAINT CK_fechanacimiento
CHECK (fechanacimiento<GETDATE());

/* 8- Establezca una restricción "check" para "seccion" que permita solamente los valores "Sistemas", 
      "Administracion" y "Contaduría": */

ALTER TABLE empleados
ADD CONSTRAINT CK_seccion
CHECK (seccion IN('Sistemas', 'Administracion', 'Contaduría'));

/* 9- Establezca una restricción "check" para "cantidadhijos" que permita solamente valores entre 0 y 
      15. */

ALTER TABLE empleados
ADD CONSTRAINT CK_cantidadhijos
CHECK (cantidadhijos BETWEEN 0 AND 15);

-- 10- Vea todas las restricciones de la tabla:

EXEC SP_HELPCONSTRAINT empleados;

-- 11- Intente agregar un registro que vaya contra alguna de las restricciones al campo "sueldo".

INSERT INTO empleados
VALUES('52525252','Valentina','1965/10/05',1,'Sistemas',7000);

-- No es posible ya que no cumple con el check.

-- 12- Intente agregar un registro con fecha de nacimiento futura.

INSERT INTO empleados
VALUES('52525252','Valentina','2025/10/05',1,'Sistemas',3000);

-- No cumple con el check.

-- 13- Intente modificar un registro colocando en "cantidadhijos" el valor "21".

INSERT INTO empleados
VALUES('52525252','Valentina','1995/10/05',21,'Sistemas',3000);

-- No cumple con el check.

/* 14- Intente modificar el valor de algún registro en el campo "seccion" cambiándolo por uno que no 
       esté incluido en la lista de permitidos. */

UPDATE empleados SET sueldo=5001
WHERE sueldo=1000;

-- No es posible por el check.

/* 15- Intente agregar una restricción al campo sección para aceptar solamente valores que comiencen 
       con la letra "B": */

ALTER TABLE empleados
ADD CONSTRAINT CK_seccion_b
CHECK (seccion LIKE '%B');

-- No es posible ya que hay otro check creado para ese campo.
