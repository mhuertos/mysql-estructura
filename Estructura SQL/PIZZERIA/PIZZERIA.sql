-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`provincia` (
  `Id_PROVINCIA` INT(11) NOT NULL,
  `Nom_Provincia` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`Id_PROVINCIA`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`localitat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`localitat` (
  `Id_Localitat` INT(11) NOT NULL,
  `PROVINCIA_Id_PROVINCIA` INT(11) NOT NULL,
  `Nom` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`Id_Localitat`, `PROVINCIA_Id_PROVINCIA`),
  INDEX `idx_nom_localitat` (`Nom` ASC) VISIBLE,
  INDEX `fk_LOCALITAT_PROVINCIA_idx` (`PROVINCIA_Id_PROVINCIA` ASC) VISIBLE,
  CONSTRAINT `fk_LOCALITAT_PROVINCIA`
    FOREIGN KEY (`PROVINCIA_Id_PROVINCIA`)
    REFERENCES `pizzeria`.`provincia` (`Id_PROVINCIA`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`botiga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`botiga` (
  `Id_Botiga` INT(11) NOT NULL,
  `Address` VARCHAR(60) NULL DEFAULT NULL,
  `Zip` VARCHAR(5) NULL DEFAULT NULL,
  `LOCALITAT_Id_Localitat` INT(11) NOT NULL,
  `LOCALITAT_PROVINCIA_Id_PROVINCIA` INT(11) NOT NULL,
  PRIMARY KEY (`Id_Botiga`),
  INDEX `fk_BOTIGA_LOCALITAT1_idx` (`LOCALITAT_Id_Localitat` ASC, `LOCALITAT_PROVINCIA_Id_PROVINCIA` ASC) VISIBLE,
  CONSTRAINT `fk_BOTIGA_LOCALITAT1`
    FOREIGN KEY (`LOCALITAT_Id_Localitat` , `LOCALITAT_PROVINCIA_Id_PROVINCIA`)
    REFERENCES `pizzeria`.`localitat` (`Id_Localitat` , `PROVINCIA_Id_PROVINCIA`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`categoria_pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categoria_pizza` (
  `Id_Categoria` INT(11) NOT NULL,
  `Nom` VARCHAR(60) NULL DEFAULT NULL,
  PRIMARY KEY (`Id_Categoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`client` (
  `Id_client` INT(11) NOT NULL,
  `Nom` VARCHAR(60) NULL DEFAULT NULL,
  `Cognoms` VARCHAR(60) NULL DEFAULT NULL,
  `Phone` VARCHAR(15) NULL DEFAULT NULL,
  `Adress` VARCHAR(60) NULL DEFAULT NULL,
  `Zip` VARCHAR(5) NULL DEFAULT NULL,
  `LOCALITAT_Id_Localitat` INT(11) NOT NULL,
  `LOCALITAT_PROVINCIA_Id_PROVINCIA` INT(11) NOT NULL,
  PRIMARY KEY (`Id_client`),
  INDEX `idx_nom` (`Nom` ASC) VISIBLE,
  INDEX `fk_CLIENT_LOCALITAT1_idx` (`LOCALITAT_Id_Localitat` ASC, `LOCALITAT_PROVINCIA_Id_PROVINCIA` ASC) VISIBLE,
  CONSTRAINT `fk_CLIENT_LOCALITAT1`
    FOREIGN KEY (`LOCALITAT_Id_Localitat` , `LOCALITAT_PROVINCIA_Id_PROVINCIA`)
    REFERENCES `pizzeria`.`localitat` (`Id_Localitat` , `PROVINCIA_Id_PROVINCIA`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`rol_emp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`rol_emp` (
  `Id_ROL_EMP` INT(11) NOT NULL,
  `Nom_Rol` VARCHAR(60) NULL DEFAULT NULL,
  PRIMARY KEY (`Id_ROL_EMP`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleat` (
  `Id_EMPLEAT` INT(11) NOT NULL,
  `Nom` VARCHAR(60) NULL DEFAULT NULL,
  `Cognoms` VARCHAR(60) NULL DEFAULT NULL,
  `Nif` VARCHAR(9) NULL DEFAULT NULL,
  `Telefon` VARCHAR(12) NULL DEFAULT NULL,
  `BOTIGA_Id_Botiga` INT(11) NOT NULL,
  `ROL_EMP_Id_ROL_EMP` INT(11) NOT NULL,
  PRIMARY KEY (`Id_EMPLEAT`),
  INDEX `fk_EMPLEAT_BOTIGA1_idx` (`BOTIGA_Id_Botiga` ASC) VISIBLE,
  INDEX `fk_EMPLEAT_ROL_EMP1_idx` (`ROL_EMP_Id_ROL_EMP` ASC) VISIBLE,
  CONSTRAINT `fk_EMPLEAT_BOTIGA1`
    FOREIGN KEY (`BOTIGA_Id_Botiga`)
    REFERENCES `pizzeria`.`botiga` (`Id_Botiga`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_EMPLEAT_ROL_EMP1`
    FOREIGN KEY (`ROL_EMP_Id_ROL_EMP`)
    REFERENCES `pizzeria`.`rol_emp` (`Id_ROL_EMP`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`comanda` (
  `Id_COMANDA` INT(11) NOT NULL,
  `DataComanda` TIMESTAMP NULL DEFAULT NULL,
  `numProductes` INT(11) NULL DEFAULT NULL,
  `PreuTotal` FLOAT NULL DEFAULT NULL,
  `TipusEntrega` VARCHAR(45) NULL DEFAULT NULL,
  `DataEntrega` TIMESTAMP NULL DEFAULT NULL,
  `CLIENT_Id_client` INT(11) NOT NULL,
  `BOTIGA_Id_Botiga` INT(11) NOT NULL,
  `EMPLEAT_Id_EMPLEAT` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`Id_COMANDA`),
  INDEX `fk_COMANDA_CLIENT1_idx` (`CLIENT_Id_client` ASC) VISIBLE,
  INDEX `fk_COMANDA_BOTIGA1_idx` (`BOTIGA_Id_Botiga` ASC) VISIBLE,
  INDEX `fk_COMANDA_EMPLEAT1_idx` (`EMPLEAT_Id_EMPLEAT` ASC) VISIBLE,
  CONSTRAINT `fk_COMANDA_BOTIGA1`
    FOREIGN KEY (`BOTIGA_Id_Botiga`)
    REFERENCES `pizzeria`.`botiga` (`Id_Botiga`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_COMANDA_CLIENT1`
    FOREIGN KEY (`CLIENT_Id_client`)
    REFERENCES `pizzeria`.`client` (`Id_client`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_COMANDA_EMPLEAT1`
    FOREIGN KEY (`EMPLEAT_Id_EMPLEAT`)
    REFERENCES `pizzeria`.`empleat` (`Id_EMPLEAT`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`tipus_producte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tipus_producte` (
  `Id_Tipus_Producte` INT(11) NOT NULL,
  `Nom_producte` VARCHAR(60) NULL DEFAULT NULL,
  PRIMARY KEY (`Id_Tipus_Producte`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`producte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`producte` (
  `Id_PRODUCTE` INT(11) NOT NULL,
  `NomProducte` VARCHAR(60) NULL DEFAULT NULL,
  `Desc` TEXT NULL DEFAULT NULL,
  `Image` BLOB NULL DEFAULT NULL,
  `Preu` FLOAT NULL DEFAULT NULL,
  `TIPUS_PRODUCTE_Id_Tipus_Producte` INT(11) NOT NULL,
  `CATEGORIA_PIZZA_Id_Categoria` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`Id_PRODUCTE`),
  INDEX `fk_PRODUCTE_TIPUS_PRODUCTE1_idx` (`TIPUS_PRODUCTE_Id_Tipus_Producte` ASC) VISIBLE,
  INDEX `fk_PRODUCTE_CATEGORIA_PIZZA1_idx` (`CATEGORIA_PIZZA_Id_Categoria` ASC) VISIBLE,
  CONSTRAINT `fk_PRODUCTE_CATEGORIA_PIZZA1`
    FOREIGN KEY (`CATEGORIA_PIZZA_Id_Categoria`)
    REFERENCES `pizzeria`.`categoria_pizza` (`Id_Categoria`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PRODUCTE_TIPUS_PRODUCTE1`
    FOREIGN KEY (`TIPUS_PRODUCTE_Id_Tipus_Producte`)
    REFERENCES `pizzeria`.`tipus_producte` (`Id_Tipus_Producte`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`producte_has_comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`producte_has_comanda` (
  `PRODUCTE_Id_PRODUCTE` INT(11) NOT NULL,
  `COMANDA_Id_COMANDA` INT(11) NOT NULL,
  PRIMARY KEY (`PRODUCTE_Id_PRODUCTE`, `COMANDA_Id_COMANDA`),
  INDEX `fk_PRODUCTE_has_COMANDA_COMANDA1_idx` (`COMANDA_Id_COMANDA` ASC) VISIBLE,
  INDEX `fk_PRODUCTE_has_COMANDA_PRODUCTE1_idx` (`PRODUCTE_Id_PRODUCTE` ASC) VISIBLE,
  CONSTRAINT `fk_PRODUCTE_has_COMANDA_COMANDA1`
    FOREIGN KEY (`COMANDA_Id_COMANDA`)
    REFERENCES `pizzeria`.`comanda` (`Id_COMANDA`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PRODUCTE_has_COMANDA_PRODUCTE1`
    FOREIGN KEY (`PRODUCTE_Id_PRODUCTE`)
    REFERENCES `pizzeria`.`producte` (`Id_PRODUCTE`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
