-- 1- Elimine la tabla "visitantes", si existe:

IF OBJECT_ID('visitantes') IS NOT NULL
DROP TABLE visitantes;

-- 2- Cree la tabla con la siguiente estructura:

CREATE TABLE visitantes(
  numero      INT IDENTITY,
  nombre      VARCHAR(30),
  edad        TINYINT,
  domicilio   VARCHAR(30),
  ciudad      VARCHAR(20),
  montocompra DECIMAL(6,2) NOT NULL
 );

/* 3- Defina una restricción "default" para el campo "ciudad" que almacene el valor "Cordoba" en caso 
      de no ingresar valor para dicho campo: */

ALTER TABLE visitantes
ADD CONSTRAINT DF_visitantes_ciudad
DEFAULT 'Cordoba'
FOR ciudad;

/* 4- Defina una restricción "default" para el campo "montocompra" que almacene el valor "0" en caso de 
      no ingresar valor para dicho campo: */

ALTER TABLE visitantes
ADD CONSTRAINT DF_visitantes_montocompra
DEFAULT 0
FOR montocompra;

-- 5- Ingrese algunos registros sin valor para los campos con restricción "default":

INSERT INTO visitantes
VALUES ('Susana Molina',35,'Colon 123',DEFAULT,59.80),
       ('Marcos Torres',29,'Carlos Paz', DEFAULT, DEFAULT),
       ('Mariana Juarez',45,'Carlos Paz',null,23.90);
	   
-- 6- Vea cómo se almacenaron los registros:

SELECT * FROM visitantes;

-- 7- Vea las restricciones creadas anteriormente.

EXEC sp_helpconstraint visitantes;

-- 8- Intente agregar otra restricción "default" al campo "ciudad".

ALTER TABLE visitantes
ADD CONSTRAINT DF_visitantes_ciudad
DEFAULT 'Buenos Aires'
FOR ciudad;

-- No es posible ya que solo puede existir un default por campo.

-- 9- Intente establecer una restricción "default" al campo "identity".

ALTER TABLE visitantes
ADD CONSTRAINT DF_visitantes_numero
DEFAULT 5
FOR numero;

-- NO es posible crear defaults en campos de atributo IDENTITY.
