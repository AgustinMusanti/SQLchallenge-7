-- 1- Elimine la tabla si existe:

IF object_id('agenda') IS NOT NULL
DROP TABLE agenda;

-- 2- Cree la tabla:

CREATE TABLE agenda(
  apellido  VARCHAR(30),
  nombre    VARCHAR(20),
  domicilio VARCHAR(30),
  telefono  VARCHAR(11)
 );

/* 3- Ingrese los siguientes registros:

('Acosta','Alberto','Colon 123','4234567');
('Juarez','Juan','Avellaneda 135','4458787');
('Lopez','Maria','Urquiza 333','4545454');
('Lopez','Jose','Urquiza 333','4545454'); 
('Suarez','Susana','Gral. Paz 1234','4123456'); */

INSERT INTO agenda
VALUES('Acosta','Alberto','Colon 123','4234567'),
      ('Juarez','Juan','Avellaneda 135','4458787'),
      ('Lopez','Maria','Urquiza 333','4545454'),
      ('Lopez','Jose','Urquiza 333','4545454'),
      ('Suarez','Susana','Gral. Paz 1234','4123456');

SELECT * FROM agenda -- Veo como quedo constituida la tabla

-- 4- Modifique el registro cuyo nombre sea "Juan" por "Juan Jose"

UPDATE agenda SET nombre='Juan Jose'
WHERE nombre='Juan';

-- 5- Actualice los registros cuyo número telefónico sea igual a "4545454" por "4445566" 

UPDATE agenda SET telefono='4445566'
WHERE telefono='4545454';

-- 6- Actualice los registros que tengan en el campo "nombre" el valor "Juan" por "Juan Jose"

UPDATE agenda SET nombre='Juan Jose'
WHERE nombre='Juan';

-- 7 - Ejecute un select que muestre todos los registros de la tabla.

SELECT * FROM agenda;
