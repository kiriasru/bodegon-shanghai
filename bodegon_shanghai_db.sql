-- Crear base de datos y usarla
CREATE DATABASE bodegon_shanghai_db;
USE bodegon_shanghai_db;

-- Crear la tabla para Categorias
/*
Esta tabla sirve para crear categorias para los productos, ya sean de limpieza, electronica,
electrodomesticos, vestimenta, hogar o deportes. Contiene su Id, Nombre de categoria y descripcion.
*/
CREATE TABLE Categorias (
  Id INT AUTO_INCREMENT,
  NombreCategoria ENUM('Limpieza', 'Electrónica', 'Electrodomésticos', 'Vestimenta', 'Hogar', 'Deportes') NOT NULL,
  Descripcion TEXT,
  PRIMARY KEY (Id)
);

-- Crear la tabla para Proveedores
/*
Esta tabla sirve para crear proveedores que tengan su respectivo Id, nombre de razon social, telefono, email, direccion.
El telefono y el correo son unicos, ya que ningun otro proveedor debe tener ese correo, ni ese telefono.
*/
CREATE TABLE Proveedores (
  Id INT AUTO_INCREMENT,
  NombreRazonSocial VARCHAR(35) NOT NULL,
  Telefono VARCHAR(20),
  CorreoElectronico VARCHAR(40),
  Direccion VARCHAR(80),
  PRIMARY KEY (Id),
  UNIQUE (Telefono),
  UNIQUE (CorreoElectronico)
);

-- Crear tabla para usuarios
/*
Esta tabla sirve para agregar ususarios en el sistema. Contiene su Id, Nombre del usuario, correo, username, su rol y estado.
Tmabien tiene su correo y username como unicos.
*/
CREATE TABLE Usuarios (
  Id INT AUTO_INCREMENT,
  NombreCompleto VARCHAR(80) NOT NULL,
  CorreoElectronico VARCHAR(60) NOT NULL,
  Username VARCHAR(40) NOT NULL,
  PuestoRol VARCHAR(40),
  Estado ENUM('Activo', 'Inactivo') DEFAULT 'Activo',
  PRIMARY KEY (Id),
  UNIQUE (CorreoElectronico),
  UNIQUE (Username)
);

-- Tabla para productos
/*
Usamos esta tabla para agregar los productos. Tienen su respectivo id, nombre de producto, descripcion, su codigo SKU unico, 
precio de compra, venta, stock, estado y su id de categoria como llave foranea.
*/
CREATE TABLE Productos (
  Id INT AUTO_INCREMENT,
  NombreProducto VARCHAR(150) NOT NULL,
  Descripcion TEXT,
  SKU VARCHAR(50) NOT NULL,
  PrecioCompra DECIMAL(10,2) CHECK (PrecioCompra > 0),
  PrecioVenta DECIMAL(10,2) CHECK (PrecioVenta > 0),
  StockMinimo INT DEFAULT 0,
  Estado ENUM('Activo', 'Inactivo') DEFAULT 'Activo',
  IdCategoria INT NOT NULL,
  PRIMARY KEY (Id),
  UNIQUE (SKU),
  FOREIGN KEY (IdCategoria) REFERENCES Categorias(Id)
);

-- Tabla de movimientos de inventario
-- La E es para Entrada y la S es para Salida
CREATE TABLE MovimientoInventario (
  Id INT AUTO_INCREMENT,
  IdProducto INT NOT NULL,
  TipoMovimiento ENUM('E', 'S') NOT NULL,
  Cantidad INT NOT NULL CHECK (Cantidad > 0),
  FechaHoraMovimiento DATETIME NOT NULL,
  ObservacionesNota TEXT,
  IdUsuario INT NOT NULL,
  PRIMARY KEY (Id),
  FOREIGN KEY (IdProducto) REFERENCES Productos(Id),
  FOREIGN KEY (IdUsuario) REFERENCES Usuarios(Id)
);

-- Tabla intermedia
-- Tabla intermedia para relación muchos a muchos entre productos y proveedores
CREATE TABLE ProductosHasProveedores (
  IdProducto INT NOT NULL,
  IdProveedor INT NOT NULL,
  PRIMARY KEY (IdProducto, IdProveedor),
  FOREIGN KEY (IdProducto) REFERENCES Productos(Id),
  FOREIGN KEY (IdProveedor) REFERENCES Proveedores(Id)
);