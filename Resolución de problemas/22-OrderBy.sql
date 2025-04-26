-- 1- Elimine la tabla "visitas", si existe:

IF OBJECT_ID('visitas') IS NOT NULL
DROP TABLE visitas;

-- 2- Créela con la siguiente estructura:

CREATE TABLE visitas (
  numero INT IDENTITY,
  nombre VARCHAR(30) DEFAULT 'Anonimo',
  mail   VARCHAR(50),
  pais   VARCHAR(20),
  fecha  DATETIME,
  PRIMARY KEY(numero)
);

/* 3- Ingrese algunos registros:

('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina','2006-10-10 10:10');
('Gustavo Gonzalez','GustavoGGonzalez@hotmail.com','Chile','2006-10-10 21:30');
('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-10-11 15:45');
('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-10-12 08:15');
('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-09-12 20:45');
('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-09-12 16:20');
('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-09-15 16:25'); */

INSERT INTO visitas
VALUES('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina','2006-10-10 10:10'),
      ('Gustavo Gonzalez','GustavoGGonzalez@hotmail.com','Chile','2006-10-10 21:30'),
      ('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-10-11 15:45'),
      ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-10-12 08:15'),
      ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-09-12 20:45'),
      ('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-09-12 16:20'),
      ('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-09-15 16:25');


-- 4- Ordene los registros por fecha, en orden descendente.

SELECT * FROM visitas
ORDER BY fecha DESC;

/* 5- Muestre el nombre del usuario, pais y el nombre del mes, ordenado por pais (ascendente) y nombre 
      del mes (descendente) */

SELECT nombre, pais, DATENAME(MONTH, fecha) AS mes
FROM visitas
ORDER BY pais, mes DESC;

/* 6- Muestre el pais, el mes, el día y la hora y ordene las visitas por nombre del mes, del día y la 
      hora. */

SELECT pais,
       DATENAME(MONTH, fecha) AS mes,
	   DATENAME(DAY, fecha) AS dia,
	   DATENAME(HOUR, fecha) AS hora
FROM visitas
ORDER BY mes, dia, hora;

-- 7- Muestre los mail, país, ordenado por país, de todos los que visitaron la página en octubre.

SELECT mail, pais
FROM visitas
WHERE DATENAME(MONTH,fecha)='October'
ORDER BY pais;
