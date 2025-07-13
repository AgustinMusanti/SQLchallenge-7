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

-- 3- Elimine el procedimiento llamado "pa_empleados_seccion", si existe:

IF OBJECT_ID('pa_empleados_seccion') IS NOT NULL
DROP PROCEDURE pa_empleados_seccion;

/* 4- Cree un procedimiento que muestre todos los empleados de una sección determinada que se ingresa 
      como parámetro. Si no se ingresa un valor, o se ingresa "null", se muestra un mensaje y se sale del 
      procedimiento. */

CREATE PROCEDURE pa_empleados_seccion
  @seccion VARCHAR(20)=NULL
AS 
 IF @seccion IS NULL
 BEGIN 
 SELECT 'Debe indicar una seccion'
 RETURN
 END
 SELECT nombre FROM empleados WHERE seccion=@seccion;

-- 5- Ejecute el procedimiento enviándole un valor para el parámetro.

EXEC pa_empleados_seccion 'Secretaria';

-- 6- Ejecute el procedimiento sin parámetro.

EXEC pa_empleados_seccion;

-- 7- Elimine el procedimiento "pa_actualizarhijos", si existe:

IF OBJECT_ID('pa_actualizarhijos') IS NOT NULL
DROP PROCEDURE pa_actualizarhijos;

/* 8- Cree un procedimiento almacenado que permita modificar la cantidad de hijos ingresando el 
      documento de un empleado y la cantidad de hijos nueva. Ambos parámetros DEBEN ingresarse con un 
      valor distinto de "null". El procedimiento retorna "1" si la actualización se realiza (si se 
      ingresan valores para ambos parámetros) y "0", en caso que uno o ambos parámetros no se ingresen o 
      sean nulos. */

CREATE PROCEDURE pa_actualizarhijos
  @documento CHAR(8)=NULL,
  @hijos TINYINT=NULL
AS 
IF (@documento IS NULL) OR (@hijos IS NULL)
RETURN 0
ELSE 
BEGIN
UPDATE empleados SET cantidadhijos=@hijos WHERE documento=@documento
RETURN 1
END;

/* 9- Declare una variable en la cual se almacenará el valor devuelto por el procedimiento, ejecute el 
      procedimiento enviando los dos parámetros y vea el contenido de la variable. */

DECLARE @retorno INT

EXEC @retorno=pa_actualizarhijos '22222222',3
SELECT 'Registro actualizado=1' = @retorno;

-- 10- Verifique la actualización consultando la tabla:

SELECT * FROM empleados;

-- 11- Ejecute los mismos pasos, pero esta vez envíe solamente un valor para el parámetro "documento".

DECLARE @retorno INT

EXEC @retorno=pa_actualizarhijos '22333333'
SELECT 'Registro actualizado=1' = @retorno;

-- 12- Verifique que el registro no se actualizó consultando la tabla:

SELECT * FROM empleados;

-- 13- Emplee un "if" para controlar el valor de la variable de retorno. Enviando al procedimiento valores para los parámetros.

DECLARE @retorno INT

EXEC @retorno=pa_actualizarhijos '22333333',2
IF @retorno=1 SELECT 'Registro actualizado'
ELSE SELECT 'Registro no actualizado, se necesita un documento y la cantidad de hijos';

-- 14- Verifique la actualización consultando la tabla:

SELECT * FROM empleados;

-- 15- Emplee nuevamente un "if" y envíe solamente valor para el parámetro "hijos".

DECLARE @retorno INT
EXEC @retorno=pa_actualizarhijos @hijos=4
IF @retorno=1 SELECT 'Registro actualizado'
ELSE SELECT 'Registro no actualizado, se necesita un documento y la cantidad de hijos';
