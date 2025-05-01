-- 1- Elimine la tabla "ventas" si existe:

IF OBJECT_ID('ventas') IS NOT NULL
DROP TABLE ventas;

-- 2- Cree la tabla:

CREATE TABLE ventas(
  numero      INT IDENTITY,
  montocompra DECIMAL(6,2),
  tipopago    CHAR(1),--c=contado, t=tarjeta
  vendedor    VARCHAR(30),
  PRIMARY KEY(numero)
 );

/* 3- Ingrese algunos registros:

(100.50,'c','Marisa Perez');
(200,'c','Marisa Perez');
(50,'t','Juan Lopez');
(220,'c','Juan Lopez');
(150,'t','Marisa Perez');
(550.80,'c','Marisa Perez');
(300,'t','Juan Lopez');
(25,'c','Marisa Perez'); */

INSERT INTO ventas
VALUES(100.50,'c','Marisa Perez'),
      (200,'c','Marisa Perez'),
      (50,'t','Juan Lopez'),
      (220,'c','Juan Lopez'),
      (150,'t','Marisa Perez'),
      (550.80,'c','Marisa Perez'),
      (300,'t','Juan Lopez'),
      (25,'c','Marisa Perez');

-- 4- Agrupe por "tipopago" y "vendedor" y cuente la cantidad empleando "rollup".

SELECT tipopago, vendedor,
COUNT(*) AS 'Cantidad de ventas'
FROM ventas
GROUP BY tipopago, vendedor
WITH ROLLUP;

-- 5- Agrupe por "tipopago" y "vendedor" y cuente la cantidad empleando "cube".

SELECT tipopago, vendedor,
COUNT(*) AS 'Cantidad de ventas'
FROM ventas
GROUP BY tipopago, vendedor
WITH CUBE;
