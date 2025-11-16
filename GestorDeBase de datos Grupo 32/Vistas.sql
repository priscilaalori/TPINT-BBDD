
--Vistas 

--Vista 1:  Subastas activas
--Creo la vista para ver las subastas que se encuentran activas en este momento

USE GaleriaDeArteV2;
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
FROM Subastas s
JOIN Lotes l ON s.IdSubasta = l.IdSubasta
JOIN ObrasXLotes oxl ON l.IdLote = oxl.IdLote
JOIN Obras o ON oxl.IdObra = o.IdObra
WHERE s.FechaCierre > GETDATE();
GO

--De esta forma verificamos la misma

SELECT * FROM SubastasActivas;

-------------------------------------------------------------Separador ---------------------------------------------

--Vista 2 
-- Artistas con más obras Vendidas 
use GaleriaDeArteV2
go
CREATE VIEW vw_ArtistaConMasObrasVendidas
AS
SELECT TOP 1
    a.IdArtista,
    a.Nombre,
    a.Apellido,
    COUNT(DISTINCT v.IdVenta) AS ObrasVendidas
FROM Ventas v
JOIN Obras o ON v.IdObra = o.IdObra
JOIN ObrasXArtistas ox ON o.IdObra = ox.IdObra
JOIN Artistas a ON ox.IdArtista = a.IdArtista
WHERE v.PrecioVenta IS NOT NULL
GROUP BY a.IdArtista, a.Nombre, a.Apellido
HAVING COUNT(DISTINCT v.IdVenta) > 0
ORDER BY COUNT(v.IdVenta) DESC;

--- Alter sobre la vista anterior 

ALTER VIEW vw_ArtistaConMasObrasVendidas
AS
SELECT TOP 3
    a.IdArtista,
    a.Nombre,
    a.Apellido,
    COUNT(DISTINCT v.IdVenta) AS ObrasVendidas
FROM Ventas v
JOIN Obras o ON v.IdObra = o.IdObra
JOIN ObrasXArtistas ox ON o.IdObra = ox.IdObra
JOIN Artistas a ON ox.IdArtista = a.IdArtista
WHERE v.PrecioVenta IS NOT NULL
GROUP BY a.IdArtista, a.Nombre, a.Apellido
HAVING COUNT(DISTINCT v.IdVenta) > 0
ORDER BY ObrasVendidas DESC;

SELECT * FROM vw_ArtistaConMasObrasVendidas;

----- Separador -----------------------------------------------

--Vista 3 
-- Muestra todas las obras marcadas como favoritas por usuario

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


