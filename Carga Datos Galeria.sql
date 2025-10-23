USE GaleriaDeArte;
GO

-- =======================================================
-- 1. PAISES
-- =======================================================
INSERT INTO Paises (Nombre) VALUES
('Argentina'),
('Espa�a'),
('Italia'),
('Francia'),
('M�xico'),
('Estados Unidos'),
('Alemania'),
('Brasil'),
('Jap�n'),
('Chile');

-- =======================================================
-- 2. USUARIOS
-- =======================================================
INSERT INTO Usuario (Nombre, Apellido, Telefono, DNI, TipoUsuario, FechaRegistro) VALUES
('Luc�a', 'P�rez', '1123456789', '40111222', 'Cliente', GETDATE()),
('Mart�n', 'G�mez', '1133345566', '39122123', 'Cliente', GETDATE()),
('Camila', 'Rodr�guez', '1144456677', '41122444', 'Artista', GETDATE()),
('Santiago', 'L�pez', '1155567788', '40111999', 'Cliente', GETDATE()),
('Elena', 'Mart�nez', '1166678899', '42123555', 'Artista', GETDATE()),
('Pedro', 'Alonso', '1177789900', '40111234', 'Cliente', GETDATE()),
('Laura', 'Ben�tez', '1188899011', '43121212', 'Administrador', GETDATE()),
('Juli�n', 'Torres', '1199900112', '45122333', 'Cliente', GETDATE()),
('Valentina', 'Su�rez', '1100001112', '46111222', 'Cliente', GETDATE()),
('Diego', 'Ramos', '1201112233', '47111999', 'Artista', GETDATE()),
('Natalia', 'Prieto', '1211223344', '48111000', 'Cliente', GETDATE()),
('Hern�n', 'Sosa', '1222334455', '49111111', 'Cliente', GETDATE());

-- =======================================================
-- 3. ARTISTAS
-- =======================================================
INSERT INTO Artista (Nombre, Apellido, FechaDeNac, FechaDeFallecimiento, Biografia, IdPaisOrigen) VALUES
('Pablo', 'Picasso', '1881-10-25', '1973-04-08', 'Pintor y escultor espa�ol.', 2),
('Frida', 'Kahlo', '1907-07-06', '1954-07-13', 'Pintora mexicana reconocida mundialmente.', 5),
('Leonardo', 'da Vinci', '1452-04-15', '1519-05-02', 'Artista, inventor y cient�fico italiano.', 3),
('Carlos', 'Moretti', '1978-05-12', NULL, 'Artista contempor�neo argentino de arte abstracto.', 1),
('Claire', 'Dubois', '1985-09-22', NULL, 'Fot�grafa francesa que retrata la vida urbana.', 4),
('Akira', 'Tanaka', '1980-06-03', NULL, 'Artista japon�s de t�cnica mixta.', 9),
('Julia', 'M�ller', '1975-11-30', NULL, 'Pintora alemana impresionista moderna.', 7),
('Thomas', 'Reed', '1969-08-15', NULL, 'Escultor estadounidense.', 6),
('Fernanda', 'Costa', '1988-04-19', NULL, 'Artista brasile�a especializada en retratos.', 8),
('Sof�a', 'Lagos', '1990-02-14', NULL, 'Pintora argentina de arte surrealista.', 1);

-- =======================================================
-- 4. OBRAS
-- =======================================================
INSERT INTO Obra (Titulo, Tecnica, Alto, Ancho, Profundidad, Precio, Estado, Fecha) VALUES
('El Guernica', '�leo sobre lienzo', 349, 776, 0, 1200000, 'Exhibici�n', '1937-06-01'),
('Las dos Fridas', '�leo sobre lienzo', 173, 173, 0, 900000, 'Vendida', '1939-01-01'),
('La �ltima Cena', 'Tempera sobre yeso', 460, 880, 0, 2000000, 'Exhibici�n', '1498-01-01'),
('Reflejos del Alma', 'Acr�lico sobre lienzo', 120, 100, 2, 15000, 'Disponible', '2022-03-01'),
('Sombras de Par�s', 'Fotograf�a digital', 50, 70, 0, 7000, 'Subasta', '2023-08-15'),
('Horizonte Interior', 'Tinta sobre papel', 60, 90, 0, 8500, 'Disponible', '2021-07-10'),
('Cuerpos de Luz', 'Instalaci�n mixta', 250, 200, 50, 35000, 'Exhibici�n', '2020-10-05'),
('Sue�o en Rojo', '�leo sobre lienzo', 100, 80, 0, 11000, 'Disponible', '2023-04-12'),
('Bosque Azul', 'Acuarela', 70, 50, 0, 5000, 'Vendida', '2021-05-08'),
('Ecos del Silencio', 'Escultura en m�rmol', 150, 60, 40, 45000, 'Exhibici�n', '2019-09-22'),
('Retrato de un R�o', 'Fotograf�a', 60, 90, 0, 6000, 'Subasta', '2024-02-12'),
('Luces de Tokio', 'T�cnica mixta', 80, 120, 0, 9500, 'Disponible', '2023-09-10'),
('El Vuelo', '�leo sobre madera', 75, 100, 0, 7000, 'Disponible', '2022-12-01');

-- =======================================================
-- 5. IM�GENES
-- =======================================================
INSERT INTO Imagen (IdObra, URLImagen, Creditos) VALUES
(1, 'https://example.com/guernica.jpg', 'Museo Reina Sof�a'),
(2, 'https://example.com/las_dos_fridas.jpg', 'Museo de Arte Moderno'),
(3, 'https://example.com/ultima_cena.jpg', 'Santa Maria delle Grazie'),
(4, 'https://example.com/reflejos_del_alma.jpg', 'Carlos Moretti'),
(5, 'https://example.com/sombras_de_paris.jpg', 'Claire Dubois'),
(6, 'https://example.com/horizonte_interior.jpg', 'Carlos Moretti'),
(7, 'https://example.com/cuerpos_de_luz.jpg', 'Thomas Reed'),
(8, 'https://example.com/sueno_en_rojo.jpg', 'Fernanda Costa'),
(9, 'https://example.com/bosque_azul.jpg', 'Julia M�ller'),
(10, 'https://example.com/ecos_del_silencio.jpg', 'Thomas Reed'),
(11, 'https://example.com/retrato_rio.jpg', 'Claire Dubois'),
(12, 'https://example.com/luces_tokio.jpg', 'Akira Tanaka'),
(13, 'https://example.com/el_vuelo.jpg', 'Sof�a Lagos');

-- =======================================================
-- 6. OBRA X ARTISTA
-- =======================================================
INSERT INTO ObraxArtista (IdObra, IdArtista, Rol, Orden) VALUES
(1, 1, 'Autor', '1'),
(2, 2, 'Autor', '1'),
(3, 3, 'Autor', '1'),
(4, 4, 'Autor', '1'),
(5, 5, 'Autor', '1'),
(6, 4, 'Autor', '1'),
(7, 8, 'Autor', '1'),
(8, 9, 'Autor', '1'),
(9, 7, 'Autor', '1'),
(10, 8, 'Autor', '1'),
(11, 5, 'Autor', '1'),
(12, 6, 'Autor', '1'),
(13, 10, 'Autor', '1');

-- =======================================================
-- 7. CALIFICACIONES
-- =======================================================
INSERT INTO Calificacion (IdUsuario, IdObra, IdArtista, Estrellas, FechaCalificacion, Rese�a) VALUES
(1, 1, 1, 5, GETDATE(), 'Obra impresionante, transmite mucho.'),
(2, 2, 2, 4, GETDATE(), 'Muy emocional y poderosa.'),
(4, 4, 4, 5, GETDATE(), 'Colores y profundidad perfectos.'),
(6, 5, 5, 4, GETDATE(), 'Gran fotograf�a.'),
(8, 6, 4, 5, GETDATE(), 'Hermosa tinta, muy delicada.'),
(9, 8, 9, 4, GETDATE(), 'Muy buena paleta de colores.'),
(11, 10, 8, 5, GETDATE(), 'Una escultura excelente.'),
(12, 12, 6, 5, GETDATE(), 'Excelente uso de luz y composici�n.');

-- =======================================================
-- 8. VENTAS
-- =======================================================
INSERT INTO Venta (IdObra, IdCliente, FechaVenta) VALUES
(2, 1, '2023-02-12'),
(9, 4, '2022-11-08');

-- =======================================================
-- 9. MUESTRAS
-- =======================================================
INSERT INTO Muestra (Titulo, Descripcion, FechaInicio, FechaFinalizacion) VALUES
('Maestros del Siglo XX', 'Obras influyentes del siglo pasado.', '2023-01-01', '2023-06-01'),
('Arte Contempor�neo Argentino', 'Tendencias del arte local.', '2024-02-01', '2024-05-01'),
('Visiones del Futuro', 'Arte digital y conceptual.', '2025-03-10', '2025-08-15'),
('Formas y Materia', 'Esculturas contempor�neas.', '2024-06-01', '2024-10-01');

-- =======================================================
-- 10. OBRAS X MUESTRA
-- =======================================================
INSERT INTO ObrasXMuestra (IdObra, IdMuestra, Sala) VALUES
(1, 1, 'Sala Principal'),
(2, 1, 'Sala Norte'),
(3, 1, 'Sala Renacimiento'),
(4, 2, 'Sala Moderna'),
(7, 4, 'Sala Escultura'),
(10, 4, 'Sala M�rmol'),
(5, 3, 'Sala Digital'),
(12, 3, 'Sala Tecnolog�a');

-- =======================================================
-- 11. FAVORITOS
-- =======================================================
INSERT INTO Favoritos (IdObra, IdUsuario, FechaMarcado) VALUES
(1, 2, GETDATE()),
(3, 1, GETDATE()),
(5, 6, GETDATE()),
(8, 9, GETDATE()),
(10, 4, GETDATE());

-- =======================================================
-- 12. SUBASTAS
-- =======================================================
INSERT INTO Subasta (IdObra, IdUsuario, FechaInicio, FechaCierre) VALUES
(5, 7, '2024-10-01', '2024-10-10'),
(11, 7, '2025-01-05', '2025-01-12');

-- =======================================================
-- 13. LOTES
-- =======================================================
INSERT INTO Lote (IdSubasta, IdObra, PrecioBase, PrecioActual) VALUES
(1, 5, 7000, 8500),
(2, 11, 6000, 7200);

-- =======================================================
-- 14. PUJAS
-- =======================================================
INSERT INTO Puja (IdLote, IdUsuario, MontoOfrecido, FechaHora) VALUES
(1, 1, 7500, '2024-10-02'),
(1, 2, 8000, '2024-10-04'),
(1, 4, 8500, '2024-10-05'),
(2, 8, 6500, '2025-01-06'),
(2, 9, 7000, '2025-01-07'),
(2, 12, 7200, '2025-01-08');