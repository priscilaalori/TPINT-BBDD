
-- CREACIÓN 
CREATE DATABASE GaleriaDeArteV2;
GO
USE GaleriaDeArteV2;
GO


-- TABLA: PAISES
CREATE TABLE Paises (
    IdPais BIGINT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(50) NOT NULL
);
GO


-- TABLA: TIPOS DE USUARIO
CREATE TABLE TiposUsuario (
    IdTipoUsuario BIGINT PRIMARY KEY IDENTITY(1,1),
    Descripcion VARCHAR(50) NOT NULL
);
GO


-- TABLA: USUARIOS
CREATE TABLE Usuarios (
    IdUsuario BIGINT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Telefono VARCHAR(20),
    DNI VARCHAR(15),
    IdTipoUsuario BIGINT NOT NULL,
    FechaRegistro DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Usuarios_TipoUsuario FOREIGN KEY (IdTipoUsuario) REFERENCES TiposUsuario(IdTipoUsuario)
);
GO


-- TABLA: ARTISTAS
CREATE TABLE Artistas (
    IdArtista BIGINT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Apellido VARCHAR(255) NOT NULL,
    FechaDeNac DATE,
    FechaDeFallecimiento DATE,
    Biografia VARCHAR(MAX),
    IdPais BIGINT NOT NULL,
    CONSTRAINT FK_Artistas_Pais FOREIGN KEY (IdPais) REFERENCES Paises(IdPais)
);
GO


-- TABLA: OBRAS
CREATE TABLE Obras (
    IdObra BIGINT PRIMARY KEY IDENTITY(1,1),
    Titulo VARCHAR(255) NOT NULL,
    Tecnica VARCHAR(255),
    Alto DECIMAL(10,2),
    Ancho DECIMAL(10,2),
    Profundidad DECIMAL(10,2),
    Precio MONEY,
    Estado VARCHAR(50),
    Fecha DATE,
    Imagen VARCHAR(255) 
);
GO


-- TABLA: ROLES (de artistas en obras)
CREATE TABLE Roles (
    IdRol BIGINT PRIMARY KEY IDENTITY(1,1),
    TipoRol VARCHAR(50) NOT NULL
);
GO


-- TABLA: OBRAS x ARTISTAS
CREATE TABLE ObrasXArtistas (
    IdObra BIGINT NOT NULL,
    IdArtista BIGINT NOT NULL,
    IdRol BIGINT NOT NULL,
    Orden INT,
    CONSTRAINT PK_ObrasXArtistas PRIMARY KEY (IdObra, IdArtista, IdRol),
    CONSTRAINT FK_ObrasXArtistas_Obra FOREIGN KEY (IdObra) REFERENCES Obras(IdObra),
    CONSTRAINT FK_ObrasXArtistas_Artista FOREIGN KEY (IdArtista) REFERENCES Artistas(IdArtista),
    CONSTRAINT FK_ObrasXArtistas_Rol FOREIGN KEY (IdRol) REFERENCES Roles(IdRol)
);
GO


-- TABLA: CALIFICACIONES
CREATE TABLE Calificaciones (
    IdCalificacion BIGINT PRIMARY KEY IDENTITY(1,1),
    IdUsuario BIGINT NOT NULL,
    IdObra BIGINT NOT NULL,
    Estrellas DECIMAL(2,1) CHECK (Estrellas BETWEEN 1 AND 5),
    FechaCalificacion DATETIME DEFAULT GETDATE(),
    Resena VARCHAR(255),
    CONSTRAINT FK_Calificaciones_Usuario FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario),
    CONSTRAINT FK_Calificaciones_Obra FOREIGN KEY (IdObra) REFERENCES Obras(IdObra)
);
GO


-- TABLA: MUESTRAS
CREATE TABLE Muestras (
    IdMuestra BIGINT PRIMARY KEY IDENTITY(1,1),
    Titulo VARCHAR(255) NOT NULL,
    Descripcion VARCHAR(255),
    FechaInicio DATETIME,
    FechaFinalizacion DATETIME
);
GO


-- TABLA: OBRAS x MUESTRAS
CREATE TABLE ObrasXMuestras (
    IdObra BIGINT NOT NULL,
    IdMuestra BIGINT NOT NULL,
    Sala VARCHAR(255),
    CONSTRAINT PK_ObrasXMuestras PRIMARY KEY (IdObra, IdMuestra),
    CONSTRAINT FK_ObrasXMuestras_Obra FOREIGN KEY (IdObra) REFERENCES Obras(IdObra),
    CONSTRAINT FK_ObrasXMuestras_Muestra FOREIGN KEY (IdMuestra) REFERENCES Muestras(IdMuestra)
);
GO


-- TABLA: FAVORITOS
CREATE TABLE Favoritos (
    IdObra BIGINT NOT NULL,
    IdUsuario BIGINT NOT NULL,
    FechaMarcado DATETIME DEFAULT GETDATE(),
    CONSTRAINT PK_Favoritos PRIMARY KEY (IdObra, IdUsuario),
    CONSTRAINT FK_Favoritos_Obra FOREIGN KEY (IdObra) REFERENCES Obras(IdObra),
    CONSTRAINT FK_Favoritos_Usuario FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario)
);
GO


-- TABLA: SUBASTAS
CREATE TABLE Subastas (
    IdSubasta BIGINT PRIMARY KEY IDENTITY(1,1),
    IdUsuario BIGINT NOT NULL,
    FechaInicio DATETIME NOT NULL,
    FechaCierre DATETIME,
    CONSTRAINT FK_Subastas_Usuario FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario)
);
GO


-- TABLA: LOTES
CREATE TABLE Lotes (
    IdLote BIGINT PRIMARY KEY IDENTITY(1,1),
    IdSubasta BIGINT NOT NULL,
    PrecioBase MONEY NOT NULL,
    PrecioActual MONEY,
    IncrementoMinimo MONEY,
    CONSTRAINT FK_Lotes_Subasta FOREIGN KEY (IdSubasta) REFERENCES Subastas(IdSubasta)
);
GO


-- TABLA: OBRAS x LOTES (nueva tabla intermedia)
CREATE TABLE ObrasXLotes (
    IdObra BIGINT NOT NULL,
    IdLote BIGINT NOT NULL,
    CONSTRAINT PK_ObrasXLotes PRIMARY KEY (IdObra, IdLote),
    CONSTRAINT FK_ObrasXLotes_Obra FOREIGN KEY (IdObra) REFERENCES Obras(IdObra),
    CONSTRAINT FK_ObrasXLotes_Lote FOREIGN KEY (IdLote) REFERENCES Lotes(IdLote)
);
GO


-- TABLA: PUJAS
CREATE TABLE Pujas (
    IdPuja BIGINT PRIMARY KEY IDENTITY(1,1),
    IdLote BIGINT NOT NULL,
    IdUsuario BIGINT NOT NULL,
    MontoOfrecido MONEY NOT NULL,
    FechaHora DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Pujas_Lote FOREIGN KEY (IdLote) REFERENCES Lotes(IdLote),
    CONSTRAINT FK_Pujas_Usuario FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario)
);
GO


-- TABLA: VENTAS
CREATE TABLE Ventas (
    IdVenta BIGINT PRIMARY KEY IDENTITY(1,1),
    IdObra BIGINT NOT NULL,
    IdClienteComprador BIGINT NOT NULL,
    FechaVenta DATETIME DEFAULT GETDATE(),
    PrecioVenta MONEY,
    CONSTRAINT FK_Ventas_Obra FOREIGN KEY (IdObra) REFERENCES Obras(IdObra),
    CONSTRAINT FK_Ventas_Usuario FOREIGN KEY (IdClienteComprador) REFERENCES Usuarios(IdUsuario)
);
GO
