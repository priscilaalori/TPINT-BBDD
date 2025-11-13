
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

