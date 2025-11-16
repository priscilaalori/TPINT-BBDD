--Triggers

--Trigger de eliminación 

CREATE TRIGGER tr_EliminarMuestra
ON Muestras INSTEAD OF DELETE
AS
BEGIN
    -- En lugar de eliminar, actualiza la fecha de finalización
    UPDATE M  SET M.FechaFinalizacion = GETDATE()
    FROM Muestras M INNER JOIN deleted D ON M.IdMuestra = D.IdMuestra;
    PRINT 'La muestra fue marcada como finalizada.';
END;
GO

--------------------------------------Separador-----------------------------------------------------


---Trigger Cambiar estado de la obra

-- Creo un trigger para que cuando una obra se venda actualice automaticamente su estado en la tabla correspondiente

USE GaleriaDeArteV2;
GO
CREATE TRIGGER CambiarEstadoObra_Venta
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

