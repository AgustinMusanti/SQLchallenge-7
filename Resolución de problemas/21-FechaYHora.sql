-- 1- Elimine la tabla si existe:

IF OBJECT_ID('empleados') IS NOT NULL
DROP TABLE empleados;

-- 2- Cree la tabla:

CREATE TABLE empleados(
  nombre          VARCHAR(30) NOT NULL,
  apellido        VARCHAR(20) NOT NULL,
  documento       CHAR(8),
  fechanacimiento DATETIME,
  fechaingreso    DATETIME,
  sueldo          DECIMAL(6,2),
  PRIMARY KEY(documento)
 );

-- 3- Ingrese algunos registros:

INSERT INTO empleados
VALUES('Ana','Acosta','22222222','1970/10/10','1995/05/05',228.50),
      ('Carlos','Caseres','25555555','1978/02/06','1998/05/05',309),
      ('Francisco','Garcia','26666666','1978/10/15','1998/10/02',250.68),
      ('Gabriela','Garcia','30000000','1985/10/25','2000/12/22',300.25),
      ('Luis','Lopez','31111111','1987/02/10','2000/08/21',350.98);

/* 4- Muestre nombre y apellido concatenados, con el apellido en letras mayúsculas, el documento 
      precedido por "DNI Nº " y el sueldo precedido por "$ ". */

-- Utilizando STUFF

SELECT nombre+SPACE(1)+UPPER(apellido) AS nombre,
  STUFF(documento,1,0,'DNI Nº ') AS documento,
  STUFF(sueldo,1,0,'$ ') AS sueldo 
 FROM empleados;

 -- Forma simple

SELECT 
  nombre + ' ' + UPPER(apellido) AS nombre,
  'DNI Nº ' + documento AS documento,
  '$ ' + CAST(sueldo AS VARCHAR) AS sueldo
FROM empleados;

-- 5- Muestre el documento y el sueldo redondeado hacia arriba y precedido por "$ ".

SELECT documento, STUFF(CEILING(sueldo),1,0,'$ ') AS 'Sueldo redondeado' 
FROM empleados;

-- 6- Muestre los nombres y apellidos de los empleados que cumplen años en el mes "october"

SELECT * FROM empleados
WHERE DATENAME(MONTH,fechanacimiento)='october';

-- 7- Muestre los nombres y apellidos de los empleados que ingresaron en un determinado año

SELECT nombre, apellido FROM empleados
WHERE DATEPART(YEAR, fechaingreso)=2000;
