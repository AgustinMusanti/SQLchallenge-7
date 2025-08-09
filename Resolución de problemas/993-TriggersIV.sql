-- 1- Elimine las tablas si existen:
 
if object_id('empleados') is not null
drop table empleados;

if object_id('sucursales') is not null
drop table sucursales;

-- 2- Cree las tablas, con las siguientes estructuras:
 
 create table sucursales(
  codigo    int identity,
  domicilio varchar(30),
  constraint PK_sucursales primary key (codigo)
 );

 create table empleados(
  documento char(8) not null,
  nombre    varchar(30),
  domicilio varchar(30),
  sucursal int not null,
  constraint PK_empleados primary key (documento),
  constraint FK_empleados_sucursal foreign key(sucursal)
  references sucursales(codigo)
 );

-- 3- Ingrese algunos registros en las dos tablas:

 insert into sucursales values ('Colon 123');
 insert into sucursales values ('Sucre 234');
 insert into sucursales values ('Rivadavia 345');

 insert into empleados values ('22222222','Ana Acosta','Avellaneda 1258',1);
 insert into empleados values ('23333333','Betina Bustos','Bulnes 345',2);
 insert into empleados values ('24444444','Carlos Caseres','Caseros 948',3);
 insert into empleados values ('25555555','Fabian Fuentes','Francia 845',1);
 insert into empleados values ('26666666','Gustavo Garcia','Guemes 587',2);
 insert into empleados values ('27777777','Maria Morales','Maipu 643',3);

/* 4- Cree un disparador de inserción, eliminación y actualización que no permita modificaciones en la 
      tabla "empleados" si tales modificaciones afectan a empleados de la sucursal de 1. */

 create trigger dis_empleados
  on empleados
  for insert,update,delete
  as
   declare @suc int
   if (exists (select *from inserted where sucursal=1)) or
      (exists (select *from deleted where sucursal=1))
   begin
    raiserror('No puede modificar datos de empleados de la sucursal 1', 16, 1)
    rollback transaction
   end;

-- 5- Ingrese un empleado en la sucursal 3.

 insert into empleados values ('30000000','Zulma Zapata','Suiza 258',3);

-- 6- Intente ingresar un empleado en la sucursal 1.

 insert into empleados values ('31111111','Ricardo Rojas','Rivadavia 256',1);

-- El trigger se dispara y deshace la transacción.

-- 7- Ejecute un "update" sobre "empleados" que permita la transacción.

 update empleados set domicilio='Avellaneda 234' where documento='23333333';

-- 8- Ejecute un "update" sobre "empleados" que el trigger deshaga.

 update empleados set domicilio='Avellaneda 234' where documento='22222222';

-- 9- Elimine un empleado (o varios) que no sean de la sucursal 1.

 delete from empleados where documento='30000000';

-- 10- Intente eliminar un empleado (o varios) de la sucursal 1.

 delete from empleados where documento='25555555';

 -- El trigger deshace la transacción.
