-- 1- Elimine la tabla "medicamentos",si existe:

IF object_id('medicamentos') IS NOT NULL
DROP TABLE medicamentos;

/*2- Cree la tabla con un campo "codigo" que genere valores secuenciales automáticamente comenzando en 
     10 e incrementándose en 1: */

CREATE TABLE medicamentos(
  codigo      INTEGER IDENTITY(10,1),
  nombre      VARCHAR(20) NOT NULL,
  laboratorio VARCHAR(20),
  precio      FLOAT,
  cantidad    INTEGER
 );

/* 3- Ingrese los siguientes registros:

('Sertal','Roche',5.2,100);
('Buscapina','Roche',4.10,200);
('Amoxidal 500','Bayer',15.60,100); */

INSERT INTO medicamentos
VALUES('Sertal','Roche',5.2,100),
      ('Buscapina','Roche',4.10,200),
      ('Amoxidal 500','Bayer',15.60,100);

-- 4- Verifique que SQL Server generó valores para el campo "código" de modo automático:

SELECT * FROM medicamentos;

-- 5- Intente ingresar un registro con un valor para el campo "codigo".

INSERT INTO medicamentos
VALUES(4,'Sertal Doble','Roche',10.0,100);

-- No es posible ya que no esta seteado "identity_insert" en ON.

-- 6- Setee la opción "identity_insert" en "on"

SET IDENTITY_INSERT medicamentos ON;

-- 7- Ingrese un nuevo registro sin valor para el campo "codigo":

INSERT INTO medicamentos
VALUES('Sertal Doble','Roche',10.0,100);

-- Ahora no es posible. 

-- 8- Ingrese un nuevo registro con valor para el campo "codigo" repetido.

INSERT INTO medicamentos
VALUES(2,'Sertal Doble','Roche',10.0,100);

-- No es posible.

/* 9- Use la función "ident_seed()" para averiguar el valor de inicio del campo "identity" de la tabla 
      "medicamentos" */

SELECT IDENT_SEED('medicamentos');


/* 10- Emplee la función "ident_incr()" para saber cuál es el valor de incremento del campo "identity" 
       de "medicamentos" */

SELECT IDENT_INCR('medicamentos');
