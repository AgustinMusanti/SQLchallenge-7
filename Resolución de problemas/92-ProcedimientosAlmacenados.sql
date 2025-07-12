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
 insert into empleados values('22333333','Luis','Lopez',300,0,'Contaduria');
 insert into empleados values ('22444444','Marta','Perez',500,1,'Sistemas');
 insert into empleados values('22555555','Susana','Garcia',400,2,'Secretaria');
 insert into empleados values('22666666','Jose Maria','Morales',400,3,'Secretaria');

-- 3- Elimine el procedimiento llamado "pa_empleados_sueldo" si existe:

IF OBJECT_ID('pa_empleados_sueldo') IS NOT NULL
DROP PROCEDURE pa_empleados_sueldo;

/* 4- Cree un procedimiento almacenado llamado "pa_empleados_sueldo" que seleccione los nombres, 
      apellidos y sueldos de los empleados. */

CREATE PROCEDURE pa_empleados_sueldo
AS
  SELECT nombre,apellido,sueldo
  FROM empleados;

-- 5- Ejecute el procedimiento creado anteriormente.

EXEC pa_empleados_sueldo;

-- 6- Elimine el procedimiento llamado "pa_empleados_hijos" si existe:

IF OBJECT_ID('pa_empleados_hijos') IS NOT NULL
DROP PROCEDURE pa_empleados_hijos;

/* 7- Cree un procedimiento almacenado llamado "pa_empleados_hijos" que seleccione los nombres, 
      apellidos y cantidad de hijos de los empleados con hijos. */

CREATE PROCEDURE pa_empleados_hijos
AS
  SELECT nombre,apellido,cantidadhijos
  FROM empleados;

-- 8- Ejecute el procedimiento creado anteriormente.

EXEC pa_empleados_hijos;

/* 9- Actualice la cantidad de hijos de algún empleado sin hijos y vuelva a ejecutar el procedimiento 
      para verificar que ahora si aparece en la lista. */

UPDATE empleados SET cantidadhijos=1
WHERE documento='22333333';

EXEC pa_empleados_hijos;
