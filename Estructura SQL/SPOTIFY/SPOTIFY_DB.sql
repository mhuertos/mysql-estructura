-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spotify` DEFAULT CHARACTER SET utf8 ;
USE `spotify` ;

-- -----------------------------------------------------
-- Table `spotify`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`user` (
  `Id_USER` INT(11) NOT NULL,
  `Nom` VARCHAR(45) NULL DEFAULT NULL,
  `Mail` VARCHAR(60) NULL DEFAULT NULL,
  `Password` VARCHAR(60) NULL DEFAULT NULL,
  `DataNaix` DATE NULL DEFAULT NULL,
  `Address` VARCHAR(60) NULL DEFAULT NULL,
  `Sex` VARCHAR(1) NULL DEFAULT NULL COMMENT '\'F\' = Female\\n\'H\' = Male',
  `Country` VARCHAR(45) NULL DEFAULT NULL,
  `Zip` VARCHAR(5) NULL DEFAULT NULL,
  `User_Type` VARCHAR(60) NULL DEFAULT NULL COMMENT '\'P\'=Premium\\n\'F\'=Free',
  PRIMARY KEY (`Id_USER`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spotify`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlist` (
  `Id_PLAYLIST` INT(11) NOT NULL,
  `Nom_Playlist` VARCHAR(60) NOT NULL,
  `DataCreacio` DATETIME NOT NULL,
  `Estat` VARCHAR(60) NOT NULL COMMENT '\'Activa\' OR \'Eliminada\'',
  `NumSongs` INT(11) NULL DEFAULT NULL,
  `USER_Id_USER` INT(11) NOT NULL,
  PRIMARY KEY (`Id_PLAYLIST`),
  INDEX `fk_PLAYLIST_USER1_idx` (`USER_Id_USER` ASC) VISIBLE,
  CONSTRAINT `fk_PLAYLIST_USER1`
    FOREIGN KEY (`USER_Id_USER`)
    REFERENCES `spotify`.`user` (`Id_USER`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spotify`.`activa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`activa` (
  `PLAYLIST_Id_PLAYLIST` INT(11) NOT NULL,
  PRIMARY KEY (`PLAYLIST_Id_PLAYLIST`),
  CONSTRAINT `fk_ACTIVA_PLAYLIST1`
    FOREIGN KEY (`PLAYLIST_Id_PLAYLIST`)
    REFERENCES `spotify`.`playlist` (`Id_PLAYLIST`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spotify`.`artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artista` (
  `Id_ARTISTA` INT(11) NOT NULL,
  `Nom` VARCHAR(60) NOT NULL,
  `Imatge` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`Id_ARTISTA`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spotify`.`album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`album` (
  `Id_ALBUM` INT(11) NOT NULL,
  `Nom_Album` VARCHAR(60) NOT NULL,
  `Any` YEAR(4) NULL DEFAULT NULL,
  `ImatgePortada` BLOB NULL DEFAULT NULL,
  `ARTISTA_Id_ARTISTA` INT(11) NOT NULL,
  PRIMARY KEY (`Id_ALBUM`),
  INDEX `fk_ALBUM_ARTISTA1_idx` (`ARTISTA_Id_ARTISTA` ASC) VISIBLE,
  CONSTRAINT `fk_ALBUM_ARTISTA1`
    FOREIGN KEY (`ARTISTA_Id_ARTISTA`)
    REFERENCES `spotify`.`artista` (`Id_ARTISTA`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spotify`.`artistes_relacionats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artistes_relacionats` (
  `Id_ARTISTA` INT(11) NOT NULL,
  `Id_ARTISTA_RELACIONAT` INT(11) NOT NULL,
  PRIMARY KEY (`Id_ARTISTA`, `Id_ARTISTA_RELACIONAT`),
  INDEX `fk_ARTISTA_has_ARTISTA_ARTISTA2_idx` (`Id_ARTISTA_RELACIONAT` ASC) VISIBLE,
  INDEX `fk_ARTISTA_has_ARTISTA_ARTISTA1_idx` (`Id_ARTISTA` ASC) VISIBLE,
  CONSTRAINT `fk_ARTISTA_has_ARTISTA_ARTISTA1`
    FOREIGN KEY (`Id_ARTISTA`)
    REFERENCES `spotify`.`artista` (`Id_ARTISTA`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ARTISTA_has_ARTISTA_ARTISTA2`
    FOREIGN KEY (`Id_ARTISTA_RELACIONAT`)
    REFERENCES `spotify`.`artista` (`Id_ARTISTA`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spotify`.`song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`song` (
  `Id_SONG` INT(11) NOT NULL,
  `ALBUM_Id_ALBUM` INT(11) NOT NULL,
  `Titol` VARCHAR(60) NOT NULL,
  `Durada` INT(11) NULL DEFAULT NULL,
  `numRepr` BIGINT(20) NULL DEFAULT NULL,
  PRIMARY KEY (`Id_SONG`),
  INDEX `fk_SONG_ALBUM1_idx` (`ALBUM_Id_ALBUM` ASC) VISIBLE,
  CONSTRAINT `fk_SONG_ALBUM1`
    FOREIGN KEY (`ALBUM_Id_ALBUM`)
    REFERENCES `spotify`.`album` (`Id_ALBUM`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spotify`.`compartida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`compartida` (
  `Id_Playlist_Compartida` INT(11) NOT NULL,
  PRIMARY KEY (`Id_Playlist_Compartida`),
  CONSTRAINT `fk_COMPARTIDA_ACTIVA1`
    FOREIGN KEY (`Id_Playlist_Compartida`)
    REFERENCES `spotify`.`activa` (`PLAYLIST_Id_PLAYLIST`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spotify`.`añade_cancion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`añade_cancion` (
  `USER_Id_USER` INT(11) NOT NULL,
  `COMPARTIDA_Id_Playlist_Compartida` INT(11) NOT NULL,
  `SONG_Id_SONG` INT(11) NOT NULL,
  `Data` DATETIME NOT NULL,
  PRIMARY KEY (`USER_Id_USER`, `COMPARTIDA_Id_Playlist_Compartida`, `SONG_Id_SONG`),
  INDEX `fk_USER_has_COMPARTIDA_COMPARTIDA1_idx` (`COMPARTIDA_Id_Playlist_Compartida` ASC) VISIBLE,
  INDEX `fk_USER_has_COMPARTIDA_USER1_idx` (`USER_Id_USER` ASC) VISIBLE,
  INDEX `fk_AÑADE_CANCION_SONG1_idx` (`SONG_Id_SONG` ASC) VISIBLE,
  CONSTRAINT `fk_AÑADE_CANCION_SONG1`
    FOREIGN KEY (`SONG_Id_SONG`)
    REFERENCES `spotify`.`song` (`Id_SONG`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_USER_has_COMPARTIDA_COMPARTIDA1`
    FOREIGN KEY (`COMPARTIDA_Id_Playlist_Compartida`)
    REFERENCES `spotify`.`compartida` (`Id_Playlist_Compartida`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_USER_has_COMPARTIDA_USER1`
    FOREIGN KEY (`USER_Id_USER`)
    REFERENCES `spotify`.`user` (`Id_USER`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spotify`.`eliminades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`eliminades` (
  `PLAYLIST_Id_PLAYLIST` INT(11) NOT NULL,
  `Data` DATETIME NOT NULL,
  PRIMARY KEY (`PLAYLIST_Id_PLAYLIST`),
  INDEX `fk_ELIMINADES_PLAYLIST1_idx` (`PLAYLIST_Id_PLAYLIST` ASC) VISIBLE,
  CONSTRAINT `fk_ELIMINADES_PLAYLIST1`
    FOREIGN KEY (`PLAYLIST_Id_PLAYLIST`)
    REFERENCES `spotify`.`playlist` (`Id_PLAYLIST`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spotify`.`pagament`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`pagament` (
  `Id_PAGAMENT` INT(11) NOT NULL,
  `Data` DATETIME NOT NULL,
  `Total` FLOAT NOT NULL,
  `USER_Id_USER` INT(11) NOT NULL,
  PRIMARY KEY (`Id_PAGAMENT`),
  INDEX `fk_PAGAMENT_USER1_idx` (`USER_Id_USER` ASC) VISIBLE,
  CONSTRAINT `fk_PAGAMENT_USER1`
    FOREIGN KEY (`USER_Id_USER`)
    REFERENCES `spotify`.`user` (`Id_USER`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spotify`.`paypal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`paypal` (
  `Id_PAYPAL` INT(11) NOT NULL,
  `Nom_compte` VARCHAR(60) NOT NULL,
  `USER_Id_USER` INT(11) NOT NULL,
  PRIMARY KEY (`Id_PAYPAL`, `USER_Id_USER`),
  INDEX `fk_PAYPAL_USER1_idx` (`USER_Id_USER` ASC) VISIBLE,
  CONSTRAINT `fk_PAYPAL_USER1`
    FOREIGN KEY (`USER_Id_USER`)
    REFERENCES `spotify`.`user` (`Id_USER`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spotify`.`privada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`privada` (
  `Id_Playlist_Privada` INT(11) NOT NULL,
  PRIMARY KEY (`Id_Playlist_Privada`),
  CONSTRAINT `fk_PRIVADA_ACTIVA1`
    FOREIGN KEY (`Id_Playlist_Privada`)
    REFERENCES `spotify`.`activa` (`PLAYLIST_Id_PLAYLIST`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spotify`.`servei_premiu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`servei_premiu` (
  `Id_SERVEI_PREMIU` INT(11) NOT NULL,
  `Data_Inici` DATETIME NOT NULL,
  `Data_Renovacio` DATETIME NOT NULL,
  `FormaPagament` VARCHAR(60) NULL DEFAULT NULL,
  `USER_Id_USER` INT(11) NOT NULL,
  PRIMARY KEY (`Id_SERVEI_PREMIU`),
  INDEX `fk_SERVEI_PREMIU_USER_idx` (`USER_Id_USER` ASC) VISIBLE,
  CONSTRAINT `fk_SERVEI_PREMIU_USER`
    FOREIGN KEY (`USER_Id_USER`)
    REFERENCES `spotify`.`user` (`Id_USER`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spotify`.`targeta_credit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`targeta_credit` (
  `Id_TARGETA_CREDIT` INT(11) NOT NULL,
  `Num_Targeta` VARCHAR(60) NOT NULL,
  `Data_Cad` DATETIME NOT NULL,
  `Cod_Seguretat` VARCHAR(3) NOT NULL,
  `USER_Id_USER` INT(11) NOT NULL,
  PRIMARY KEY (`Id_TARGETA_CREDIT`, `USER_Id_USER`),
  INDEX `fk_TARGETA_CREDIT_USER1_idx` (`USER_Id_USER` ASC) VISIBLE,
  CONSTRAINT `fk_TARGETA_CREDIT_USER1`
    FOREIGN KEY (`USER_Id_USER`)
    REFERENCES `spotify`.`user` (`Id_USER`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spotify`.`user_fav_album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`user_fav_album` (
  `USER_Id_USER` INT(11) NOT NULL,
  `ALBUM_Id_ALBUM` INT(11) NOT NULL,
  PRIMARY KEY (`USER_Id_USER`, `ALBUM_Id_ALBUM`),
  INDEX `fk_USER_has_ALBUM_ALBUM1_idx` (`ALBUM_Id_ALBUM` ASC) VISIBLE,
  INDEX `fk_USER_has_ALBUM_USER1_idx` (`USER_Id_USER` ASC) VISIBLE,
  CONSTRAINT `fk_USER_has_ALBUM_ALBUM1`
    FOREIGN KEY (`ALBUM_Id_ALBUM`)
    REFERENCES `spotify`.`album` (`Id_ALBUM`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_USER_has_ALBUM_USER1`
    FOREIGN KEY (`USER_Id_USER`)
    REFERENCES `spotify`.`user` (`Id_USER`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spotify`.`user_fav_song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`user_fav_song` (
  `USER_Id_USER` INT(11) NOT NULL,
  `SONG_Id_SONG` INT(11) NOT NULL,
  PRIMARY KEY (`USER_Id_USER`, `SONG_Id_SONG`),
  INDEX `fk_USER_has_SONG_SONG1_idx` (`SONG_Id_SONG` ASC) VISIBLE,
  INDEX `fk_USER_has_SONG_USER1_idx` (`USER_Id_USER` ASC) VISIBLE,
  CONSTRAINT `fk_USER_has_SONG_SONG1`
    FOREIGN KEY (`SONG_Id_SONG`)
    REFERENCES `spotify`.`song` (`Id_SONG`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_USER_has_SONG_USER1`
    FOREIGN KEY (`USER_Id_USER`)
    REFERENCES `spotify`.`user` (`Id_USER`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `spotify`.`user_follows_artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`user_follows_artista` (
  `USER_Id_USER` INT(11) NOT NULL,
  `ARTISTA_Id_ARTISTA` INT(11) NOT NULL,
  PRIMARY KEY (`USER_Id_USER`, `ARTISTA_Id_ARTISTA`),
  INDEX `fk_USER_has_ARTISTA_ARTISTA1_idx` (`ARTISTA_Id_ARTISTA` ASC) VISIBLE,
  INDEX `fk_USER_has_ARTISTA_USER1_idx` (`USER_Id_USER` ASC) VISIBLE,
  CONSTRAINT `fk_USER_has_ARTISTA_ARTISTA1`
    FOREIGN KEY (`ARTISTA_Id_ARTISTA`)
    REFERENCES `spotify`.`artista` (`Id_ARTISTA`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_USER_has_ARTISTA_USER1`
    FOREIGN KEY (`USER_Id_USER`)
    REFERENCES `spotify`.`user` (`Id_USER`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
