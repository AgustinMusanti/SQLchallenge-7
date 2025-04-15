-- 1- Elimine la tabla "agenda" si existe:

IF object_id('agenda') IS NOT NULL
DROP TABLE agenda;

/* 2- Cree la tabla con los siguientes campos: 

      apellido (cadena de 30), nombre (cadena de 20), 
      domicilio (cadena de 30) y telefono (cadena de 11): */

CREATE TABLE agenda(
apellido  VARCHAR(30),
nombre    VARCHAR(20),
domicilio VARCHAR(30),
telefono  VARCHAR(11)
);

/* 3- Ingrese los siguientes registros:

 (Alvarez,Alberto,Colon 123,4234567),
 (Juarez,Juan,Avellaneda 135,4458787),
 (Lopez,Maria,Urquiza 333,4545454),
 (Lopez,Jose,Urquiza 333,4545454),
 (Salas,Susana,Gral. Paz 1234,4123456). */

 INSERT INTO agenda
 VALUES('Alvarez','Alberto','Colon 123','4234567'),
       ('Juarez','Juan','Avellaneda 135','4458787'),
       ('Lopez','Maria','Urquiza 333','4545454'),
       ('Lopez','Jose','Urquiza 333','4545454'),
       ('Salas','Susana','Gral. Paz 1234','4123456');

-- 4- Elimine el registro cuyo nombre sea "Juan"

DELETE FROM agenda
WHERE nombre='Juan';

-- 5- Elimine los registros cuyo número telefónico sea igual a "4545454"

DELETE FROM agenda
WHERE telefono='4545454';

-- 6- Muestre la tabla.

SELECT * FROM agenda;

-- 7- Elimine todos los registros

DELETE FROM agenda;

-- 8- Muestre la tabla.

SELECT * FROM agenda;
