-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: pdv
-- ------------------------------------------------------
-- Server version	5.7.44-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `pedidosdadosgerais`
--

DROP TABLE IF EXISTS `pedidosdadosgerais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidosdadosgerais` (
  `Numero` int(11) NOT NULL AUTO_INCREMENT,
  `DataEmissao` datetime DEFAULT NULL,
  `CodCliente` int(11) DEFAULT NULL,
  `ValorTotal` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`Numero`),
  KEY `Codigo_idx` (`CodCliente`),
  CONSTRAINT `Codigo` FOREIGN KEY (`CodCliente`) REFERENCES `clientes` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidosdadosgerais`
--

LOCK TABLES `pedidosdadosgerais` WRITE;
/*!40000 ALTER TABLE `pedidosdadosgerais` DISABLE KEYS */;
INSERT INTO `pedidosdadosgerais` VALUES (2,NULL,1,NULL),(3,NULL,1,NULL),(4,NULL,1,NULL),(5,NULL,1,NULL),(6,NULL,1,NULL),(7,NULL,1,NULL),(8,NULL,1,NULL),(9,NULL,1,NULL),(10,NULL,1,NULL),(11,NULL,1,NULL),(12,NULL,1,NULL),(13,NULL,1,NULL),(18,NULL,1,NULL),(19,NULL,1,NULL),(21,NULL,1,NULL),(22,NULL,1,NULL),(23,NULL,1,NULL),(24,NULL,1,NULL),(25,NULL,1,NULL),(26,NULL,1,NULL),(27,NULL,1,NULL);
/*!40000 ALTER TABLE `pedidosdadosgerais` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-29 22:02:04