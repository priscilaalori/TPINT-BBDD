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


