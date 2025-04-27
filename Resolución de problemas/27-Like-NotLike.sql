-- 1- Elimine la tabla "empleados", si existe:

IF OBJECT_ID('empleados') IS NOT NULL
DROP TABLE empleados;

-- 2- Cree la tabla:

CREATE TABLE empleados(
  nombre       VARCHAR(30),
  documento    CHAR(8),
  domicilio    VARCHAR(30),
  fechaingreso DATETIME,
  seccion      VARCHAR(20),
  sueldo       DECIMAL(6,2),
  PRIMARY KEY(documento)
 );

/* 3- Ingrese algunos registros:

('Juan Perez','22333444','Colon 123','1990-10-08','Gerencia',900.50);
('Ana Acosta','23444555','Caseros 987','1995-12-18','Secretaria',590.30);
('Lucas Duarte','25666777','Sucre 235','2005-05-15','Sistemas',790);
('Pamela Gonzalez','26777888','Sarmiento 873','1999-02-12','Secretaria',550);
('Marcos Juarez','30000111','Rivadavia 801','2002-09-22','Contaduria',630.70);
('Yolanda Perez','35111222','Colon 180','1990-10-08','Administracion',400);
('Rodolfo Perez','35555888','Coronel Olmedo 588','1990-05-28','Sistemas',800); */

INSERT INTO empleados
VALUES('Juan Perez','22333444','Colon 123','1990-10-08','Gerencia',900.50),
      ('Ana Acosta','23444555','Caseros 987','1995-12-18','Secretaria',590.30),
      ('Lucas Duarte','25666777','Sucre 235','2005-05-15','Sistemas',790),
      ('Pamela Gonzalez','26777888','Sarmiento 873','1999-02-12','Secretaria',550),
      ('Marcos Juarez','30000111','Rivadavia 801','2002-09-22','Contaduria',630.70),
      ('Yolanda Perez','35111222','Colon 180','1990-10-08','Administracion',400),
      ('Rodolfo Perez','35555888','Coronel Olmedo 588','1990-05-28','Sistemas',800);

-- 4- Muestre todos los empleados con apellido "Perez" empleando el operador "like".

SELECT * FROM empleados
WHERE nombre LIKE '%Perez%';

-- 5- Muestre todos los empleados cuyo domicilio comience con "Co" y tengan un "8".

SELECT * FROM empleados
WHERE domicilio LIKE 'Co%8%';

-- 6- Seleccione todos los empleados cuyo documento finalice en 0,2,4,6 u 8.

SELECT * FROM empleados
WHERE documento LIKE '%[02468]';

/* 7- Seleccione todos los empleados cuyo documento NO comience con 1 ni 3 y cuyo nombre finalice en 
      "ez" */

SELECT * FROM empleados
WHERE documento NOT LIKE '[^13]%'
AND nombre LIKE '%ez';

-- 8- Recupere todos los nombres que tengan una "y" o una "j" en su nombre o apellido

SELECT * FROM empleados
WHERE nombre LIKE '%[yj]%';

/* 9- Muestre los nombres y sección de los empleados que pertenecen a secciones que comiencen con "S" o 
      "G" y tengan 8 caracteres. */

SELECT nombre,seccion FROM empleados
WHERE seccion LIKE'[SG]_______';

/* 10- Muestre los nombres y sección de los empleados que pertenecen a secciones que NO comiencen con 
"S" o "G". */

SELECT nombre,seccion FROM empleados
WHERE seccion NOT LIKE'[SG]%';

-- 11- Muestre todos los nombres y sueldos de los empleados cuyos sueldos incluyen centavos.

SELECT nombre,sueldo FROM empleados
WHERE sueldo NOT LIKE '%.00';

-- 12- Muestre los empleados que hayan ingresado en "1990".

SELECT * FROM empleados
WHERE fechaingreso LIKE '%1990%';
