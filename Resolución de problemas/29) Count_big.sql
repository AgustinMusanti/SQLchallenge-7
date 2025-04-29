-- 1- Elimine la tabla "medicamentos", si existe:

IF OBJECT_ID('medicamentos') IS NOT NULL
DROP TABLE medicamentos;

-- 2- Cree la tabla con la siguiente estructura:

CREATE TABLE medicamentos(
  codigo           INT IDENTITY,
  nombre           VARCHAR(20),
  laboratorio      VARCHAR(20),
  precio           DECIMAL(6,2),
  cantidad         TINYINT,
  fechavencimiento DATETIME NOT NULL,
  numerolote       INT DEFAULT NULL,
 PRIMARY KEY(codigo)
 );

/* 3- Ingrese algunos registros:

('Sertal','Roche',5.2,1,'2015-02-01',null);
('Buscapina','Roche',4.10,3,'2016-03-01',null);
('Amoxidal 500','Bayer',15.60,100,'2017-05-01',null);
('Paracetamol 500','Bago',1.90,20,'2018-02-01',null);
('Bayaspirina',null,2.10,null,'2019-12-01',null); 
('Amoxidal jarabe','Bayer',null,250,'2019-12-15',null); */

INSERT INTO medicamentos
VALUES('Sertal','Roche',5.2,1,'2015-02-01',null),
      ('Buscapina','Roche',4.10,3,'2016-03-01',null),
      ('Amoxidal 500','Bayer',15.60,100,'2017-05-01',null),
      ('Paracetamol 500','Bago',1.90,20,'2018-02-01',null),
      ('Bayaspirina',null,2.10,null,'2019-12-01',null),
      ('Amoxidal jarabe','Bayer',null,250,'2019-12-15',null);


-- 4- Muestre la cantidad de registros empleando la función "count_big(*)".

SELECT COUNT_BIG(*)
FROM medicamentos;

-- 5- Cuente la cantidad de laboratorios distintos.

SELECT COUNT_BIG(DISTINCT laboratorio) AS 'Laboratorios distintos'
FROM medicamentos;

-- 6- Cuente la cantidad de medicamentos que tienen precio y cantidad distinto de "null".

SELECT COUNT_BIG(precio) AS 'Con precio',
       COUNT_BIG(cantidad) AS 'Con cantidad'
FROM medicamentos;
