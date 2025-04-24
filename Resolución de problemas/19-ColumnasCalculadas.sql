-- 1- Elimine la tabla si existe:

IF OBJECT_ID('articulos') IS NOT NULL
DROP TABLE articulos;

-- 2- Cree la tabla:

CREATE TABLE articulos(
  codigo      INT IDENTITY,
  nombre      VARCHAR(20),
  descripcion VARCHAR(30),
  precio      SMALLMONEY,
  cantidad    TINYINT DEFAULT 0,
  PRIMARY KEY(codigo)
 );

-- 3- Ingrese algunos registros:

INSERT INTO articulos (nombre, descripcion, precio, cantidad)
VALUES('impresora','Epson Stylus C45',400.80,20),
      ('impresora','Epson Stylus C85',500, 76),
      ('monitor','Samsung 14',800, DEFAULT),
      ('teclado','ingles Biswal',100,50);

/* 4- El comercio quiere aumentar los precios de todos sus artículos en un 15%. Actualice todos los 
      precios empleando operadores aritméticos. */

UPDATE articulos SET precio=precio+(precio*0.15);

-- 5- Vea el resultado:

SELECT * FROM articulos;

/* 6- Muestre todos los artículos, concatenando el nombre y la descripción de cada uno de ellos 
      separados por coma. */

SELECT 
  nombre + ', ' + descripcion AS nombre_descripcion,
  precio,
  cantidad
FROM articulos;

7- Reste a la cantidad de todos los teclados, el valor 5, empleando el operador aritmético menos ("-")

UPDATE articulos SET cantidad=cantidad-5
WHERE nombre='teclado';

SELECT * FROM articulos;
