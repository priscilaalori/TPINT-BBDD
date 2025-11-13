use GaleriaDeArteV2
go
CREATE PROCEDURE BuscarObrasPorArtista
    @IdArtista BIGINT
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRY
IF NOT EXISTS (SELECT 1 FROM ARTISTAS WHERE IdArtista = @IdArtista)
BEGIN
RAISERROR('El artista no existe.',16,1);
RETURN;
END
IF NOT EXISTS(SELECT 1 FROM ObrasXArtistas Where IdArtista =@IdArtista)
BEGIN 
RAISERROR('El artista no tiene obras en este momento',16,1);
RETURN;
END

    SELECT o.IdObra, o.Titulo, r.TipoRol, ox.Orden
    FROM Obras o
    JOIN ObrasXArtistas ox ON o.IdObra = ox.IdObra
    JOIN Roles r ON ox.IdRol = r.IdRol
    WHERE ox.IdArtista = @IdArtista;
END TRY
BEGIN CATCH
 PRINT ERROR_MESSAGE();
 THROW;
 END CATCH 
 END;



