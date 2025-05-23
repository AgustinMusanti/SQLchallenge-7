-- 1- Elimine la tabla "clientes" si existe y créela:

IF OBJECT_ID('clientes') IS NOT NULL
DROP TABLE clientes;

CREATE TABLE clientes(
  codigo          INT NOT NULL,
  nombre          VARCHAR(30),
  domicilio       VARCHAR(30),
  ciudad          VARCHAR(20),
  referenciadopor INT,
  PRIMARY KEY(codigo)
 );

-- 2- Ingresamos algunos registros:

INSERT INTO clientes
VALUES(50,'Juan Perez','Sucre 123','Cordoba',null),
      (90,'Marta Juarez','Colon 345','Carlos Paz',null),
      (110,'Fabian Torres','San Martin 987','Cordoba',50),
      (125,'Susana Garcia','Colon 122','Carlos Paz',90),
      (140,'Ana Herrero','Colon 890','Carlos Paz',9);

/* 3- Intente agregar una restricción "foreign key" para evitar que en el campo "referenciadopor" se 
      ingrese un valor de código de cliente que no exista. */

ALTER TABLE clientes ADD CONSTRAINT FK_clientes_referenciadopor
FOREIGN KEY (referenciadopor) REFERENCES clientes (codigo);

-- No se permite porque existe un registro que no cumple con la restricción que se intenta establecer.

/* 4- Cambie el valor inválido de "referenciadopor" del registro que viola la restricción por uno 
      válido. */

UPDATE clientes SET referenciadopor=90
WHERE referenciadopor=9;

-- 5- Agregue la restricción "foreign key" que intentó agregar en el punto 3.

ALTER TABLE clientes ADD CONSTRAINT FK_clientes_referenciadopor
FOREIGN KEY (referenciadopor) REFERENCES clientes (codigo);

-- 6- Vea la información referente a las restricciones de la tabla "clientes".

EXEC sp_helpconstraint clientes;

-- 7- Intente agregar un registro que infrinja la restricción.

INSERT INTO clientes 
VALUES(150,'Karina Gomez','Caseros 444','Cruz del Eje',8);

-- No se permite.

-- 8- Intente modificar el código de un cliente que está referenciado en "referenciadopor".

UPDATE clientes SET codigo=180 
WHERE codigo=90;

-- No se permite.

-- 9- Intente eliminar un cliente que sea referenciado por otro en "referenciadopor".

DELETE FROM clientes
WHERE nombre='Marta Juarez';

-- No se permite.

-- 10- Cambie el valor de código de un cliente que no referenció a nadie.

UPDATE clientes SET codigo=180 
WHERE codigo=125;

-- 11- Elimine un cliente que no haya referenciado a otros.

DELETE FROM clientes 
WHERE codigo=110;
