-- 1- Elimine la tabla "clientes", si existe:

IF OBJECT_ID('clientes') IS NOT NULL
DROP TABLE clientes;

-- 2- Créela con la siguiente estructura:

CREATE TABLE clientes (
  codigo     INT IDENTITY,
  nombre     VARCHAR(30) NOT NULL,
  domicilio  VARCHAR(30),
  ciudad     VARCHAR(20),
  provincia  VARCHAR(20),
  telefono   VARCHAR(11),
  PRIMARY KEY(codigo)
);

/* 3- Ingrese algunos registros:

('Lopez Marcos','Colon 111','Cordoba','Cordoba','null');
('Perez Ana','San Martin 222','Cruz del Eje','Cordoba','4578585');
('Garcia Juan','Rivadavia 333','Villa del Rosario','Cordoba','4578445');
('Perez Luis','Sarmiento 444','Rosario','Santa Fe',null);
('Pereyra Lucas','San Martin 555','Cruz del Eje','Cordoba','4253685');
('Gomez Ines','San Martin 666','Santa Fe','Santa Fe','0345252525');
('Torres Fabiola','Alem 777','Villa del Rosario','Cordoba','4554455');
('Lopez Carlos',null,'Cruz del Eje','Cordoba',null);
('Ramos Betina','San Martin 999','Cordoba','Cordoba','4223366');
('Lopez Lucas','San Martin 1010','Posadas','Misiones','0457858745'); */

INSERT INTO clientes
VALUES('Lopez Marcos','Colon 111','Cordoba','Cordoba','null'),
      ('Perez Ana','San Martin 222','Cruz del Eje','Cordoba','4578585'),
      ('Garcia Juan','Rivadavia 333','Villa del Rosario','Cordoba','4578445'),
      ('Perez Luis','Sarmiento 444','Rosario','Santa Fe',null),
      ('Pereyra Lucas','San Martin 555','Cruz del Eje','Cordoba','4253685'),
      ('Gomez Ines','San Martin 666','Santa Fe','Santa Fe','0345252525'),
      ('Torres Fabiola','Alem 777','Villa del Rosario','Cordoba','4554455'),
      ('Lopez Carlos',null,'Cruz del Eje','Cordoba',null),
      ('Ramos Betina','San Martin 999','Cordoba','Cordoba','4223366'),
      ('Lopez Lucas','San Martin 1010','Posadas','Misiones','0457858745');

-- 4- Obtenga el total de los registros agrupados por ciudad y provincia.

SELECT ciudad, provincia, COUNT(*) AS Cantidad 
FROM clientes
GROUP BY ciudad, provincia;

/* 5- Obtenga el total de los registros agrupados por ciudad y provincia sin considerar los que tienen 
      menos de 2 clientes. */

SELECT ciudad, provincia, COUNT(*) AS Cantidad 
FROM clientes
GROUP BY ciudad, provincia
HAVING COUNT(*)>2;

/* 6- Obtenga el total de los clientes que viven en calle "San Martin", agrupados por provincia, teniendo
      en cuenta todos los valores, de aquellas ciudades que tengan menos de 2 clientes y omitiendo la fila
      correspondiente a la ciudad de "Cordoba" */

SELECT ciudad, COUNT(*) AS cantidad
FROM clientes
WHERE domicilio LIKE '%San Martin%'
GROUP BY ALL ciudad
HAVING COUNT(*)<2 AND 
ciudad <> 'Cordoba';
