-- 1- Elimine la tabla "cuentas" si existe:

IF OBJECT_ID('cuentas') IS NOT NULL
DROP TABLE cuentas;

/* 2- Cree la tabla eligiendo el tipo de dato adecuado para almacenar los datos descriptos arriba:

 - Número de cuenta: entero, no nulo, no puede haber valores repetidos, clave primaria;
 - Documento del propietario de la cuenta: cadena de caracteres de 8 de longitud (siempre 8), no nulo;
 - Nombre del propietario de la cuenta: cadena de caracteres de 30 de longitud,
 - Saldo de la cuenta: valores altos con decimales. */

CREATE TABLE cuentas (
  numero    INT NOT NULL PRIMARY KEY,
  documento CHAR(8) NOT NULL,
  nombre    VARCHAR(30),
  saldo     DECIMAL(15,2)
);


/* 3- Ingrese los siguientes registros:

('1234','25666777','Pedro Perez',500000.60);
('2234','27888999','Juan Lopez',-250000);
('3344','27888999','Juan Lopez',4000.50);
('3346','32111222','Susana Molina',1000); */

INSERT INTO cuentas
VALUES('1234','25666777','Pedro Perez',500000.60),
      ('2234','27888999','Juan Lopez',-250000),
      ('3344','27888999','Juan Lopez',4000.50),
      ('3346','32111222','Susana Molina',1000);

-- 4- Seleccione todos los registros cuyo saldo sea mayor a "4000".

SELECT * FROM cuentas
WHERE saldo > 4000;

-- 5- Muestre el número de cuenta y saldo de todas las cuentas cuyo propietario sea "Juan Lopez"

SELECT numero, saldo FROM cuentas
WHERE nombre='Juan Lopez';

-- 6- Muestre las cuentas con saldo negativo

SELECT * FROM cuentas
WHERE saldo<0;

-- 7- Muestre todas las cuentas cuyo número es igual o mayor a "3000":

SELECT * FROM cuentas
WHERE saldo>=3000;
