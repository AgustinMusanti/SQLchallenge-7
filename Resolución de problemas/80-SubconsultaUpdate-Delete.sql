-- 1- Elimine las tablas si existen:

IF OBJECT_ID('socios') IS NOT NULL
DROP TABLE socios;

IF OBJECT_ID('inscriptos') IS NOT NULL
DROP TABLE inscriptos;

-- 2- Cree las tablas:

 create table socios(
  numero    int identity,
  documento char(8),
  nombre    varchar(30),
  domicilio varchar(30),
  primary key (numero)
 );
 
 create table inscriptos (
  numerosocio int not null,
  deporte     varchar(20) not null,
  matricula   char(1),-- 'n' o 's'
  primary key(numerosocio,deporte),
  constraint FK_inscriptos_socio
  foreign key (numerosocio) references socios(numero)
 );

-- 3- Ingrese algunos registros:

3- Ingrese algunos registros:

INSERT INTO socios
VALUES('23333333','Alberto Paredes','Colon 111'),
      ('24444444','Carlos Conte','Sarmiento 755'),
      ('25555555','Fabian Fuentes','Caseros 987'),
      ('26666666','Hector Lopez','Sucre 344');

INSERT INTO inscriptos
VALUES(1,'tenis','s'),
      (1,'basquet','s'),
      (1,'natacion','s'),
      (2,'tenis','s'),
      (2,'natacion','s'),
      (2,'basquet','n'),
      (2,'futbol','n'),
      (3,'tenis','s'),
      (3,'basquet','s'),
      (3,'natacion','n'),
      (4,'basquet','n');

/* 4- Actualizamos la cuota ('s') de todas las inscripciones de un socio determinado (por documento) 
      empleando subconsulta. */

UPDATE inscriptos SET matricula='s'
WHERE numerosocio=
   (SELECT numero
    FROM   socios
    WHERE  documento='25555555');

-- 5- Elimine todas las inscripciones de los socios que deben alguna matrícula

DELETE FROM inscriptos
WHERE numerosocio IN
   (SELECT numero
    FROM   socios AS s
    JOIN   inscriptos
    ON     numerosocio=numero
    WHERE  matricula='n');
