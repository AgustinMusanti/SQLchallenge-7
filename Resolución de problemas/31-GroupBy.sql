-- 1- Elimine la tabla "visitantes", si existe:

IF OBJECT_ID('visitantes') IS NOT NULL
DROP TABLE visitantes;

-- 2- Cree la tabla con la siguiente estructura:

CREATE TABLE visitantes(
  nombre      VARCHAR(30),
  edad        TINYINT,
  sexo        CHAR(1) DEFAULT 'f',
  domicilio   VARCHAR(30),
  ciudad      VARCHAR(20) DEFAULT 'Cordoba',
  telefono    VARCHAR(11),
  mail        VARCHAR(30) DEFAULT 'no tiene',
  montocompra DECIMAL(6,2)
 );

/* 3- Ingrese algunos registros:

('Susana Molina',35,default,'Colon 123',default,null,null,59.80);
('Marcos Torres',29,'m',default,'Carlos Paz',default,'marcostorres@hotmail.com',150.50);
('Mariana Juarez',45,default,default,'Carlos Paz',null,default,23.90);
('Fabian Perez',36,'m','4556677','fabianperez@xaxamail.com');
('Alejandra Gonzalez','La Falda',280.50);
('Gaston Perez',29,'m','Carlos Paz','gastonperez1@gmail.com',95.40);
('Liliana Torres',40,default,'Sarmiento 876',default,default,default,85);
('Gabriela Duarte',21,null,null,'Rio Tercero',default,'gabrielaltorres@hotmail.com',321.50); */

INSERT INTO visitantes
VALUES('Susana Molina',35,default,'Colon 123',default,null,null,59.80),
      ('Marcos Torres',29,'m',default,'Carlos Paz',default,'marcostorres@hotmail.com',150.50),
      ('Mariana Juarez',45,default,default,'Carlos Paz',null,default,23.90),
	  ('Liliana Torres',40,default,'Sarmiento 876',default,default,default,85),
      ('Gabriela Duarte',21,null,null,'Rio Tercero',default,'gabrielaltorres@hotmail.com',321.50);

INSERT INTO visitantes (nombre, edad,sexo,telefono, mail)
VALUES('Fabian Perez',36,'m','4556677','fabianperez@xaxamail.com');

INSERT INTO visitantes (nombre, ciudad, montocompra)
VALUES('Alejandra Gonzalez','La Falda',280.50);

INSERT INTO visitantes (nombre, edad,sexo, ciudad, mail,montocompra)
VALUES('Gaston Perez',29,'m','Carlos Paz','gastonperez1@gmail.com',95.40);


-- 4- Queremos saber la cantidad de visitantes de cada ciudad utilizando la cláusula "group by".

SELECT ciudad, COUNT(*) AS 'Cantidad de visitantes'
FROM visitantes
GROUP BY ciudad;

-- 5- Queremos la cantidad visitantes con teléfono no nulo, de cada ciudad.

SELECT ciudad, COUNT(telefono) AS 'Con telefono'
FROM visitantes
GROUP BY ciudad;

-- 6- Necesitamos el total del monto de las compras agrupadas por sexo.

SELECT sexo, SUM(montocompra) AS 'Total compras'
FROM visitantes
GROUP BY sexo;

-- 7- Se necesita saber el máximo y mínimo valor de compra agrupados por sexo y ciudad.

SELECT sexo, ciudad,
       MAX(montocompra) AS 'Maxima compra',
	   MIN(montocompra) AS 'Minima compra'
FROM visitantes
GROUP BY sexo, ciudad;

-- 8- Calcule el promedio del valor de compra agrupados por ciudad.

SELECT ciudad, AVG(montocompra) AS 'Promedio de compra'
FROM visitantes
GROUP BY ciudad;

-- 9- Cuente y agrupe por ciudad sin tener en cuenta los visitantes que no tienen mail.

SELECT ciudad,
COUNT(*) AS 'Cantidad con mail'
FROM visitantes
WHERE mail IS NOT NULL
AND mail<>'no tiene'
GROUP BY ciudad;

/* 10- Realice la misma consulta anterior, pero use la palabra clave "all" para mostrar todos los 
       valores de ciudad, incluyendo las que devuelven cero o "null" en la columna de agregado */


SELECT ciudad,
COUNT(*) AS 'Cantidad con mail'
FROM visitantes
WHERE mail IS NOT NULL
AND mail<>'no tiene'
GROUP BY ALL ciudad;
