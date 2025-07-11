-- 1:Cree la tabla "Inversiones"

IF OBJECT_ID('Inversiones') IS NOT NULL
DROP TABLE Inversiones;

CREATE TABLE Inversiones(
  inversion_id INT,
  inversor VARCHAR(50),
  monto_invertido DECIMAL(10, 2),
  monto_final DECIMAL(10, 2)
);

-- 2: Inserte algunos registros

INSERT INTO Inversiones 
VALUES(1, 'Ana Mercado', 1000000, 1120000),
      (2, 'Esteban López', 500000, 520000),
      (3, 'Rocío Fernández', 750000, 860000),
      (4, 'Martín Gallo', 1200000, 1250000);

-- 3: Indicar si una inversión fue rentable o no rentable, comparando la ganancia con una tasa objetivo del 10%.

SELECT 
    inversor,
    monto_invertido,
    monto_final,
    ROUND(((monto_final - monto_invertido) / monto_invertido) * 100, 2) AS 'Retorno%',
    IIF(((monto_final - monto_invertido) / monto_invertido) >= 0.10, 'Rentable', 'No Rentable') AS estado
FROM Inversiones;
