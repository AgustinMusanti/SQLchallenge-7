CREATE DATABASE db1;

-- 1- Elimine la tabla "agenda" si existe:

IF object_id('agenda') IS NOT NULL
DROP TABLE agenda;

-- 2- Intente crear una tabla llamada "/agenda":

CREATE TABLE /agenda(
  apellido VARCHAR(30),
  nombre VARCHAR(20),
  domicilio VARCHAR(30),
  telefono VARCHAR(11)
 );

 -- Aparece un mensaje de error en "/agenda" ya que no podemos usar el "/".


/* 3- Cree una tabla llamada "agenda", debe tener los siguientes campos: apellido, varchar(30); nombre, 
      varchar(20); domicilio, varchar (30) y telefono, varchar(11): */

CREATE TABLE agenda(
apellido VARCHAR(30),
nombre VARCHAR(20),
domicilio VARCHAR(30),
telefono VARCHAR(11)
);

-- 4- Intente crearla nuevamente.

CREATE TABLE agenda(
apellido VARCHAR(30),
nombre VARCHAR(20),
domicilio VARCHAR(30),
telefono VARCHAR(11)
);

-- Aparece mensaje de error porque la tabla ya existe.

-- 5- Visualice las tablas existentes.

EXEC sp_tables @table_owner='dbo';

-- 6- Visualice la estructura de la tabla "agenda".

EXEC sp_columns agenda;

-- 7- Elimine la tabla

DROP TABLE agenda;

-- 8- Intente eliminar la tabla, sin controlar si existe. Debe aparecer un mensaje de error.

DROP TABLE agenda;

-- Aparece mensaje de error.
