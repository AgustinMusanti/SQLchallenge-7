-- 1- Elimine las tablas si existen:

IF OBJECT_ID('clientes') IS NOT NULL
DROP TABLE clientes;

IF OBJECT_ID('facturas') IS NOT NULL
DROP TABLE facturas;

-- 2-Créelas:

  create table clientes(
  codigo    int identity,
  nombre    varchar(30),
  domicilio varchar(30),
  primary key(codigo)
 );

  create table facturas(
  numero        int not null,
  fecha         datetime,
  codigocliente int not null,
  total         decimal(6,2),
  primary key(numero),
  constraint FK_facturas_cliente
  foreign key (codigocliente) references clientes(codigo)
  on update cascade
 );

-- 3-Ingrese algunos registros:

INSERT INTO clientes
VALUES('Juan Lopez','Colon 123'),
      ('Luis Torres','Sucre 987'),
      ('Ana Garcia','Sarmiento 576'),
      ('Susana Molina','San Martin 555');

INSERT INTO facturas
VALUES(1200,'2007-01-15',1,300),
      (1201,'2007-01-15',2,550),
      (1202,'2007-01-15',3,150),
      (1300,'2007-01-20',1,350),
      (1310,'2007-01-22',3,100);

/* 4- El comercio necesita una tabla llamada "clientespref" en la cual quiere almacenar el nombre y 
      domicilio de aquellos clientes que han comprado hasta el momento más de 500 pesos en mercaderías. 
      Elimine la tabla si existe y créela con esos 2 campos: */

IF OBJECT_ID('clientespref') IS NOT NULL
DROP TABLE clientespref;

  create table clientespref(
  nombre    varchar(30),
  domicilio varchar(30)
 );

/* 5- Ingrese los registros en la tabla "clientespref" seleccionando registros de la tabla "clientes" y 
      "facturas". */

INSERT INTO clientespref
SELECT nombre,domicilio
FROM clientes 
WHERE codigo IN
    (SELECT codigocliente
     FROM clientes AS c
     JOIN facturas AS f
     ON codigocliente=codigo
     GROUP BY codigocliente
     HAVING SUM(total)>500);

-- 6- Vea los registros de "clientespref":

SELECT * FROM clientespref;
