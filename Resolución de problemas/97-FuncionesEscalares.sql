-- 1- Elimine las tablas si existen:

IF OBJECT_ID('medicos') IS NOT NULL
DROP TABLE medicos;

IF OBJECT_ID('consultas') IS NOT NULL
DROP TABLE consultas;

-- 2- Cree las tablas con las siguientes estructuras:

 create table medicos (
  documento char(8) not null,
  nombre    varchar(30),
  constraint PK_medicos 
  primary key clustered (documento)
 );

 create table consultas(
  fecha    datetime,
  medico   char(8) not null,
  paciente varchar(30),
  constraint PK_consultas
  primary key (fecha,medico),
  constraint FK_consultas_medico
  foreign key (medico)
  references medicos(documento)
  on update cascade
  on delete cascade
 );

-- 3- Ingrese algunos registros:

 insert into medicos values('22222222','Alfredo Acosta');
 insert into medicos values('23333333','Pedro Perez');
 insert into medicos values('24444444','Marcela Morales');

 insert into consultas values('2007/03/26 8:00','22222222','Juan Juarez');
 insert into consultas values('2007/03/26 8:00','23333333','Gaston Gomez');
 insert into consultas values('2007/03/26 8:30','22222222','Nora Norte');
 insert into consultas values('2007/03/28 9:00','22222222','Juan Juarez');
 insert into consultas values('2007/03/29 8:00','24444444','Nora Norte');
 insert into consultas values('2007/03/24 8:30','22222222','Hector Huerta'); 
 insert into consultas values('2007/03/24 9:30','23333333','Hector Huerta');

-- 4- Elimine la función "f_nombreDia" si existe:

IF OBJECT_ID('f_nombreDia') IS NOT NULL
DROP FUNCTION f_nombreDia;

/* 5- Cree la función "f_nombreDia" que recibe una fecha (tipo string) y nos retorne el nombre del día 
      en español. */

CREATE FUNCTION f_nombreDia
 (@fecha VARCHAR(30))
  RETURNS VARCHAR(10)
  AS
  BEGIN
    DECLARE @nombre VARCHAR(10)
    SET @nombre='Fecha inválida'   
    IF (ISDATE(@fecha)=1)
    BEGIN
      SET @fecha=CAST(@fecha AS DATETIME)
      SET @nombre=
      CASE DATENAME(WEEKDAY,@fecha)
       WHEN 'Monday'    THEN 'lunes'
       WHEN 'Tuesday'   THEN 'martes'
       WHEN 'Wednesday' THEN 'miércoles'
       WHEN 'Thursday'  THEN 'jueves'
       WHEN 'Friday'    THEN 'viernes'
       WHEN 'Saturday'  THEN 'sábado'
       WHEN 'Sunday'    THEN 'domingo'
      END--case
    END--si es una fecha válida
    RETURN @nombre
 END;
 
-- 6- Elimine la función "f_horario" si existe:

IF OBJECT_ID('f_horario') IS NOT NULL
DROP FUNCTION f_horario;

-- 7- Cree la función "f_horario" que recibe una fecha (tipo string) y nos retorne la hora y minutos.

CREATE FUNCTION f_horario
 (@fecha VARCHAR(30))
  RETURNS VARCHAR(5)
  AS
  BEGIN
    DECLARE @nombre VARCHAR(5)
    SET @nombre='Fecha inválida'   
    IF (ISDATE(@fecha)=1)
    BEGIN
      SET @fecha=CAST(@fecha AS DATETIME)
      SET @nombre=RTRIM(CAST(DATEPART(HOUR,@fecha) AS CHAR(2)))+':'
      SET @nombre=@nombre+RTRIM(CAST(DATEPART(MINUTE,@fecha) AS CHAR(2)))
    END--si es una fecha válida
    RETURN @nombre
 END;

-- 8- Elimine la función "f_fecha" si existe:

IF OBJECT_ID('f_fecha') IS NOT NULL
DROP FUNCTION f_fecha;

/* 9- Cree la función "f_fecha" que recibe una fecha (tipo string) y nos retorne la fecha (sin hora ni 
      minutos) */

create function f_fecha
 (@fecha varchar(30))
  returns varchar(12)
  as
  begin
    declare @nombre varchar(12)
    set @nombre='Fecha inválida'   
    if (isdate(@fecha)=1)
    begin
      set @fecha=cast(@fecha as datetime)
      set @nombre=rtrim(cast(datepart(day,@fecha) as char(2)))+'/'
      set @nombre=@nombre+rtrim(cast(datepart(month,@fecha) as char(2)))+'/'
      set @nombre=@nombre+rtrim(cast(datepart(year,@fecha) as char(4)))
    end--si es una fecha válida
    return @nombre
 end;

/* 10- Muestre todas las consultas del médico llamado 'Alfredo Acosta', incluyendo el día (emplee la 
       función "f_nombreDia", la fecha (emplee la función "f_fecha"), el horario (emplee la función 
       "f_horario") y el nombre del paciente. */

SELECT dbo.f_nombredia(fecha) AS dia,
       dbo.f_fecha(fecha) AS fecha,
       dbo.f_horario(fecha) AS horario,
  paciente
FROM consultas AS c
JOIN medicos AS m
ON m.documento=c.medico
WHERE m.nombre='Alfredo Acosta';

-- 11- Muestre todos los turnos para el día sábado, junto con la fecha, de todos los médicos.

SELECT fecha, m.nombre
FROM consultas AS c
JOIN medicos AS m
ON m.documento=c.medico
WHERE dbo.f_nombredia(fecha)='sábado';

-- 12- Envíe a la función "f_nombreDia" una fecha y muestre el valor retornado:

DECLARE @valor CHAR(30)

SET @valor='2022/04/09'

SELECT dbo.f_nombreDia(@valor);
