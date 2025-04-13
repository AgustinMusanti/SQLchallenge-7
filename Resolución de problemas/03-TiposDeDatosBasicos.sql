/* Un videoclub que alquila películas en video almacena la información de sus películas en una tabla 
   llamada "peliculas"; para cada película necesita los siguientes datos:
   -nombre, cadena de caracteres de 20 de longitud,
   -actor, cadena de caracteres de 20 de longitud,
   -duración, valor numérico entero.
   -cantidad de copias: valor entero. */

-- 1- Elimine la tabla, si existe:

IF object_id('peliculas') IS NOT NULL
DROP TABLE peliculas;

-- 2- Cree la tabla eligiendo el tipo de dato adecuado para cada campo:

CREATE TABLE peliculas(
  nombre VARCHAR(20),
  actor VARCHAR(20),
  duracion INTEGER,
  cantidad INTEGER
 );

-- 3- Vea la estructura de la tabla:

EXEC sp_columns peliculas;

/* 4- Ingrese los siguientes registros:

('Mision imposible','Tom Cruise',128,3);
('Mision imposible 2','Tom Cruise',130,2);
('Mujer bonita','Julia Roberts',118,3);
('Elsa y Fred','China Zorrilla',110,2); */

INSERT INTO peliculas
VALUES('Mision imposible','Tom Cruise',128,3),
      ('Mision imposible 2','Tom Cruise',130,2),
      ('Mujer bonita','Julia Roberts',118,3),
      ('Elsa y Fred','China Zorrilla',110,2); 

5- Muestre todos los registros.

SELECT * FROM peliculas;
