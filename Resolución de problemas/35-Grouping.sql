-- 1- Elimine la tabla "empleados", si existe:

IF OBJECT_ID('empleados') IS NOT NULL
DROP TABLE empleados;

-- 2- Créela con la siguiente estructura:

CREATE TABLE empleados (
  documento   VARCHAR(8) NOT NULL,
  nombre      VARCHAR(30),
  sexo        CHAR(1),
  estadocivil CHAR(1),--c=casado, s=soltero,v=viudo
  seccion     VARCHAR(20),
  PRIMARY KEY(documento)
 );

/* 3- Ingrese algunos registros:

('22222222','Alberto Lopez','m','c','Sistemas');
('23333333','Beatriz Garcia','f','c','Administracion');
('24444444','Carlos Fuentes','m','s','Administracion');
('25555555','Daniel Garcia','m','s','Sistemas');
('26666666','Ester Juarez',null,'c','Sistemas');
('27777777','Fabian Torres',null,'s','Sistemas');
('28888888','Gabriela Lopez','f',null,'Sistemas');
('29999999','Hector Garcia','m',null,'Administracion'); */

INSERT INTO empleados
VALUES('22222222','Alberto Lopez','m','c','Sistemas'),
      ('23333333','Beatriz Garcia','f','c','Administracion'),
      ('24444444','Carlos Fuentes','m','s','Administracion'),
      ('25555555','Daniel Garcia','m','s','Sistemas'),
      ('26666666','Ester Juarez',null,'c','Sistemas'),
      ('27777777','Fabian Torres',null,'s','Sistemas'),
      ('28888888','Gabriela Lopez','f',null,'Sistemas'),
      ('29999999','Hector Garcia','m',null,'Administracion');

-- 4- Cuente la cantidad de empleados agrupados por sexo y estado civil, empleando "rollup".

SELECT sexo, estadocivil,
       COUNT(*) AS 'Cantidad de empleados'
FROM empleados
GROUP BY sexo, estadocivil
WITH ROLLUP;

/* 5- Realice la misma consulta anterior pero emplee la función "grouping" para los dos campos por los 
      que se agrupa para distinguir los valores de resumen y de detalle. */

SELECT sexo, estadocivil,
       COUNT(*) AS 'Cantidad de empleados',
       GROUPING(sexo) AS 'Resumen Sexo',
       GROUPING(estadocivil) AS 'Resumen Estado Civil'
FROM empleados
GROUP BY sexo, estadocivil
WITH ROLLUP;

/* 6- Realice la misma consulta anterior pero con "cube" en lugar de "rollup", distinguiendo los 
      valores de resumen y de detalle. */

SELECT sexo, estadocivil,
       COUNT(*) AS 'Cantidad de empleados',
       GROUPING(sexo) AS 'Resumen Sexo',
       GROUPING(estadocivil) AS 'Resumen Estado Civil'
FROM empleados
GROUP BY sexo, estadocivil
WITH CUBE;
