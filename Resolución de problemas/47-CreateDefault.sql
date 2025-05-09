-- 1- Elimine la tabla "clientes", si existe:

IF OBJECT_ID('clientes') IS NOT NULL
DROP TABLE clientes;

/* 2-Elimine los siguientes Defaults:

('VP_legajo_patron')
('RG_legajo_patron')
('RG_legajo')
('VP_datodesconocido')
('VP_fechaactual') */

IF OBJECT_ID('VP_legajo_patron') IS NOT NULL
DROP DEFAULT VP_legajo_patron;

IF OBJECT_ID('RG_legajo_patron') IS NOT NULL
DROP RULE RG_legajo_patron;

IF OBJECT_ID('RG_legajo') IS NOT NULL
DROP RULE RG_legajo;

IF OBJECT_ID('VP_datodesconocido') IS NOT NULL
DROP DEFAULT VP_datodesconocido;

IF OBJECT_ID('VP_fechaactual') IS NOT NULL
DROP DEFAULT VP_fechaactual;

-- 3- Cree la tabla:

CREATE TABLE clientes(
  legajo       CHAR(4),
  nombre       VARCHAR(30),
  domicilio    VARCHAR(30),
  ciudad       VARCHAR(15),
  provincia    VARCHAR(20) DEFAULT 'Cordoba',
  fechaingreso DATETIME
 );

/* 4- Cree una regla para establecer un patrón para los valores que se ingresen en el campo "legajo" (2 
      letras seguido de 2 cifras) llamada "RG_legajo_patron": */

CREATE RULE RG_legajo_patron
AS @valor LIKE '[A-Z][A-Z][0-9][0-9]';

-- 5- Asocie la regla al campo "legajo".

EXEC sp_bindrule RG_legajo_patron,'clientes.legajo';

-- 6- Cree un valor predeterminado para el campo "legajo" ('AA00') llamado "VP_legajo_patron".

CREATE DEFAULT VP_legajo_patron
AS'AA00';

-- 7- Asócielo al campo "legajo".

EXEC sp_bindefault VP_legajo_patron,'clientes.legajo';

-- 8- Cree un valor predeterminado con la cadena "??" llamado "VP_datodesconocido".

CREATE DEFAULT VP_datodesconocido
AS'??';
9- Asócielo al campo "domicilio".

10- Asócielo al campo "ciudad".

11- Ingrese un registro con valores por defecto para los campos "domicilio" y "ciudad" y vea qué 
almacenaron.

12- Intente asociar el valor predeterminado "VP_datodesconocido" al campo "provincia".

13- Cree un valor predeterminado con la fecha actual llamado "VP_fechaactual".

14- Asócielo al campo "fechaingreso".

15- Ingrese algunos registros para ver cómo se almacenan los valores para los cuales no se insertan 
datos.

16- Asocie el valor predeterminado "VP_datodesconocido" al campo "fechaingreso".

17- Ingrese un registro con valores por defecto.

18- Cree una regla que entre en conflicto con el valor predeterminado "VP_legajo_patron".

19- Asocie la regla al campo "legajo".

20- Intente ingresar un registro con el valor "default" para el campo "legajo".
