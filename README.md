# Base_de_Datos_TG3
Ejercicios realizados en clase.

CREATE DATABASE Base_de_datos;
GO

USE Base_de_datos;
GO

CREATE TABLE Persona (
    CI INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Nombre NVARCHAR(10) NULL,
    Apellido NVARCHAR(6) NULL,
    Telefono NUMERIC(10,0) NOT NULL
);


INSERT INTO Persona (Nombre, Apellido, Telefono)
VALUES ('Juan', 'Carlos', 23455667);

Select * from Persona;
create database Veterinaria
go

USE Veterinaria

create table dueño(
id_dueño int identity (1,1) primary key,
nombre NVARCHAR(80) NOT NULL,
email NVARCHAR (150)
);

go

create table Mascotas(
id_mascotas int identity (1,1) Primary Key,
nombre Nvarchar (80) not null,
especie nvarchar (50) NOT NULL,
nacimiento date,
id_dueño int NOT NULL,
CONSTRAINT fk_dueño FOREIGN KEY([id_dueño]) REFERENCES dueño(id_dueño)
);
go

Insert into dueño (nombre,email) VALUES ('Ana Garcia', 'ana@gmail.com'),
('Luis Perez', 'luis@gmail.com'), ('Diego' , 'diego@gmail.com')

Insert into Mascotas (nombre, especie, nacimiento,id_dueño) VALUES
('Rex' , 'Perro', '2020-03-15',1),
('Mia', 'Gato','2021-07-01',2),
('Mejia','therian', '2021-02-01',3);

select * from dueño;

select * from Mascotas;

Select * from Mascotas
where especie ='Perro'

Select M.nombre as mascotas , M.especie , D.nombre as dueño 
from Mascotas m
join dueño d on M.id_dueño = D.id_dueño;

select M.nombre as Mascota m.especie , D.nombre as dueño
from Mascotas m, dueño d
where m.id_dueño = d.id_dueño

select top 1 * from Mascotas

select nombre, ISNULL(email, 'sin email') as email 

select especie, count (*) as cantidad
from mascotas
group by especie

select * from dueño

select D.nombre, count (*) as cantidad_mascotas
from mascotas M
join dueño D on M.id_dueño = D.id_dueño
group by D.nombre
having count(*)>1;

select * from mascotas

CREATE TABLE Consulta_1( 
id_consulta INT Identity (1,1)Primary key,
id_mascotas INT NOT NULL,
fecha Datetime default getdate(),
motivo nvarchar(200),
costo DECIMAL (8,2) NOT NULL,
CONSTRAINT fk_mascotas FOREIGN KEY (id_mascotas) REFERENCES Mascotas(id_mascotas)
);

delete from Consultas


INSERT INTO Consulta_1(id_mascotas, motivo, costo) VALUES 
(1,'Vacuna anual',850.00),
(2,'Control de peso',400.00),
(3,'Constracion',2200.00),
(2,'Vacunacion ovina',850.00),
(1,'Revision general',550.00),
(3,'Supervision de ganados',800.00)

select M.especie,SUM (C.costo) as CostoTotalConsultas
from Consultas C
join Mascotas M on C.id_mascotas= M.id_mascotas
group by M. especie

select M.especie,SUM (C.costo) as CostoTotalConsultas
from Consultas C, Mascotas m
where c.id_mascotas = m.id_mascotas
group by M.especie

select M.nombre,AVG(C.costo) as Promedio_Consulta
from Consultas C
JOIN Mascotas M on C.id_mascotas = M.id_mascotas
group by M.nombre

-- Costo total y promedio de consultas por mascotas
SELECT 
    M.nombre,
    SUM(c.costo) AS costo_total,
    AVG(c.costo) AS costo_promedio,
    MAX(c.costo) AS maximo,
    MIN(c.costo) AS minimo
FROM Consultas C
JOIN Mascotas m on C.id_mascotas = M.id_mascotas
GROUP BY m.nombre

-- costo mas caro y mas barato por mascota
SELECT 
    M.nombre,
    MAX(c.costo) AS costo_total,
    MIN(c.costo) AS costo_promedio
FROM consultas C
JOIN Mascotas m on C.id_mascotas = M.id_mascotas
GROUP BY m.nombre

-- Dueños con gastos total >$1000
SELECT 
D.nombre,
    SUM(c.costo) AS gasto_total
FROM Consultas c
JOIN Mascotas M ON c.id_mascotas = m.id_mascotas
JOIN dueño d ON m.id_dueño = d.id_dueño
GROUP BY d.nombre
HAVING SUM(c.costo) > 1000;

select * from Consultas
from dueño

select nombre, 
datediff (DAY, nacimiento , getdate()) as dias
from mascotas

select especie, count (*) as cantidad
from mascotas
group by especie

select * from dueño

select D.nombre, count (*) as cantidad_mascotas
from mascotas M
join dueño D on M.id_dueño = D.id_dueño
group by D.nombre
having count(*)>1;

select * from mascotas

CREATE TABLE Consultas( 
id_consulta INT Identity (1,1)Primary key,
id_mascotas INT NOT NULL,
fecha Datetime default getdate(),
motivo nvarchar(200),
costo DECIMAL (8,2) NOT NULL,
CONSTRAINT fk_mascota FOREIGN KEY (id_mascotas) REFERENCES Mascotas(id_mascotas)
);

delete from Consultas


INSERT INTO Consultas (id_mascotas, motivo, costo) VALUES 
(1,'Vacuna anual',850.00),
(2,'Control de peso',400.00),
(3,'Constracion',2200.00),
(2,'Vacunacion ovina',850.00),
(1,'Revision general',550.00),
(3,'Supervision de ganados',800.00)

select M.especie,SUM (C.costo) as CostoTotalConsultas
from Consultas C
join Mascotas M on C.id_mascotas= M.id_mascotas
group by M. especie

select M.especie,SUM (C.costo) as CostoTotalConsultas
from Consultas C, Mascotas m
where c.id_mascotas = m.id_mascotas
group by M.especie

select M.nombre,AVG(C.costo) as Promedio_Consulta
from Consultas C
JOIN Mascotas M on C.id_mascotas = M.id_mascotas
group by M.nombre

-- Costo total y promedio de consultas por mascotas
SELECT 
    M.nombre,
    SUM(c.costo) AS costo_total,
    AVG(c.costo) AS costo_promedio,
    MAX(c.costo) AS maximo,
    MIN(c.costo) AS minimo
FROM Consultas C
JOIN Mascotas m on C.id_mascotas = M.id_mascotas
GROUP BY m.nombre

-- costo mas caro y mas barato por mascota
SELECT 
    M.nombre,
    MAX(c.costo) AS costo_total,
    MIN(c.costo) AS costo_promedio
FROM consultas C
JOIN Mascotas m on C.id_mascotas = M.id_mascotas
GROUP BY m.nombre

-- Dueños con gastos total >$1000
SELECT 
    m.id_dueño,
    m.id_mascotas,
    SUM(c.costo) AS gasto_total
FROM Consultas c
JOIN Mascotas M ON c.id_mascotas = m.id_mascotas
JOIN dueño d ON m.id_dueño = d.id_dueño
GROUP BY m.id_dueño
HAVING SUM(c.costo) > 1000;

# Pratico de base de datos entregado el jueves 30 de abril

--1 GROUP BY y HAVING (25 puntos)

--Mostrá el nombre de cada dueño y el total que gastó en consultas a través de todas sus mascotas. Ordená de mayor a menor.--

SELECT 
    D.nombre AS Dueño, 
    SUM(C.costo) AS TotalGastado
FROM 
    duenio D
JOIN 
    Mascotas M ON D.id_dueño = M.id_dueño
JOIN 
    Consulta C ON M.id_mascotas = C.id_mascotas
GROUP BY 
    D.Nombre
ORDER BY 
    TotalGastado DESC;

--Mostrá el nombre y la especie de las mascotas que tienen MÁS DE 1 consulta registrada y cuyo costo promedio supera los $600. Mostrá también la cantidad de consultas y el promedio.--

SELECT 
    M.nombre, 
    M.especie, 
    COUNT(C.id_consulta) AS CantidadConsultas, 
    AVG(C.costo) AS PromedioCosto
FROM 
    Mascotas M
JOIN 
    Consulta C ON M.id_mascotas = C.id_mascotas
GROUP BY 
    M.Nombre, 
    M.Especie
HAVING 
    COUNT(C.id_consulta) > 1 
    AND AVG(C.Costo) > 600;

-- Para cada especie mostrá: cantidad de mascotas, total gastado en consultas y el costo de la consulta más cara. Solo mostrá las especies con más de 1 mascota.
SELECT 
    M.especie, 
    COUNT(DISTINCT M.id_mascotas) AS CantidadMascotas, 
    SUM(C.costo) AS TotalGastado, 
    MAX(C.costo) AS ConsultaMasCara
FROM 
    Mascotas M
JOIN 
    Consulta C ON M.id_mascotas = C.id_mascotas
GROUP BY 
    M.Especie
HAVING 
    COUNT(DISTINCT M.id_mascotas) > 1;

--2 Subconsultas (25 puntos)

--Usando IN, mostrá el nombre y especie de las mascotas cuyos dueños NO tienen email registrado--

   SELECT 
    Nombre, 
    Especie
FROM 
    Mascotas
WHERE 
    id_dueño IN (
        SELECT id_dueño 
        FROM duenio 
        WHERE Email IS NULL OR Email = '-'
    );

--Usando EXISTS, mostrá el nombre de los dueños que tienen al menos una mascota con una consulta de costo mayor a $1000.--

    SELECT 
    D.nombre
FROM 
    duenio D
WHERE EXISTS (
    SELECT 1 
    FROM Mascotas M
    JOIN Consulta C ON M.id_mascotas = C.id_mascotas
    WHERE M.id_dueño = D.id_dueño 
      AND C.Costo > 1000
);

--Usando una subconsulta escalar en el SELECT, mostrá el nombre de cada mascota, su especie y la cantidad de consultas que tiene. Si no tiene consultas mostrá 0.--

SELECT 
    M.nombre, 
    M.especie, 
    (
        SELECT COUNT(*) 
        FROM Consulta C 
        WHERE C.id_mascotas = M.id_mascotas
    ) AS CantidadConsultas
FROM 
    Mascotas M;

--3 CTEs y Funciones de Ventana (25 puntos)

--Escribí una CTE llamada 'gastos_duenio' que calcule el total gastado por cada dueño. Luego usá esa CTE para mostrar solo los dueños cuyo gasto total está por encima del promedio general.

WITH gastos_duenio AS (
    SELECT 
        D.id_dueño,
        D.Nombre, 
        SUM(C.costo) AS TotalPorDuenio
    FROM 
        duenio D
    JOIN 
        Mascotas M ON D.id_dueño = M.id_dueño
    JOIN 
        Consulta C ON M.id_mascotas = C.id_mascotas
    GROUP BY 
        D.id_dueño, D.Nombre
)
SELECT 
    Nombre, 
    TotalPorDuenio
FROM 
    gastos_duenio
WHERE 
    TotalPorDuenio > (SELECT AVG(TotalPorDuenio) FROM gastos_duenio);

--Usando ROW_NUMBER(), numerá las consultas de cada mascota ordenadas por costo de mayor a menor. Luego filtrá para mostrar solo la consulta más cara de cada mascota. Mostrá: nombre de la mascota, motivo y costo.

WITH ConsultasNumeradas AS (
    SELECT 
        M.Nombre AS NombreMascota,
        C.motivo,
        C.costo,
        ROW_NUMBER() OVER (
            PARTITION BY M.id_mascotas
            ORDER BY C.Costo DESC
        ) AS NumeroConsulta
    FROM 
        Mascotas M
    JOIN 
        Consulta C ON M.id_mascotas = C.id_mascotas
)
SELECT 
    NombreMascota, 
    Motivo, 
    Costo
FROM 
    ConsultasNumeradas
WHERE 
    NumeroConsulta = 1;

--Usando RANK(), rankeá a los dueños según el total que gastaron en consultas. Mostrá: nombre del dueño, total gastado y posición en el ranking.

WITH TotalesPorDuenio AS (
    SELECT 
        D.nombre AS Dueño, 
        SUM(C.costo) AS TotalGastado
    FROM 
        duenio D
    JOIN 
        Mascotas M ON D.id_dueño = M.id_dueño
    JOIN 
        Consulta C ON M.id_mascotas = C.id_mascotas
    GROUP BY 
        D.id_dueño, D.Nombre
)
SELECT 
    Dueño, 
    TotalGastado, 
    RANK() OVER (ORDER BY TotalGastado DESC) AS PosicionRanking
FROM 
    TotalesPorDuenio;

--4 Funciones T-SQL (25 puntos)

--Mostrá el nombre de cada mascota, su edad en años y la fecha de su próxima vacuna anual (365 días después de su nacimiento — usá DATEADD).

SELECT 
    Nombre, 
    DATEDIFF(YEAR, nacimiento, GETDATE()) AS EdadAnios, 
    DATEADD(DAY, 365, nacimiento) AS ProximaVacunaAnual
FROM 
    Mascotas;

--Mostrá una ficha por consulta con este formato: REX — Vacunacion anual — $850.00 — 15/03/2024 Usá UPPER, CONCAT, CAST y CONVERT(fecha, 103).

SELECT 
    CONCAT(
        UPPER(M.Nombre), 
        ' — ', 
        C.motivo, 
        ' — $', 
        CAST(C.costo AS DECIMAL(10,2)), 
        ' — ', 
        CONVERT(VARCHAR, C.Fecha, 103)
    ) AS FichaConsulta
FROM 
    Consulta C
JOIN 
    Mascotas M ON C.id_mascotas = M.id_mascotas;

-- Mostrá el nombre del dueño en mayúsculas, su contacto principal (email si tiene, sino teléfono, sino Sin contacto) y la cantidad de caracteres de su nombre. Usá COALESCE y LEN

SELECT 
    UPPER(Nombre) AS DueñoMayusculas, 
    COALESCE(Email, Telefono, 'Sin contacto') AS ContactoPrincipal, 
    LEN(Nombre) AS CantidadCaracteres
FROM 
    duenio;

--Combiná todo: generá un reporte con los TOP 3 dueños que más gastaron, mostrando nombre en mayúsculas, total gastado, cantidad de mascotas y su ranking. Usá CTE + RANK() + funciones de texto.

WITH ReporteDuenios AS (
    SELECT 
        D.id_dueño,
        D.nombre,
        SUM(C.costo) AS TotalGastado,
        COUNT(DISTINCT M.id_mascotas) AS CantidadMascotas
    FROM 
        duenio D
    JOIN 
        Mascotas M ON D.id_dueño = M.id_dueño
    JOIN 
        Consulta C ON M.id_mascotas = C.id_mascotas
    GROUP BY 
        D.id_dueño, D.Nombre
)
SELECT TOP 3
    UPPER(Nombre) AS DUEÑO,
    TotalGastado,
    CantidadMascotas,
    RANK() OVER (ORDER BY TotalGastado DESC) AS PosicionRanking
FROM 
    ReporteDuenios
ORDER BY 
    TotalGastado DESC;
