-- 1- Elimine la tabla, si existe:

IF OBJECT_ID('alumnos') IS NOT NULL
DROP TABLE alumnos;

-- 2- Cree la tabla eligiendo el tipo de dato adecuado para cada campo:

CREATE TABLE alumnos(
  apellido        VARCHAR(30),
  nombre          VARCHAR(30),
  documento       CHAR(8),
  domicilio       VARCHAR(30),
  fechaingreso    DATETIME,
  fechanacimiento DATETIME
 );

-- 3- Setee el formato para entrada de datos de tipo fecha para que acepte valores "día-mes-año": 

SET DATEFORMAT 'dmy';

-- 4- Ingrese un alumno empleando distintos separadores para las fechas:

INSERT INTO alumnos 
VALUES('Gonzalez','Ana','22222222','Colon 123','10-08-1990','15/02/1972');

-- Veo que respeta el formato aunque utilicemos diferentes separadores.

-- 5- Ingrese otro alumno empleando solamente un dígito para día y mes y 2 para el año:

INSERT INTO alumnos
VALUES('Juarez','Bernardo','25555555','Sucre 456','3-3-91','5/2/72');

-- Compruebo la insercion:

SELECT * FROM alumnos;

-- Veo que se inserto sin problemas.

/* 6- Ingrese un alumnos empleando 2 dígitos para el año de la fecha de ingreso y "null" en 
      "fechanacimiento": */

INSERT INTO alumnos 
VALUES('Perez','Laura','26666666','Bulnes 345','03-03-91',null);

-- La inserción se realizo con exito.

/* 7- Intente ingresar un alumno con fecha de ingreso correspondiente a "15 de marzo de 1990" pero en 
      orden incorrecto "03-15-90": */

INSERT INTO alumnos 
VALUES('Lopez','Carlos','27777777','Sarmiento 1254','03-15-1990',null);

/* Aparece un mensaje de error porque SQL Server en este caso lee con el formato día, mes y año
   y no reconoce el mes 15. */

-- 8- Muestre todos los alumnos que ingresaron antes del '1-1-91'.

SELECT * FROM alumnos
WHERE fechaingreso<'1-1-91';

-- 9- Muestre todos los alumnos que tienen "null" en "fechanacimiento":

SELECT * FROM alumnos 
WHERE fechanacimiento IS NULL;

-- 10- Intente ingresar una fecha de ingreso omitiendo los separadores:

INSERT INTO alumnos
VALUES('Rosas','Romina','28888888','Avellaneda 487','03151990',null);

-- No lo acepta sin los separadores.

-- 11- Setee el formato de entrada de fechas para que acepte valores "mes-dia-año".

SET DATEFORMAT 'mdy';

-- 12- Ingrese el registro del punto 7.

INSERT INTO alumnos 
VALUES('Lopez','Carlos','27777777','Sarmiento 1254','03-15-1990',null);

SELECT * FROM alumnos;

-- La inserción se realizo de manera correcta en esta ocasión.
