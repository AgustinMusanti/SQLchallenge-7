-- 1- Elimine "articulos", si existe:

IF object_id('articulos') IS NOT NULL
DROP TABLE articulos;

-- 2- Cree la tabla, con la siguiente estructura:

CREATE TABLE articulos(
  codigo      INTEGER,
  nombre      VARCHAR(20),
  descripcion VARCHAR(30),
  precio      FLOAT,
  cantidad    INTEGER
 );

-- 3- Vea la estructura de la tabla.

EXEC sp_columns articulos;

-- 4- Ingrese algunos registros:

INSERT INTO articulos
VALUES(1,'impresora','Epson Stylus C45',400.80,20),
      (2,'impresora','Epson Stylus C85',500,30),
      (3,'monitor','Samsung 14',800,10),
      (4,'teclado','ingles Biswal',100,50),
      (5,'teclado','español Biswal',90,50);

-- 5- Seleccione los datos de las impresoras

SELECT * FROM articulos
WHERE nombre='impresora';

-- 6- Seleccione los artículos cuyo precio sea mayor o igual a 400

SELECT * FROM articulos
WHERE precio>=400;

-- 7- Seleccione el código y nombre de los artículos cuya cantidad sea menor a 30

SELECT codigo, nombre FROM articulos
WHERE cantidad<30;

8- Selecciones el nombre y descripción de los artículos que NO cuesten $100

SELECT nombre, descripcion FROM articulos
WHERE precio<>100;
