-- 1- Elimine la tabla "consultas" si existe:

IF OBJECT_ID('consultas') IS NOT NULL
DROP TABLE consultas;

/* 2- La tabla contiene los siguientes datos:

  - fechayhora: datetime not null, fecha y hora de la consulta,
  - medico: varchar(30), not null, nombre del médico (Perez,Lopez,Duarte),
  - documento: char(8) not null, documento del paciente,
  - paciente: varchar(30), nombre del paciente,
  - obrasocial: varchar(30), nombre de la obra social (IPAM,PAMI, etc.).

Un médico sólo puede atender a un paciente en una fecha y hora determianada. En una fecha y hora 
determinada, varios médicos atienden a distintos pacientes. Cree la tabla definiendo una clave 
primaria compuesta: */

CREATE TABLE consultas(
 fechayhora DATETIME NOT NULL,
 medico VARCHAR(30) NOT NULL,
 documento CHAR(8) NOT NULL,
 paciente VARCHAR(30),
 obrasocial VARCHAR(30),
 PRIMARY KEY(fechayhora, medico)
 );



-- 3- Ingrese varias consultas para un mismo médico en distintas horas el mismo día.

INSERT INTO consultas
VALUES('2006/11/05 8:00','Lopez','12222222','Acosta Betina','PAMI'),
      ('2006/11/05 8:30','Lopez','23333333','Fuentes Carlos','PAMI');

-- Ok esta inserción.

-- 4- Ingrese varias consultas para diferentes médicos en la misma fecha y hora.

INSERT INTO consultas
VALUES('2006/11/05 8:00','Perez','34444444','Garcia Marisa','IPAM'),
      ('2006/11/05 8:00','Duarte','45555555','Pereyra Luis','PAMI');

-- Ok esta inserción.

-- 5- Intente ingresar una consulta para un mismo médico en la misma hora el mismo día.

INSERT INTO consultas
VALUES('2006/11/05 8:00','Lopez','12222222','Acosta Betina','PAMI'),
      ('2006/11/05 8:00','Lopez','23333333','Fuentes Carlos','PAMI');

-- No es posible por la clave primaria compuesta.
