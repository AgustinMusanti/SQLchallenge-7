-- 1- Elimine la tabla si existe:

IF OBJECT_ID('libros') IS NOT NULL
DROP TABLE libros;

-- 2- Cree la tabla:

CREATE TABLE libros(
  codigo    INT IDENTITY,
  titulo    VARCHAR(40) NOT NULL,
  autor     VARCHAR(20) DEFAULT 'Desconocido',
  editorial VARCHAR(20),
  precio    DECIMAL(6,2),
  cantidad  TINYINT DEFAULT 0,
  PRIMARY KEY(codigo)
 );

-- 3- Ingrese algunos registros:

INSERT INTO libros (titulo,autor,editorial,precio)
VALUES('El aleph','Borges','Emece',25);

INSERT INTO libros
VALUES('Java en 10 minutos','Mario Molina','Siglo XXI',50.40,100);

INSERT INTO libros (titulo,autor,editorial,precio,cantidad)
VALUES('Alicia en el pais de las maravillas','Lewis Carroll','Emece',15,50);

/* 4- Muestre todos los campos de los libros y un campo extra, con el encabezado "monto total" en la 
      que calcule el monto total en dinero de cada libro.*/

SELECT *, precio*cantidad AS 'monto total'
FROM libros;

/* 5- Muestre el título, autor y precio de todos los libros de editorial "Emece" y agregue dos columnas 
      extra en las cuales muestre el descuento de cada libro, con el encabezado "descuento" y el precio 
      con un 10% de descuento con el encabezado "precio final". */

SELECT titulo, autor, precio, precio*0.10 AS descuento,
       precio-(precio*0.10) AS 'precio final'
FROM libros
WHERE editorial='Emece';

-- 6- Muestre una columna con el título y el autor concatenados con el encabezado "Título y autor"

SELECT titulo +'-'+ autor AS 'Título y autor'
FROM libros;
