
--Procedimientos almacenados 
-- SP 1:  Listar Favoritos del usuario 

-- Creo Store Procedure para lista 

CREATE PROCEDURE spListarFavoritoPorUsuario
      @IdUsuario BIGINT
AS
BEGIN 
SELECT 
    F.IdUsuario,
	O.IdObra,
	O.Titulo AS TituloObra,
	A.IdArtista,
	A.Nombre AS NombreArtista,
	A.Apellido AS ApellidoArtista,
	F.FechaMarcado AS FechaFavorito

    FROM Favoritos F
    INNER JOIN Obras O ON O.IdObra = F.IdObra
    INNER JOIN ObrasXArtistas OA ON OA.IdObra = O.IdObra
    INNER JOIN Artistas A ON A.IdArtista = OA.IdArtista
    WHERE F.IdUsuario = @IdUsuario
    ORDER BY F.FechaMarcado DESC;
END;
GO
-- Consulta para probar el SP

EXEC spListarFavoritoPorUsuario @IdUsuario = 6;


-------------------------------------------------------Separador ------------------------------------

--SP 2: Registrar Puja 

CREATE PROCEDURE sp_RegistrarPuja(
@IdLote BIGINT,
@IdUsuario BIGINT,
@MontoOfrecido MONEY
)
AS
--Comienza el bloque try 
    BEGIN TRY 
--comienza la transacción
     BEGIN TRAN

-- Validaciones
--Si existe el lote 
 IF (SELECT COUNT(*) FROM Lotes WHERE IdLote = @IdLote) = 0
BEGIN

    RAISERROR('El lote indicado no existe.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
    END

--Si existe el idUsuario 

IF (SELECT COUNT(*) FROM Usuarios WHERE IdUsuario = @IdUsuario) = 0
    BEGIN
    RAISERROR('El cliente indicado no existe.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
    END

--Corroborar que la subasta esté activa

IF NOT EXISTS (
    Select 1 from Lotes L 
        inner join Subastas S on L.IdSubasta = S.IdSubasta
        where  L.IdLote = @IdLote AND S.Estado = 1)

  BEGIN
  RAISERROR('La subasta del lote no está activa.', 16, 1);
  ROLLBACK TRANSACTION;
  RETURN;
  END


  -- Corroborar que el monto sea mayor a 0 
  IF (@MontoOfrecido <= 0)
    BEGIN
    RAISERROR('El monto ofrecido debe ser mayor a cero.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
    END

--Corroborar que el monto > a monto inicial + incremento minimo tabla subastas
 
    DECLARE 
    @PrecioBase MONEY, 
    @PrecioActual MONEY, 
    @IncrementoMinimo MONEY, 
    @MinRequerido MONEY;

    SELECT
      @PrecioBase   = PrecioBase,
      @PrecioActual = ISNULL(PrecioActual, 0),
      @IncrementoMinimo    = ISNULL(IncrementoMinimo, 0)
    FROM Lotes
    WHERE IdLote = @IdLote;

    -- mínimo requerido según haya o no pujas previas
    SET @MinRequerido = CASE WHEN @PrecioActual = 0
                       THEN @PrecioBase + @IncrementoMinimo
                       ELSE @PrecioActual + @IncrementoMinimo
                  END;

    IF (@MontoOfrecido <= @MinRequerido)
    BEGIN
      RAISERROR('Monto insuficiente: debe superar el mínimo requerido.', 16, 1);
      ROLLBACK TRANSACTION; RETURN;
    END
--Insert que va a realizar el SP
INSERT INTO Pujas (IdLote, IdUsuario, MontoOfrecido, FechaHora) VALUES (@IdLote,@IdUsuario,@MontoOfrecido, GETDATE())

-- after insert se tiene que actualizar en la tabla de Subastas el precio final con un trigger. 

UPDATE L 
      SET L.PrecioActual = @MontoOfrecido
    FROM Lotes L
    WHERE L.IdLote = @IdLote;

COMMIT
END TRY
BEGIN CATCH

    IF @@TRANCOUNT > 0 ROLLBACK;
    PRINT ERROR_MESSAGE();
    THROW;       

END CATCH

-----------------------------------------------------Separador-----------------------------------------------------------------------------

----SP 3 Obtener Promedio de calificaciones

USE GaleriaDeArteV2
GO

CREATE PROCEDURE sp_ObtenerPromedioCalificaciones
    @IdObra BIGINT = NULL 
AS
BEGIN
    SET NOCOUNT ON;

   
    IF @IdObra IS NOT NULL
    BEGIN
        SELECT 
            o.IdObra,
            o.Titulo,
            COUNT(c.IdCalificacion) AS TotalCalificaciones,
            ISNULL(AVG(c.Estrellas), 0) AS PromedioEstrellas
        FROM Obras o
        LEFT JOIN Calificaciones c ON o.IdObra = c.IdObra
        WHERE o.IdObra = @IdObra
        GROUP BY o.IdObra, o.Titulo;
    END
    ELSE
   
    BEGIN
        SELECT 
            o.IdObra,
            o.Titulo,
            COUNT(c.IdCalificacion) AS TotalCalificaciones,
            ISNULL(AVG(c.Estrellas), 0) AS PromedioEstrellas
        FROM Obras o
        LEFT JOIN Calificaciones c ON o.IdObra = c.IdObra
          
        GROUP BY o.IdObra, o.Titulo
        ORDER BY o.Titulo;
    END
END

EXEC sp_ObtenerPromedioCalificaciones;

EXEC sp_ObtenerPromedioCalificaciones @IdObra = 5;

-------------------------------------------------------Separador-------------------------------------------------------------------------------

--SP 4 Registrar Calificación: creación y alter
--Create
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

----ALTER Procedure


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

