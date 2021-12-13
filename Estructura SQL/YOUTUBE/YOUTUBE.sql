-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8 ;
USE `youtube` ;

-- -----------------------------------------------------
-- Table `youtube`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`user` (
  `Id_USER` INT(11) NOT NULL,
  `Nom` VARCHAR(60) NOT NULL,
  `Mail` VARCHAR(60) NOT NULL,
  `Password` VARCHAR(12) NOT NULL,
  `DataNaix` DATETIME NULL DEFAULT NULL,
  `Sex` VARCHAR(1) NULL DEFAULT NULL COMMENT '\'M\' = Male\\n\'F\' = Female',
  `Country` VARCHAR(60) NULL DEFAULT NULL,
  `Zip` VARCHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`Id_USER`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `youtube`.`canal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`canal` (
  `Id_CANAL` INT(11) NOT NULL,
  `Nom_Canal` VARCHAR(60) NULL DEFAULT NULL,
  `Desc` TEXT NULL DEFAULT NULL,
  `Data_Creacio` DATETIME NULL DEFAULT NULL,
  `Id_CREATOR_USER` INT(11) NOT NULL,
  `Id_SUSCR_USER` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`Id_CANAL`),
  INDEX `fk_CANAL_USER1_idx` (`Id_CREATOR_USER` ASC) VISIBLE,
  INDEX `fk_CANAL_USER2_idx` (`Id_SUSCR_USER` ASC) VISIBLE,
  CONSTRAINT `fk_CANAL_USER1`
    FOREIGN KEY (`Id_CREATOR_USER`)
    REFERENCES `youtube`.`user` (`Id_USER`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_CANAL_USER2`
    FOREIGN KEY (`Id_SUSCR_USER`)
    REFERENCES `youtube`.`user` (`Id_USER`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `youtube`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`video` (
  `Id_VIDEO` INT(11) NOT NULL,
  `Titol` VARCHAR(60) NULL DEFAULT NULL,
  `Desc` TEXT NULL DEFAULT NULL,
  `NumRep` BIGINT(20) NULL DEFAULT NULL,
  `Length` INT(11) NULL DEFAULT NULL,
  `Nom_Fitxer` VARCHAR(60) NULL DEFAULT NULL,
  `Durada` INT(11) NULL DEFAULT NULL,
  `Thumbnail` BLOB NULL DEFAULT NULL,
  `USER_Id_USER` INT(11) NOT NULL,
  `DataPublicacio` DATETIME NOT NULL,
  PRIMARY KEY (`Id_VIDEO`),
  INDEX `fk_VIDEO_USER_idx` (`USER_Id_USER` ASC) VISIBLE,
  CONSTRAINT `fk_VIDEO_USER`
    FOREIGN KEY (`USER_Id_USER`)
    REFERENCES `youtube`.`user` (`Id_USER`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `youtube`.`comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`comentario` (
  `Id_COMENTARIO` INT(11) NOT NULL,
  `Desc` TEXT NULL DEFAULT NULL,
  `Data` DATETIME NULL DEFAULT NULL,
  `USER_Id_USER` INT(11) NOT NULL,
  `VIDEO_Id_VIDEO` INT(11) NOT NULL,
  PRIMARY KEY (`Id_COMENTARIO`),
  INDEX `fk_COMENTARIO_USER1_idx` (`USER_Id_USER` ASC) VISIBLE,
  INDEX `fk_COMENTARIO_VIDEO1_idx` (`VIDEO_Id_VIDEO` ASC) VISIBLE,
  CONSTRAINT `fk_COMENTARIO_USER1`
    FOREIGN KEY (`USER_Id_USER`)
    REFERENCES `youtube`.`user` (`Id_USER`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_COMENTARIO_VIDEO1`
    FOREIGN KEY (`VIDEO_Id_VIDEO`)
    REFERENCES `youtube`.`video` (`Id_VIDEO`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `youtube`.`comentario_has_liked`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`comentario_has_liked` (
  `id_Valoracio` INT(11) NOT NULL,
  `COMENTARIO_Id_COMENTARIO` INT(11) NOT NULL,
  `USER_Id_USER` INT(11) NOT NULL,
  `Data` DATETIME NOT NULL,
  `Valoracio` VARCHAR(10) NOT NULL COMMENT '\'Like\' OR \'Dislike\'',
  PRIMARY KEY (`id_Valoracio`, `COMENTARIO_Id_COMENTARIO`, `USER_Id_USER`),
  INDEX `fk_COMENTARIO_has_USER_USER2_idx` (`USER_Id_USER` ASC) VISIBLE,
  INDEX `fk_COMENTARIO_has_USER_COMENTARIO2_idx` (`COMENTARIO_Id_COMENTARIO` ASC) VISIBLE,
  CONSTRAINT `fk_COMENTARIO_has_USER_COMENTARIO2`
    FOREIGN KEY (`COMENTARIO_Id_COMENTARIO`)
    REFERENCES `youtube`.`comentario` (`Id_COMENTARIO`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_COMENTARIO_has_USER_USER2`
    FOREIGN KEY (`USER_Id_USER`)
    REFERENCES `youtube`.`user` (`Id_USER`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `youtube`.`etiqueta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`etiqueta` (
  `Id_ETIQUETA` INT(11) NOT NULL,
  `Nom_Etiqueta` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`Id_ETIQUETA`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `youtube`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`playlist` (
  `Id_PLAYLIST` INT(11) NOT NULL,
  `Nom` VARCHAR(60) NOT NULL,
  `Data_Creacio` DATETIME NOT NULL,
  `Estat` VARCHAR(60) NOT NULL COMMENT '\'P\' = Public\\n\'O\'= Oculta',
  `USER_Id_USER` INT(11) NOT NULL,
  `VIDEO_Id_VIDEO` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`Id_PLAYLIST`),
  INDEX `fk_PLAYLIST_USER1_idx` (`USER_Id_USER` ASC) VISIBLE,
  INDEX `fk_PLAYLIST_VIDEO1_idx` (`VIDEO_Id_VIDEO` ASC) VISIBLE,
  CONSTRAINT `fk_PLAYLIST_USER1`
    FOREIGN KEY (`USER_Id_USER`)
    REFERENCES `youtube`.`user` (`Id_USER`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PLAYLIST_VIDEO1`
    FOREIGN KEY (`VIDEO_Id_VIDEO`)
    REFERENCES `youtube`.`video` (`Id_VIDEO`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `youtube`.`video_has_etiqueta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`video_has_etiqueta` (
  `VIDEO_Id_VIDEO` INT(11) NOT NULL,
  `ETIQUETA_Id_ETIQUETA` INT(11) NOT NULL,
  PRIMARY KEY (`VIDEO_Id_VIDEO`, `ETIQUETA_Id_ETIQUETA`),
  INDEX `fk_VIDEO_has_ETIQUETA_ETIQUETA1_idx` (`ETIQUETA_Id_ETIQUETA` ASC) VISIBLE,
  INDEX `fk_VIDEO_has_ETIQUETA_VIDEO1_idx` (`VIDEO_Id_VIDEO` ASC) VISIBLE,
  CONSTRAINT `fk_VIDEO_has_ETIQUETA_ETIQUETA1`
    FOREIGN KEY (`ETIQUETA_Id_ETIQUETA`)
    REFERENCES `youtube`.`etiqueta` (`Id_ETIQUETA`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_VIDEO_has_ETIQUETA_VIDEO1`
    FOREIGN KEY (`VIDEO_Id_VIDEO`)
    REFERENCES `youtube`.`video` (`Id_VIDEO`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `youtube`.`video_has_liked`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`video_has_liked` (
  `VIDEO_Id_VIDEO` INT(11) NOT NULL,
  `USER_Id_USER` INT(11) NOT NULL,
  `Data` DATE NULL DEFAULT NULL,
  `id_Valoracio` INT(11) NULL DEFAULT NULL,
  `Valoracio` VARCHAR(60) NULL DEFAULT NULL COMMENT '\'Like\' OR \'Dislike\'',
  PRIMARY KEY (`VIDEO_Id_VIDEO`, `USER_Id_USER`),
  INDEX `fk_VIDEO_has_USER_USER1_idx` (`USER_Id_USER` ASC) VISIBLE,
  INDEX `fk_VIDEO_has_USER_VIDEO1_idx` (`VIDEO_Id_VIDEO` ASC) VISIBLE,
  CONSTRAINT `fk_VIDEO_has_USER_USER1`
    FOREIGN KEY (`USER_Id_USER`)
    REFERENCES `youtube`.`user` (`Id_USER`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_VIDEO_has_USER_VIDEO1`
    FOREIGN KEY (`VIDEO_Id_VIDEO`)
    REFERENCES `youtube`.`video` (`Id_VIDEO`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
