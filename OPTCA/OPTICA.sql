-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8 ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`cliente` (
  `Id_Cliente` INT(11) NOT NULL,
  `Nom` VARCHAR(60) NULL DEFAULT NULL,
  `Telefono` VARCHAR(15) NULL DEFAULT NULL,
  `Email` VARCHAR(60) NULL DEFAULT NULL,
  `FechaAlta` DATE NULL DEFAULT NULL,
  `Zip` VARCHAR(5) NULL DEFAULT NULL,
  `Id_Recomendat` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`Id_Cliente`),
  INDEX `fk_cliente_cliente1_idx` (`Id_Recomendat` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_cliente1`
    FOREIGN KEY (`Id_Recomendat`)
    REFERENCES `optica`.`cliente` (`Id_Cliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `optica`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`proveedor` (
  `Id_Proveedor` INT(11) NOT NULL,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Calle` VARCHAR(60) NULL DEFAULT NULL,
  `Numero` VARCHAR(3) NULL DEFAULT NULL,
  `Piso` TINYINT(4) NULL DEFAULT NULL,
  `Puerta` VARCHAR(3) NULL DEFAULT NULL,
  `Ciudad` VARCHAR(45) NULL DEFAULT NULL,
  `Pais` VARCHAR(60) NULL DEFAULT NULL,
  `Zip` VARCHAR(5) NULL DEFAULT NULL,
  `Telefono` VARCHAR(15) NULL DEFAULT NULL,
  `Fax` VARCHAR(15) NULL DEFAULT NULL,
  `Nif` VARCHAR(9) NULL DEFAULT NULL,
  PRIMARY KEY (`Id_Proveedor`),
  INDEX `idx_pais_pr` (`Pais` ASC) VISIBLE,
  INDEX `idx_nombre_pr` (`Nombre` ASC) VISIBLE,
  INDEX `idx_ciudad` (`Ciudad` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `optica`.`marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`marca` (
  `Id_Marca` INT(11) NOT NULL,
  `Nom_Marca` VARCHAR(60) NULL DEFAULT NULL,
  `proveedor_Id_Proveedor` INT(11) NOT NULL,
  PRIMARY KEY (`Id_Marca`),
  INDEX `idx_nom_marca` (`Nom_Marca` ASC) VISIBLE,
  INDEX `fk_marca_proveedor1_idx` (`proveedor_Id_Proveedor` ASC) VISIBLE,
  CONSTRAINT `fk_marca_proveedor1`
    FOREIGN KEY (`proveedor_Id_Proveedor`)
    REFERENCES `optica`.`proveedor` (`Id_Proveedor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `optica`.`gafa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`gafa` (
  `Id_Gafa` INT(11) NOT NULL,
  `Graduacion` FLOAT NULL DEFAULT NULL,
  `Montura` VARCHAR(45) NULL DEFAULT NULL,
  `ColorMontura` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Valores admitidos: \"Pasta\", \"Metalica\" o \"Foltante\"',
  `ColorVidrio` VARCHAR(45) NULL DEFAULT NULL,
  `Precio` FLOAT NULL DEFAULT NULL,
  `MARCA_Id_Marca` INT(11) NOT NULL,
  PRIMARY KEY (`Id_Gafa`),
  INDEX `fk_GAFA_MARCA_idx` (`MARCA_Id_Marca` ASC) VISIBLE,
  CONSTRAINT `fk_GAFA_MARCA`
    FOREIGN KEY (`MARCA_Id_Marca`)
    REFERENCES `optica`.`marca` (`Id_Marca`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `optica`.`empleat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`empleat` (
  `Id_empleat` INT(11) NOT NULL,
  `Nom` VARCHAR(60) NULL DEFAULT NULL,
  PRIMARY KEY (`Id_empleat`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `optica`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`compra` (
  `CLIENTE_Id_Cliente` INT(11) NOT NULL,
  `GAFA_Id_Gafa` INT(11) NOT NULL,
  `Data` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `empleat_Id_empleat` INT(11) NOT NULL,
  `IdCompra` INT(11) NOT NULL,
  PRIMARY KEY (`IdCompra`, `CLIENTE_Id_Cliente`, `GAFA_Id_Gafa`),
  INDEX `fk_CLIENTE_has_GAFA_GAFA1_idx` (`GAFA_Id_Gafa` ASC) VISIBLE,
  INDEX `fk_CLIENTE_has_GAFA_CLIENTE1_idx` (`CLIENTE_Id_Cliente` ASC) VISIBLE,
  INDEX `fk_compra_empleat_idx` (`empleat_Id_empleat` ASC) VISIBLE,
  CONSTRAINT `fk_CLIENTE_has_GAFA_CLIENTE1`
    FOREIGN KEY (`CLIENTE_Id_Cliente`)
    REFERENCES `optica`.`cliente` (`Id_Cliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_CLIENTE_has_GAFA_GAFA1`
    FOREIGN KEY (`GAFA_Id_Gafa`)
    REFERENCES `optica`.`gafa` (`Id_Gafa`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_compra_empleat`
    FOREIGN KEY (`empleat_Id_empleat`)
    REFERENCES `optica`.`empleat` (`Id_empleat`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
