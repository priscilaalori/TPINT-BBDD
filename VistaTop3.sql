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















