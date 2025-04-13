-- 1- Elimine la tabla "peliculas", si existe:

IF object_id('peliculas') IS NOT NULL
DROP TABLE peliculas;

-- 2- Cree la tabla:

CREATE TABLE peliculas(
  titulo VARCHAR(20),
  actor VARCHAR(20),
  duracion INTEGER,
  cantidad INTEGER
 );

-- 3- Vea la estructura de la tabla.

EXEC sp_columns peliculas;

/* 4- Ingrese alos siguientes registros:

('Mision imposible','Tom Cruise',180,3);
('Mision imposible 2','Tom Cruise',190,2);
('Mujer bonita','Julia Roberts',118,3);
('Elsa y Fred','China Zorrilla',110,2); */

INSERT INTO peliculas
VALUES('Mision imposible','Tom Cruise',180,3),
      ('Mision imposible 2','Tom Cruise',190,2),
      ('Mujer bonita','Julia Roberts',118,3),
      ('Elsa y Fred','China Zorrilla',110,2);

-- 5- Realice un "select" mostrando solamente el título y actor de todas las películas

SELECT titulo, actor
FROM peliculas;

-- 6- Muestre el título y duración de todas las peliculas

SELECT titulo, duracion
FROM peliculas;

-- 7- Muestre el título y la cantidad de copias

SELECT titulo, cantidad
FROM peliculas;
