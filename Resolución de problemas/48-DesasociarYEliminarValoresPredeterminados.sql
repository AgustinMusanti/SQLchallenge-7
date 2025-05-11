-- 1- Elimine la tabla "Libros" si existe:

IF OBJECT_ID('libros') IS NOT NULL
DROP TABLE libros;

-- 2- Elimine los valores predeterminados:

IF OBJECT_ID('VP_cero') IS NOT NULL
DROP DEFAULT VP_cero;

IF OBJECT_ID('VP_desconocido') IS NOT NULL
DROP DEFAULT VP_desconocido;

IF OBJECT_ID('RG_positivo') IS NOT NULL
DROP RULE RG_positivo;

-- 3- Cree la tabla:

CREATE TABLE libros(
  codigo     INT IDENTITY,
  titulo     VARCHAR(40) NOT NULL,
  autor      VARCHAR(30),
  editorial  VARCHAR(20),
  precio     DECIMAL(5,2),
  cantidad   SMALLINT
 );

-- 4- Cree una regla para impedir que se ingresen valores negativos, llamada "RG_positivo".

CREATE RULE RG_positivo
AS @valor >=0;

-- 5- Asocie la regla al campo "precio".

EXEC sp_bindrule RG_positivo, 'libros.precio';

-- 6- Asocie la regla al campo "cantidad".

EXEC sp_bindrule RG_positivo, 'libros.cantidad';

-- 7- Cree un valor predeterminado para que almacene el valor cero, llamado "VP_cero".

CREATE DEFAULT VP_cero
AS 0;

-- 8- Asócielo al campo "precio".

EXEC sp_bindefault VP_cero,'libros.precio';

-- 9- Asócielo al campo "cantidad".

EXEC sp_bindefault VP_cero,'libros.cantidad';

-- 10- Cree un valor predeterminado con la cadena "Desconocido" llamado "VP_desconocido".

CREATE DEFAULT VP_cesconocido
AS 'Desconocido';

-- 11- Asócielo al campo "autor".

EXEC sp_bindefault VP_desconocido,'libros.autor';

-- 12- Asócielo al campo "editorial".

EXEC sp_bindefault VP_desconocido,'libros.editorial';

-- 13- Vea las reglas y valores predeterminados con "sp_help":

EXEC sp_help;

-- 14- Vea las reglas y valores predeterminados asociados a "libros".

EXEC sp_helpconstraint libros;

/*15- Ingrese un registro con valores por defecto para todos los campos, excepto "titulo" y vea qué se 
      almacenó. */

INSERT INTO libros (titulo) 
VALUES('Aprenda PHP');

SELECT * FROM libros;

-- 15- Quite la asociación del valor predeterminado "VP_cero" al campo "precio".

EXEC sp_unbindefault 'libros.precio';

-- 16- Ingrese otro registro con valor predeterminado para el campo "precio" y vea cómo se almacenó.

INSERT INTO libros (titulo) 
VALUES('Matematica estas ahi');

SELECT * FROM libros;

-- 17- Vea las reglas y valores predeterminados asociados a "libros".

EXEC sp_helpconstraint libros;

-- 18- Verifique que el valor predeterminado "VP_cero" existe aún en la base de datos.

EXEC sp_help;

-- 19- Intente eliminar el valor predeterminado "VP_cero".

DROP DEFAULT VP_cero;

-- 20- Quite la asociación del valor predeterminado "VP_cero" al campo "cantidad".

EXEC sp_unbindefault 'libros.cantidad';

-- 21- Verifique que ya no existe asociación de este valor predeterminado con la tabla "libros".

EXEC sp_helpconstraint libros;

-- 22- Verifique que el valor predeterminado "VP_cero" aun existe en la base de datos.

EXEC sp_help VP_cero;

-- 23- Elimine el valor predeterminado "VP_cero".

DROP DEFAULT VP_cero;

-- 24- Verifique que ya no existe en la base de datos.

EXEC sp_help VP_cero;
