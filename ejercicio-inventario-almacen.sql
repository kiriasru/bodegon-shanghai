CREATE TABLE `Categorias` (
  `Id` INT,
  `NombreCategoria` ENUM(Limpieza/Electrónica/Electrodomésticos/Vestimenta/Hogar/Deportes),
  `Descripcion` TEXT,
  PRIMARY KEY (`Id`)
);

CREATE TABLE `Productos` (
  `Id` INT,
  `NombreProd` VARCHAR(150),
  `Descripcion` TEXT,
  `SKU` INT,
  `PrecioCompra` Decimal (10,2),
  `PrecioVenta` Decimal (10,2),
  `StockMinimo` INT,
  `Estado` ENUM(Activo/Inactivo),
  `IdCategorias` INT,
  PRIMARY KEY (`Id`),
  FOREIGN KEY (`PrecioCompra`)
      REFERENCES `Categorias`(`NombreCategoria`),
  KEY `UQ` (`SKU`)
);

CREATE TABLE `Usuarios` (
  `Id` INT,
  `NombreCompleto` VARCHAR(45),
  `CorreoElectronico` VARCHAR (25),
  `Username` VARCHAR(25),
  `PuestoRol` VARCHAR(25),
  `Estado` ENUM(Activo/Inactivo),
  PRIMARY KEY (`Id`),
  KEY `UQ` (`CorreoElectronico`, `Username`)
);

CREATE TABLE `Proveedores` (
  `Id` INT,
  `NombreRazonSocial` VARCHAR(35),
  `Telefono` INT,
  `CorreoElectronico` VARCHAR(25),
  `Direccion` VARCHAR(55),
  PRIMARY KEY (`Id`),
  KEY `UQ` (`Telefono`, `CorreoElectronico`),
  KEY `Clave` (`Direccion`)
);

CREATE TABLE `MovimientoInventario` (
  `Id` INT,
  `IdProducto` INT,
  `TipoMovimiento ` ENUM(Entrada/Salida),
  `Cantidad` INT,
  `FechaHoraMovimiento` DATETIME,
  `ObservacionesNota` TEXT,
  `IdUsuarios` INT,
  PRIMARY KEY (`Id`),
  FOREIGN KEY (`TipoMovimiento `)
      REFERENCES `Usuarios`(`CorreoElectronico`)
);

CREATE TABLE `ProductosHasProveedores` (
  `IdProductos` INT,
  `IdProveedores` INT
);