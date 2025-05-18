-- 1- Elimine la tabla "clientes" si existe y créela:

IF OBJECT_ID('clientes') IS NOT NULL
DROP TABLE clientes;

CREATE TABLE clientes(
  nombre    VARCHAR(30),
  sexo      CHAR(1),--'f'=femenino, 'm'=masculino
  edad      INT,
  domicilio VARCHAR(30)
 );


/* 2- Ingrese los siguientes registros:

('Maria Lopez','f',45,'Colon 123');
('Liliana Garcia','f',35,'Sucre 456');
('Susana Lopez','f',41,'Avellaneda 98');
('Juan Torres','m',44,'Sarmiento 755');
('Marcelo Oliva','m',56,'San Martin 874');
('Federico Pereyra','m',38,'Colon 234');
('Juan Garcia','m',50,'Peru 333'); */

INSERT INTO clientes
VALUES('Maria Lopez','f',45,'Colon 123'),
      ('Liliana Garcia','f',35,'Sucre 456'),
      ('Susana Lopez','f',41,'Avellaneda 98'),
      ('Juan Torres','m',44,'Sarmiento 755'),
      ('Marcelo Oliva','m',56,'San Martin 874'),
      ('Federico Pereyra','m',38,'Colon 234'),
      ('Juan Garcia','m',50,'Peru 333');

/* 3- La agencia necesita la combinación de todas las personas de sexo femenino con las de sexo 
      masculino. Use un  "cross join". */

SELECT cm.nombre,cm.edad,cv.nombre,cv.edad
FROM clientes AS cm
CROSS JOIN clientes cv
WHERE cm.sexo='f' and cv.sexo='m';

-- 4- Obtenga la misma salida enterior pero realizando un "join".

SELECT cm.nombre,cm.edad,cv.nombre,cv.edad
FROM clientes AS cm
JOIN clientes cv
ON cm.nombre<>cv.nombre
WHERE cm.sexo='f' AND cv.sexo='m';

/* 5- Realice la misma autocombinación que el punto 3 pero agregue la condición que las parejas no 
      tengan una diferencia superior a 5 años. */

SELECT cm.nombre,cm.edad,cv.nombre,cv.edad
FROM clientes AS cm
CROSS JOIN clientes cv
WHERE cm.sexo='f' AND cv.sexo='m'
AND cm.edad-cv.edad BETWEEN -5 AND 5;
