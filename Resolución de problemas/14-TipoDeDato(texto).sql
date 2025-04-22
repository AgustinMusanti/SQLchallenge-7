-- 1- Elimine la tabla "autos" si existe:

IF OBJECT_ID('autos') IS NOT NULL
DROP TABLE autos;

/* 2- Cree la tabla eligiendo el tipo de dato adecuado para cada campo, estableciendo el campo 
      "patente" como clave primaria: */

CREATE TABLE autos(
  patente CHAR(6),
  marca   VARCHAR(20),
  modelo  CHAR(4),
  precio  FLOAT,
  PRIMARY KEY(patente)
 );

/* Se definió el campo "patente" de tipo "char" y no "varchar" porque la cadena de caracteres 
   siempre tendrá la misma longitud (6 caracteres). Lo mismo sucede con el campo "modelo", en el cual 
   se almacena el año, por lo que se necesitan 4 caracteres fijos. */

/* 3- Ingrese los siguientes registros:

('ACD123','Fiat 128','1970',15000);
('ACG234','Renault 11','1990',40000);
('BCD333','Peugeot 505','1990',80000);
('GCD123','Renault Clio','1990',70000);
('BCC333','Renault Megane','1998',95000);
('BVF543','Fiat 128','1975',20000); */

INSERT INTO autos
VALUES('ACD123','Fiat 128','1970',15000),
      ('ACG234','Renault 11','1990',40000),
      ('BCD333','Peugeot 505','1990',80000),
      ('GCD123','Renault Clio','1990',70000),
      ('BCC333','Renault Megane','1998',95000),
      ('BVF543','Fiat 128','1975',20000);

-- 4- Seleccione todos los autos del año 1990:

SELECT * FROM autos
WHERE modelo='1990';
