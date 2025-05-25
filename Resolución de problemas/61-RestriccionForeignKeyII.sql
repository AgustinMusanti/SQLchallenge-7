-- 1- Elimine las tablas "clientes" y "provincias", si existen:

IF OBJECT_ID('clientes') IS NOT NULL
DROP TABLE clientes;

IF OBJECT_ID('provincias') IS NOT NULL
DROP TABLE provincias;

-- 2- Créelas con las siguientes estructuras:

CREATE TABLE clientes (
  codigo          INT IDENTITY,
  nombre          VARCHAR(30),
  domicilio       VARCHAR(30),
  ciudad          VARCHAR(20),
  codigoprovincia TINYINT,
  PRIMARY KEY(codigo)
 );

CREATE TABLE provincias(
  codigo TINYINT,
  nombre VARCHAR(20),
  PRIMARY KEY(codigo)
 );

-- 3- Ingrese algunos registros para ambas tablas:

INSERT INTO provincias
VALUES(1,'Cordoba'),
      (2,'Santa Fe'),
      (3,'Misiones'),
      (4,'Rio Negro');

INSERT INTO clientes
VALUES('Perez Juan','San Martin 123','Carlos Paz',1),
      ('Moreno Marcos','Colon 234','Rosario',2),
      ('Acosta Ana','Avellaneda 333','Posadas',3);

/* 4- Establezca una restricción "foreign key" especificando la acción "en cascade" para 
      actualizaciones y "no action" para eliminaciones. */

ALTER TABLE clientes ADD CONSTRAINT FK_clientes_codigoprovincia
FOREIGN KEY(codigoprovincia) REFERENCES provincias(codigo)
ON UPDATE CASCADE
ON DELETE NO ACTION;

-- 5- Intente eliminar el registro con código 3, de "provincias".

DELETE FROM provincias
WHERE codigo=3;

-- NO es posible debido a la restricción.

-- 6- Modifique el registro con código 3, de "provincias".

UPDATE provincias SET codigo=9
WHERE codigo=3;

/*7- Verifique que el cambio se realizó en cascada, es decir, que se modificó en la tabla "provincias" 
     y en "clientes": */

SELECT * FROM clientes;

SELECT * FROM provincias;

-- 8- Intente modificar la restricción "foreign key" para que permita eliminación en cascada.

ALTER TABLE clientes ADD CONSTRAINT FK_clientes_codigoprovincia
FOREIGN KEY(codigoprovincia) REFERENCES provincias(codigo)
ON UPDATE CASCADE
ON DELETE CASCADE;

-- NO se pueden modificar las restricciones.

-- 9- Intente eliminar la tabla "provincias".

DROP TABLE provincias;

-- NO se puede debido a la restricción.
