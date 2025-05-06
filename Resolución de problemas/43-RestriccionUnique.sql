-- 1- Elimine la tabla "remis" si existe:

IF OBJECT_ID('remis') IS NOT NULL
DROP TABLE remis;

-- 2- Cree la tabla con la siguiente estructura:

CREATE TABLE remis(
  numero  TINYINT IDENTITY,
  patente CHAR(6),
  marca   VARCHAR(15),
  modelo  CHAR(4)
 );

/* 3- Ingrese algunos registros:

('ABC123','Renault clio','1990');
('DEF456','Peugeot 504','1995');
('DEF456','Fiat Duna','1998');
('GHI789','Fiat Duna','1995');
(null,'Fiat Duna','1995'); */

INSERT INTO remis
VALUES('ABC123','Renault clio','1990'),
      ('DEF456','Peugeot 504','1995'),
      ('DEF456','Fiat Duna','1998'),
      ('GHI789','Fiat Duna','1995'),
      (null,'Fiat Duna','1995');

/* 4- Intente agregar una restricción "unique" para asegurarse que la patente del remis no tomará 
      valores repetidos. */

ALTER TABLE remis
ADD CONSTRAINT UQ_patente
UNIQUE(patente);

-- NO se puede crear porque existe un registro duplicado en la base.

-- 5- Elimine el registro con patente duplicada y establezca la restricción.

DELETE FROM remis
WHERE marca='Peugeot 504';

ALTER TABLE remis
ADD CONSTRAINT UQ_patente
UNIQUE(patente);

-- Ahora si se pudo ejecutar.

-- 6- Intente ingresar un registro con patente repetida.

INSERT INTO remis
VALUES('ABC123','Chevrolet Cruze','2021');

-- NO es posible por la restricción.

-- 7- Intente ingresar un registro con valor nulo para el campo "patente".

INSERT INTO remis
VALUES(NULL,'Chevrolet Cruze','2021');

-- Tampoco es posible ya que existe un registro NULL y no se permiten duplicados por la restricción.

-- 8- Muestre la información de las restricciones:

EXEC sp_helpconstraint remis;
