-- 1- Elimine la tabla "agenda", si existe:

IF object_id('agenda') IS NOT NULL
DROP TABLE agenda;

/* 2- Cree una tabla llamada "agenda". Debe tener los siguientes campos: apellido (cadena de 30), 
      nombre (cadena de 20), domicilio (cadena de 30) y telefono (cadena de 11): */

CREATE TABLE agenda(
apellido VARCHAR(30),
nombre VARCHAR(20),
domicilio VARCHAR(30),
telefono VARCHAR(11)
);


-- 3- Visualice las tablas existentes para verificar la creación de "agenda" 

EXEC sp_tables @table_owner='dbo';

-- 4- Visualice la estructura de la tabla "agenda".

EXEC sp_columns agenda;

/* 5- Ingrese los siguientes registros:

('Moreno','Alberto','Colon 123','4234567');
('Torres','Juan','Avellaneda 135','4458787'); */

INSERT INTO agenda
VALUES('Moreno','Alberto','Colon 123','4234567'),
      ('Torres','Juan','Avellaneda 135','4458787');

-- 6- Seleccione todos los registros de la tabla:

SELECT * FROM agenda;

-- 7- Elimine la tabla "agenda":

DROP TABLE agenda;

-- 8- Intente eliminar la tabla nuevamente:

DROP TABLE agenda;

-- Aparece mensaje de error.
