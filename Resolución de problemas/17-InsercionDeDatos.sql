-- 1- Elimine la tabla "cuentas" si existe:

IF OBJECT_ID('cuentas') IS NOT NULL
DROP TABLE cuentas;

-- 2- Cree la tabla:

CREATE TABLE cuentas(
  numero    INT IDENTITY,
  documento CHAR(8) NOT NULL,
  nombre    VARCHAR(30),
  saldo     MONEY
 );

/* 3- Ingrese un registro con valores para todos sus campos, inclusive el campo identity, 
      omitiendo la lista de campos: */

INSERT INTO cuentas
VALUES(1,'25666777','Juan Perez',2500.50);

-- Nos da error ya que no se debe ingresar registros para el campo de atributo "Identity".

/* 4- Ingrese un registro con valores para todos sus campos omitiendo la lista de campos (excepto el 
      campo "identity"): */

INSERT INTO cuentas
VALUES('25666777','Juan Perez',2500.50);

-- 5- Ingrese un registro omitiendo algún campo que admitan valores nulos.

INSERT INTO cuentas
VALUES('25666777','Clara Zat',null);

-- 6- Intente ingresar un registro con valor para el campo "numero":

INSERT INTO cuentas (numero,documento,nombre,saldo)
VALUES(5,'28999777','Luis Lopez',34000);

-- Nos da error por el atributo "Indentity".

-- 7- Intente ingresar un registro listando 3 campos y colocando 4 valores

INSERT INTO cuentas (numero,documento,saldo)
VALUES(5,'28999777','Luis Lopez',34000);

-- Nos da error ya que debemos ser congruentes.

-- 8- Intente ingresar un registro sin valor para el campo "documento"

INSERT INTO cuentas (documento,nombre,saldo)
VALUES('','Agus',34000);

-- Es posible.

-- 9- Vea los registros ingresados:

SELECT * FROM cuentas;
