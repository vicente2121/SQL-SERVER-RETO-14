


CREATE TABLE stage (
 
	Año_y_Mes varchar(255),
		Empresa_ID varchar(255),
        Identificacion_Fiscal varchar(255),
		Empresa varchar(255),
        Direccion nvarchar(255),
        Localidad varchar(255), 
        Provincia varchar(255), 
        Region varchar(255), 
        Producto_ID varchar(255), 
        Producto varchar(255),
        ID_Horario varchar(255), 
        Horario_Tipo varchar(255), 
        Precio varchar(255), 
        Fecha varchar(255), 
        ID_Empresa_Bandera varchar(255), 
        Empresa_Bandera varchar(255), 
        Latitud varchar(255), 
        Longitud varchar(255)
);


--verificamos la importancion 

--combinaciones unica de Empresa y empresa bandera
select distinct Empresa, Empresa_Bandera from stage

--Creamos la tabla , especificamente para poder trabajar con estos procesos 
create table Dim_Empresa
(
Id_Empresa int identity(1,1),
Empresa varchar(150),
Empresa_Bandera varchar(150)
)

--Insertamos los datos unicos de esta dimension
insert into Dim_Empresa (Empresa,Empresa_Bandera)
select distinct Empresa, Empresa_Bandera from stage


--Creamos la seiguinete dimesion que es ubicacion
--combinaciones unica de Direccion,Localidad,Provincia,Region,Latitud,Longitud

select distinct Direccion,Localidad,Provincia,Region,Latitud,Longitud from stage

--Creamos la tabla , especificamente para poder trabajar con estos procesos 
create table Dim_Ubicacion
(
Id_Ubicacion int identity(1,1),
Direccion varchar(150),
Localidad varchar(150),
Provincia varchar(150),
Region varchar(150),
Latitud varchar(150),
Longitud varchar(150)
)

--Insertamos los datos en Dim_Ubicacion
insert into Dim_Ubicacion (Direccion,Localidad,Provincia,Region,Latitud,Longitud)
select distinct Direccion,Localidad,Provincia,Region,Latitud,Longitud from stage

--Dimension Horario
--combinaciones unica de Empresa y empresa bandera

select distinct Horario_Tipo from stage

--Creamos la tabla , especificamente para poder trabajar con estos procesos 
create table Dim_Horario
(
Id_Horario int identity(1,1),
Horario_Tipo varchar(50)
)

--creamos el el insert de la dimension horario

insert into Dim_Horario (Horario_Tipo)
select distinct Horario_Tipo from stage


--Pasamos a la dimension Calendario

SELECT MIN(TRY_CONVERT(DATE, Fecha, 103))
FROM stage;

SELECT MAX(TRY_CONVERT(DATE, Fecha, 103))
FROM stage;

select * from stage
order by 

--primero encontrar maximo y minimo de fechas OJO 

DECLARE @FechaInicio DATE = '2016-06-01';
DECLARE @FechaFin DATE = '2023-10-29';

WITH Calendario AS (
    SELECT @FechaInicio AS Fecha
    UNION ALL
    SELECT DATEADD(dd, 1, Fecha)
    FROM Calendario
    WHERE DATEADD(dd, 1, Fecha) <= @FechaFin
)
insert into Dim_Calendario (Fecha,Mes,MesNombre,Año)
SELECT Fecha,MONTH(Fecha),datename (MONTH,Fecha),Year(Fecha)
FROM Calendario
OPTION (MAXRECURSION 0); -- Aquí estableces el límite de recursión a 0 para que no haya límite


---Procedemos a crear la tabla

create table Dim_Calendario 
(
Fecha date,
Mes int,
MesNombre varchar(15), 
Año int,
)

---Vereficamos especificamente como queda la tabla 

Select * from Dim_Calendario

-- Pasamos a crear la dimension Producto

select distinct Producto from stage

--Pasamos a crear la tabla de dimension

create table Dim_Producto
(
Id_Producto int identity(1,1),
Producto varchar(50)
)

select * from Dim_Producto
--Creamos el proceso para insertar los datos 
insert into Dim_Producto (Producto)
select distinct Producto from stage


---Creamos la tabla de hechos final

Create table Tabla_Hechos
(
		Id_Empresa int,
        Identificacion_Fiscal varchar(100),
		Empresa varchar(150),
		Id_Ubicacion int,
        Direccion nvarchar(150),
        Id_Producto int, 
        Producto varchar(255),
        Id_Horario varchar(255), 
        Horario_Tipo varchar(255), 
        Precio money, 
        Fecha date
)

--insertar datos en la tabla de hechos 
insert into Tabla_Hechos(Empresa, Identificacion_Fiscal, Direccion,Producto,Horario_Tipo,Precio,Fecha )
Select Empresa, Identificacion_Fiscal, Direccion,Producto,Horario_Tipo,Precio,Fecha
from stage  

--procedemos a vincular los id de empresa ons los lef join , Y HACER EL UPDATE 

UPDATE a
SET a.Id_Empresa = b.Id_Empresa
FROM Tabla_Hechos AS a
LEFT JOIN Dim_Empresa AS b ON a.Empresa = b.Empresa;

--Procedemos a la dimension ubicacion

UPDATE a
SET a.Id_Ubicacion = b.Id_Ubicacion
FROM Tabla_Hechos AS a
LEFT JOIN Dim_Ubicacion AS b ON a.Direccion = b.Direccion;

--Procedemos a la dimension Dim_Horario

UPDATE a
SET a.Id_Horario = b.Id_Horario
FROM Tabla_Hechos AS a
LEFT JOIN Dim_Horario AS b ON a.Horario_Tipo = b.Horario_Tipo;


--Por ultimo procedemos a la tabla Dim_Producto 
UPDATE a
SET a.Id_Producto = b.Id_Producto
FROM Tabla_Hechos AS a
LEFT JOIN Dim_Producto AS b ON a.Producto = b.Producto;

select * from Tabla_Hechos


