-- 1- Elimine la tabla "alumnos" si existe y créela con la siguiente estructura:

IF OBJECT_ID('alumnos') IS NOT NULL
DROP TABLE alumnos;

CREATE TABLE alumnos(
  legajo    CHAR(5) NOT NULL,
  documento CHAR(8) NOT NULL,
  apellido  VARCHAR(30),
  nombre    VARCHAR(30),
  notafinal DECIMAL(4,2)
 );

-- 2- Cree un índice no agrupado para el campo "apellido".

CREATE NONCLUSTERED INDEX I_alumnos_apellido
ON alumnos(apellido);

-- 3- Vea la información de los índices de "alumnos".

EXEC sp_helpindex alumnos;

-- 4- Modifíquelo agregando el campo "nombre".

CREATE NONCLUSTERED INDEX I_alumnos_apellido
ON alumnos(apellido,nombre)
WITH DROP_EXISTING;

-- 5- Verifique que se modificó:

EXEC sp_helpindex alumnos;

-- 6- Establezca una restricción "unique" para el campo "documento".

ALTER TABLE alumnos
ADD CONSTRAINT UQ_alumnos_documento
UNIQUE NONCLUSTERED(documento);

-- 7- Vea la información que muestra "sp_helpindex":

EXEC sp_helpindex alumnos;

/* 8- Intente modificar con "drop_existing" alguna característica del índice que se creó 
      automáticamente al agregar la restricción "unique": */

CREATE CLUSTERED INDEX UQ_alumnos_documento
ON alumnos(documento)
WITH DROP_EXISTING;

-- NO se puede.

-- 9- Cree un índice no agrupado para el campo "legajo".

CREATE NONCLUSTERED INDEX I_alumnos_legajo
ON alumnos(legajo);

-- 10- Muestre todos los índices:

EXEC sp_helpindex alumnos;

-- 11- Convierta el índice creado en el punto 9 a agrupado conservando las demás características.

CREATE CLUSTERED INDEX I_alumnos_legajo
ON alumnos(legajo)
WITH DROP_EXISTING;

-- 12- Verifique que se modificó:

EXEC sp_helpindex alumnos;

-- 13- Intente convertir el índice "I_alumnos_legajo" a no agrupado:

CREATE NONCLUSTERED INDEX I_alumnos_legajo
ON alumnos(legajo)
WITH DROP_EXISTING;

-- No se puede convertir un índice agrupado en no agrupado.

-- 14- Modifique el índice "I_alumnos_apellido" quitándole el campo "nombre".

CREATE NONCLUSTERED INDEX I_alumnos_apellido
ON alumnos(apellido)
WITH DROP_EXISTING;

-- 15- Intente convertir el índice "I_alumnos_apellido" en agrupado:

CREATE CLUSTERED INDEX I_alumnos_apellido
ON alumnos(apellido)
WITH DROP_EXISTING;

-- NO puede haber mas de un clustered index por tabla.

/* 16- Modifique el índice "I_alumnos_legajo" para que sea único y conserve todas las otras 
       características. */

CREATE UNIQUE CLUSTERED INDEX I_alumnos_legajo
ON alumnos(legajo)
WITH DROP_EXISTING;

-- 17- Verifique la modificación:

EXEC sp_helpindex alumnos;

/* 18- Modifique nuevamente el índice "I_alumnos_legajo" para que no sea único y conserve las demás 
       características. */

CREATE CLUSTERED INDEX I_alumnos_legajo
ON alumnos(legajo)
WITH DROP_EXISTING;

-- 19- Verifique la modificación:

EXEC sp_helpindex alumnos;
