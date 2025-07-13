-- 1- Elimine la tabla si existe y créela:

IF OBJECT_ID('alumnos') IS NOT NULL
DROP TABLE alumnos;

 create table alumnos(
  documento char(8),
  nombre    varchar(40),
  nota      decimal(4,2),
  primary key(documento)
 );

-- 2- Ingrese algunos registros:

 insert into alumnos values ('22222222','Pedro Lopez',5);
 insert into alumnos values ('23333333','Ana Lopez',4);
 insert into alumnos values ('24444444','Maria Juarez',8);
 insert into alumnos values ('25555555','Juan Garcia',5.6);
 insert into alumnos values ('26666666','Karina Torres',2);
 insert into alumnos values ('27777777','Nora Torres',7.5);
 insert into alumnos values ('28888888','Mariano Herrero',3.5);

-- 3- Elimine la tabla "aprobados" si existe y créela con los mismos campos de la tabla "alumnos":

IF OBJECT_ID('aprobados') IS NOT NULL
DROP TABLE aprobados;

create table aprobados(
  documento char(8),
  nombre    varchar(40),
  nota      decimal(4,2),
  primary key(documento)
 );

4- Elimine la tabla "desaprobados" si existe y créela con los siguientes campos:

IF OBJECT_ID('desaprobados') IS NOT NULL
DROP TABLE desaprobados;

 create table desaprobados(
  documento char(8),
  nombre    varchar(40)
 );

-- 5- Elimine el procedimiento llamado "pa_aprobados", si existe:

IF OBJECT_ID('pa_aprobados') IS NOT NULL
DROP PROCEDURE pa_aprobados;

/* 6- Cree el procedimiento para que seleccione todos los datos de los alumnos cuya nota es igual o 
      superior a 4. */

CREATE PROCEDURE pa_aprobados
AS
  SELECT *
  FROM alumnos
  WHERE nota>=4;

-- 7- Ingrese en la tabla "aprobados" el resultado devuelto por el procedimiento almacenado "pa_aprobados".

INSERT INTO aprobados EXEC pa_aprobados;

-- 8- Vea el contenido de "aprobados":

SELECT * FROM aprobados;

-- 9- Elimine el procedimiento llamado "pa_desaprobados", si existe:

IF OBJECT_ID('pa_desaprobados') IS NOT NULL
DROP PROCEDURE pa_desaprobados;

/* 10- Cree el procedimiento para que seleccione el documento y nombre de los alumnos cuya nota es 
       menor a 4. */

CREATE PROC pa_desaprobados
AS
  SELECT documento,nombre
  FROM alumnos
  WHERE nota<4;

/* 11- Ingrese en la tabla "desaprobados" el resultado devuelto por el procedimiento almacenado 
       "pa_desaprobados". */

INSERT INTO desaprobados EXEC pa_desaprobados;

-- 12- Vea el contenido de "desaprobados":

SELECT * FROM desaprobados;
