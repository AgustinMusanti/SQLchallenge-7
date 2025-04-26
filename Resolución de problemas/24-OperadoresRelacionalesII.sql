-- 1- Elimine la tabla "peliculas", si existe;

IF OBJECT_ID('peliculas') IS NOT NULL
DROP TABLE peliculas;

-- 2- Créela con la siguiente estructura:

CREATE TABLE peliculas(
  codigo   INT IDENTITY,
  titulo   VARCHAR(40) NOT NULL,
  actor    VARCHAR(20),
  duracion TINYINT,
  PRIMARY KEY(codigo)
 );

-- 3- Ingrese algunos registros:

INSERT INTO peliculas
VALUES('Mision imposible','Tom Cruise',120),
      ('Harry Potter y la piedra filosofal','Daniel R.',null),
      ('Harry Potter y la camara secreta','Daniel R.',190),
      ('Mision imposible 2','Tom Cruise',120),
      ('Mujer bonita',null,120),
      ('Tootsie','D. Hoffman',90);

INSERT INTO peliculas (titulo)
VALUES('Un oso rojo');

-- 4- Recupere las películas cuyo actor sea nulo.

SELECT * FROM peliculas -- Primero chequeo que toda la info se cargo de manera correcta.

SELECT * FROM peliculas
WHERE actor IS NULL;

-- 5- Cambie la duración a 0, de las películas que tengan duración igual a "null".

UPDATE peliculas SET duracion=0
WHERE duracion IS NULL;

SELECT * FROM peliculas; -- Con esto chequeo que se haya actualizado correctamente.

-- 6- Borre todas las películas donde el actor sea "null" y cuya duración sea 0.

DELETE FROM peliculas
WHERE actor IS NULL
AND duracion=0;

SELECT * FROM peliculas; -- Para chequear la eliminación.
