/*
SQLyog Ultimate v9.63 
MySQL - 5.5.8-log : Database - db_turismo_proyecto
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_turismo_proyecto` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `db_turismo_proyecto`;

/*Table structure for table `adminsitioturistico` */

DROP TABLE IF EXISTS `adminsitioturistico`;

CREATE TABLE `adminsitioturistico` (
  `id_adminsitioturistico` int(128) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `id_sitioturistico` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_adminsitioturistico`),
  KEY `fk_id_Usuario` (`id_usuario`),
  KEY `fk_id_sitioturistico` (`id_sitioturistico`),
  CONSTRAINT `fk_id_Usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
  CONSTRAINT `fk_id_sitioturistico` FOREIGN KEY (`id_sitioturistico`) REFERENCES `sitioturistico` (`id_sitioturistico`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `adminsitioturistico` */

/*Table structure for table `alerta` */

DROP TABLE IF EXISTS `alerta`;

CREATE TABLE `alerta` (
  `id_Alerta` int(128) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) DEFAULT NULL,
  `id_Bitacora` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_Alerta`),
  KEY `fk_id_Bitacora` (`id_Bitacora`),
  CONSTRAINT `fk_id_Bitacora` FOREIGN KEY (`id_Bitacora`) REFERENCES `bitacora` (`id_Bitacora`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `alerta` */

/*Table structure for table `bitacora` */

DROP TABLE IF EXISTS `bitacora`;

CREATE TABLE `bitacora` (
  `id_Bitacora` int(128) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_Bitacora`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `bitacora` */

/*Table structure for table `hotel` */

DROP TABLE IF EXISTS `hotel`;

CREATE TABLE `hotel` (
  `id_hotel` int(128) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `id_tipohotel` int(128) DEFAULT NULL,
  PRIMARY KEY (`id_hotel`),
  KEY `fk_id_tipohotel` (`id_tipohotel`),
  CONSTRAINT `fk_id_tipohotel` FOREIGN KEY (`id_tipohotel`) REFERENCES `tipohotel` (`id_TipoHotel`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `hotel` */

/*Table structure for table `mapa` */

DROP TABLE IF EXISTS `mapa`;

CREATE TABLE `mapa` (
  `id_mapa` int(128) NOT NULL AUTO_INCREMENT,
  `ubicacion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_mapa`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `mapa` */

/*Table structure for table `restaurante` */

DROP TABLE IF EXISTS `restaurante`;

CREATE TABLE `restaurante` (
  `id_Restaurante` int(128) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_Restaurante`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `restaurante` */

/*Table structure for table `rol` */

DROP TABLE IF EXISTS `rol`;

CREATE TABLE `rol` (
  `id_Rol` int(128) NOT NULL AUTO_INCREMENT,
  `Rol` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_Rol`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `rol` */

/*Table structure for table `sitioturistico` */

DROP TABLE IF EXISTS `sitioturistico`;

CREATE TABLE `sitioturistico` (
  `id_sitioturistico` int(128) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `id_mapa` int(11) DEFAULT NULL,
  `id_hotel` int(11) DEFAULT NULL,
  `id_Restaurante` int(11) DEFAULT NULL,
  `id_Alerta` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_sitioturistico`),
  KEY `fk_id_Mapa` (`id_mapa`),
  KEY `fk_id_Hotel` (`id_hotel`),
  KEY `fk_id_Restaurante` (`id_Restaurante`),
  KEY `fk_id_Alerta` (`id_Alerta`),
  CONSTRAINT `fk_id_Mapa` FOREIGN KEY (`id_mapa`) REFERENCES `mapa` (`id_mapa`),
  CONSTRAINT `fk_id_Hotel` FOREIGN KEY (`id_hotel`) REFERENCES `hotel` (`id_hotel`),
  CONSTRAINT `fk_id_Restaurante` FOREIGN KEY (`id_Restaurante`) REFERENCES `restaurante` (`id_Restaurante`),
  CONSTRAINT `fk_id_Alerta` FOREIGN KEY (`id_Alerta`) REFERENCES `alerta` (`id_Alerta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `sitioturistico` */

/*Table structure for table `tipohotel` */

DROP TABLE IF EXISTS `tipohotel`;

CREATE TABLE `tipohotel` (
  `id_TipoHotel` int(128) NOT NULL AUTO_INCREMENT,
  `tipohotel` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_TipoHotel`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tipohotel` */

/*Table structure for table `usuario` */

DROP TABLE IF EXISTS `usuario`;

CREATE TABLE `usuario` (
  `id_usuario` int(128) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `correo` varchar(255) DEFAULT NULL,
  `contrasena` varchar(255) DEFAULT NULL,
  `id_Rol` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `fk_id_Rol` (`id_Rol`),
  CONSTRAINT `fk_id_Rol` FOREIGN KEY (`id_Rol`) REFERENCES `rol` (`id_Rol`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `usuario` */

/* Procedure structure for procedure `sp_autenticarUsuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_autenticarUsuario` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_autenticarUsuario`(IN _nick VARCHAR(128),IN _contrasena VARCHAR(128))
BEGIN
	SELECT nombre,correo,nick FROM usuario WHERE usuario.`nick`=_nick AND usuario.`contraseña`=MD5(_contrasena);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_registroUsuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_registroUsuario` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registroUsuario`(IN _nombre VARCHAR(128),IN _correo VARCHAR(128),IN _nick VARCHAR(128),_contraseña VARCHAR(128))
BEGIN
	INSERT INTO usuario VALUES(NULL,_nombre,_correo,_nick,MD5(_contraseña));
    END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
