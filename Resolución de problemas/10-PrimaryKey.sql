-- 1- Elimine la tabla "libros" si existe:

IF object_id('libros') IS NOT NULL
DROP TABLE libros;

-- 2- Créela con los siguientes campos, estableciendo como clave primaria el campo "codigo":

CREATE TABLE libros(
  codigo    INT NOT NULL,
  titulo    VARCHAR(40) NOT NULL,
  autor     VARCHAR(20),
  editorial VARCHAR(15),
  PRIMARY KEY(codigo)
 );

/* 3- Ingrese los siguientes registros:

(1,'El aleph','Borges','Emece');
(2,'Martin Fierro','Jose Hernandez','Planeta');
(3,'Aprenda PHP','Mario Molina','Nuevo Siglo'); */

INSERT INTO libros
VALUES(1,'El aleph','Borges','Emece'),
      (2,'Martin Fierro','Jose Hernandez','Planeta'),
      (3,'Aprenda PHP','Mario Molina','Nuevo Siglo');

-- 4- Ingrese un registro con código repetido

(2,'Martin Fierro','Jose Hernandez','Musa');

-- Nos da error ya que no podemos ingresar codigo repetido al ser PK.

-- 5- Intente ingresar el valor "null" en el campo "codigo"

(null,'Martin Fierro','Jose Hernandez','Musa');

-- También nos da error ya que al crear la tabla definimos que codigo NO puede ser NULL.

-- 6- Intente actualizar el código del libro "Martin Fierro" a "1"

UPDATE libros SET codigo=1
WHERE titulo='Martin Fierro';

-- No es posible dicho update.
