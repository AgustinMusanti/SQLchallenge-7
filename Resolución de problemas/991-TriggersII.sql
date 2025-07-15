-- 1- Elimine la tabla si existe:

if object_id('articulos') is not null
drop table articulos;

-- 2- Cree la tabla, con la siguiente estructura:

 create table articulos(
  codigo      int identity,
  tipo        varchar(30),
  descripcion varchar(40),
  precio      decimal(8,2),
  stock int,
  constraint PK_articulos primary key (codigo)
 );

-- 3- Ingrese algunos registros:

 insert into articulos values ('impresora','Epson Stylus C45',400,100);
 insert into articulos values ('impresora','Epson Stylus C85',500,200);
 insert into articulos values ('impresora','Epson Stylus Color 600',400,0);
 insert into articulos values ('monitor','Samsung 14',900,0);
 insert into articulos values ('monitor','Samsung 17',1200,0);
 insert into articulos values ('monitor','xxx 15',1500,0);
 insert into articulos values ('monitor','xxx 17',1600,0);
 insert into articulos values ('monitor','zzz 15',1300,0);

/* 4- Cree un disparador para controlar que no se elimine un artículo si hay stock. El disparador se 
      activará cada vez que se ejecuta un "delete" sobre "articulos", controlando el stock, si se está 
      eliminando un artículo cuyo stock sea mayor a 0, el disparador debe retornar un mensaje de error y 
      deshacer la transacción. */

create trigger DIS_articulos_borrar
  on articulos
  for delete
  as 
   if exists(select *from deleted where stock>0)--si algun registro borrado tiene stock
   begin
    raiserror('No puede eliminar artículos que tienen stock',16,1)
    rollback transaction
   end
   else
   begin
     declare @cantidad int
     select @cantidad=count(*) from deleted
     select 'Se eliminaron ' +rtrim(cast(@cantidad as char(10)))+ ' registros'
   end;

-- 5- Solicite la eliminación de un articulo que no tenga stock.

 delete from articulos where codigo=4;

-- 6- Intente eliminar un artículo para el cual haya stock.

 delete from articulos where codigo=2;

-- 7- Solicite la eliminación de varios artículos que no tengan stock.

 delete from articulos where descripcion like '%xx%';

-- 8- Intente eliminar varios artículos, algunos con stock y otros sin stock.

 delete from articulos where codigo<=3;

-- 9- Cree un trigger para evitar que se elimine más de 1 artículo.

create trigger DIS_articulos_borrar2
  on articulos
  for delete
  as
   declare @cantidad int
   select @cantidad=count(*) from deleted
   if @cantidad>1
   begin
    raiserror('No puede eliminar más de 1 artículo',16,1)
    rollback transaction
   end;

-- 10- Solicite la eliminación de 1 artículo para el cual no haya stock.

 delete from articulos where codigo=3;

-- 11- Solicite la eliminación de 1 artículo que tenga stock.

 delete from articulos where codigo=2;

-- 12- Solicite la eliminación de 2 artículos para los cuales no haya stock.

 delete from articulos where tipo='monitor';

-- 13- Solicite la eliminación de 2 artículos para los que haya stock.

 delete from articulos where tipo='impresora';
