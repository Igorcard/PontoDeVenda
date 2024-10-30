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
-- Table structure for table `pedidosprodutos`
--

DROP TABLE IF EXISTS `pedidosprodutos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidosprodutos` (
  `Codigo` int(11) NOT NULL AUTO_INCREMENT,
  `NumeroPedido` int(11) DEFAULT NULL,
  `CodProduto` int(11) DEFAULT NULL,
  `Quantidade` decimal(18,2) DEFAULT NULL,
  `VlrUnitario` decimal(18,2) DEFAULT NULL,
  `VlrTotal` decimal(18,2) DEFAULT NULL,
  `Descricao` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `Codigo_idx` (`CodProduto`),
  KEY `CodigoPedido_idx` (`NumeroPedido`),
  CONSTRAINT `CodProduto` FOREIGN KEY (`CodProduto`) REFERENCES `produtos` (`Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Numero` FOREIGN KEY (`NumeroPedido`) REFERENCES `pedidosdadosgerais` (`Numero`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidosprodutos`
--

LOCK TABLES `pedidosprodutos` WRITE;
/*!40000 ALTER TABLE `pedidosprodutos` DISABLE KEYS */;
INSERT INTO `pedidosprodutos` VALUES (1,10,1,1.00,5.00,5.00,NULL),(2,12,1,1.00,5.00,5.00,'Maçã'),(3,13,19,5.00,45.95,229.75,'Alcatra'),(7,18,1,1.00,5.00,5.00,'Maçã'),(8,18,1,2.00,5.00,10.00,'Maçã'),(9,18,1,3.00,5.00,15.00,'Maçã'),(10,18,5,1.00,32.00,32.00,'Patinho'),(11,21,1,5.00,5.00,25.00,'Maçã'),(12,21,3,5.00,6.50,32.50,'Abacate'),(13,21,1,1.00,5.00,5.00,'Maçã'),(14,23,1,1.00,5.00,5.00,'Maçã'),(16,25,1,1.00,5.00,5.00,'Maçã'),(17,26,1,2.00,5.00,10.00,'Maçã');
/*!40000 ALTER TABLE `pedidosprodutos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-29 22:02:05
