-- 1:Cree la tabla "TipoCambio"

IF OBJECT_ID('TipoCambio') IS NOT NULL
DROP TABLE TipoCambio;

CREATE TABLE TipoCambio(
  fecha DATE,
  tipo_cambio DECIMAL(10, 2)
);


-- 2: Inserte algunos registros

INSERT INTO TipoCambio (fecha, tipo_cambio)
VALUES('2025-07-01', 890.25),
      ('2025-07-02', 950.00),
      ('2025-07-03', 1010.75),
      ('2025-07-04', 985.40),
      ('2025-07-05', 1055.10);

-- 3: Según el valor del tipo de cambio, clasificar si está alto, moderado o bajo.

SELECT *,
        IIF(tipo_cambio >= 1000, 'Alto',
        IIF(tipo_cambio >= 920, 'Moderado', 'Bajo')) AS categoria
FROM TipoCambio;
