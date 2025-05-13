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

/* 3- Establezca una restricción "primary" para el campo "legajo" y especifique que cree un índice 
      "agrupado". */

ALTER TABLE alumnos
ADD CONSTRAINT PK_alumnos_legajo
PRIMARY KEY CLUSTERED(legajo);

-- 4- Vea la información que muestra "sp_helpindex":

EXEC sp_helpindex alumnos;

-- 5- Intente eliminar el índice "PK_alumnos_legajo" con "drop index":

DROP INDEX PK_alumnos_legajo;

-- NO se puede ya que se debe especificar primero.

-- 6- Intente eliminar el índice "I_alumnos_apellido" sin especificar el nombre de la tabla:

DROP INDEX I_alumnos_apellido;

-- NO se puede ya que se debe especificar primero.

-- 7- Elimine el índice "I_alumnos_apellido" especificando el nombre de la tabla.

DROP INDEX alumnos.I_alumnos_apellido;

-- 8- Verifique que se eliminó:

EXEC sp_helpindex alumnos;

-- 9- Solicite que se elimine el índice "I_alumnos_apellido" si existe:

IF EXISTS (SELECT NAME FOR sysindexes
WHERE NAME = 'I_alumnos_apellido')
DROP INDEX alumnos.I_alumnos_apellido;

-- 10- Elimine el índice "PK_alumnos_legajo".

ALTER TABLE alumnos
DROP PK_alumnos_legajo;

-- 11- Verifique que el índice "PK_alumnos_legajo" ya no existe:

EXEC sp_helpindex alumnos;
