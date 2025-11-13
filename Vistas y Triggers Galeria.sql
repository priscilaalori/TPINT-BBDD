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

        -- tomo el precio automáticamente desde Obras
        UPDATE v
        SET v.PrecioVenta = o.Precio
        FROM Ventas v
        INNER JOIN inserted i ON v.IdVenta = i.IdVenta
        INNER JOIN Obras o ON i.IdObra = o.IdObra
        WHERE v.PrecioVenta IS NULL;

        -- Verificamos si el comprador NO es de tipo "Cliente"
        IF EXISTS (
            SELECT 1
            FROM inserted i
            JOIN Usuarios u ON i.IdClienteComprador = u.IdUsuario
            JOIN TiposUsuario t ON u.IdTipoUsuario = t.IdTipoUsuario
            WHERE t.Descripcion <> 'Cliente' 
        )
        BEGIN
            RAISERROR('Solo los usuarios de tipo "Cliente" pueden comprar obras.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Solo actualiza si la obra NO está vendida
        IF EXISTS (
            SELECT 1
            FROM inserted i
            JOIN Obras o ON i.IdObra = o.IdObra
            WHERE o.Estado = 'Vendida'
        )
        BEGIN
            RAISERROR('Esta obra ya se encuentra como vendida.', 18, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Si no está vendida, actualizar su estado a "Vendida"
        UPDATE o
        SET o.Estado = 'Vendida'
        FROM Obras o
        JOIN inserted i ON o.IdObra = i.IdObra;

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


USE master;
ALTER DATABASE GaleriaDeArteV2 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
ALTER DATABASE GaleriaDeArteV2 SET MULTI_USER;
