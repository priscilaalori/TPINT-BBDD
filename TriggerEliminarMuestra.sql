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
