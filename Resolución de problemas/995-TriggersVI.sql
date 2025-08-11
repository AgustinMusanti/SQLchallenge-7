-- 1- Elimine las tablas si existen y créelas con los siguientes campos:

 if object_id('empleados') is not null
 drop table empleados;

 if object_id('secciones') is not null
 drop table secciones;

 create table secciones(
  codigo int identity,
  nombre varchar(30),
  constraint pk_secciones primary key (codigo)
 ); 

 create table empleados(
  documento char(8) not null,
  nombre    varchar(30),
  domicilio varchar(30),
  seccion   int not null,
  constraint pk_empleados primary key (documento),
  constraint fk_empleados_seccion foreign key(seccion)
  references secciones (codigo)
 ); 

-- 2- Ingrese algunos registros:

 insert into secciones values('Secretaria');
 insert into secciones values('Sistemas');
 insert into secciones values('Contaduría');
 insert into secciones values('Gerencia');

 insert into empleados values('22222222','Alejandro Acosta','Avellaneda 90',1);
 insert into empleados values('22333333','Betina Bustos','Bulnes 345',2);
 insert into empleados values('23444444','Camila Costa','Colon 234',1);
 insert into empleados values('23555555','Daniel Duarte','Duarte Quiros 345',3);
 insert into empleados values('23666666','Estela Esperanza','España 211',4);

/* 3- Cree un disparador de eliminación sobre la tabla "empleados" que permita borrar varios empleados 
      a la vez, pero ningún empleado de la sección "Gerencia".
      Se eliminan todos los empleados solicitados en cualquier sentencia "delete", y luego se vuelven a 
      insertar aquellos de la sección "Gerencia". */

 create trigger dis_empleados_borrar
 on empleados
 after delete
 as 
  declare @seccion int
  select @seccion=codigo from secciones where nombre='Gerencia'
  declare @borrados int
  select @borrados= count(*)from deleted
  declare @insertados int
  select @insertados=count(*)from inserted
  if exists (select *from deleted where seccion=@seccion)
  begin
   insert into empleados select documento,nombre,domicilio,seccion from deleted
   where deleted.seccion=@seccion
   select @insertados=count(*)from inserted
  end;

-- 4- Elimine varios registros entre los cuales haya un empleado de "Gerencia".

 delete empleados where documento like '23%';

-- 5- Vea el resultado:

 select *from empleados;

-- Solamente se eliminaron aquellos que no pertenecen a la sección "Gerencia".
