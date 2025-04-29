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

-- 4- Muestre la cantidad de registros empleando la función "count(*)".

SELECT COUNT(*)
FROM medicamentos;

-- 5- Cuente la cantidad de medicamentos que tienen laboratorio conocido

SELECT COUNT(laboratorio) AS 'Registros de Laboratorios'
FROM medicamentos;

/* 6- Cuente la cantidad de medicamentos que tienen precio distinto a "null" y que tienen cantidad 
      distinto a "null", disponer alias para las columnas. */

SELECT COUNT(precio) AS 'Con precio',
       COUNT(cantidad) AS 'Con cantidad'
FROM medicamentos;

-- 7- Cuente la cantidad de remedios con precio conocido, cuyo laboratorio comience con "B".

SELECT COUNT(precio) AS 'Cantidad de remedios con precio conocido'
FROM medicamentos
WHERE laboratorio LIKE 'B%';

-- 8- Cuente la cantidad de medicamentos con número de lote distinto de "null".

SELECT COUNT(numerolote) AS 'Numero de lote'
FROM medicamentos;
