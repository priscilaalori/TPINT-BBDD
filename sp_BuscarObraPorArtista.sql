use GaleriaDeArteV2
go
CREATE PROCEDURE BuscarObrasPorArtista
    @IdArtista BIGINT
AS
BEGIN
    SELECT o.IdObra, o.Titulo, r.TipoRol, ox.Orden
    FROM Obras o
    JOIN ObrasXArtistas ox ON o.IdObra = ox.IdObra
    JOIN Roles r ON ox.IdRol = r.IdRol
    WHERE ox.IdArtista = @IdArtista;
END;
 



