-- 1:Cree la tabla "ClientesFinancieros"

IF OBJECT_ID('ClientesFinancieros') IS NOT NULL
DROP TABLE ClientesFinancieros;

CREATE TABLE ClientesFinancieros(
  cliente_id    INT,
  nombre        VARCHAR(50),
  ing_mensuales DECIMAL(10, 2),
  deuda_total   DECIMAL(10, 2)
);

-- 2: Inserte algunos registros

INSERT INTO ClientesFinancieros
VALUES(1, 'Carlos Pérez', 500000, 320000),
      (2, 'María Gómez', 750000, 200000),
      (3, 'Julián Acosta', 400000, 300000),
      (4, 'Lucía Torres', 600000, 650000);

-- 3: Evaluar si un cliente es de riesgo alto si su deuda supera el 60% de sus ingresos.

SELECT nombre, ing_mensuales, deuda_total,
 IIF(deuda_total > ing_mensuales * 0.6, 'Alto', 'Bajo') AS RiesgoCrediticio
FROM ClientesFinancieros;
