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
    BEGIN TRY
        BEGIN TRANSACTION; 

        -- Actualizamos el estado de las obras vendidas
        UPDATE Obra
        SET Estado = 'Vendida'
        WHERE IdObra IN (SELECT IdObra FROM inserted);

        -- Confirmamos los cambios
        COMMIT TRANSACTION;

        PRINT 'El estado de la obra fue actualizado correctamente a "Vendida".';
    END TRY

    BEGIN CATCH
        -- Si ocurre un error, revertimos
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        PRINT 'Error al intentar actualizar el estado de la obra.';
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO