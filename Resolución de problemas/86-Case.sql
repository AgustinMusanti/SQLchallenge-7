-- 1- Elimine la tabla "empleados" si existe:

IF OBJECT_ID('empleados') IS NOT NULL
DROP TABLE empleados;

-- 2- Cree la tabla:

 create table empleados(
  documento       char(8) not null,
  nombre          varchar(30) not null,
  sexo            char(1),
  fechanacimiento datetime,
  fechaingreso    datetime,
  cantidadhijos   tinyint,
  sueldo          decimal(5,2),
  primary key(documento)
);

-- 3- Ingrese algunos registros:

 insert into empleados values ('22333111','Juan Perez','m','1970-05-10','1987-04-05',2,550);
 insert into empleados values ('25444444','Susana Morales','f','1975-11-06','1990-04-06',0,650);
 insert into empleados values ('20111222','Hector Pereyra','m','1965-03-25','1997-04-12',3,510);
 insert into empleados values ('30000222','Luis LUque','m','1980-03-29','1999-11-06',1,700);
 insert into empleados values ('20555444','Laura Torres','f','1965-12-22','2003-11-06',3,400);
 insert into empleados values ('30000234','Alberto Soto','m','1989-10-10','1999-11-06',2,420);
 insert into empleados values ('20125478','Ana Gomez','f','1976-09-21','1998-11-06',3,350);
 insert into empleados values ('24154269','Ofelia Garcia','f','1974-05-12','1990-11-06',0,390);
 insert into empleados values ('30415426','Oscar Torres','m','1978-05-02','1997-11-06',1,400);

/* 4- Es política de la empresa festejar cada fin de mes, los cumpleaños de todos los empleados que 
      cumplen ese mes. Si los empleados son de sexo femenino, se les regala un ramo de rosas, si son de 
      sexo masculino, una corbata. La secretaria de la Gerencia necesita saber cuántos ramos de rosas y 
      cuántas corbatas debe comprar para el mes de mayo. */

SELECT sexo, COUNT(*) AS cantidad, obsequio=
   CASE 
   WHEN sexo='f' THEN 'rosas'
   ELSE 'corbata'
   END
   FROM empleados
   WHERE DATEPART(MONTH,fechanacimiento)=5
   GROUP BY sexo
   ORDER BY cantidad DESC;

/* 5- Además, si el empleado cumple 10,20,30,40... años de servicio, se le regala una placa 
      recordatoria. La secretaria de Gerencia necesita saber la cantidad de años de servicio que cumplen 
      los empleados que ingresaron en el mes de abril para encargar dichas placas. */

SELECT nombre,DATEPART(YEAR,fechaingreso) AS añoingreso,
     DATEPART(YEAR,GETDATE())-DATEPART(YEAR,fechaingreso) AS AñosdeServicio, placa=
     CASE (DATEPART(YEAR,GETDATE())-DATEPART(YEAR,fechaingreso)) %10
     WHEN 0 THEN 'Si'  --si la cantidad de años es divisible por 10
     ELSE 'No'
     END
FROM empleados
WHERE DATEPART(MONTH,fechaingreso)=4;

/* 6- La empresa paga un sueldo adicional por hijos a cargos. Para un sueldo menor o igual a $500 el 
      salario familiar por hijo es de $200, para un sueldo superior, el monto es de $100 por hijo. Muestre 
      el nombre del empleado, el sueldo básico, la cantidad de hijos a cargo, el valor del salario por 
      hijo, el valor total del salario familiar y el sueldo final con el salario familiar incluido de 
      todos los empleados. */

SELECT nombre,sueldo,cantidadhijos,AdicionalPorHijo=
     CASE 
     WHEN sueldo<=500 THEN 200
     ELSE 100
     END,
 salariofamilar=
     CASE
     WHEN sueldo<=500 THEN 200*cantidadhijos
     ELSE 100*cantidadhijos
     END,
 sueldototal=
     CASE
     WHEN sueldo<=500 THEN sueldo+(200*cantidadhijos)
     ELSE sueldo+(100*cantidadhijos)
     END
FROM empleados
ORDER BY sueldototal;
