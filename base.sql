/* Esta base de datos debe ser arreglada, los ALTER TABLE se deben agregar a la tabla
para no tener errores, tambien debemos agregar primero las tablas que no tienen referencias. 
 */

CREATE DATABASE coordinadora;
USE coordinadora;
CREATE TABLE `pais`(
    `Id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(255) NOT NULL
);
CREATE TABLE `tipopago`(
    `Id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(255) NOT NULL
);
CREATE TABLE `tipoProducto`(
    `Id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);
CREATE TABLE `tipoEnvio`(
    `Id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `tipoenvio` VARCHAR(255) NOT NULL
);
CREATE TABLE `departamento`(
    `Id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(255) NOT NULL,
    `IdPaisFk` INT NOT NULL,
    CONSTRAINT `departamento_idpaisfk_foreign` FOREIGN KEY(`IdPaisFk`) REFERENCES `pais`(`Id`)
);
CREATE TABLE `ciudad`(
    `Id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(255) NOT NULL,
    `IdDepartamentoFk` INT NOT NULL,
    CONSTRAINT `ciudad_iddepartamentofk_foreign` FOREIGN KEY(`IdDepartamentoFk`) REFERENCES `departamento`(`Id`)
);
CREATE TABLE `empleado`(
    `Id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(255) NOT NULL,
    `correo` VARCHAR(255) NOT NULL,
    `direccion` VARCHAR(255) NOT NULL,
    `Idciudadfk` INT NOT NULL,
    CONSTRAINT `empleado_idciudadfk_foreign` FOREIGN KEY(`Idciudadfk`) REFERENCES `ciudad`(`Id`)
);
CREATE TABLE `usuario`(
    `Id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(255) NOT NULL,
    `correo` VARCHAR(255) NOT NULL,
    `telefono` VARCHAR(255) NOT NULL,
    `Direccion` VARCHAR(255) NOT NULL,
    `IdCiudadFk` INT NOT NULL,
    CONSTRAINT `usuario_idciudadfk_foreign` FOREIGN KEY(`IdCiudadFk`) REFERENCES `ciudad`(`Id`)
);
CREATE TABLE `envio`(
    `Id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Descripcion` VARCHAR(255) NOT NULL,
    `duracion` VARCHAR(255) NOT NULL,
    `IdtipoenvioFk` INT NOT NULL,
    CONSTRAINT `envio_idtipoenviofk_foreign` FOREIGN KEY(`IdtipoenvioFk`) REFERENCES `tipoEnvio`(`Id`)
);
CREATE TABLE `pedido`(
    `Id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `IdUsuarioFk` INT NOT NULL,
    `Descripcion` VARCHAR(255) NOT NULL,
    `IdenvioFk` INT NOT NULL,
    CONSTRAINT `pedido_idenviofk_foreign` FOREIGN KEY(`IdenvioFk`) REFERENCES `envio`(`Id`),
    CONSTRAINT `pedido_idusuariofk_foreign` FOREIGN KEY(`IdUsuarioFk`) REFERENCES `usuario`(`Id`)
);

CREATE TABLE `detallepedido`(
    `Id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `cantidad` INT NOT NULL,
    `preciounitario` DOUBLE NOT NULL,
    `IdpedidoFk` INT NOT NULL,
    CONSTRAINT `detallepedido_idpedidofk_foreign` FOREIGN KEY(`IdpedidoFk`) REFERENCES `pedido`(`Id`)
);
CREATE TABLE `estado`(
    `Id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Fechapedido` DATE NOT NULL,
    `Fechaesperada` DATE NOT NULL,
    `Fechaentrega` DATE NOT NULL,
    `IdpedidoFk` INT NOT NULL,
    CONSTRAINT `estado_idpedidofk_foreign` FOREIGN KEY(`IdpedidoFk`) REFERENCES `pedido`(`Id`)
);
CREATE TABLE `ruta`(
    `Id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `puntoorigen` VARCHAR(255) NOT NULL,
    `puntodestino` VARCHAR(255) NOT NULL,
    `IdPedidoFk` INT NOT NULL,
    CONSTRAINT `ruta_idpedidofk_foreign` FOREIGN KEY(`IdPedidoFk`) REFERENCES `pedido`(`Id`)
);
CREATE TABLE `producto`(
    `Id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Descripcion` VARCHAR(255) NOT NULL,
    `proveedor` VARCHAR(255) NOT NULL,
    `precio` DOUBLE NOT NULL,
    `cantidad` INT NOT NULL,
    `IdpedidoFk` INT NOT NULL,
    `preciototal` INT NOT NULL,
    `IdtipoproductoFk` INT NOT NULL,
    CONSTRAINT `producto_idpedidofk_foreign` FOREIGN KEY(`IdpedidoFk`) REFERENCES `pedido`(`Id`),
    CONSTRAINT `producto_idtipoproductofk_foreign` FOREIGN KEY(`IdtipoproductoFk`) REFERENCES `tipoProducto`(`Id`)
);
CREATE TABLE `pago`(
    `Id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `IdproductoFk` INT NOT NULL,
    `valortotal` DOUBLE NOT NULL,
    `IdtipopagoFk` INT NOT NULL,
    CONSTRAINT `pago_idproductofk_foreign` FOREIGN KEY(`IdproductoFk`) REFERENCES `producto`(`Id`),
    CONSTRAINT `pago_idtipopagofk_foreign` FOREIGN KEY(`IdtipopagoFk`) REFERENCES `tipopago`(`Id`)
);


















