-- 1- Elimine "agenda", si existe:

IF object_id('agenda') IS NOT NULL
DROP TABLE agenda;

/* 2- Cree la tabla, con los siguientes campos: apellido (cadena de 30), nombre (cadena de 20), 
      domicilio (cadena de 30) y telefono (cadena de 11). */

CREATE TABLE agenda(
apellido  VARCHAR(30),
nombre    VARCHAR(20),
domicilio VARCHAR(30),
telefono  VARCHAR(11)
);

-- 3- Visualice la estructura de la tabla "agenda".

EXEC sp_columns agenda;

/* 4- Ingrese los siguientes registros:

 Acosta, Ana, Colon 123, 4234567;
 Bustamante, Betina, Avellaneda 135, 4458787;
 Lopez, Hector, Salta 545, 4887788; 
 Lopez, Luis, Urquiza 333, 4545454;
 Lopez, Marisa, Urquiza 333, 4545454. */

INSERT INTO agenda
VALUES('Acosta', 'Ana', 'Colon 123', '4234567'),
      ('Bustamante', 'Betina', 'Avellaneda 135', '4458787'),
      ('Lopez', 'Hector', 'Salta 545', '4887788'), 
      ('Lopez', 'Luis', 'Urquiza 333', '4545454'),
      ('Lopez', 'Marisa', 'Urquiza 333', '4545454');

-- 5- Seleccione todos los registros de la tabla

SELECT * FROM agenda;

-- 6- Seleccione el registro cuyo nombre sea "Marisa"

SELECT * FROM agenda
WHERE nombre='Marisa';

-- 7- Seleccione los nombres y domicilios de quienes tengan apellido igual a "Lopez"

SELECT nombre, domicilio FROM agenda
WHERE apellido='Lopez';

-- 8- Muestre el nombre de quienes tengan el teléfono "4545454"

SELECT nombre FROM agenda
WHERE telefono='4545454';
