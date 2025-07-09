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

-- 4- Elimine la vista "vista_deudores" si existe:

IF OBJECT_ID('vista_deudores') IS NOT NULL
DROP VIEW vista_deudores;

/* 5- Cree la vista "vista_deudores" que muestre el documento y nombre del socio, el deporte, el día y 
      la matrícula, de todas las inscripciones no pagas colocando "with check option". */

CREATE VIEW vista_deudores
AS
  SELECT documento,nombre,c.deporte,c.dia,matricula
  FROM socios AS s
  JOIN inscriptos AS i
  ON documento=documentosocio
  JOIN cursos AS c
  ON c.numero=i.numero
  WHERE matricula='n'
  WITH CHECK OPTION;

-- 6- Consulte la vista:

SELECT * FROM vista_deudores;

-- 7- Veamos el texto de la vista.

sp_helptext vista_deudores;

-- 8- Intente actualizar a "s" la matrícula de una inscripción desde la vista.

UPDATE vista_deudores SET matricula='s' 
WHERE documento='31111111';

-- No lo permite por la opción "with check option".

-- 9- Modifique el documento de un socio mediante la vista.

UPDATE vista_deudores SET documento='31111113'
WHERE documento='31111111';

-- 10- Vea si se alteraron las tablas referenciadas en la vista:

SELECT * FROM socios;

SELECT * FROM inscriptos;

-- NO se alteraron.

/* 11- Modifique la vista para que muestre el domicilio, coloque la opción de encriptación y omita 
       "with check option". */

ALTER VIEW vista_deudores
WITH ENCRYPTION
AS
  SELECT documento,nombre,domicilio,c.deporte,c.dia,matricula
  FROM socios AS s
  JOIN inscriptos AS i
  ON documento=documentosocio
  JOIN cursos AS c
  ON c.numero=i.numero
  WHERE matricula='n';

-- 12- Consulte la vista para ver si se modificó:

SELECT * FROM vista_deudores;

-- 13- Vea el texto de la vista.

sp_helptext vista_deudores;

-- 14- Actualice la matrícula de un inscripto.

UPDATE vista_deudores SET matricula='s'
WHERE documento='30000000';

-- Ahora si se puede ya que sacamos el "with check option".

-- 15- Consulte la vista:

SELECT * FROM vista_deudores;

-- 16- Elimine la vista "vista_socios" si existe:

IF OBJECT_ID('vista_socios') IS NOT NULL
DROP VIEW vista_socios;

-- 17- Cree la vista "vista_socios" que muestre todos los campos de la tabla "socios".

CREATE VIEW vista_socios
AS
   SELECT * FROM socios;

-- 18- Consulte la vista.

SELECT * FROM vista_socios;

-- 19- Agregue un campo a la tabla "socios".

ALTER TABLE socios
ADD telefono CHAR(10);

-- 20- Consulte la vista "vista_socios".

SELECT * FROM vista_socios;

-- NO se agrega el nuevo campo.

-- 21- Altere la vista para que aparezcan todos los campos.

ALTER VIEW vista_socios
AS
  SELECT * FROM socios;

-- 22- Consulte la vista.

SELECT * FROM vista_socios;

-- Ahora si figura el neuvo campo (telefono).
