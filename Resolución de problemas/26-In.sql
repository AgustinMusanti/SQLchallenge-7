-- 1- Elimine la tabla "medicamentos", si existe:

IF OBJECT_ID('medicamentos') IS NOT NULL
DROP TABLE medicamentos;

-- 2- Cree la tabla con la siguiente estructura:

CREATE TABLE medicamentos(
  codigo           INT IDENTITY PRIMARY KEY,
  nombre           VARCHAR(20),
  laboratorio      VARCHAR(20),
  precio           DECIMAL(6,2),
  cantidad         TINYINT,
  fechavencimiento DATETIME NOT NULL,
 );

/* 3- Ingrese algunos registros:

('Sertal','Roche',5.2,1,'2015-02-01');
('Buscapina','Roche',4.10,3,'2016-03-01');
('Amoxidal 500','Bayer',15.60,100,'2017-05-01');
('Paracetamol 500','Bago',1.90,20,'2018-02-01');
('Bayaspirina','Bayer',2.10,150,'2019-12-01'); 
('Amoxidal jarabe','Bayer',5.10,250,'2020-10-01'); */

INSERT INTO medicamentos
VALUES('Sertal','Roche',5.2,1,'2015-02-01'),
      ('Buscapina','Roche',4.10,3,'2016-03-01'),
      ('Amoxidal 500','Bayer',15.60,100,'2017-05-01'),
      ('Paracetamol 500','Bago',1.90,20,'2018-02-01'),
      ('Bayaspirina','Bayer',2.10,150,'2019-12-01'),
      ('Amoxidal jarabe','Bayer',5.10,250,'2020-10-01');

/*4- Recupere los nombres y precios de los medicamentos cuyo laboratorio sea "Bayer" o "Bago" 
     empleando el operador "in" */

SELECT nombre, precio
from medicamentos
WHERE laboratorio IN('Bayer','Bago');

/* 5- Seleccione los remedios cuya cantidad se encuentre entre 1 y 5 empleando el operador "between" y 
      luego el operador "in". */

SELECT * FROM medicamentos
WHERE cantidad 
BETWEEN 1 AND 5;

SELECT * FROM medicamentos
WHERE cantidad
IN(1,2,3,4,5);

-- Es mas práctico en este caso usar BETWEEN.
