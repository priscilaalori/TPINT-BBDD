
--Script: Agregar columnas en la tabla subastas

Alter table Subastas
ADD Estado BIT NOT NULL DEFAULT 1
GO


