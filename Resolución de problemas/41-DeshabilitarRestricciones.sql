-- 1- Elimine la tabla "empleados" (si existe):

IF OBJECT_ID('empleados') IS NOT NULL
DROP TABLE empleados;

/* 2- Créela con la siguiente estructura e ingrese los registros siguientes:

 create table empleados (
  documento varchar(8),
  nombre varchar(30),
  seccion varchar(20),
  sueldo decimal(6,2)
 );

('22222222','Alberto Acosta','Sistemas',-10);
('33333333','Beatriz Benitez','Recursos',3000);
('34444444','Carlos Caseres','Contaduria',4000); */

CREATE TABLE empleados (
  documento VARCHAR(8),
  nombre    VARCHAR(30),
  seccion   VARCHAR(20),
  sueldo    DECIMAL(6,2)
 );

 INSERT INTO empleados
 VALUES('22222222','Alberto Acosta','Sistemas',-10),
       ('33333333','Beatriz Benitez','Recursos',3000),
       ('34444444','Carlos Caseres','Contaduria',4000);

/* 3- Intente agregar una restricción "check" para asegurarse que no se ingresen valores negativos para 
      el sueldo: */

ALTER TABLE empleados
ADD CONSTRAINT CK_sueldo_positivo
CHECK (sueldo>=0);

-- NO se puede ya que existe un valor con sueldo negativo.

-- 4- Vuelva a intentarlo agregando la opción "with nocheck":

ALTER TABLE empleados
WITH NOCHECK
ADD CONSTRAINT CK_sueldo_positivo
CHECK (sueldo>=0);

-- Ahora si se ejecuta.

-- 5- Intente ingresar un valor negativo para sueldo:

INSERT INTO empleados
VALUES('35555555','Daniel Duarte','Administracion',-2000);

-- No es posible debido a la restriccion que hemos creado.

-- 6- Deshabilite la restricción e ingrese el registro anterior:

ALTER TABLE empleados
NOCHECK CONSTRAINT CK_sueldo_positivo;

/* 7- Establezca una restricción "check" para "seccion" que permita solamente los valores "Sistemas", 
      "Administracion" y "Contaduría": */

ALTER TABLE empleados
ADD CONSTRAINT CK_seccion
CHECK (seccion in('Sistemas','Administracion', 'Contaduría'));

-- NO se ejecuta ya que existe un valor fuera de la lista.

-- 8- Establezca la restricción anterior evitando que se controlen los datos existentes.

ALTER TABLE empleados
WITH NOCHECK
ADD CONSTRAINT CK_seccion
CHECK (seccion in('Sistemas','Administracion', 'Contaduría'));

-- 9- Vea si las restricciones de la tabla están o no habilitadas:

EXEC sp_helpconstraint empleados;

-- 10- Habilite la restricción deshabilitada.

ALTER TABLE empleados
CHECK CONSTRAINT CK_sueldo_positivo;

-- 11- Intente modificar la sección del empleado "Carlos Caseres" a "Recursos".

UPDATE empleados SET seccion='Recursos'
WHERE nombre='Carlos Caseres';

-- La restricción no lo permite.

-- 12- Deshabilite la restricción para poder realizar la actualización del punto precedente.

ALTER TABLE empleados
NOCHECK CONSTRAINT CK_seccion;

UPDATE empleados SET seccion='Recursos'
WHERE nombre='Carlos Caseres';

SELECT * FROM empleados;
