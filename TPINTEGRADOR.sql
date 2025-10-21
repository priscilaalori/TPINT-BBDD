USE GaleriaDeArte;
GO
CREATE TABLE Paises(
IdPaises INT PRIMARY KEY IDENTITY (1,1),
Nombre VARCHAR (50) NOT NULL);

CREATE TABLE Usuario(
    IdUsuario INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Telefono VARCHAR (20),
    DNI VARCHAR (15),
    TipoUsuario VARCHAR (50),
    FechaRegistro DATETIME
);
CREATE TABLE Artista (
    IdArtista INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255),
    Apellido VARCHAR(255),
    FechaDeNac DATE,
    FechaDeFallecimiento DATE,
    Biografia VARCHAR(MAX),
    IdPaisOrigen INT,
    FOREIGN KEY (IdPaisOrigen) REFERENCES Paises(IdPaises)
);

CREATE TABLE Obra (
    IdObra INT PRIMARY KEY IDENTITY(1,1),
    Titulo VARCHAR(255),
    Tecnica VARCHAR(255),
    Alto DECIMAL,
    Ancho DECIMAL,
    Profundidad DECIMAL,
    Precio FLOAT,
    Estado VARCHAR(255),
    Fecha DATE
);
CREATE TABLE Imagen (
    IdImagen INT PRIMARY KEY IDENTITY(1,1),
    IdObra INT,
    URLImagen VARCHAR(255),
    Creditos VARCHAR(255),
    FOREIGN KEY (IdObra) REFERENCES Obra(IdObra)
);

CREATE TABLE Calificacion (
    IdCalificacion INT PRIMARY KEY IDENTITY(1,1),
    IdUsuario INT,
    IdObra INT,
    IdArtista INT,
    Estrellas INT,
    FechaCalificacion DATETIME,
    Reseña VARCHAR(255),
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
    FOREIGN KEY (IdObra) REFERENCES Obra(IdObra)
);
CREATE TABLE Venta (
    IdVenta INT PRIMARY KEY IDENTITY(1,1),
    IdObra INT,
    IdCliente INT,
    FechaVenta DATETIME,
    FOREIGN KEY (IdObra) REFERENCES Obra(IdObra),
    FOREIGN KEY (IdCliente) REFERENCES Usuario(IdUsuario)
);
 
 CREATE TABLE Muestra (
    IdMuestra INT PRIMARY KEY IDENTITY(1,1),
    Titulo VARCHAR(255),
    Descripcion VARCHAR(255),
    FechaInicio DATETIME,
    FechaFinalizacion DATETIME
);
CREATE TABLE ObrasXMuestra (
    IdObra INT,
    IdMuestra INT,
    Sala VARCHAR(255),
    PRIMARY KEY (IdObra, IdMuestra),
    FOREIGN KEY (IdObra) REFERENCES Obra(IdObra),
    FOREIGN KEY (IdMuestra) REFERENCES Muestra(IdMuestra)
);
CREATE TABLE Favoritos (
    IdObra INT,
    IdUsuario INT,
    FechaMarcado DATETIME,
    PRIMARY KEY (IdObra, IdUsuario),
    FOREIGN KEY (IdObra) REFERENCES Obra(IdObra),
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);
CREATE TABLE Subasta (
    IdSubasta INT PRIMARY KEY IDENTITY(1,1),
    IdObra INT,
    IdUsuario INT,
    FechaInicio DATETIME,
    FechaCierre DATETIME,
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
    FOREIGN KEY (IdObra) REFERENCES Obra(IdObra)
    
);

CREATE TABLE Lote (
    IdLote INT PRIMARY KEY IDENTITY(1,1),
    IdSubasta INT,
    IdObra INT,
    PrecioBase FLOAT,
    PrecioActual FLOAT,
    FOREIGN KEY (IdSubasta) REFERENCES Subasta(IdSubasta),
    FOREIGN KEY (IdObra) REFERENCES Obra(IdObra)
);
CREATE TABLE Puja (
    IdPuja INT PRIMARY KEY IDENTITY(1,1),
    IdLote INT,
    IdUsuario INT,
    MontoOfrecido FLOAT,
    FechaHora DATETIME,
    FOREIGN KEY (IdLote) REFERENCES Lote(IdLote),
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);
CREATE TABLE ObraxArtista(
IdObra INT,
IdArtista INT,
Rol VARCHAR (50),
Orden VARCHAR (50)
 FOREIGN KEY (IdObra) REFERENCES Obra(IdObra),
 FOREIGN KEY (IdArtista) REFERENCES Artista(IdArtista)
 );
