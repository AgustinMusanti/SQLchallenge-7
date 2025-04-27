-- 1- Elimine la tabla "visitas", si existe:

IF OBJECT_ID('visitas') IS NOT NULL
DROP TABLE visitas;

-- 2- Créela con la siguiente estructura:

CREATE TABLE visitas (
  numero     INT IDENTITY,
  nombre     VARCHAR(30) DEFAULT 'Anonimo',
  mail       VARCHAR(50) DEFAULT 'Anonimo',
  pais       VARCHAR(20),
  fechayhora DATETIME,
  PRIMARY KEY(numero)
);

-- 3- Ingrese algunos registros:

INSERT INTO visitas
VALUES('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina','2006-10-10 10:10'),
      ('Gustavo Gonzalez','GustavoGGonzalez@gotmail.com','Chile','2006-10-10 21:30'),
      ('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-10-11 15:45'),
      ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-10-12 08:15'),
      (DEFAULT,DEFAULT,'Mexico','2006-09-12 20:45'),
      ('Juancito','JuanJosePerez@gmail.com','Argentina','2006-09-12 16:20'),
      ('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-09-15 16:25'),
      (DEFAULT,DEFAULT,'Argentina', NULL);

-- 4- Seleccione los usuarios que visitaron la página entre el '2006-09-12' y '2006-10-11'

SELECT * FROM visitas
WHERE fechayhora BETWEEN '2006-09-12' AND '2006-10-11';

-- 5- Recupere las visitas cuyo número se encuentra entre 2 y 5

SELECT * FROM visitas
WHERE numero
BETWEEN 2 AND 5;
