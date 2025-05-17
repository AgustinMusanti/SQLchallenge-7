-- 1- Elimine las tablas si existen y créelas:

IF OBJECT_ID('mujeres') IS NOT NULL
DROP TABLE mujeres;

IF OBJECT_ID('varones') IS NOT NULL
DROP TABLE varones;

CREATE TABLE mujeres(
  nombre    VARCHAR(30),
  domicilio VARCHAR(30),
  edad      INT
 );
 
CREATE TABLE varones(
  nombre    VARCHAR(30),
  domicilio VARCHAR(30),
  edad      INT
 );

/* 2- Ingrese los siguientes registros:

('Maria Lopez','Colon 123',45);
('Liliana Garcia','Sucre 456',35);
('Susana Lopez','Avellaneda 98',41);

('Juan Torres','Sarmiento 755',44);
('Marcelo Oliva','San Martin 874',56);
('Federico Pereyra','Colon 234',38);
('Juan Garcia','Peru 333',50); */

INSERT INTO mujeres
VALUES('Maria Lopez','Colon 123',45),
      ('Liliana Garcia','Sucre 456',35),
      ('Susana Lopez','Avellaneda 98',41);

INSERT INTO varones
VALUES('Juan Torres','Sarmiento 755',44),
      ('Marcelo Oliva','San Martin 874',56),
      ('Federico Pereyra','Colon 234',38),
      ('Juan Garcia','Peru 333',50);

/* 3- La agencia necesita la combinación de todas las personas de sexo femenino con las de sexo 
      masculino. Use un "cross join". */

SELECT m.nombre,m.edad,v.nombre,v.edad
FROM mujeres AS m
CROSS JOIN varones AS v;

-- 4- Realice la misma combinación pero considerando solamente las personas mayores de 40 años.

SELECT m.nombre,m.edad,v.nombre,v.edad
FROM mujeres AS m
CROSS JOIN varones AS v
WHERE m.edad>40 AND v.edad>40;

-- 5- Forme las parejas pero teniendo en cuenta que no tengan una diferencia superior a 10 años.

SELECT m.nombre,m.edad,v.nombre,v.edad
FROM mujeres AS m
CROSS JOIN varones AS v
WHERE m.edad-v.edad BETWEEN -10 AND 10;
