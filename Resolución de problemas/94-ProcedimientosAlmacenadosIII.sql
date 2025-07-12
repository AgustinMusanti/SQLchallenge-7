-- 1- Eliminamos la tabla, si existe y la creamos:

IF OBJECT_ID('empleados') IS NOT NULL
DROP TABLE empleados;

 create table empleados(
  documento     char(8),
  nombre        varchar(20),
  apellido      varchar(20),
  sueldo        decimal(6,2),
  cantidadhijos tinyint,
  seccion       varchar(20),
  primary key(documento)
 );

-- 2- Ingrese algunos registros:

 insert into empleados values('22222222','Juan','Perez',300,2,'Contaduria');
 insert into empleados values('22333333','Luis','Lopez',350,0,'Contaduria');
 insert into empleados values ('22444444','Marta','Perez',500,1,'Sistemas');
 insert into empleados values('22555555','Susana','Garcia',null,2,'Secretaria');
 insert into empleados values('22666666','Jose Maria','Morales',460,3,'Secretaria');
 insert into empleados values('22777777','Andres','Perez',580,3,'Sistemas');
 insert into empleados values('22888888','Laura','Garcia',400,3,'Secretaria');

-- 3- Elimine el procedimiento llamado "pa_seccion" si existe:

IF OBJECT_ID('pa_seccion') IS NOT NULL
DROP PROCEDURE pa_seccion;

/* 4- Cree un procedimiento almacenado llamado "pa_seccion" al cual le enviamos el nombre de una 
      sección y que nos retorne el promedio de sueldos de todos los empleados de esa sección y el valor 
      mayor de sueldo (de esa sección) */

CREATE PROCEDURE pa_seccion
  @seccion  VARCHAR(20)='%',
  @promedio DECIMAL(6,2) OUTPUT,
  @mayor    DECIMAL(6,2) OUTPUT
AS
  SELECT @promedio=AVG(sueldo)
  FROM   empleados
  WHERE  seccion LIKE @seccion
  SELECT @mayor=MAX(sueldo)
  FROM   empleados
  WHERE  seccion LIKE @seccion;

-- 5- Ejecute el procedimiento creado anteriormente con distintos valores.


DECLARE @p DECIMAL(6,2), @m DECIMAL(6,2)

EXECUTE pa_seccion 'Contaduria', @p OUTPUT, @m OUTPUT
SELECT @p AS promedio, @m AS mayor

/* 6- Ejecute el procedimiento "pa_seccion" sin pasar valor para el parámetro "sección". Luego muestre 
      los valores devueltos por el procedimiento. */

EXECUTE pa_seccion, @p OUTPUT, @m OUTPUT
SELECT @p AS promedio, @m AS mayor;

-- Error.

/* 7- Elimine el procedimiento almacenado "pa_sueldototal", si existe y cree un procedimiento con ese 
      nombre que reciba el documento de un empleado y retorne el sueldo total, resultado de la suma del 
      sueldo y salario por hijo, que es $200 si el sueldo es menor a $500 y $100 si es mayor o igual. */

IF OBJECT_ID('pa_sueldototal') IS NOT NULL
DROP PROCEDURE pa_sueldototal;

CREATE PROCEDURE pa_sueldototal
  @documento   VARCHAR(8)='%',
  @sueldototal DECIMAL(8,2) OUTPUT
AS
  SELECT @sueldototal=
  CASE 
    WHEN sueldo<500 THEN sueldo+(cantidadhijos*200)
    WHEN sueldo>=500 THEN sueldo+(cantidadhijos*100)
  END
  FROM empleados
  WHERE documento LIKE @documento;

-- 8- Ejecute el procedimiento anterior enviando un documento existente.

DECLARE @st DECIMAL(8,2)
EXEC pa_sueldototal '22666666', @st OUTPUT
SELECT @st AS SueldoTotal;

-- 9- Ejecute el procedimiento anterior enviando un documento inexistente.

DECLARE @st DECIMAL(8,2)
EXEC pa_sueldototal '52525252', @st OUTPUT
SELECT @st AS SueldoTotal;

-- Arroja NULL.

/* 10- Ejecute el procedimiento anterior enviando el documento de un empleado en cuyo campo "sueldo" 
       contenga "null". */

DECLARE @st DECIMAL(8,2)
EXEC pa_sueldototal '22999999', @st OUTPUT
SELECT @st;

-- 11- Ejecute el procedimiento anterior sin enviar valor para el parámetro "documento".

DECLARE @st DECIMAL(8,2)
EXEC pa_sueldototal @sueldototal=@st OUTPUT
SELECT @st;

-- Retorna el valor calculado del último registro.
