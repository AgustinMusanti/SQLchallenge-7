-- 1- Elimine la tabla "empleados" si existe:

IF OBJECT_ID('empleados') IS NOT NULL
DROP TABLE empleados;

-- 2- Créela con la siguiente estructura:

CREATE TABLE empleados (
  documento   VARCHAR(8) NOT NULL,
  nombre      VARCHAR(30),
  estadocivil CHAR(1),--c=casado, s=soltero,v=viudo
  seccion     VARCHAR(20)
 );

/* 3- Ingrese algunos registros:

('22222222','Alberto Lopez','c','Sistemas');
('23333333','Beatriz Garcia','c','Administracion');
('24444444','Carlos Fuentes','s','Administracion');
('25555555','Daniel Garcia','s','Sistemas');
('26666666','Ester Juarez','c','Sistemas');
('27777777','Fabian Torres','s','Sistemas');
('28888888','Gabriela Lopez',null,'Sistemas');
('29999999','Hector Garcia',null,'Administracion'); */

INSERT INTO empleados
VALUES('22222222','Alberto Lopez','c','Sistemas'),
      ('23333333','Beatriz Garcia','c','Administracion'),
      ('24444444','Carlos Fuentes','s','Administracion'),
      ('25555555','Daniel Garcia','s','Sistemas'),
      ('26666666','Ester Juarez','c','Sistemas'),
      ('27777777','Fabian Torres','s','Sistemas'),
      ('28888888','Gabriela Lopez',null,'Sistemas'),
      ('29999999','Hector Garcia',null,'Administracion');

-- 4- Muestre los 5 primeros registros

SELECT TOP 5 * FROM empleados;

-- 5- Muestre nombre y seccion de los 4 primeros registros ordenados por sección

SELECT TOP 4 nombre, seccion
FROM empleados
ORDER BY seccion;

/* 6- Realice la misma consulta anterior pero incluya todos los registros que tengan el mismo valor en 
      "seccion" que el último */

SELECT TOP 4 WITH TIES nombre, seccion
FROM empleados
ORDER BY seccion;

/*7- Muestre nombre, estado civil y seccion de los primeros 4 empleados ordenados por estado civil y 
     sección */

SELECT TOP 4 nombre, estadocivil, seccion
FROM empleados
ORDER BY estadocivil, seccion;

/* 8- Realice la misma consulta anterior pero incluya todos los valores iguales al último registro 
      retornado */

SELECT TOP 4 WITH TIES nombre, estadocivil, seccion
FROM empleados
ORDER BY estadocivil, seccion;
