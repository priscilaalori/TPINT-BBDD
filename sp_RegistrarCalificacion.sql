USE GaleriaDeArteV2
go
CREATE PROCEDURE sp_RegistrarCalificacion
    @IdObra BIGINT,
    @IdUsuario BIGINT,
    @Estrellas INT,
    @Comentario NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRAN;

        --  existencia de la obra
        IF NOT EXISTS (SELECT 1 FROM Obras WHERE IdObra = @IdObra)
        BEGIN
            RAISERROR('La obra indicada no existe.', 16, 1);
            ROLLBACK TRAN;
            RETURN;
        END

        -- existencia del usuario
        IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE IdUsuario = @IdUsuario)
        BEGIN
            RAISERROR('El usuario indicado no existe.', 16, 1);
            ROLLBACK TRAN;
            RETURN;
        END

        -- calificación from entre 1 y 5
        IF @Estrellas < 1 OR @Estrellas > 5
        BEGIN
            RAISERROR('La calificación debe estar entre 1 y 5 estrellas.', 16, 1);
            ROLLBACK TRAN;
            RETURN;
        END

        -- calificación previa del mismo usuario para la misma obra
        IF EXISTS (
            SELECT 1 FROM Calificaciones
            WHERE IdObra = @IdObra AND IdUsuario = @IdUsuario
        )
        BEGIN
            RAISERROR('El usuario ya ha calificado esta obra.', 16, 1);
            ROLLBACK TRAN;
            RETURN;
        END

        -- Insertar la calificación
        INSERT INTO Calificaciones (IdObra, IdUsuario, Estrellas, Resena, FechaCalificacion)
        VALUES (@IdObra, @IdUsuario, @Estrellas, @Comentario, GETDATE());

       -- promedio de calificacion 
        SELECT 
            o.IdObra,
            o.Titulo,
            COUNT(c.IdCalificacion) AS TotalCalificaciones,
            AVG(c.Estrellas) AS PromedioEstrellas
        FROM Obras o
        JOIN Calificaciones c ON o.IdObra = c.IdObra
        WHERE o.IdObra = 3
        GROUP BY o.IdObra, o.Titulo;

      COMMIT 
      
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;

        THROW;
    END CATCH
END;


USE GaleriaDeArteV2
GO
ALTER PROCEDURE sp_RegistrarCalificacion
    @IdObra BIGINT,
    @IdUsuario BIGINT,
    @Estrellas INT,
    @Comentario NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRAN;

       
        IF NOT EXISTS (SELECT 1 FROM Obras WHERE IdObra = @IdObra)
        BEGIN
            RAISERROR('La obra indicada no existe.', 16, 1);
            ROLLBACK TRAN;
            RETURN;
        END

        
        IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE IdUsuario = @IdUsuario)
        BEGIN
            RAISERROR('El usuario indicado no existe.', 16, 1);
            ROLLBACK TRAN;
            RETURN;
        END

      
        IF @Estrellas < 1 OR @Estrellas > 5
        BEGIN
            RAISERROR('La calificación debe estar entre 1 y 5 estrellas.', 16, 1);
            ROLLBACK TRAN;
            RETURN;
        END

      
        IF EXISTS (
            SELECT 1 FROM Calificaciones
            WHERE IdObra = @IdObra AND IdUsuario = @IdUsuario
        )
        BEGIN
            RAISERROR('El usuario ya ha calificado esta obra.', 16, 1);
            ROLLBACK TRAN;
            RETURN;
        END

      
        INSERT INTO Calificaciones (IdObra, IdUsuario, Estrellas, Resena, FechaCalificacion)
        VALUES (@IdObra, @IdUsuario, @Estrellas, @Comentario, GETDATE());

        -- Mensaje de confirmación
        PRINT 'La calificación fue registrada correctamente.';

        COMMIT

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;

        THROW;
    END CATCH
END;


EXEC sp_helptext 'sp_RegistrarCalificacion';



