-- 1- Elimine la tabla "empleados" si existe:

IF OBJECT_ID('empleados') IS NOT NULL
DROP TABLE empleados;

-- 2- Créela con la siguiente estructura:

CREATE TABLE empleados (
  documento VARCHAR(8) NOT NULL,
  nombre    VARCHAR(30),
  seccion   VARCHAR(20)
 );

/* 3- Ingrese algunos registros, dos de ellos con el mismo número de documento:

('22222222','Alberto Lopez','Sistemas');
('23333333','Beatriz Garcia','Administracion');
('23333333','Carlos Fuentes','Administracion'); */

INSERT INTO empleados
VALUES('22222222','Alberto Lopez','Sistemas'),
      ('23333333','Beatriz Garcia','Administracion'),
      ('23333333','Carlos Fuentes','Administracion');

/* 4- Intente establecer una restricción "primary key" para la tabla para que el documento no se repita 
      ni admita valores nulos */:

ALTER TABLE empleados
ADD CONSTRAINT PK_documento
PRIMARY KEY(documento);

-- No lo permite porque hay un documento duplicado.

-- 5- Establezca la restricción "primary key" del punto 4.

-- Para esto, primero elimino el registro duplicado:

DELETE FROM empleados
WHERE nombre='Carlos Fuentes';

ALTER TABLE empleados
ADD CONSTRAINT PK_documento
PRIMARY KEY(documento);

-- Ahora si se ejecuta esa restricción.

-- 6- Intente actualizar un documento para que se repita.

UPDATE empleados SET documento='23333333'
WHERE documento='22222222';

-- NO se puede por la PK.

-- 7-Intente establecer otra restricción "primary key" con el campo "nombre".


ALTER TABLE empleados
ADD CONSTRAINT PK_nombre
PRIMARY KEY(nombre);

-- NO se puede ya que solo se permite una PK por tabla.

-- 8- Intente ingresar un registro con valor nulo para el documento.

INSERT INTO empleados
VALUES(NULL, 'Clara', 'Medicina');

-- NO se puede ingresar valor null en la PK.

/*9- Establezca una restricción "default" para que almacene "00000000" en el documento en caso de 
     omitirlo en un "insert". */

ALTER TABLE empleados
ADD CONSTRAINT DF_documento
DEFAULT '00000000'
FOR documento;

-- 10- Ingrese un registro sin valor para el documento.

INSERT INTO empleados
VALUES('','Clara', 'Medicina');

-- 11- Vea el registro:

SELECT * FROM empleados;

-- 12- Intente ingresar otro empleado sin documento explícito.

INSERT INTO empleados
VALUES(DEFAULT,'Clara', 'Medicina');

-- 13- Vea las restricciones de la tabla empleados:

EXEC sp_helpconstraint empleados;
