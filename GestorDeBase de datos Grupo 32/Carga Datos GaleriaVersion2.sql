USE GaleriaDeArteV2

INSERT INTO Paises (Nombre) VALUES
('Argentina'),
('España'),
('México'),
('Italia'),
('Francia'),
('Alemania'),
('Brasil'),
('Chile'),
('Colombia'),
('Estados Unidos');

INSERT INTO TiposUsuario (Descripcion) VALUES
('Administrador'),
('Cliente'),
('Artista'),
('Curador'),
('Comprador'),
('Vendedor'),
('Visitante'),
('Gestor'),
('Subastador'),
('Invitado');

INSERT INTO Roles (TipoRol) VALUES
('Autor'),
('Colaborador'),
('Restaurador'),
('Curador'),
('Fotógrafo'),
('Diseñador'),
('Escultor'),
('Pintor'),
('Grabador'),
('Ilustrador');


INSERT INTO Usuarios (Nombre, Apellido, Telefono, DNI, IdTipoUsuario) VALUES
('Lucía', 'Gómez', '1122334455', '12345678', 2),
('Martín', 'Pérez', '1133445566', '23456789', 3),
('Sofía', 'López', '1144556677', '34567890', 4),
('Carlos', 'Ramírez', '1155667788', '45678901', 5),
('Ana', 'Fernández', '1166778899', '56789012', 6),
('Diego', 'Torres', '1177889900', '67890123', 7),
('Valentina', 'Martínez', '1188990011', '78901234', 8),
('Julián', 'Castro', '1199001122', '89012345', 9),
('Camila', 'Suárez', '1100112233', '90123456', 10),
('Priscila','Alori','1168061301',  '41554170',  10),
('Elias' ,'Lopez' ,' 1131197654', '40565321', 2),
('Pamela','Vizcarra', '112345678', '40987654', 1),
('Federico', 'Domínguez', '1111223344', '01234567', 1);

INSERT INTO Artistas (Nombre, Apellido, FechaDeNac, FechaDeFallecimiento, Biografia, IdPais) VALUES
('Frida', 'Kahlo', '1907-07-06', '1954-07-13', 'Pintora mexicana reconocida por sus autorretratos.', 3),
('Pablo', 'Picasso', '1881-10-25', '1973-04-08', 'Fundador del cubismo y uno de los artistas más influyentes.', 2),
('Leonardo', 'da Vinci', '1452-04-15', '1519-05-02', 'Artista renacentista italiano, autor de La Mona Lisa.', 4),
('Claude', 'Monet', '1840-11-14', '1926-12-05', 'Pintor francés, pionero del impresionismo.', 5),
('Diego', 'Rivera', '1886-12-08', '1957-11-24', 'Muralista mexicano de fama internacional.', 3),
('Andy', 'Warhol', '1928-08-06', '1987-02-22', 'Figura clave del arte pop estadounidense.', 10),
('Remedios', 'Varo', '1908-12-16', '1963-10-08', 'Artista surrealista española radicada en México.', 3),
('Joan', 'Miró', '1893-04-20', '1983-12-25', 'Pintor, escultor y ceramista español.', 2),
('Antonio', 'Berni', '1905-05-14', '1981-10-13', 'Artista argentino comprometido con lo social.', 1),
('Fernando', 'Botero', '1932-04-19', NULL, 'Pintor y escultor colombiano conocido por sus figuras voluminosas.', 9);

INSERT INTO Obras (Titulo, Tecnica, Alto, Ancho, Profundidad, Precio, Estado, Fecha, Imagen) VALUES
('La persistencia de la memoria', 'Óleo sobre lienzo', 24.0, 33.0, 2.0, 150000, 'Disponible', '1931-01-01', 'https://upload.wikimedia.org/wikipedia/en/d/dd/The_Persistence_of_Memory.jpg'),
('Guernica', 'Óleo sobre lienzo', 349.0, 776.0, 5.0, 500000, 'Exhibida', '1937-06-01', 'https://upload.wikimedia.org/wikipedia/en/7/7f/PicassoGuernica.jpg'),
('La Gioconda', 'Óleo sobre tabla', 77.0, 53.0, 3.0, 1000000, 'Reservada', '1503-01-01', 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Mona_Lisa.jpg'),
('Las Meninas', 'Óleo sobre lienzo', 318.0, 276.0, 4.0, 750000, 'Vendida', '1656-01-01', 'https://upload.wikimedia.org/wikipedia/commons/9/99/Las_Meninas_01.jpg'),
('El nacimiento de Venus', 'Temple sobre lienzo', 172.5, 278.5, 3.0, 600000, 'Disponible', '1486-01-01', 'https://upload.wikimedia.org/wikipedia/commons/1/1c/Sandro_Botticelli_-_La_nascita_di_Venere_-_Google_Art_Project_-_edited.jpg'),
('El grito', 'Óleo y pastel sobre cartón', 91.0, 73.5, 2.0, 400000, 'Exhibida', '1893-01-01', 'https://upload.wikimedia.org/wikipedia/en/f/f4/The_Scream.jpg'),
('La noche estrellada', 'Óleo sobre lienzo', 74.0, 92.0, 2.0, 550000, 'Disponible', '1889-06-01', 'https://upload.wikimedia.org/wikipedia/commons/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg'),
('El jardín de las delicias', 'Óleo sobre tabla', 220.0, 389.0, 6.0, 800000, 'Reservada', '1500-01-01', 'https://upload.wikimedia.org/wikipedia/commons/0/0c/Garden_delights.jpg'),
('Autorretrato con collar de espinas', 'Óleo sobre lienzo', 61.0, 47.0, 2.0, 300000, 'Disponible', '1940-01-01', 'https://upload.wikimedia.org/wikipedia/commons/1/1e/Frida_Kahlo_%28self_portrait%29.jpg'),
('La libertad guiando al pueblo', 'Óleo sobre lienzo', 260.0, 325.0, 4.0, 700000, 'Vendida', '1830-07-01', 'https://upload.wikimedia.org/wikipedia/commons/5/5f/Eug%C3%A8ne_Delacroix_-_La_libert%C3%A9_guidant_le_peuple.jpg');

INSERT INTO ObrasXArtistas (IdObra, IdArtista, IdRol, Orden) VALUES
(1, 1, 1, 1),
(2, 2, 1, 1),
(3, 3, 1, 1),
(4, 4, 1, 1),
(5, 5, 1, 1),
(6, 6, 1, 1),
(7, 7, 1, 1),
(8, 8, 1, 1),
(9, 1, 2, 2),
(10, 9, 1, 1);

INSERT INTO Calificaciones (IdUsuario, IdObra, Estrellas, Resena) VALUES
(1, 1, 4.5, 'Obra impactante y profunda.'),
(2, 2, 5.0, 'Una pieza histórica invaluable.'),
(3, 9, 4.0, 'Muy buena técnica.'),
(4, 4, 3.5, 'Interesante pero no mi estilo.'),
(5, 9, 4.8, 'Excelente composición.'),
(6, 6, 5.0, 'Me encantó la expresividad.'),
(7, 7, 4.2, 'Colores vibrantes y bien logrados.'),
(8, 8, 4.7, 'Obra compleja y fascinante.'),
(10, 9, 4.9, 'Muy conmovedora.'),
(10, 10, 5.0, 'Una obra maestra.');

INSERT INTO Muestras (Titulo, Descripcion, FechaInicio, FechaFinalizacion) VALUES
('Impresionismo en París', 'Exposición de obras impresionistas.', '2025-01-10', '2025-02-20'),
('Arte Latinoamericano', 'Muestra de artistas de América Latina.', '2025-03-01', '2025-04-15'),
('Renacimiento Italiano', 'Obras del siglo XV y XVI.', '2025-05-05', '2025-06-30'),
('Modernismo Global', 'Tendencias modernas en el arte.', '2025-07-10', '2025-08-25'),
('Surrealismo y sueños', 'Exploración del surrealismo.', '2025-09-01', '2025-10-15'),
('Arte Pop', 'Obras icónicas del arte pop.', '2025-11-01', '2025-12-10'),
('Mujeres en el arte', 'Artistas femeninas destacadas.', '2026-01-05', '2026-02-20'),
('Arte y política', 'Obras con contenido social.', '2026-03-01', '2026-04-10'),
('Paisajes del mundo', 'Representaciones de la naturaleza.', '2026-05-15', '2026-06-30'),
('Arte abstracto', 'Formas y colores sin límites.', '2026-07-10', '2026-08-25');

INSERT INTO ObrasXMuestras (IdObra, IdMuestra, Sala) VALUES
(1, 1, 'Sala A'),
(2, 2, 'Sala B'),
(3, 2, 'Sala C'),
(4, 4, 'Sala D'),
(5, 5, 'Sala E'),
(6, 2, 'Sala F'),
(7, 7, 'Sala G'),
(8, 8, 'Sala H'),
(9, 9, 'Sala I'),
(10, 10, 'Sala J');

INSERT INTO Favoritos (IdObra, IdUsuario) VALUES
(1, 1),
(2, 6),
(3, 3),
(4, 4),
(5, 6),
(6, 6),
(7, 7),
(8, 8),
(9, 6),
(10, 10);

INSERT INTO Subastas (IdUsuario, FechaInicio, FechaCierre) VALUES
(9, '2025-01-01', '2025-01-10'),
(9, '2025-02-01', '2025-02-10'),
(9, '2025-03-01', '2025-03-10'),
(9, '2025-04-01', '2025-04-10'),
(9, '2025-05-01', '2025-05-10'),
(9, '2025-06-01', '2025-06-10'),
(9, '2025-07-01', '2025-07-10'),
(9, '2025-08-01', '2025-08-10'),
(9, '2025-09-01', '2025-09-10'),
(9, '2025-10-01', '2025-10-10');

INSERT INTO Lotes (IdSubasta, PrecioBase, PrecioActual, IncrementoMinimo) VALUES
(1, 100000, 110000, 5000),
(2, 150000, 160000, 5000),
(3, 200000, 210000, 5000),
(4, 250000, 260000, 5000),
(5, 300000, 310000, 5000),
(6, 350000, 360000, 5000),
(7, 400000, 410000, 5000),
(8, 450000, 460000, 5000),
(9, 500000, 510000, 5000),
(10, 550000, 560000, 5000);


INSERT INTO ObrasXLotes (IdObra, IdLote) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO Pujas (IdLote, IdUsuario, MontoOfrecido) VALUES
(1, 2, 115000),
(2, 3, 165000),
(3, 4, 215000),
(4, 5, 265000),
(5, 6, 315000),
(6, 7, 365000),
(7, 8, 415000),
(8, 9, 465000),
(9, 10, 515000),
(10, 1, 565000);

INSERT INTO Ventas (IdObra, IdClienteComprador, PrecioVenta) VALUES
(1, 3, 120000),
(2, 4, 170000),
(3, 5, 220000),
(4, 6, 270000),
(5, 7, 320000),
(6, 8, 370000),
(7, 9, 420000),
(8, 10, 470000),
(9, 1, 520000),
(10, 2, 570000);































