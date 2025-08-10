-- 1- Elimine las tablas si existen:

if object_id('inscriptos') is not null
drop table inscriptos;

if object_id('socios') is not null
drop table socios;

if object_id('cursos') is not null
drop table cursos;

-- 2- Cree las tablas, con las siguientes estructuras:

 create table socios(
  documento char(8) not null,
  nombre    varchar(30),
  domicilio varchar(30),
  constraint PK_socios primary key(documento)
 );

 create table cursos(
  numero  tinyint identity,
  deporte char(20),
  cantidadmaxima tinyint,
  constraint PK_cursos primary key(numero)
 );

 create table inscriptos(
  documento   char(8) not null,
  numerocurso tinyint,
  fecha       datetime,
  constraint PK_inscriptos primary key(documento,numerocurso),
  constraint FK_inscriptos_documento
  foreign key (documento)
  references socios(documento),
  constraint FK_inscriptos_curso
  foreign key (numerocurso)
  references cursos(numero)
 );

-- 3- Elimine la tabla "condicionales" si existe:

if object_id('condicionales') is not null
drop table condicionales;

-- 4- Cree la tabla, con la siguiente estructura:

 create table condicionales(
  documento   char(8) not null,
  codigocurso tinyint not null,
  fecha       datetime
 );

-- 5- Ingrese algunos registros en las tablas "socios", "cursos" e "inscriptos":

 insert into socios values('22222222','Ana Acosta','Avellaneda 800');
 insert into socios values('23333333','Bernardo Bustos','Bulnes 345');
 insert into socios values('24444444','Carlos Caseros','Colon 382');
 insert into socios values('25555555','Mariana Morales','Maipu 234');
 insert into socios values('26666666','Patricia Palacios','Paru 587');

 insert into cursos values('tenis',4);
 insert into cursos values('natacion',6);
 insert into cursos values('basquet',20);
 insert into cursos values('futbol',20);

 insert into inscriptos values('22222222',1,getdate());
 insert into inscriptos values('22222222',2,getdate());
 insert into inscriptos values('23333333',1,getdate());
 insert into inscriptos values('23333333',3,getdate());
 insert into inscriptos values('24444444',1,getdate());
 insert into inscriptos values('24444444',4,getdate());
 insert into inscriptos values('25555555',1,getdate());

/* 6- Cree un trigger "instead of" para el evento de inserción para que, al intentar ingresar un 
      registro en "inscriptos" controle que el curso no esté completo (tantos inscriptos a tal curso como 
      su "cantidadmaxima"); si lo estuviese, debe ingresarse la inscripción en la tabla "condicionales" y 
      mostrar un mensaje indicando tal situación. Si la "cantidadmaxima" no se alcanzó, se ingresa la 
      inscripción en "inscriptos". */

create trigger dis_inscriptos_insertar
 on inscriptos
 instead of insert
 as
 begin
  declare @maximo tinyint
  select @maximo=cantidadmaxima from cursos as c
                  join inserted as i
                  on c.numero=i.numerocurso
  if (@maximo=(select count(*) from inscriptos as i
               join cursos as c
               on i.numerocurso=c.numero
               join inserted as ins
               on i.numerocurso=ins.numerocurso))
  -- esta completo
  begin
   insert into condicionales select documento,numerocurso,fecha from inserted
   select 'Inscripción condicional.'
  end
  else -- no esta completo
  begin
   insert into inscriptos select documento,numerocurso,fecha from inserted
   select 'Inscripción realizada.'
  end
 end;

/* 7- Inscriba un socio en un curso que no esté completo.
      Verifique que el trigger realizó la acción esperada consultando las tablas: */

 insert into inscriptos values('26666666',2,getdate());

 select *from inscriptos;

 select *from condicionales;

/* 8- Inscriba un socio en un curso que esté completo.
      Verifique que el trigger realizó la acción esperada consultando las tablas: */

 insert into inscriptos values('26666666',1,getdate());

 select *from inscriptos;

 select *from condicionales;
