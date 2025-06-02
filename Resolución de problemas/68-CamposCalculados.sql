-- 1- Elimine la tabla "articulos", si existe y créela nuevamente:

IF OBJECT_ID('articulos') IS NOT NULL
DROP TABLE articulos;

CREATE TABLE articulos(
  codigo      INT IDENTITY,
  descripcion VARCHAR(30),
  precio      DECIMAL(5,2) NOT NULL,
  cantidad    SMALLINT NOT NULL DEFAULT 0,
  montototal AS precio*cantidad
 );

-- 2- Intente ingresar un registro con valor para el campo calculado:

INSERT INTO articulos
VALUES(1,'aaaaa',50,10,500);

-- NO se puede.

-- 3- Ingrese algunos registros:

INSERT INTO articulos
VALUES('birome',1.5,100),
      ('cuaderno 12 hojas',4.8,150),
      ('lapices x 12',5,200);

-- 4- Recupere los registros:

SELECT * FROM articulos;

-- 5- Actualice un precio y recupere los registros:

UPDATE articulos SET precio=1.60
WHERE precio=1.50;

SELECT * FROM articulos;

-- 6- Actualice una cantidad y vea el resultado:

UPDATE articulos SET cantidad=120
WHERE cantidad=100;

SELECT * FROM articulos;

--7- Intente actualizar un campo calculado:

UPDATE articulos SET montototal=300 
WHERE descripcion='birome';

-- NO lo permite.
