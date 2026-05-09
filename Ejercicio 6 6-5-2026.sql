create procedure sp_todas_las_mascotas
AS
BEGIN
SET NOCOUNT ON;
Select * from mascotas;
END;

EXEC sp_todas_las_mascotas

ALTER PROCEDURE sp_todas_las_mascostas 
AS
Begin
set nocount ON;
Select nombre,especie from Mascotas;
END;

Create procedure sp_mascotas_por_especie
@especie NVARCHAR (50)
AS
BEGIN
SET NOCOUNT ON;
Select nombre, nacimiento
from Mascotas
where especie=@especie;
end;

EXEC sp_mascotas_por_especie @especie='Gato'

create procedure sp_consultas_por_costo
@min Decimal (8,2)=0,
@max DECIMAL (8,2)=9999
AS
BEGIN
SET NOCOUNT ON;
SELECT motivo,costo
from Consulta
where costo BETWEEN @min and @max
order by costo desc;
END;
EXEC sp_consultas_por_costo @max=2000,@min =501;

create procedure sp_total_mascotas
@id_mascotas INT,
@total DECIMAL(8,2) OUTPUT
AS
BEGIN
SET NOCOUNT ON;
SELECT @total=SUM(costo)
From Consulta
where id_mascotas=@id_mascotas;
END;

DECLARE @resultado DECIMAL(8,2);
EXEC sp_total_mascotas @id_mascotas=1, @total=@resultado OUTPUT
Select @resultado as total_gastado

--crear un sp llamado sp_resumen_veterinaria que muestre en una sola ejecucion
--*Cantidad total de dueños
--*Cantidad total de mascotas
--*cantidad total de consultas
--* costo total facturado.

CREATE PROCEDURE sp_resumen_veterinaria
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        (SELECT COUNT(*) FROM dueño) AS Total_Dueños,
        (SELECT COUNT(*) FROM Mascotas) AS Total_Mascotas,
        (SELECT COUNT(*) FROM Consulta) AS Total_Consulta,
        (SELECT SUM(Costo) FROM Consulta) AS Total_Facturado;
END;

EXEC sp_resumen_veterinaria

-- SP con parametro de entrada , crear un sp llamado sp_buscar_duenio que reciba 
-- @nombre NVARCHAR(100) y devuelva los dueños cuyo nombre contenga ese texto (usa LIKE).
-- Ejecutar buscando 'garcia' y luego 'Perez'

CREATE PROCEDURE sp_buscar_duenio
    @nombre NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM duenio
    WHERE Nombre LIKE '%' + @nombre + '%';
END

EXEC sp_buscar_duenio 'garcia';

EXEC sp_buscar_duenio 'Perez';

--SP con parametro OUTPUT
-- Crea un sp llamado sp_consultas_mas_cara_duenio que reciba @id_duenio INT y devuelva el OUTPUT el costo de  la consulta mas cara entre todas las mascotas de ese dueño.
-- Declare la variable, ejecutalo para el duenio 1 y mostrar el resultado.

CREATE PROCEDURE sp_consultas_mas_cara_duenio
    @id_duenio INT,
    @max_costo DECIMAL(10,2) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT @max_costo = MAX(c.Costo)
    FROM Consulta c
    INNER JOIN Mascotas m
        ON c.id_mascotas = m.id_mascotas
    WHERE m.id_dueño = @id_duenio;
END;

select*from Consulta


DECLARE @resultado DECIMAL(10,2);

EXEC sp_consultas_mas_cara_duenio
    @id_duenio = 1,
    @max_costo = @resultado OUTPUT;

SELECT @resultado AS Consulta_Mas_Cara;