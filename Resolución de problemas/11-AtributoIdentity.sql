-- 1- Elimine la tabla "Medicamentos",si existe:

IF object_id('medicamentos') IS NOT NULL
DROP TABLE medicamentos;

-- 2- Cree la tabla con un campo "codigo" que genere valores secuenciales automáticamente:

CREATE TABLE medicamentos(
  codigo      INT IDENTITY,
  nombre      VARCHAR(20) not null,
  laboratorio VARCHAR(20),
  precio      FLOAT,
  cantidad    INTEGER
 );

-- 3- Visualice la estructura de la tabla "medicamentos":

EXEC sp_columns medicamentos;

/* 4- Ingrese los siguientes registros:

('Sertal','Roche',5.2,100);
('Buscapina','Roche',4.10,200);
('Amoxidal 500','Bayer',15.60,100); */

INSERT INTO medicamentos
VALUES('Sertal','Roche',5.2,100),
      ('Buscapina','Roche',4.10,200),
      ('Amoxidal 500','Bayer',15.60,100);

-- 5- Verifique que SQL Server generó valores para el campo "código" de modo automático:

SELECT * FROM medicamentos;

-- 6- Intente ingresar un registro con un valor para el campo "codigo"

INSERT INTO medicamentos
VALUES(4,'Amoxidal Duo','Bayer',99.9,50);

-- No es posible.

-- 7- Intente actualizar un valor de código

UPDATE medicamentos SET codigo=5
WHERE nombre='Bayaspirina';

-- No es posible.

-- 8- Elimine el registro con codigo "3"

DELETE FROM medicamentos
WHERE codigo=3;

-- 9- Ingrese un nuevo registro:

INSERT INTO medicamentos
VALUES('Amoxidal Duo','Bayer',99.9,50);

-- 10- Seleccione todos los registros para ver qué valor guardó SQL Server en el campo código:

SELECT * FROM medicamentos;

-- Vemos que SQL Server siguio con el codigo 4 a pesar de que el 3 ya ha sido borrado.
