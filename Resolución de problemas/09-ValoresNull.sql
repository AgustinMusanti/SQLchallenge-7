-- 1- Elimine la tabla "medicamentos", si existe:

IF object_id('medicamentos') IS NOT NULL
DROP TABLE medicamentos;

-- 2- Cree la tabla con la siguiente estructura:

CREATE TABLE medicamentos(
  codigo      INTEGER NOT NULL,
  nombre      VARCHAR(20) NOT NULL,
  laboratorio VARCHAR(20),
  precio      FLOAT,
  cantidad    INTEGER NOT NULL
 );

-- 3- Visualice la estructura de la tabla "medicamentos":

EXEC sp_columns medicamentos;

-- 4- Ingrese algunos registros con valores "null" para los campos que lo admitan:

INSERT INTO medicamentos
VALUES(1,'Sertal gotas',null,null,100),
      (2,'Sertal compuesto',null,8.90,150),
      (3,'Buscapina','Roche',null,200);

-- 5- Vea todos los registros:

SELECT * FROM medicamentos;

-- 6- Ingrese un registro con valor "0" para el precio y cadena vacía para el laboratorio:

INSERT INTO medicamentos
VALUES(4,'Bayaspirina','',0,150);

-- 7- Ingrese un registro con valor "0" para el código y cantidad y cadena vacía para el nombre:

INSERT INTO medicamentos
VALUES(0,'','Bayer',15.60,0);

-- 8- Muestre todos los registros:

SELECT * FROM medicamentos;

-- 9- Intente ingresar un registro con valor nulo para un campo que no lo admite:

INSERT INTO medicamentos
VALUES(null,'Amoxidal jarabe','Bayer',25,120);

-- Aparece mensaje de error.

/* 10- Recupere los registros que contengan valor "null" en el campo "laboratorio", luego los que 
       tengan una cadena vacía en el mismo campo. Note que el resultado es diferente. */

SELECT * FROM medicamentos
WHERE laboratorio IS NULL;

SELECT * FROM medicamentos
WHERE laboratorio='';

-- Noto que NULL es diferente de una cadena vacia.

/*11- Recupere los registros que contengan valor "null" en el campo "precio", luego los que tengan el 
      valor 0 en el mismo campo. Note que el resultado es distinto. */

SELECT * FROM medicamentos
WHERE precio IS NULL;

SELECT * FROM medicamentos
WHERE precio='0';

-- Tambien noto que NULL es diferente de "0".

/* 12- Recupere los registros cuyo laboratorio no contenga una cadena vacía, luego los que sean 
       distintos de "null". */

SELECT * FROM medicamentos
WHERE laboratorio<>'';

SELECT * FROM medicamentos
WHERE laboratorio IS NOT NULL;

/* La salida de la primera sentencia no muestra los registros con cadenas vacías y tampoco los 
que tienen valor nulo; el resultado de la segunda sentencia muestra los registros con valor para el 
campo laboratorio (incluso cadena vacía). */

-- 13- Recupere los registros cuyo precio sea distinto de 0, luego los que sean distintos de "null":

SELECT * FROM medicamentos
WHERE precio<>'0';

SELECT * FROM medicamentos
WHERE precio IS NOT NULL;

/* La salida de la primera sentencia no muestra los registros con valor 0 y tampoco los que 
   tienen valor nulo; el resultado de la segunda sentencia muestra los registros con valor para el 
   campo precio (incluso el valor 0). */
