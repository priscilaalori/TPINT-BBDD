--Creo la vista para ver las subastas que se encuentran activas en este momento

USE GaleriaDeArte;
GO
CREATE VIEW SubastasActivas
AS
SELECT 
    s.IdSubasta,
    o.Titulo AS Obra,
    l.PrecioBase,
    l.PrecioActual,
    s.FechaInicio,
    s.FechaCierre
FROM Subasta s
JOIN Lote l ON s.IdSubasta = l.IdSubasta
JOIN Obra o ON l.IdObra = o.IdObra
WHERE s.FechaCierre > GETDATE();
GO

--De esta forma verificamos la misma

SELECT * FROM SubastasActivas;




--------------------- Separador ---------------------------

-- Creo un trigger para que cuando una obra se venda actualice automaticamente su estado en la tabla correspondiente

USE GaleriaDeArte;
GO
CREATE TRIGGER CambiarEstadoObra_Venta
ON Venta
AFTER INSERT
AS
BEGIN
    UPDATE Obra
    SET Estado = 'Vendida'
    WHERE IdObra IN (SELECT IdObra FROM inserted);
END;
GO