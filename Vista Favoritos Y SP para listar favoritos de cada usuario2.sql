-- Creo vista que mustra todas las obras marcadas como favoritas por usuario

use GaleriaDeArteV2;
go


CREATE VIEW VistaFavoritos 
AS
SELECT 
      F.IdUsuario,
	  U.Nombre AS NombreUsuario,
	  U.Apellido AS ApellidoUsuario,
	  F.IdObra,
	  O.Titulo AS TituloObra,
	  A.IdArtista,
	  A.Nombre AS NombreArtista,
	  A.Apellido AS ApellidoArtista,
	  F.FechaMarcado AS FechaFavorito

FROM Favoritos AS F
INNER JOIN Usuarios AS U ON U.IdUsuario = F.IdUsuario
INNER JOIN Obras AS O ON O.IdObra = F.IdObra
INNER JOIN ObrasXArtistas AS OA ON OA.IdObra = O.IdObra
INNER JOIN Artistas AS A ON A.IdArtista = OA.IdArtista;
GO

-- Consulta para verificar que funciona

SELECT * FROM VistaFavoritos


-----------------------------------------------------------------------------

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