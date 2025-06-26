-- 1- Elimine las tablas y créelas nuevamente:

 if object_id('inscriptos') is not null  
 drop table inscriptos;

 if object_id('socios') is not null  
 drop table socios;

 if object_id('profesores') is not null  
 drop table profesores; 

 if object_id('cursos') is not null  
 drop table cursos;

 create table socios(
  documento char(8) not null,
  nombre    varchar(40),
  domicilio varchar(30),
  constraint PK_socios_documento
  primary key (documento)
 );

 create table profesores(
  documento char(8) not null,
  nombre    varchar(40),
  domicilio varchar(30),
  constraint PK_profesores_documento
  primary key (documento)
 );

 create table cursos(
  numero  tinyint identity,
  deporte varchar(20),
  dia     varchar(15),
  constraint CK_inscriptos_dia check (dia in('lunes','martes','miercoles','jueves','viernes','sabado')),
  documentoprofesor char(8),
  constraint PK_cursos_numero
  primary key (numero),
 );

 create table inscriptos(
  documentosocio char(8) not null,
  numero         tinyint not null,
  matricula      char(1),
  constraint CK_inscriptos_matricula check (matricula in('s','n')),
  constraint PK_inscriptos_documento_numero
  primary key (documentosocio,numero)
 );

-- 2- Ingrese algunos registros para todas las tablas:

 insert into socios values('30000000','Fabian Fuentes','Caseros 987');
 insert into socios values('31111111','Gaston Garcia','Guemes 65');
 insert into socios values('32222222','Hector Huerta','Sucre 534');
 insert into socios values('33333333','Ines Irala','Bulnes 345');

 insert into profesores values('22222222','Ana Acosta','Avellaneda 231');
 insert into profesores values('23333333','Carlos Caseres','Colon 245');
 insert into profesores values('24444444','Daniel Duarte','Sarmiento 987');
 insert into profesores values('25555555','Esteban Lopez','Sucre 1204');

 insert into cursos values('tenis','lunes','22222222');
 insert into cursos values('tenis','martes','22222222');
 insert into cursos values('natacion','miercoles','22222222');
 insert into cursos values('natacion','jueves','23333333');
 insert into cursos values('natacion','viernes','23333333');
 insert into cursos values('futbol','sabado','24444444');
 insert into cursos values('futbol','lunes','24444444');
 insert into cursos values('basquet','martes','24444444');

 insert into inscriptos values('30000000',1,'s');
 insert into inscriptos values('30000000',3,'n');
 insert into inscriptos values('30000000',6,null);
 insert into inscriptos values('31111111',1,'s');
 insert into inscriptos values('31111111',4,'s');
 insert into inscriptos values('32222222',8,'s');

-- 3- Elimine la vista "vista_club" si existe:

IF OBJECT_ID('vista_club') IS NOT NULL
DROP TABLE vista_club;

/* 4- Cree una vista en la que aparezca el nombre y documento del socio, el deporte, el día y el nombre 
      del profesor. */

CREATE VIEW vista_club AS
SELECT s.nombre AS socio,s.documento AS docsocio,s.domicilio AS domsocio,c.deporte,dia,
       p.nombre AS profesor, matricula
FROM socios AS s
FULL JOIN inscriptos AS i
ON s.documento=i.documentosocio
FULL JOIN cursos AS c
ON i.numero=c.numero
FULL JOIN profesores AS p
ON c.documentoprofesor=p.documento;

-- 5- Muestre la información contenida en la vista.

SELECT * FROM vista_club;

/* 6- Realice una consulta a la vista donde muestre la cantidad de socios inscriptos en cada deporte 
      ordenados por cantidad. */

SELECT deporte,dia, COUNT(socio) AS 'Cantidad de socios'
FROM vista_club
WHERE deporte IS NOT NULL
GROUP BY deporte,dia
ORDER BY 'Cantidad de socios' DESC;

-- 7- Muestre (consultando la vista) los cursos (deporte y día) para los cuales no hay inscriptos.

SELECT deporte,dia
FROM vista_club
WHERE socio IS NULL AND deporte IS NOT NULL;

-- 8- Muestre los nombres de los socios que no se han inscripto en ningún curso (consultando la vista)

SELECT socio FROM vista_club
WHERE deporte IS NULL AND socio IS NOT NULL;

-- 9- Muestre (consultando la vista) los profesores que no tienen asignado ningún deporte aún.

SELECT profesor
FROM vista_club
WHERE deporte IS NULL AND profesor IS NOT NULL;

-- 10- Muestre (consultando la vista) el nombre y documento de los socios que deben matrículas.

SELECT socio, docsocio 
FROM vista_club 
WHERE deporte IS NOT NULL AND matricula <> 's';

/* 11- Consulte la vista y muestre los nombres de los profesores y los días en que asisten al club para 
       dictar sus clases. */

SELECT DISTINCT profesor,dia
FROM vista_club WHERE profesor IS NOT NULL;

-- 12- Muestre la misma información anterior pero ordenada por día.

SELECT DISTINCT profesor,dia
FROM vista_club WHERE profesor IS NOT NULL
ORDER BY dia ASC;

-- 13- Muestre todos los socios que son compañeros en tenis los lunes.

SELECT socio FROM vista_club
WHERE deporte='tenis' AND dia='lunes';

/* 14- Elimine la vista "vista_inscriptos" si existe y créela para que muestre la cantidad de 
       inscriptos por curso, incluyendo el número del curso, el nombre del deporte y el día. */

IF OBJECT_ID('vista_inscriptos') IS NOT NULL
DROP TABLE vista_inscriptos;

CREATE VIEW vista_inscriptos AS
SELECT deporte,dia,
       (SELECT COUNT(*)
        FROM inscriptos AS i
        WHERE i.numero=c.numero) AS cantidad
FROM cursos AS c;

-- 15- Consulte la vista:

SELECT * FROM vista_inscriptos;
