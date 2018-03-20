SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema proyectoArduino
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `proyectoArduino`;
-- -----------------------------------------------------
-- Schema proyectoArduino
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `proyectoArduino` DEFAULT CHARACTER SET utf8 ;
USE `proyectoArduino` ;

-- -----------------------------------------------------
-- Table `proyectoArduino`.`ARTICULO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyectoArduino`.`ARTICULO` ;

CREATE TABLE IF NOT EXISTS `proyectoArduino`.`ARTICULO` (
  `codArt` INT NOT NULL,
  `descArt` VARCHAR(80) NOT NULL,
  `precArt` DOUBLE NOT NULL,
  `imgArt` VARCHAR(50) NULL,
  PRIMARY KEY (`codArt`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyectoArduino`.`PROYECTO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyectoArduino`.`PROYECTO` ;

CREATE TABLE IF NOT EXISTS `proyectoArduino`.`PROYECTO` (
  `codPro` INT NOT NULL,
  `nomPro` VARCHAR(80) NOT NULL,
  `descPro` TEXT NOT NULL,
  `fecEntrega` DATE NOT NULL,
  PRIMARY KEY (`codPro`),
  UNIQUE INDEX `codPro_UNIQUE` (`codPro` ASC))
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `proyectoArduino`.`ART_PRO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyectoArduino`.`ART_PRO` ;

CREATE TABLE IF NOT EXISTS `proyectoArduino`.`ART_PRO` (
  `codArt` INT NOT NULL,
  `codPro` INT NOT NULL,
  `cantidad` INT NOT NULL,
  INDEX `fk_ART_PRO_ARTICULO1_idx` (`codArt` ASC),
  PRIMARY KEY (`codArt`, `codPro`),
  INDEX `fk_ART_PRO_PROYECTO1_idx` (`codPro` ASC),
  CONSTRAINT `fk_ART_PRO_ARTICULO1`
    FOREIGN KEY (`codArt`)
    REFERENCES `proyectoArduino`.`ARTICULO` (`codArt`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ART_PRO_PROYECTO1`
    FOREIGN KEY (`codPro`)
    REFERENCES `proyectoArduino`.`PROYECTO` (`codPro`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- -----------------------------------------------------
-- INSERTANDO DATOS EN ARTICULO
-- -----------------------------------------------------
INSERT INTO `articulo` (`codArt`, `descArt`, `precArt`, `imgArt`) VALUES 
(1, 'Modulo de alimentación', '8.99', NULL),
(2, 'Protoboard 830 pines', '2.32', NULL),
(3, 'Zumbador activo (Buzzer)', '1.60', NULL),
(4, 'Zumbador pasivo (Buzzer)', '1.60', NULL),
(5, 'Potenciómetro de precisión', '2.09', NULL),
(6, 'Diodo rectificador (1N4007)', '0.99', NULL),
(7, 'Transistor NPN (PN2222)', '0.10', NULL),
(8, 'Fotoresistencia (LDR)', '1.90', NULL),
(9, 'LED RGB', '2.22', NULL),
(10, 'Piezoeléctrico', '0.99', NULL),
(11, 'Resistencia(220R)', '0.59', NULL),
(12, 'Resistencia(100R)', '0.59', NULL),
(13, 'Botones (pequeños)', '0.20', NULL),
(14, 'LED Blanco', '0.8', NULL),
(15, 'LED Amarillo', '0.8', NULL),
(16, 'LED Azul', '0.8', NULL),
(17, 'LED Verde', '0.8', NULL),
(18, 'LED Rojo', '0.8', NULL),
(19, 'Módulo ultrasónico hc-SR04', '1.34', NULL);


-- -----------------------------------------------------
-- INSERTANDO DATOS EN PROYECTO
-- -----------------------------------------------------
INSERT INTO `proyecto` (`codPro`, `nomPro`, `descPro`, `fecEntrega`) VALUES 
(1, 'Sensor aparcacoches', 'Simula el sistema de proximidad de un coche', '2018-03-31'),
(2, 'Semáforo inteligente', 'Semáforo que cambia de color con un objeto cerca', '2018-05-01'),
(3, 'Theremín', 'Simula un Theremín', '2018-04-17'),
(4, 'Transmisor morse', 'Simula un transmisor de código Morse', '2018-04-25');


-- -----------------------------------------------------
-- INSERTANDO DATOS EN ART_PRO
-- -----------------------------------------------------
INSERT INTO `art_pro` (`codArt`, `codPro`, `cantidad`) VALUES 
 ('11', '1', '3'),
 ('12', '1', '1'),
 ('17', '1', '1'),
 ('18', '1', '1'),
 ('15', '1', '1'),
 ('11', '2', '3'),
 ('12', '2', '1'),
 ('17', '2', '1'),
 ('18', '2', '1'),
 ('15', '2', '1'),
 ('10', '2', '1'),
 ('19', '2', '1'),
 ('10', '3', '1'),
 ('8', '3', '1'),
 ('11', '4', '1'),
 ('17', '4', '1');


