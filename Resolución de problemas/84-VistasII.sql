-- 1- Elimine las tabla "inscriptos", "socios" y "cursos", si existen:

if object_id('socios') IS NOT NULL
drop table socios;

if object_id('cursos') IS NOT NULL
drop table cursos;

if object_id('inscriptos') IS NOT NULL
drop table inscriptos;

-- 2- Cree las tablas:

 create table socios(
  documento char(8) not null,
  nombre    varchar(40),
  domicilio varchar(30),
  constraint PK_socios_documento
  primary key (documento)
 );

 create table cursos(
  numero  tinyint identity,
  deporte varchar(20),
  dia     varchar(15),
  constraint CK_inscriptos_dia check (dia in('lunes','martes','miercoles','jueves','viernes','sabado')),
  profesor varchar(20),
  constraint PK_cursos_numero
  primary key (numero),
 );

 create table inscriptos(
  documentosocio char(8) not null,
  numero         tinyint not null,
  matricula      char(1),
  constraint PK_inscriptos_documento_numero
  primary key (documentosocio,numero),
  constraint FK_inscriptos_documento
  foreign key (documentosocio)
  references socios(documento)
  on update cascade,
  constraint FK_inscriptos_numero
  foreign key (numero)
  references cursos(numero)
  on update cascade
  );

-- 3- Ingrese algunos registros para todas las tablas:

 insert into socios values('30000000','Fabian Fuentes','Caseros 987');
 insert into socios values('31111111','Gaston Garcia','Guemes 65');
 insert into socios values('32222222','Hector Huerta','Sucre 534');
 insert into socios values('33333333','Ines Irala','Bulnes 345');

 insert into cursos values('tenis','lunes','Ana Acosta');
 insert into cursos values('tenis','martes','Ana Acosta');
 insert into cursos values('natacion','miercoles','Ana Acosta');
 insert into cursos values('natacion','jueves','Carlos Caseres');
 insert into cursos values('futbol','sabado','Pedro Perez');
 insert into cursos values('futbol','lunes','Pedro Perez');
 insert into cursos values('basquet','viernes','Pedro Perez');

 insert into inscriptos values('30000000',1,'s');
 insert into inscriptos values('30000000',3,'n');
 insert into inscriptos values('30000000',6,null);
 insert into inscriptos values('31111111',1,'s');
 insert into inscriptos values('31111111',4,'s');
 insert into inscriptos values('32222222',1,'s');
 insert into inscriptos values('32222222',7,'s');

-- 4- Realice un join para mostrar todos los datos de todas las tablas, sin repetirlos:

SELECT documento,nombre,domicilio,c.numero,deporte,dia, profesor,matricula
FROM socios AS s
JOIN inscriptos AS i
ON s.documento=documentosocio
JOIN cursos AS c
ON c.numero=i.numero;

-- 5- Elimine, si existe, la vista "vista_cursos":

IF OBJECT_ID('vista_cursos') IS NOT NULL
DROP VIEW vista_cursos;

-- 6- Cree la vista "vista_cursos" que muestre el número, deporte y día de todos los cursos.

CREATE VIEW vista_cursos
AS
SELECT numero,deporte,dia
FROM cursos;

-- 7- Consulte la vista ordenada por deporte.

SELECT * FROM vista_cursos
ORDER BY deporte;

-- 8- Ingrese un registro en la vista "vista_cursos" y vea si afectó a "cursos".

INSERT INTO vista_cursos
VALUES('futbol','martes');

SELECT * FROM cursos;

-- Si, afecto a cursos.

-- 9- Actualice un registro sobre la vista y vea si afectó a la tabla "cursos".

UPDATE vista_cursos SET dia='miercoles'
WHERE numero=8;

SELECT * FROM cursos;

-- Si, afecto a cursos.

-- 10- Elimine un registro de la vista para el cual no haya inscriptos y vea si afectó a "cursos".

DELETE FROM vista_cursos 
WHERE numero=8;

SELECT * FROM cursos;

--Si, afecto a cursos.

-- 11- Intente eliminar un registro de la vista para el cual haya inscriptos.

DELETE FROM vista_cursos 
WHERE numero=1;

-- No es posible.

/* 12- Elimine la vista "vista_inscriptos" si existe y créela para que muestre el documento y nombre 
       del socio, el numero de curso, el deporte y día de los cursos en los cuales está inscripto. */

IF OBJECT_ID('vista_inscriptos') IS NOT NULL
DROP VIEW vista_inscriptos;

CREATE VIEW vista_inscriptos
AS
SELECT i.documentosocio,s.nombre,i.numero,c.deporte,dia
FROM inscriptos AS i
JOIN socios AS s
ON s.documento=documentosocio
JOIN cursos AS c
ON c.numero=i.numero;

-- 13- Intente ingresar un registro en la vista.

INSERT INTO vista_inscriptos
VALUES('32222222','Hector Huerta',6,'futbol','lunes');

-- No lo permite.

-- 14- Actualice un registro de la vista.

UPDATE vista_inscriptos SET nombre='Fabio Fuentes' 
WHERE nombre='Fabian Fuentes';

-- Es posible.

-- 15- Vea si afectó a la tabla "socios":

SELECT * FROM socios;

-- Si, se afecto.

-- 16- Intente actualizar el documento de un socio.

UPDATE vista_inscriptos SET documentosocio='30000111'
WHERE documentosocio='30000000';

-- No es posible.

-- 17- Intente eliminar un registro de la vista.

DELETE FROM vista_inscriptos
WHERE documentosocio='30000111' and deporte='tenis';

-- No es posible.
