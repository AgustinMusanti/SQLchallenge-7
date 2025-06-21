-- 1- Elimine las tablas "empleados" y "sucursales" si existen:

IF OBJECT_ID('empleados') IS NOT NULL
DROP TABLE empleados;

IF OBJECT_ID('sucursales') IS NOT NULL
DROP TABLE sucursales;

-- 2- Cree la tabla "sucursales":

 create table sucursales( 
  codigo int identity,
  ciudad varchar(30) not null,
  primary key(codigo)
 ); 

-- 3- Cree la tabla "empleados":

 create table empleados( 
  documento      char(8) not null,
  nombre         varchar(30) not null,
  domicilio      varchar(30),
  seccion        varchar(20),
  sueldo         decimal(6,2),
  codigosucursal int,
  primary key(documento),
  constraint FK_empleados_sucursal
  foreign key (codigosucursal) references sucursales(codigo)
  on update cascade
 ); 

-- 4- Ingrese algunos registros para ambas tablas:

INSERT INTO sucursales
VALUES('Cordoba'),
      ('Villa Maria'),
      ('Carlos Paz'),
      ('Cruz del Eje');

INSERT INTO empleados
VALUES('22222222','Ana Acosta','Avellaneda 111','Secretaria',500,1),
      ('23333333','Carlos Caseros','Colon 222','Sistemas',800,1),
      ('24444444','Diana Dominguez','Dinamarca 333','Secretaria',550,2),
      ('25555555','Fabiola Fuentes','Francia 444','Sistemas',750,2),
      ('26666666','Gabriela Gonzalez','Guemes 555','Secretaria',580,3),
      ('27777777','Juan Juarez','Jujuy 777','Secretaria',500,4),
      ('28888888','Luis Lopez','Lules 888','Sistemas',780,4),
      ('29999999','Maria Morales','Marina 999','Contaduria',670,4);

-- 5- Realice un join para mostrar todos los datos de "empleados" incluyendo la ciudad de la sucursal:

SELECT e.*, s.ciudad
FROM empleados AS e
JOIN sucursales AS s
ON s.codigo=e.codigosucursal;

-- 6-Cree una tabla llamada "secciones" que contenga las secciones de la empresa

IF OBJECT_ID('secciones') IS NOT NULL
DROP TABLE secciones;

SELECT DISTINCT seccion AS 'Secciones'
INTO secciones
FROM empleados;

-- 7- Recupere la información de "secciones":

SELECT * FROM secciones;

/* 8- Se necesita una nueva tabla llamada "sueldosxseccion" que contenga la suma de los sueldos de los 
      empleados por sección. Primero elimine la tabla, si existe: */

IF OBJECT_ID('sueldoxseccion') IS NOT NULL
DROP TABLE sueldoxseccion;

SELECT SUM(sueldo) AS 'TotalSueldo'
INTO sueldoxseccion
FROM empleados
GROUP BY seccion;

-- 9- Recupere los registros de la nueva tabla:

SELECT * FROM sueldoxseccion;

/* 10- Se necesita una tabla llamada "maximossueldos" que contenga los mismos campos que "empleados" y 
       guarde los 3 empleados con sueldos más altos. */

IF OBJECT_ID('maximossueldos') IS NOT NULL
DROP TABLE maximossueldos;

SELECT TOP 3 *
INTO maximossueldos
FROM empleados
ORDER BY sueldo ASC;

-- 11- Vea los registros de la nueva tabla:

SELECT * FROM maximossueldos;

/* 12- Se necesita una nueva tabla llamada "sucursalCordoba" que contenga los nombres y sección de los 
       empleados de la ciudad de Córdoba. */

SELECT e.nombre, e.seccion, s.ciudad
INTO sucursalCordoba
FROM empleados AS e
JOIN sucursales AS s
ON s.codigo=e.codigosucursal
WHERE ciudad='Cordoba';

-- 13- Consulte la nueva tabla:

SELECT * FROM sucursalCordoba;
