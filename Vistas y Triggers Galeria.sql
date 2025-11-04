--Creo la vista para ver las subastas que se encuentran activas en este momento

USE GaleriaDeArteV2;
GO

CREATE OR ALTER VIEW SubastasActivas
AS
SELECT 
    s.IdSubasta,
    o.Titulo AS Obra,
    l.PrecioBase,
    l.PrecioActual,
    s.FechaInicio,
    s.FechaCierre
FROM Subastas s
JOIN Lotes l ON s.IdSubasta = l.IdSubasta
JOIN ObrasXLotes oxl ON l.IdLote = oxl.IdLote
JOIN Obras o ON oxl.IdObra = o.IdObra
WHERE s.FechaCierre > GETDATE();
GO

--De esta forma verificamos la misma

SELECT * FROM SubastasActivas;




--------------------- Separador ---------------------------

-- Creo un trigger para que cuando una obra se venda actualice automaticamente su estado en la tabla correspondiente

USE GaleriaDeArteV2;
GO
CREATE OR ALTER TRIGGER CambiarEstadoObra_Venta
ON Ventas
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE Obras
        SET Estado = 'Vendida'
        WHERE IdObra IN (SELECT IdObra FROM inserted);

        COMMIT TRANSACTION;

        PRINT 'El estado de la obra fue actualizado correctamente a "Vendida".';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        PRINT 'Error al intentar actualizar el estado de la obra.';
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO