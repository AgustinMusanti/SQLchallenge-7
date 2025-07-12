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
      apellidos y sueldos de los empleados que tengan un sueldo superior o igual al enviado como 
      parámetro. */

CREATE PROCEDURE pa_empleados_sueldo
  @sueldo DECIMAL(6,2)
AS
  SELECT nombre,apellido,sueldo
  FROM empleados
  WHERE sueldo>=@sueldo;

-- 5- Ejecute el procedimiento creado anteriormente con distintos valores:

EXEC pa_empleados_sueldo @sueldo=100;

EXEC pa_empleados_sueldo @sueldo=350;

-- 6- Ejecute el procedimiento almacenado "pa_empleados_sueldo" sin parámetros.

EXEC pa_empleados_sueldo;

-- NO es posible.

-- 7- Elimine el procedimiento almacenado "pa_empleados_actualizar_sueldo" si existe:

IF OBJECT_ID('pa_empleados_actualizar_sueldo') IS NOT NULL
DROP PROCEDURE pa_empleados_actualizar_sueldo;

/* 8- Cree un procedimiento almacenado llamado "pa_empleados_actualizar_sueldo" que actualice los 
      sueldos iguales al enviado como primer parámetro con el valor enviado como segundo parámetro. */

CREATE PROCEDURE pa_empleados_actualizar_sueldo
  @sueldoanterior DECIMAL(6,2),
  @sueldonuevo DECIMAL(6,2)
AS
  UPDATE empleados SET sueldo=@sueldonuevo
  WHERE sueldo=@sueldoanterior;

-- 9- Ejecute el procedimiento creado anteriormente y verifique si se ha ejecutado correctamente:

SELECT * FROM empleados;

EXEC pa_empleados_actualizar_sueldo 300,350;

SELECT * FROM empleados;

-- 10- Ejecute el procedimiento "pa_empleados_actualizar_sueldo" enviando un solo parámetro.

EXEC pa_empleados_actualizar_sueldo 350;

-- Error.

/* 11- Ejecute el procedimiento almacenado "pa_empleados_actualizar_sueldo" enviando en primer lugar el 
       parámetro @sueldonuevo y en segundo lugar @sueldoanterior (parámetros por nombre). */

EXEC pa_empleados_actualizar_sueldo @sueldonuevo=400,@sueldoanterior=350;

-- Es posible.

-- 12- Verifique el cambio:

SELECT * FROM empleados;

-- 13- Elimine el procedimiento almacenado "pa_sueldototal", si existe:

IF OBJECT_ID('pa_sueldo_total') IS NOT NULL
DROP PROCEDURE pa_sueldo_total;

/* 14- Cree un procedimiento llamado "pa_sueldototal" que reciba el documento de un empleado y muestre 
       su nombre, apellido y el sueldo total (resultado de la suma del sueldo y salario por hijo, que es de 
       $200 si el sueldo es menor a $500 y $100, si el sueldo es mayor o igual a $500). Coloque como valor 
       por defecto para el parámetro el patrón "%". */

CREATE PROCEDURE pa_sueldototal
  @documento VARCHAR(8) = '%'
AS
  SELECT nombre,apellido,
   sueldototal=
   CASE 
   WHEN sueldo<500 THEN sueldo+(cantidadhijos*200)
   WHEN sueldo>=500 THEN sueldo+(cantidadhijos*100)
   END
   FROM empleados
   WHERE documento LIKE @documento;

-- 15- Ejecute el procedimiento anterior enviando diferentes valores:

EXEC pa_sueldototal '22333333';

EXEC pa_sueldototal '22444444';

EXEC pa_sueldototal '22666666';

-- 16-  Ejecute el procedimiento sin enviar parámetro para que tome el valor por defecto.

EXEC pa_sueldototal;
