-- 1- Elimine la tabla si existe:

IF OBJECT_ID('empleados') IS NOT NULL
DROP TABLE empleados;

-- 2- Cree la tabla con la siguiente estructura:

 create table empleados(
  documento       char(8) not null,
  apellido        varchar(30) not null,
  nombre          varchar(30) not null,
  domicilio       varchar(30),
  ciudad          varchar(30),
  fechanacimiento datetime,
  constraint PK_empleados
   primary key(documento)
 );

-- 3- Ingrese algunos registros:

 insert into empleados values('22222222','Acosta','Ana','Avellaneda 123','Cordoba','1970/10/10');
 insert into empleados values('23333333','Bustos','Bernardo','Bulnes 234','Cordoba','1972/05/15');
 insert into empleados values('24444444','Caseros','Carlos','Colon 356','Carlos Paz','1980/02/25');
 insert into empleados values('25555555','Fuentes','Fabiola','Fragueiro 987','Jesus Maria','1984/06/12');

-- 4- Elimine la función "f_empleados" si existe:;

IF OBJECT_ID('f_empleados') IS NOT NULL
DROP FUNCTION f_empleados;

/* 5- Cree una función que reciba como parámetro el texto "total" o "parcial" y muestre, en el primer 
      caso, todos los datos de los empleados y en el segundo caso (si recibe el valor "parcial"): el 
      documento, apellido, ciudad y año de nacimiento. */

create function f_empleados
 (@opcion varchar(10)
 )
 returns @listado table
 (documento char(8),
 nombre varchar(60),
 domicilio varchar(60),
 nacimiento varchar(12))
 as 
 begin
  if @opcion not in ('total','parcial')
    set @opcion='parcial'
  if @opcion='total'
   insert @listado 
    select documento,
    (apellido+' '+nombre),
    (domicilio+' ('+ciudad+')'), 
    cast(fechanacimiento as varchar(12))
     from empleados
  else
   insert @listado
   select documento,apellido,ciudad,cast(datepart(year,fechanacimiento) as char(4))
   from empleados
  return
end;

-- 6 - Llame a la función creada anteriormente enviándole "total".

SELECT * FROM dbo.f_empleados('total');

-- 7- Llame a la función anteriormente creada sin enviar argumento.

SELECT * FROM dbo.f_empleados();

-- Error.

-- 8- Llame a la función enviándole una cadena vacía.

SELECT * FROM dbo.f_empleados('');

/* 9- Ejecute la función "f_empleados" enviando "parcial" como argumento y recupere solamente los 
      registros cuyo domicilio es "Cordoba". */

SELECT * FROM dbo.f_empleados('parcial')
WHERE domicilio='Cordoba';
