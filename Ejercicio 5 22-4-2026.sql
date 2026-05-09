select D.nombre,SUM(c.costo) as total
from Consulta
join Mascotas m on C.id_mascotas=M.id_mascotas
join dueño D on M.id_dueño= D.id_dueño
where M.especie='Perro'
group by D.nombre
having sum(c.costo)>500

select M.nombre, COUNT(*)as cantidad
From Consulta C
join Mascotas M on C.id_mascotas=M.id_mascotas
group by M.nombre
having COUNT(*)>1

select M.nombre,M.especie, SUM(c.costo)
FROM Consulta c
JOIN Mascotas M on c.id_mascotas=M.id_mascotas
GROUP BY M.nombre,M.especie

-- Subconsultas con el comando With--

with mascotas_por_dueño AS (
select id_dueño, COUNT(*) as cantidad
From Mascotas
group by id_dueño
)
select D.nombre, M.cantidad
from dueño d
join mascotas_por_dueño m on d.id_dueño=m.id_dueño
order by M.cantidad desc

with total_por_mascotas AS(
select id_mascota,sum(costo) as total
from Consulta
group by id_mascotas
),
mascotas_caras AS(
select id_mascotas,total
from total_por_mascotas
where total>800
)
select M.nombre,c.total
from Mascotas m
join mascotas_caras c on m.id_mascotas=c.total

--Escribir una CTE llamado "Gastos" que calcule el total gastado en consultas por cada mascota, luego usa CTE para mostrar el nombre de la mascota y su total, solo de las que gastaron mas de 500.

WITH Gastos AS (
    SELECT 
        id_mascotas,
        SUM(costo) AS total_gastado
    FROM Consulta
    GROUP BY id_mascotas
)
SELECT 
    m.nombre,
    g.total_gastado
FROM Gastos g
JOIN Mascotas m 
    ON m.id_mascotas = g.id_mascotas
WHERE g.total_gastado > 500;

--Escribir dos CTE encadenados. 1 cantidad de mascotas por dueño, 2- filtrar solo los dueños con mas de 1 mascota. Mostrar el nombre del dueño y su cantidad de mascotas. 

WITH CantidadMascotas AS (
    SELECT 
        id_dueño,
        COUNT(*) AS cantidad
    FROM Mascotas
    GROUP BY id_dueño
),
DueniosConMasDeUna AS (
    SELECT 
        id_dueño,
        cantidad
    FROM CantidadMascotas
    WHERE cantidad > 1
)
SELECT 
    D.nombre,
    c.cantidad
FROM DueniosConMasDeUna c
JOIN duenio d 
    ON d.id_dueño = c.id_dueño;