-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: miapp
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alertas_b2b`
--

DROP TABLE IF EXISTS `alertas_b2b`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alertas_b2b` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `rol_destino` varchar(50) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `referencia_tipo` varchar(50) DEFAULT NULL,
  `referencia_id` int(11) DEFAULT NULL,
  `titulo` varchar(200) NOT NULL,
  `mensaje` text DEFAULT NULL,
  `leida` tinyint(1) DEFAULT 0,
  `activa` tinyint(1) DEFAULT 1,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_lectura` datetime DEFAULT NULL,
  `fecha_cierre` datetime DEFAULT NULL,
  `whatsapp_enviado` tinyint(1) DEFAULT 0,
  `whatsapp_fecha` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_empresa` (`empresa_id`),
  KEY `idx_usuario` (`usuario_id`),
  KEY `idx_rol` (`rol_destino`),
  KEY `idx_activa` (`activa`),
  KEY `idx_referencia` (`referencia_tipo`,`referencia_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alertas_b2b`
--

LOCK TABLES `alertas_b2b` WRITE;
/*!40000 ALTER TABLE `alertas_b2b` DISABLE KEYS */;
/*!40000 ALTER TABLE `alertas_b2b` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `almacenes`
--

DROP TABLE IF EXISTS `almacenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `almacenes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `codigo` varchar(20) DEFAULT NULL,
  `tipo` enum('bodega','cuarto_frio','area_produccion','otro') DEFAULT 'bodega',
  `ancho_metros` decimal(6,2) DEFAULT NULL,
  `largo_metros` decimal(6,2) DEFAULT NULL,
  `alto_metros` decimal(6,2) DEFAULT NULL,
  `tamano_cuadrante` decimal(6,2) DEFAULT 1.00,
  `descripcion` text DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_empresa` (`empresa_id`),
  CONSTRAINT `almacenes_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `almacenes`
--

LOCK TABLES `almacenes` WRITE;
/*!40000 ALTER TABLE `almacenes` DISABLE KEYS */;
INSERT INTO `almacenes` VALUES (1,10,'Bodega Cines','BODCINES','bodega',3.00,3.00,3.00,1.00,'bODEGA',1,'2026-01-11 04:35:13');
/*!40000 ALTER TABLE `almacenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `almacenes_elementos`
--

DROP TABLE IF EXISTS `almacenes_elementos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `almacenes_elementos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `almacen_id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `tipo` enum('mesa','repisa','rack','refrigerador','congelador','estanteria','pallet','otro') NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `codigo` varchar(20) DEFAULT NULL,
  `ancho_metros` decimal(6,2) DEFAULT NULL,
  `largo_metros` decimal(6,2) DEFAULT NULL,
  `alto_metros` decimal(6,2) DEFAULT NULL,
  `posicion_x` decimal(6,2) DEFAULT 0.00,
  `posicion_y` decimal(6,2) DEFAULT 0.00,
  `cuadrante_fila` char(1) DEFAULT NULL,
  `cuadrante_columna` int(11) DEFAULT NULL,
  `cuadrante_codigo` varchar(100) DEFAULT NULL,
  `numero_niveles` int(11) DEFAULT 1,
  `compartimentos_por_nivel` int(11) DEFAULT 1,
  `color_hex` varchar(7) DEFAULT '#3498db',
  `notas` text DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `empresa_id` (`empresa_id`),
  KEY `idx_almacen` (`almacen_id`),
  CONSTRAINT `almacenes_elementos_ibfk_1` FOREIGN KEY (`almacen_id`) REFERENCES `almacenes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `almacenes_elementos_ibfk_2` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `almacenes_elementos`
--

LOCK TABLES `almacenes_elementos` WRITE;
/*!40000 ALTER TABLE `almacenes_elementos` DISABLE KEYS */;
INSERT INTO `almacenes_elementos` VALUES (1,1,10,'rack','Rack Ventana principal','RACK001',2.50,0.60,1.50,0.00,0.00,'A',1,'A1,A2',2,3,'#4733db',NULL,1,'2026-01-11 05:09:56'),(2,1,10,'repisa','REPISA EN MESA','REPISA02',1.00,0.40,1.90,1.00,2.00,'C',2,'C2',4,1,'#3498db',NULL,1,'2026-01-11 05:16:44'),(3,1,10,'refrigerador','REFRI BLANCO','REFRI',0.80,0.80,1.70,0.00,1.00,'B',1,'B1',5,1,'#f4f5f6',NULL,1,'2026-01-12 12:41:29');
/*!40000 ALTER TABLE `almacenes_elementos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `areas_produccion`
--

DROP TABLE IF EXISTS `areas_produccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `areas_produccion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `empresa_id` (`empresa_id`),
  CONSTRAINT `areas_produccion_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areas_produccion`
--

LOCK TABLES `areas_produccion` WRITE;
/*!40000 ALTER TABLE `areas_produccion` DISABLE KEYS */;
INSERT INTO `areas_produccion` VALUES (11,1,'Produccion','Area de manufactura y ensamble',1,'2025-12-19 20:02:46'),(12,1,'Almacen','Control de inventarios y materias primas',1,'2025-12-19 20:02:46'),(13,1,'Ventas','Gestion de ventas y facturacion',1,'2025-12-19 20:02:46'),(14,1,'Compras','Adquisicion de materiales y proveedores',1,'2025-12-19 20:02:46'),(15,1,'Calidad','Control de calidad y certificaciones',1,'2025-12-19 20:02:46'),(16,10,'Reembalaje',NULL,1,'2026-01-26 07:53:42'),(17,10,'Etiquetado',NULL,1,'2026-01-26 07:53:52'),(18,10,'Corte',NULL,1,'2026-01-26 07:54:31'),(19,10,'Mezclado - Batido ',NULL,1,'2026-01-26 07:55:39'),(20,10,'Trituración',NULL,1,'2026-01-26 07:56:00'),(21,10,'Envasado - Empaquetado',NULL,1,'2026-01-26 07:56:45'),(22,10,'Almacenamiento',NULL,1,'2026-01-26 07:59:34'),(23,10,'Coccion - Horno, Freidora, Estufa',NULL,1,'2026-01-26 08:02:59'),(24,10,'Cobertura',NULL,1,'2026-01-26 08:07:53'),(25,10,'Cuarto frio',NULL,1,'2026-04-09 17:52:02');
/*!40000 ALTER TABLE `areas_produccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `areas_sistema`
--

DROP TABLE IF EXISTS `areas_sistema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `areas_sistema` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) DEFAULT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `modulo_relacionado` varchar(50) DEFAULT NULL,
  `icono` varchar(50) DEFAULT 'fas fa-folder',
  `color` varchar(20) DEFAULT '#6c757d',
  `requiere_supervisor` tinyint(1) DEFAULT 1,
  `orden` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areas_sistema`
--

LOCK TABLES `areas_sistema` WRITE;
/*!40000 ALTER TABLE `areas_sistema` DISABLE KEYS */;
INSERT INTO `areas_sistema` VALUES (1,1,'VENTAS','Ventas / Punto de Venta','Gestión de ventas, caja y atención al cliente',1,'2025-12-11 17:39:09','ventas','fas fa-cash-register','#28a745',1,1),(2,1,'INVENTARIO','Almacén / Inventario','Control de mercancía, entradas, salidas y existencias',1,'2025-12-11 17:39:09','inventario','fas fa-boxes','#ffc107',1,2),(3,1,'COMPRAS','Compras','Órdenes de compra y relación con proveedores',1,'2025-12-11 17:39:09','compras','fas fa-shopping-cart','#17a2b8',1,3),(4,1,'CAJA','Caja y Tesorería','Manejo de efectivo, cortes y flujo de caja',1,'2025-12-11 17:39:09','caja','fas fa-money-bill-wave','#20c997',1,4),(5,1,'CXC','Cuentas por Cobrar','Cartera de clientes y cobranza',1,'2025-12-11 17:39:09','cxc','fas fa-hand-holding-usd','#28a745',1,5),(6,1,'CXP','Cuentas por Pagar','Deudas con proveedores y programación de pagos',1,'2025-12-11 17:39:09','cxp','fas fa-file-invoice-dollar','#dc3545',1,6),(7,1,'CONTABILIDAD','Contabilidad','Registros contables, pólizas y estados financieros',1,'2025-12-11 17:39:09','contabilidad','fas fa-calculator','#6f42c1',1,7),(8,1,'RRHH','Recursos Humanos','Gestión de personal, nómina y prestaciones',1,'2025-12-11 17:39:09','nomina','fas fa-users','#e83e8c',1,8),(9,1,'GASTOS','Control de Gastos','Registro y autorización de gastos operativos',1,'2025-12-11 17:39:09','gastos','fas fa-receipt','#fd7e14',1,9),(10,1,'B2B_CLIENTE','B2B Como Cliente','Órdenes de compra y recepción de mercancía B2B',1,'2025-12-11 17:39:09','b2b','fas fa-building','#007bff',1,10),(11,1,'B2B_PROVEEDOR','B2B Como Proveedor','Pedidos, facturación y entregas B2B',1,'2025-12-11 17:39:09','b2b','fas fa-industry','#6610f2',1,11),(12,1,'REPARTO','Logística y Reparto','Entregas, rutas y distribución',1,'2025-12-11 17:39:09','reparto','fas fa-truck','#795548',1,12),(13,1,'ADMINISTRACION','Administración General','Supervisión general y toma de decisiones',1,'2025-12-11 17:39:09','admin','fas fa-cogs','#343a40',1,13),(14,1,'REPORTES','Reportes y Análisis','Generación de reportes y análisis de datos',1,'2025-12-11 17:39:09','reportes','fas fa-chart-bar','#17a2b8',1,14),(15,1,'AUDITORIA','Auditoría','Revisión de operaciones y cumplimiento',1,'2025-12-11 17:39:09','auditoria','fas fa-search','#6c757d',1,15),(24,10,'VENTAS','Ventas / Punto de Venta','Gestión de ventas, caja y atención al cliente',1,'2026-01-07 06:23:15','ventas','fas fa-cash-register','#28a745',1,1),(25,10,'INVENTARIO','Almacén / Inventario','Control de mercancía, entradas, salidas y existencias',1,'2026-01-07 06:23:15','inventario','fas fa-boxes','#ffc107',1,2),(26,10,'COMPRAS','Compras','Órdenes de compra y relación con proveedores',1,'2026-01-07 06:23:15','compras','fas fa-shopping-cart','#17a2b8',1,3),(27,10,'CAJA','Caja y Tesorería','Manejo de efectivo, cortes y flujo de caja',1,'2026-01-07 06:23:15','caja','fas fa-money-bill-wave','#20c997',1,4),(28,10,'CXC','Cuentas por Cobrar','Cartera de clientes y cobranza',1,'2026-01-07 06:23:15','cxc','fas fa-hand-holding-usd','#28a745',1,5),(29,10,'CXP','Cuentas por Pagar','Deudas con proveedores y programación de pagos',1,'2026-01-07 06:23:15','cxp','fas fa-file-invoice-dollar','#dc3545',1,6),(30,10,'CONTABILIDAD','Contabilidad','Registros contables, pólizas y estados financieros',1,'2026-01-07 06:23:15','contabilidad','fas fa-calculator','#6f42c1',1,7),(31,10,'RRHH','Recursos Humanos','Gestión de personal, nómina y prestaciones',1,'2026-01-07 06:23:15','nomina','fas fa-users','#e83e8c',1,8),(32,10,'GASTOS','Control de Gastos','Registro y autorización de gastos operativos',1,'2026-01-07 06:23:15','gastos','fas fa-receipt','#fd7e14',1,9),(33,10,'B2B_CLIENTE','B2B Como Cliente','Órdenes de compra y recepción de mercancía B2B',1,'2026-01-07 06:23:15','b2b','fas fa-building','#007bff',1,10),(34,10,'B2B_PROVEEDOR','B2B Como Proveedor','Pedidos, facturación y entregas B2B',1,'2026-01-07 06:23:15','b2b','fas fa-industry','#6610f2',1,11),(35,10,'REPARTO','Logística y Reparto','Entregas, rutas y distribución',1,'2026-01-07 06:23:15','reparto','fas fa-truck','#795548',1,12),(36,10,'ADMINISTRACION','Administración General','Supervisión general y toma de decisiones',1,'2026-01-07 06:23:15','admin','fas fa-cogs','#343a40',1,13),(37,10,'REPORTES','Reportes y Análisis','Generación de reportes y análisis de datos',1,'2026-01-07 06:23:15','reportes','fas fa-chart-bar','#17a2b8',1,14),(38,10,'AUDITORIA','Auditoría','Revisión de operaciones y cumplimiento',1,'2026-01-07 06:23:15','auditoria','fas fa-search','#6c757d',1,15);
/*!40000 ALTER TABLE `areas_sistema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asientos_detalle`
--

DROP TABLE IF EXISTS `asientos_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asientos_detalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asiento_id` int(11) NOT NULL,
  `cuenta_id` int(11) NOT NULL,
  `debe` decimal(12,2) DEFAULT 0.00,
  `haber` decimal(12,2) DEFAULT 0.00,
  `empresa_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `asiento_id` (`asiento_id`),
  KEY `cuenta_id` (`cuenta_id`),
  CONSTRAINT `asientos_detalle_ibfk_1` FOREIGN KEY (`asiento_id`) REFERENCES `asientos_contables` (`id`),
  CONSTRAINT `asientos_detalle_ibfk_2` FOREIGN KEY (`cuenta_id`) REFERENCES `cuentas_contables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asientos_detalle`
--

LOCK TABLES `asientos_detalle` WRITE;
/*!40000 ALTER TABLE `asientos_detalle` DISABLE KEYS */;
INSERT INTO `asientos_detalle` VALUES (1,3,10,34.00,0.00,NULL),(2,3,30,0.00,34.00,NULL),(3,4,10,1990.00,0.00,NULL),(4,4,30,0.00,1990.00,NULL),(5,5,10,379.80,0.00,NULL),(6,5,30,0.00,379.80,NULL),(7,6,10,212.00,0.00,NULL),(8,6,30,0.00,212.00,NULL),(9,7,10,212.00,0.00,NULL),(10,7,30,0.00,212.00,NULL),(11,8,10,212.00,0.00,NULL),(12,8,30,0.00,212.00,NULL),(13,9,10,51.00,0.00,NULL),(14,9,30,0.00,51.00,NULL),(15,10,10,212.00,0.00,NULL),(16,10,30,0.00,212.00,NULL),(17,11,10,0.00,0.00,NULL),(18,11,30,0.00,0.00,NULL),(19,12,10,384.26,0.00,NULL),(20,12,30,0.00,384.26,NULL),(21,13,10,584.26,0.00,NULL),(22,13,30,0.00,584.26,NULL),(23,14,10,615.00,0.00,NULL),(24,14,30,0.00,615.00,NULL),(25,15,10,615.00,0.00,NULL),(26,15,30,0.00,615.00,NULL),(27,16,10,615.00,0.00,NULL),(28,16,30,0.00,615.00,NULL),(29,17,10,212.00,0.00,NULL),(30,17,30,0.00,212.00,NULL),(31,18,10,615.00,0.00,NULL),(32,18,30,0.00,615.00,NULL),(43,24,10,1368.80,0.00,NULL),(44,24,30,0.00,1368.80,NULL),(45,25,10,1368.80,0.00,NULL),(46,25,30,0.00,1368.80,NULL),(47,26,10,1368.80,0.00,NULL),(48,26,30,0.00,1368.80,NULL),(49,27,10,1368.80,0.00,NULL),(50,27,30,0.00,1368.80,NULL);
/*!40000 ALTER TABLE `asientos_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caja_botones`
--

DROP TABLE IF EXISTS `caja_botones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caja_botones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `caja_id` int(11) NOT NULL,
  `fila` int(11) NOT NULL,
  `columna` int(11) NOT NULL,
  `etiqueta` varchar(50) NOT NULL,
  `color` varchar(20) DEFAULT NULL,
  `tipo` enum('producto','combo','categoria') NOT NULL DEFAULT 'producto',
  `producto_id` int(11) DEFAULT NULL,
  `combo_id` int(11) DEFAULT NULL,
  `categoria_id` int(11) DEFAULT NULL,
  `empresa_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caja_botones`
--

LOCK TABLES `caja_botones` WRITE;
/*!40000 ALTER TABLE `caja_botones` DISABLE KEYS */;
/*!40000 ALTER TABLE `caja_botones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caja_ventas`
--

DROP TABLE IF EXISTS `caja_ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caja_ventas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) DEFAULT NULL,
  `turno_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `folio` varchar(50) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `subtotal` decimal(12,2) DEFAULT 0.00,
  `iva` decimal(12,2) DEFAULT 0.00,
  `total` decimal(12,2) DEFAULT 0.00,
  `metodo_pago` varchar(50) DEFAULT 'efectivo',
  `estado` varchar(20) DEFAULT 'completada',
  `cliente_nombre` varchar(200) DEFAULT NULL,
  `notas` text DEFAULT NULL,
  `efectivo_recibido` decimal(12,2) DEFAULT 0.00,
  `cambio` decimal(12,2) DEFAULT 0.00,
  `descuento` decimal(12,2) DEFAULT 0.00,
  `cancelada` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `turno_id` (`turno_id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `caja_ventas_ibfk_1` FOREIGN KEY (`turno_id`) REFERENCES `turnos` (`id`),
  CONSTRAINT `caja_ventas_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caja_ventas`
--

LOCK TABLES `caja_ventas` WRITE;
/*!40000 ALTER TABLE `caja_ventas` DISABLE KEYS */;
INSERT INTO `caja_ventas` VALUES (5,1,NULL,13,NULL,'2025-12-04 21:08:44',0.00,0.00,1941.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(6,12,NULL,9,NULL,'2026-02-04 21:18:39',0.00,0.00,555.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(7,12,NULL,9,NULL,'2026-02-04 21:19:07',0.00,0.00,375.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(8,12,NULL,9,NULL,'2026-02-04 21:26:44',0.00,0.00,136.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(9,12,NULL,9,NULL,'2026-02-10 14:23:07',0.00,0.00,15.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(10,12,NULL,9,NULL,'2026-02-10 15:03:56',0.00,0.00,54.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(11,12,NULL,9,NULL,'2026-02-10 15:07:51',0.00,0.00,42.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(12,12,NULL,9,NULL,'2026-02-10 15:11:56',0.00,0.00,109.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(13,12,NULL,9,NULL,'2026-02-10 15:13:11',0.00,0.00,80.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(14,12,NULL,9,NULL,'2026-02-10 15:14:42',0.00,0.00,15.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(15,12,NULL,9,NULL,'2026-02-10 15:22:05',0.00,0.00,65.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(16,12,NULL,9,NULL,'2026-02-10 15:25:10',0.00,0.00,30.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(17,12,NULL,9,NULL,'2026-02-10 15:27:52',0.00,0.00,15.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(18,12,NULL,9,NULL,'2026-02-10 15:42:59',0.00,0.00,30.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(19,12,NULL,9,NULL,'2026-02-10 15:48:04',0.00,0.00,66.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(20,12,NULL,9,NULL,'2026-02-10 15:55:00',0.00,0.00,45.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(21,12,NULL,9,NULL,'2026-02-10 16:17:46',0.00,0.00,72.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(22,12,NULL,9,NULL,'2026-02-10 16:20:30',0.00,0.00,30.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(23,12,NULL,9,NULL,'2026-02-10 16:29:42',0.00,0.00,15.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(24,12,NULL,9,NULL,'2026-02-10 16:48:59',0.00,0.00,15.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(25,12,NULL,9,NULL,'2026-02-10 17:09:40',0.00,0.00,30.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0),(26,12,NULL,9,NULL,'2026-04-04 21:01:56',0.00,0.00,276.00,'efectivo','completada',NULL,NULL,0.00,0.00,0.00,0);
/*!40000 ALTER TABLE `caja_ventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caja_ventas_detalle`
--

DROP TABLE IF EXISTS `caja_ventas_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caja_ventas_detalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) DEFAULT NULL,
  `venta_id` int(11) DEFAULT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `mercancia_id` int(11) DEFAULT NULL,
  `cantidad` decimal(10,3) DEFAULT 1.000,
  `precio_unitario` decimal(12,2) DEFAULT 0.00,
  `subtotal` decimal(12,2) DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `venta_id` (`venta_id`),
  CONSTRAINT `caja_ventas_detalle_ibfk_1` FOREIGN KEY (`venta_id`) REFERENCES `caja_ventas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caja_ventas_detalle`
--

LOCK TABLES `caja_ventas_detalle` WRITE;
/*!40000 ALTER TABLE `caja_ventas_detalle` DISABLE KEYS */;
INSERT INTO `caja_ventas_detalle` VALUES (1,1,5,NULL,66,2.000,68.00,136.00),(2,1,5,NULL,64,3.000,68.00,204.00),(3,1,5,NULL,55,25.000,15.00,375.00),(4,1,5,NULL,56,27.000,18.00,486.00),(5,1,5,NULL,57,10.000,16.00,160.00),(6,1,5,NULL,58,7.000,27.00,189.00),(7,1,5,NULL,59,1.000,42.00,42.00),(8,1,5,NULL,60,1.000,65.00,65.00),(9,1,5,NULL,61,2.000,22.00,44.00),(10,1,5,NULL,62,1.000,8.00,8.00),(11,1,5,NULL,63,4.000,58.00,232.00),(12,12,6,NULL,146,25.000,15.00,375.00),(13,12,6,NULL,147,10.000,18.00,180.00),(14,12,7,NULL,146,25.000,15.00,375.00),(15,12,8,NULL,155,2.000,68.00,136.00),(16,12,9,NULL,146,1.000,15.00,15.00),(17,12,10,NULL,148,1.000,27.00,27.00),(18,12,10,NULL,148,1.000,27.00,27.00),(19,12,11,NULL,148,1.000,27.00,27.00),(20,12,11,NULL,146,1.000,15.00,15.00),(21,12,12,NULL,147,1.000,18.00,18.00),(22,12,12,NULL,147,1.000,18.00,18.00),(23,12,12,NULL,146,1.000,15.00,15.00),(24,12,12,NULL,154,1.000,58.00,58.00),(25,12,13,NULL,151,1.000,65.00,65.00),(26,12,13,NULL,146,1.000,15.00,15.00),(27,12,14,NULL,146,1.000,15.00,15.00),(28,12,15,NULL,151,1.000,65.00,65.00),(29,12,16,NULL,146,1.000,15.00,15.00),(30,12,16,NULL,146,1.000,15.00,15.00),(31,12,17,NULL,146,1.000,15.00,15.00),(32,12,18,NULL,146,1.000,15.00,15.00),(33,12,18,NULL,146,1.000,15.00,15.00),(34,12,19,NULL,147,1.000,18.00,18.00),(35,12,19,NULL,147,1.000,18.00,18.00),(36,12,19,NULL,146,2.000,15.00,30.00),(37,12,20,NULL,146,3.000,15.00,45.00),(38,12,21,NULL,150,1.000,42.00,42.00),(39,12,21,NULL,146,1.000,15.00,15.00),(40,12,21,NULL,146,1.000,15.00,15.00),(41,12,22,NULL,146,2.000,15.00,30.00),(42,12,23,NULL,146,1.000,15.00,15.00),(43,12,24,NULL,146,1.000,15.00,15.00),(44,12,25,NULL,146,1.000,15.00,15.00),(45,12,25,NULL,146,1.000,15.00,15.00),(46,12,26,NULL,150,1.000,46.00,46.00),(47,12,26,NULL,150,1.000,46.00,46.00),(48,12,26,NULL,154,1.000,62.00,62.00),(49,12,26,NULL,148,1.000,30.00,30.00),(50,12,26,NULL,146,1.000,18.00,18.00),(51,12,26,NULL,156,1.000,74.00,74.00);
/*!40000 ALTER TABLE `caja_ventas_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cajas`
--

DROP TABLE IF EXISTS `cajas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cajas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `sucursal_id` int(11) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cajas`
--

LOCK TABLES `cajas` WRITE;
/*!40000 ALTER TABLE `cajas` DISABLE KEYS */;
INSERT INTO `cajas` VALUES (1,1,'Caja principal',NULL,1),(2,1,'Caja Principal',NULL,1);
/*!40000 ALTER TABLE `cajas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_inventario`
--

DROP TABLE IF EXISTS `catalogo_inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogo_inventario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `tipo` enum('MP','WIP','PT') DEFAULT 'MP',
  `activo` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `empresa_id` (`empresa_id`),
  CONSTRAINT `catalogo_inventario_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_inventario`
--

LOCK TABLES `catalogo_inventario` WRITE;
/*!40000 ALTER TABLE `catalogo_inventario` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalogo_inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_modulos`
--

DROP TABLE IF EXISTS `catalogo_modulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogo_modulos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio_mensual` decimal(10,2) NOT NULL DEFAULT 0.00,
  `precio_anual` decimal(10,2) NOT NULL DEFAULT 0.00,
  `activo` tinyint(1) DEFAULT 1,
  `orden` int(11) DEFAULT 0,
  `icono` varchar(50) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `idx_codigo` (`codigo`),
  KEY `idx_activo` (`activo`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_modulos`
--

LOCK TABLES `catalogo_modulos` WRITE;
/*!40000 ALTER TABLE `catalogo_modulos` DISABLE KEYS */;
INSERT INTO `catalogo_modulos` VALUES (1,'VENTAS','Ventas','Gesti?n completa de ventas y cotizaciones',299.00,2990.00,1,1,'shopping-cart','#10b981'),(2,'COMPRAS','Compras','Control de compras y proveedores',299.00,2990.00,1,2,'shopping-bag','#3b82f6'),(3,'INVENTARIO','Inventario','Control de inventarios y almacenes',399.00,3990.00,1,3,'package','#8b5cf6'),(4,'CONTABILIDAD','Contabilidad','Contabilidad y finanzas',499.00,4990.00,1,4,'calculator','#f59e0b'),(5,'NOMINA','N?mina','Gesti?n de n?mina y RRHH',599.00,5990.00,1,5,'users','#ef4444'),(6,'CRM','CRM','Gesti?n de relaciones con clientes',399.00,3990.00,1,6,'user-check','#06b6d4'),(7,'PRODUCCION','Producci?n','Control de producci?n y manufactura',499.00,4990.00,1,7,'settings','#6366f1'),(8,'PROYECTOS','Proyectos','Gesti?n de proyectos',399.00,3990.00,1,8,'briefcase','#ec4899');
/*!40000 ALTER TABLE `catalogo_modulos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogo_mp`
--

DROP TABLE IF EXISTS `catalogo_mp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogo_mp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `unidad_id` int(11) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `empresa_id` (`empresa_id`),
  CONSTRAINT `catalogo_mp_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_mp`
--

LOCK TABLES `catalogo_mp` WRITE;
/*!40000 ALTER TABLE `catalogo_mp` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalogo_mp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cfdi_importados_detalle`
--

DROP TABLE IF EXISTS `cfdi_importados_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfdi_importados_detalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cfdi_id` int(11) NOT NULL,
  `clave_prod_serv` varchar(20) DEFAULT NULL,
  `clave_unidad` varchar(10) DEFAULT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `cantidad` decimal(12,3) NOT NULL,
  `valor_unitario` decimal(12,4) NOT NULL,
  `descuento` decimal(12,2) DEFAULT 0.00,
  `importe` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cfdi_id` (`cfdi_id`),
  CONSTRAINT `cfdi_importados_detalle_ibfk_1` FOREIGN KEY (`cfdi_id`) REFERENCES `cfdi_importados` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cfdi_importados_detalle`
--

LOCK TABLES `cfdi_importados_detalle` WRITE;
/*!40000 ALTER TABLE `cfdi_importados_detalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `cfdi_importados_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras`
--

DROP TABLE IF EXISTS `compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contratante_id` int(11) NOT NULL,
  `empresa_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `proveedor_id` int(11) DEFAULT NULL,
  `proveedor` varchar(255) DEFAULT NULL,
  `numero_factura` varchar(50) DEFAULT NULL,
  `subtotal` decimal(12,2) DEFAULT 0.00,
  `iva` decimal(12,2) DEFAULT 0.00,
  `ieps` decimal(12,2) DEFAULT 0.00,
  `total` decimal(10,2) DEFAULT NULL,
  `forma_pago` varchar(30) DEFAULT 'credito',
  `tipo_cambio` decimal(10,4) DEFAULT 1.0000,
  `estado` enum('pendiente','en_recepcion','recibida','cancelada') DEFAULT 'pendiente',
  `notas` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_compra_contratante` (`contratante_id`),
  KEY `idx_empresa` (`empresa_id`),
  KEY `idx_usuario` (`usuario_id`),
  KEY `idx_proveedor` (`proveedor_id`),
  KEY `idx_estado` (`estado`),
  CONSTRAINT `fk_compra_contratante` FOREIGN KEY (`contratante_id`) REFERENCES `contratantes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras`
--

LOCK TABLES `compras` WRITE;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
INSERT INTO `compras` VALUES (4,9,10,34,'2025-12-03',7,'DEL RIO','83254',42.00,0.00,0.00,42.00,'credito',1.0000,'pendiente',''),(5,9,10,34,'2025-12-03',5,'VANI','46944',1180.00,0.00,0.00,1180.00,'credito',1.0000,'pendiente',''),(6,9,10,34,'2025-12-03',9,'SUPERMERCADO GONZALEZ','1',159.80,0.00,0.00,159.80,'credito',1.0000,'pendiente',''),(9,9,10,34,'2025-12-04',10,'POSTRES CONGELADOS JUAREZ SA DE CV','112318',1180.00,0.00,0.00,1180.00,'credito',1.0000,'pendiente',''),(10,9,10,34,'2025-12-04',7,'DEL RIO','13826',84.00,0.00,0.00,84.00,'credito',1.0000,'pendiente',''),(11,9,10,34,'2025-12-04',5,'VANI','46960',810.00,0.00,0.00,810.00,'credito',1.0000,'pendiente',''),(12,9,10,34,'2025-12-05',7,'DEL RIO','14453',42.00,0.00,0.00,42.00,'credito',1.0000,'pendiente',''),(13,9,10,34,'2025-12-05',7,'DEL RIO','14531',22.50,0.00,0.00,22.50,'credito',1.0000,'pendiente',''),(15,9,10,34,'2025-12-06',7,'DEL RIO','15603',69.00,0.00,0.00,69.00,'credito',1.0000,'pendiente',''),(16,9,10,34,'2025-12-06',6,'EL LOCO JR','628550',1203.00,0.00,0.00,1203.00,'credito',1.0000,'pendiente',''),(17,9,10,34,'2025-12-06',9,'SUPERMERCADO GONZALEZ','10',399.50,0.00,0.00,399.50,'credito',1.0000,'pendiente',''),(18,9,10,34,'2025-12-06',11,'Waldos Dolar Mart de Mexico SdeRLdeCV','10',53.98,0.00,0.00,53.98,'credito',1.0000,'pendiente',''),(19,9,10,34,'2025-12-06',7,'DEL RIO','15195',22.50,0.00,0.00,22.50,'credito',1.0000,'pendiente',''),(20,9,10,34,'2025-12-07',10,'POSTRES CONGELADOS JUAREZ SA DE CV','112502',415.00,0.00,0.00,415.00,'credito',1.0000,'pendiente',''),(21,9,10,34,'2025-12-07',5,'VANI','46983',2797.50,0.00,0.00,2797.50,'credito',1.0000,'pendiente',''),(22,9,10,34,'2025-12-07',9,'SUPERMERCADO GONZALEZ','1',179.00,0.00,0.00,179.00,'credito',1.0000,'pendiente',''),(23,9,10,34,'2025-12-07',9,'SUPERMERCADO GONZALEZ','11',239.70,0.00,0.00,239.70,'credito',1.0000,'pendiente',''),(24,9,10,34,'2025-12-07',7,'DEL RIO','16292',34.00,0.00,0.00,34.00,'credito',1.0000,'pendiente',''),(25,9,10,34,'2025-12-07',6,'EL LOCO JR','629196',110.00,0.00,0.00,110.00,'credito',1.0000,'pendiente',''),(26,9,10,34,'2025-12-07',9,'SUPERMERCADO GONZALEZ','1',738.90,0.00,0.00,738.90,'credito',1.0000,'pendiente',''),(27,9,10,34,'2025-12-07',7,'DEL RIO','16011',34.00,0.00,0.00,34.00,'credito',1.0000,'pendiente',''),(28,9,10,34,'2025-12-07',5,'VANI','49993',2590.00,0.00,0.00,2590.00,'credito',1.0000,'pendiente',''),(29,9,10,34,'2025-12-09',12,'Costco de Mexico S de RL  de CV','1',488.98,0.00,0.00,488.98,'credito',1.0000,'pendiente',''),(30,9,10,34,'2025-12-09',9,'SUPERMERCADO GONZALEZ','1',656.45,0.00,0.00,656.45,'credito',1.0000,'pendiente',''),(31,9,10,34,'2025-12-09',9,'SUPERMERCADO GONZALEZ','2',49.50,0.00,0.00,49.50,'credito',1.0000,'pendiente',''),(32,9,10,34,'2025-12-09',13,'Sams Club. Nueva Walmart de Mexico SdeRL de CV','3823',933.48,0.00,0.00,933.48,'credito',1.0000,'pendiente',''),(33,9,10,34,'2025-12-11',9,'SUPERMERCADO GONZALEZ','630660',125.30,0.00,0.00,125.30,'credito',1.0000,'pendiente',''),(35,9,10,34,'2025-12-11',6,'EL LOCO JR','630660',606.00,0.00,0.00,606.00,'credito',1.0000,'pendiente',''),(36,9,10,34,'2025-12-11',7,'DEL RIO','18553',34.00,0.00,0.00,34.00,'credito',1.0000,'pendiente',''),(37,9,10,34,'2025-12-12',10,'POSTRES CONGELADOS JUAREZ SA DE CV','112979',1080.00,0.00,0.00,1080.00,'credito',1.0000,'pendiente',''),(38,9,10,34,'2025-12-12',5,'VANI','47043',2825.00,0.00,0.00,2825.00,'credito',1.0000,'pendiente',''),(39,9,10,34,'2025-12-12',5,'VANI','47041',740.00,0.00,0.00,740.00,'credito',1.0000,'pendiente',''),(40,9,10,34,'2025-12-13',13,'Sams Club. Nueva Walmart de Mexico SdeRL de CV','3680',1336.01,0.00,0.00,1336.01,'credito',1.0000,'pendiente',''),(41,9,10,34,'2025-12-13',7,'DEL RIO','20309',43.00,0.00,0.00,43.00,'credito',1.0000,'pendiente',''),(42,9,10,34,'2025-12-13',6,'EL LOCO JR','631739',90.00,0.00,0.00,90.00,'credito',1.0000,'pendiente',''),(43,9,10,34,'2025-12-13',9,'SUPERMERCADO GONZALEZ','1',239.70,0.00,0.00,239.70,'credito',1.0000,'pendiente',''),(44,9,10,34,'2025-12-13',9,'SUPERMERCADO GONZALEZ','12',232.70,0.00,0.00,232.70,'credito',1.0000,'pendiente',''),(45,9,10,34,'2025-12-13',5,'VANI','47053',3530.00,0.00,0.00,3530.00,'credito',1.0000,'pendiente',''),(46,9,10,34,'2025-12-13',7,'DEL RIO','20522',34.00,0.00,0.00,34.00,'credito',1.0000,'pendiente',''),(47,9,10,34,'2025-12-13',9,'SUPERMERCADO GONZALEZ','11',559.30,0.00,0.00,559.30,'credito',1.0000,'pendiente',''),(48,9,10,34,'2025-12-14',10,'POSTRES CONGELADOS JUAREZ SA DE CV','113050',815.00,0.00,0.00,815.00,'credito',1.0000,'pendiente',''),(49,9,10,34,'2025-12-14',5,'VANI','47062',1692.50,0.00,0.00,1692.50,'credito',1.0000,'pendiente',''),(50,9,10,34,'2025-12-16',5,'VANI','47076',1915.00,0.00,0.00,1915.00,'credito',1.0000,'pendiente',''),(51,9,10,34,'2025-12-17',6,'EL LOCO JR','633422',129.00,0.00,0.00,129.00,'credito',1.0000,'pendiente',''),(52,9,10,34,'2025-12-17',5,'VANI','47084',1060.00,0.00,0.00,1060.00,'credito',1.0000,'pendiente',''),(53,9,10,34,'2025-12-17',9,'SUPERMERCADO GONZALEZ','1',399.50,0.00,0.00,399.50,'credito',1.0000,'pendiente',''),(54,9,10,34,'2025-12-17',7,'DEL RIO','23134',68.00,0.00,0.00,68.00,'credito',1.0000,'pendiente',''),(56,9,10,34,'2025-12-17',9,'SUPERMERCADO GONZALEZ','1',639.85,0.00,0.00,639.85,'credito',1.0000,'pendiente',''),(58,9,10,34,'2025-12-18',14,'Walmart Supercenter','975',558.70,0.00,0.00,558.70,'credito',1.0000,'pendiente',''),(60,9,10,34,'2025-12-18',15,'Sams Club ELP','2643',881.34,0.00,0.00,881.34,'credito',1.0000,'pendiente',''),(61,9,10,34,'2025-12-18',14,'Walmart Supercenter','973',824.36,0.00,0.00,824.36,'credito',1.0000,'pendiente',''),(62,9,10,34,'2025-12-18',13,'Sams Club. Nueva Walmart de Mexico SdeRL de CV','7309',1450.58,0.00,0.00,1450.58,'credito',1.0000,'pendiente',''),(64,9,10,34,'2025-12-19',9,'SUPERMERCADO GONZALEZ','1',513.00,0.00,0.00,513.00,'credito',1.0000,'pendiente',''),(65,9,10,34,'2025-12-19',6,'EL LOCO JR','634204',1083.00,0.00,0.00,1083.00,'credito',1.0000,'pendiente',''),(66,9,10,34,'2025-12-19',5,'VANI','47103',1472.50,0.00,0.00,1472.50,'credito',1.0000,'pendiente',''),(67,9,10,34,'2025-12-19',5,'VANI','47113',1175.00,0.00,0.00,1175.00,'credito',1.0000,'pendiente',''),(68,9,10,34,'2025-12-19',10,'POSTRES CONGELADOS JUAREZ SA DE CV','113478',400.00,0.00,0.00,400.00,'credito',1.0000,'pendiente',''),(69,9,10,34,'2025-12-20',10,'POSTRES CONGELADOS JUAREZ SA DE CV','113560',715.00,0.00,0.00,715.00,'credito',1.0000,'pendiente',''),(70,9,10,34,'2025-12-20',5,'VANI','47123',2825.00,0.00,0.00,2825.00,'credito',1.0000,'pendiente',''),(71,9,10,34,'2025-12-20',7,'DEL RIO','27320',68.00,0.00,0.00,68.00,'credito',1.0000,'pendiente',''),(72,9,10,34,'2025-12-21',5,'VANI','47129',2355.00,0.00,0.00,2355.00,'credito',1.0000,'pendiente',''),(73,9,10,34,'2025-12-21',13,'Sams Club. Nueva Walmart de Mexico SdeRL de CV','433',896.64,0.00,0.00,896.64,'credito',1.0000,'pendiente',''),(74,9,10,34,'2025-12-21',7,'DEL RIO','26272',76.00,0.00,0.00,76.00,'credito',1.0000,'pendiente',''),(75,9,10,34,'2025-12-21',9,'SUPERMERCADO GONZALEZ','1',680.00,0.00,0.00,680.00,'credito',1.0000,'pendiente',''),(76,9,10,34,'2025-12-21',5,'VANI','47135',3707.50,0.00,0.00,3707.50,'credito',1.0000,'pendiente',''),(77,9,10,34,'2025-12-21',9,'SUPERMERCADO GONZALEZ','1',548.80,0.00,0.00,548.80,'credito',1.0000,'pendiente',''),(78,9,10,34,'2025-12-22',10,'POSTRES CONGELADOS JUAREZ SA DE CV','113767',1253.00,0.00,0.00,1253.00,'credito',1.0000,'pendiente',''),(79,9,10,34,'2025-12-23',10,'POSTRES CONGELADOS JUAREZ SA DE CV','113810',1487.00,0.00,0.00,1487.00,'credito',1.0000,'pendiente',''),(80,9,10,34,'2025-12-23',5,'VANI','47143',2872.50,0.00,0.00,2872.50,'credito',1.0000,'pendiente',''),(81,9,10,34,'2025-12-23',6,'EL LOCO JR','636055',466.40,0.00,0.00,466.40,'credito',1.0000,'pendiente',''),(82,9,10,34,'2025-12-24',6,'EL LOCO JR','636527',454.00,0.00,0.00,454.00,'credito',1.0000,'pendiente',''),(83,9,10,34,'2025-12-24',6,'EL LOCO JR','636529',43.00,0.00,0.00,43.00,'credito',1.0000,'pendiente',''),(84,9,10,34,'2025-12-24',5,'VANI','47160',2892.50,0.00,0.00,2892.50,'credito',1.0000,'pendiente',''),(85,9,10,34,'2025-12-24',7,'DEL RIO','28742',34.00,0.00,0.00,34.00,'credito',1.0000,'pendiente',''),(86,9,10,34,'2025-12-25',9,'SUPERMERCADO GONZALEZ','1',471.10,0.00,0.00,471.10,'credito',1.0000,'pendiente',''),(87,9,10,34,'2025-12-26',9,'SUPERMERCADO GONZALEZ','1',274.40,0.00,0.00,274.40,'credito',1.0000,'pendiente',''),(88,9,10,34,'2025-12-26',5,'VANI','47166',1467.50,0.00,0.00,1467.50,'credito',1.0000,'pendiente',''),(89,9,10,34,'2025-12-26',7,'DEL RIO','30045',68.00,0.00,0.00,68.00,'credito',1.0000,'pendiente',''),(90,9,10,34,'2025-12-27',5,'VANI','47173',3707.50,0.00,0.00,3707.50,'credito',1.0000,'pendiente',''),(91,9,10,34,'2025-12-27',12,'Costco de Mexico S de RL  de CV','1',488.98,0.00,0.00,488.98,'credito',1.0000,'pendiente',''),(92,9,10,34,'2025-12-28',7,'DEL RIO','31479',34.00,0.00,0.00,34.00,'credito',1.0000,'pendiente',''),(93,9,10,34,'2025-12-28',6,'EL LOCO JR','637420',115.00,0.00,0.00,115.00,'credito',1.0000,'pendiente',''),(94,9,10,34,'2025-12-28',11,'Waldos Dolar Mart de Mexico SdeRLdeCV','1',104.97,0.00,0.00,104.97,'credito',1.0000,'pendiente',''),(95,9,10,34,'2025-12-28',6,'EL LOCO JR','637418',728.00,0.00,0.00,728.00,'credito',1.0000,'pendiente',''),(96,9,10,34,'2025-12-29',10,'POSTRES CONGELADOS JUAREZ SA DE CV','114051',500.00,0.00,0.00,500.00,'credito',1.0000,'pendiente',''),(97,9,10,34,'2025-12-29',9,'SUPERMERCADO GONZALEZ','1',274.40,0.00,0.00,274.40,'credito',1.0000,'pendiente',''),(98,9,10,34,'2025-12-29',6,'EL LOCO JR','637600',183.00,0.00,0.00,183.00,'credito',1.0000,'pendiente',''),(99,9,10,34,'2025-12-31',7,'DEL RIO','33128',34.00,0.00,0.00,34.00,'credito',1.0000,'pendiente',''),(100,9,10,34,'2025-12-31',6,'EL LOCO JR','638317',180.00,0.00,0.00,180.00,'credito',1.0000,'pendiente',''),(101,9,10,34,'2025-12-31',9,'SUPERMERCADO GONZALEZ','1',399.50,0.00,0.00,399.50,'credito',1.0000,'pendiente',''),(102,9,10,34,'2026-01-02',10,'POSTRES CONGELADOS JUAREZ SA DE CV','114431',684.26,0.00,0.00,684.26,'credito',1.0000,'pendiente',''),(104,9,10,9,'2026-01-01',0,'Dispensador de agua','1',80.00,0.00,0.00,80.00,'efectivo',1.0000,'pendiente',''),(105,9,10,9,'2026-04-28',16,'Top Marketing','280426',2625.00,0.00,0.00,2625.00,'efectivo',1.0000,'pendiente','');
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras_credito`
--

DROP TABLE IF EXISTS `compras_credito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compras_credito` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `contratante_id` int(11) NOT NULL,
  `compra_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `numero_documento` varchar(100) DEFAULT NULL,
  `proveedor` varchar(255) DEFAULT NULL,
  `importe` decimal(10,2) DEFAULT 0.00,
  `iva` decimal(10,2) DEFAULT 0.00,
  `total` decimal(10,2) DEFAULT 0.00,
  `saldo_pendiente` decimal(10,2) DEFAULT 0.00,
  `pagado` tinyint(1) DEFAULT 0,
  `fecha_vencimiento` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_empresa` (`empresa_id`),
  KEY `idx_contratante` (`contratante_id`),
  KEY `idx_compra` (`compra_id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras_credito`
--

LOCK TABLES `compras_credito` WRITE;
/*!40000 ALTER TABLE `compras_credito` DISABLE KEYS */;
INSERT INTO `compras_credito` VALUES (6,10,34,9,58,'2025-12-03','46944','VANI',1180.00,188.80,1368.80,0.00,0,NULL,'2026-01-05 19:20:51'),(8,10,34,9,60,'2025-12-03','46944','VANI',1180.00,188.80,1368.80,0.00,0,NULL,'2026-01-05 19:38:14'),(9,10,34,9,61,'2025-12-03','46944','VANI',1180.00,188.80,1368.80,0.00,0,NULL,'2026-01-05 19:44:53'),(12,10,34,9,4,'2025-12-03','83254','DEL RIO',42.00,0.00,42.00,0.00,0,NULL,'2026-01-06 03:00:58'),(13,10,34,9,5,'2025-12-03','46944','VANI',1180.00,0.00,1180.00,0.00,0,NULL,'2026-01-06 03:02:13'),(14,10,34,9,6,'2025-12-03','1','SUPERMERCADO GONZALEZ',159.80,0.00,159.80,0.00,0,NULL,'2026-01-06 03:03:15'),(17,10,34,9,9,'2025-12-04','112318','POSTRES CONGELADOS JUAREZ SA DE CV',1180.00,0.00,1180.00,0.00,0,NULL,'2026-01-06 03:14:19'),(18,10,34,9,10,'2025-12-04','13826','DEL RIO',84.00,0.00,84.00,0.00,0,NULL,'2026-01-06 03:15:22'),(19,10,34,9,11,'2025-12-04','46960','VANI',810.00,0.00,810.00,0.00,0,NULL,'2026-01-06 03:16:43'),(20,10,34,9,12,'2025-12-05','14453','DEL RIO',42.00,0.00,42.00,0.00,0,NULL,'2026-01-06 04:55:39'),(21,10,34,9,13,'2025-12-05','14531','DEL RIO',22.50,0.00,22.50,0.00,0,NULL,'2026-01-06 04:56:12'),(23,10,34,9,15,'2025-12-06','15603','DEL RIO',69.00,0.00,69.00,0.00,0,NULL,'2026-01-06 04:59:08'),(24,10,34,9,16,'2025-12-06','628550','EL LOCO JR',1203.00,0.00,1203.00,0.00,0,NULL,'2026-01-06 05:05:33'),(25,10,34,9,17,'2025-12-06','10','SUPERMERCADO GONZALEZ',399.50,0.00,399.50,0.00,0,NULL,'2026-01-06 05:08:10'),(26,10,34,9,18,'2025-12-06','10','Waldos Dolar Mart de Mexico SdeRLdeCV',53.98,0.00,53.98,0.00,0,NULL,'2026-01-06 05:10:11'),(27,10,34,9,19,'2025-12-06','15195','DEL RIO',22.50,0.00,22.50,0.00,0,NULL,'2026-01-06 05:10:39'),(28,10,34,9,20,'2025-12-07','112502','POSTRES CONGELADOS JUAREZ SA DE CV',415.00,0.00,415.00,0.00,0,NULL,'2026-01-06 05:11:25'),(29,10,34,9,21,'2025-12-07','46983','VANI',2797.50,0.00,2797.50,0.00,0,NULL,'2026-01-06 05:12:33'),(30,10,34,9,22,'2025-12-07','1','SUPERMERCADO GONZALEZ',179.00,0.00,179.00,0.00,0,NULL,'2026-01-06 05:19:50'),(31,10,34,9,23,'2025-12-07','11','SUPERMERCADO GONZALEZ',239.70,0.00,239.70,0.00,0,NULL,'2026-01-06 05:20:18'),(32,10,34,9,24,'2025-12-07','16292','DEL RIO',34.00,0.00,34.00,0.00,0,NULL,'2026-01-06 05:20:42'),(33,10,34,9,25,'2025-12-07','629196','EL LOCO JR',110.00,0.00,110.00,0.00,0,NULL,'2026-01-06 05:21:18'),(34,10,34,9,26,'2025-12-07','1','SUPERMERCADO GONZALEZ',738.90,0.00,738.90,0.00,0,NULL,'2026-01-06 05:22:56'),(35,10,34,9,27,'2025-12-07','16011','DEL RIO',34.00,0.00,34.00,0.00,0,NULL,'2026-01-06 05:23:22'),(36,10,34,9,28,'2025-12-07','49993','VANI',2590.00,0.00,2590.00,0.00,0,NULL,'2026-01-06 05:24:10'),(37,10,34,9,29,'2025-12-09','1','Costco de Mexico S de RL  de CV',488.98,0.00,488.98,0.00,0,NULL,'2026-01-06 05:32:19'),(38,10,34,9,30,'2025-12-09','1','SUPERMERCADO GONZALEZ',656.45,0.00,656.45,0.00,0,NULL,'2026-01-06 05:33:31'),(39,10,34,9,31,'2025-12-09','2','SUPERMERCADO GONZALEZ',49.50,0.00,49.50,0.00,0,NULL,'2026-01-06 05:34:02'),(40,10,34,9,32,'2025-12-09','3823','Sams Club. Nueva Walmart de Mexico SdeRL de CV',933.48,0.00,933.48,0.00,0,NULL,'2026-01-06 05:35:21'),(41,10,34,9,33,'2025-12-11','630660','SUPERMERCADO GONZALEZ',125.30,0.00,125.30,0.00,0,NULL,'2026-01-06 05:36:16'),(43,10,34,9,35,'2025-12-11','630660','EL LOCO JR',606.00,0.00,606.00,0.00,0,NULL,'2026-01-06 05:39:13'),(44,10,34,9,36,'2025-12-11','18553','DEL RIO',34.00,0.00,34.00,0.00,0,NULL,'2026-01-06 05:39:39'),(45,10,34,9,37,'2025-12-12','112979','POSTRES CONGELADOS JUAREZ SA DE CV',1080.00,0.00,1080.00,0.00,0,NULL,'2026-01-06 05:40:50'),(46,10,34,9,38,'2025-12-12','47043','VANI',2825.00,0.00,2825.00,0.00,0,NULL,'2026-01-06 05:42:00'),(47,10,34,9,39,'2025-12-12','47041','VANI',740.00,0.00,740.00,0.00,0,NULL,'2026-01-06 05:42:58'),(48,10,34,9,40,'2025-12-13','3680','Sams Club. Nueva Walmart de Mexico SdeRL de CV',1336.01,0.00,1336.01,0.00,0,NULL,'2026-01-06 05:46:48'),(49,10,34,9,41,'2025-12-13','20309','DEL RIO',43.00,0.00,43.00,0.00,0,NULL,'2026-01-06 05:48:21'),(50,10,34,9,42,'2025-12-13','631739','EL LOCO JR',90.00,0.00,90.00,0.00,0,NULL,'2026-01-06 05:48:53'),(51,10,34,9,43,'2025-12-13','1','SUPERMERCADO GONZALEZ',239.70,0.00,239.70,0.00,0,NULL,'2026-01-06 05:49:27'),(52,10,34,9,44,'2025-12-13','12','SUPERMERCADO GONZALEZ',232.70,0.00,232.70,0.00,0,NULL,'2026-01-06 05:50:00'),(53,10,34,9,45,'2025-12-13','47053','VANI',3530.00,0.00,3530.00,0.00,0,NULL,'2026-01-06 05:50:46'),(54,10,34,9,46,'2025-12-13','20522','DEL RIO',34.00,0.00,34.00,0.00,0,NULL,'2026-01-06 05:51:08'),(55,10,34,9,47,'2025-12-13','11','SUPERMERCADO GONZALEZ',559.30,0.00,559.30,0.00,0,NULL,'2026-01-06 05:51:39'),(56,10,34,9,48,'2025-12-14','113050','POSTRES CONGELADOS JUAREZ SA DE CV',815.00,0.00,815.00,0.00,0,NULL,'2026-01-06 05:53:16'),(57,10,34,9,49,'2025-12-14','47062','VANI',1692.50,0.00,1692.50,0.00,0,NULL,'2026-01-06 05:54:55'),(58,10,34,9,50,'2025-12-16','47076','VANI',1915.00,0.00,1915.00,0.00,0,NULL,'2026-01-06 05:55:54'),(59,10,34,9,51,'2025-12-17','633422','EL LOCO JR',129.00,0.00,129.00,0.00,0,NULL,'2026-01-06 05:58:21'),(60,10,34,9,52,'2025-12-17','47084','VANI',1060.00,0.00,1060.00,0.00,0,NULL,'2026-01-06 05:58:55'),(61,10,34,9,53,'2025-12-17','1','SUPERMERCADO GONZALEZ',399.50,0.00,399.50,0.00,0,NULL,'2026-01-06 05:59:20'),(62,10,34,9,54,'2025-12-17','23134','DEL RIO',68.00,0.00,68.00,0.00,0,NULL,'2026-01-06 05:59:53'),(64,10,34,9,56,'2025-12-17','1','SUPERMERCADO GONZALEZ',639.85,0.00,639.85,0.00,0,NULL,'2026-01-06 06:01:41'),(66,10,34,9,58,'2025-12-18','975','Walmart Supercenter',558.70,0.00,558.70,0.00,0,NULL,'2026-01-06 06:13:24'),(68,10,34,9,60,'2025-12-18','2643','Sams Club ELP',881.34,0.00,881.34,0.00,0,NULL,'2026-01-06 06:16:00'),(69,10,34,9,61,'2025-12-18','973','Walmart Supercenter',824.36,0.00,824.36,0.00,0,NULL,'2026-01-06 06:21:42'),(70,10,34,9,62,'2025-12-18','7309','Sams Club. Nueva Walmart de Mexico SdeRL de CV',1450.58,0.00,1450.58,0.00,0,NULL,'2026-01-06 06:28:01'),(72,10,34,9,64,'2025-12-19','1','SUPERMERCADO GONZALEZ',513.00,0.00,513.00,0.00,0,NULL,'2026-01-06 06:29:56'),(73,10,34,9,65,'2025-12-19','634204','EL LOCO JR',1083.00,0.00,1083.00,0.00,0,NULL,'2026-01-06 06:32:10'),(74,10,34,9,66,'2025-12-19','47103','VANI',1472.50,0.00,1472.50,0.00,0,NULL,'2026-01-06 06:32:55'),(75,10,34,9,67,'2025-12-19','47113','VANI',1175.00,0.00,1175.00,0.00,0,NULL,'2026-01-06 06:33:47'),(76,10,34,9,68,'2025-12-19','113478','POSTRES CONGELADOS JUAREZ SA DE CV',400.00,0.00,400.00,0.00,0,NULL,'2026-01-06 06:34:27'),(77,10,34,9,69,'2025-12-20','113560','POSTRES CONGELADOS JUAREZ SA DE CV',715.00,0.00,715.00,0.00,0,NULL,'2026-01-06 06:35:18'),(78,10,34,9,70,'2025-12-20','47123','VANI',2825.00,0.00,2825.00,0.00,0,NULL,'2026-01-06 06:36:36'),(79,10,34,9,71,'2025-12-20','27320','DEL RIO',68.00,0.00,68.00,0.00,0,NULL,'2026-01-06 06:37:09'),(80,10,34,9,72,'2025-12-21','47129','VANI',2355.00,0.00,2355.00,0.00,0,NULL,'2026-01-06 06:38:10'),(81,10,34,9,73,'2025-12-21','433','Sams Club. Nueva Walmart de Mexico SdeRL de CV',896.64,0.00,896.64,0.00,0,NULL,'2026-01-06 06:38:46'),(82,10,34,9,74,'2025-12-21','26272','DEL RIO',76.00,0.00,76.00,0.00,0,NULL,'2026-01-06 06:39:30'),(83,10,34,9,75,'2025-12-21','1','SUPERMERCADO GONZALEZ',680.00,0.00,680.00,0.00,0,NULL,'2026-01-06 06:40:24'),(84,10,34,9,76,'2025-12-21','47135','VANI',3707.50,0.00,3707.50,0.00,0,NULL,'2026-01-06 06:41:17'),(85,10,34,9,77,'2025-12-21','1','SUPERMERCADO GONZALEZ',548.80,0.00,548.80,0.00,0,NULL,'2026-01-06 06:41:53'),(86,10,34,9,78,'2025-12-22','113767','POSTRES CONGELADOS JUAREZ SA DE CV',1253.00,0.00,1253.00,0.00,0,NULL,'2026-01-06 06:42:54'),(87,10,34,9,79,'2025-12-23','113810','POSTRES CONGELADOS JUAREZ SA DE CV',1487.00,0.00,1487.00,0.00,0,NULL,'2026-01-06 06:45:37'),(88,10,34,9,80,'2025-12-23','47143','VANI',2872.50,0.00,2872.50,0.00,0,NULL,'2026-01-06 06:46:27'),(89,10,34,9,81,'2025-12-23','636055','EL LOCO JR',466.40,0.00,466.40,0.00,0,NULL,'2026-01-06 06:47:23'),(90,10,34,9,82,'2025-12-24','636527','EL LOCO JR',454.00,0.00,454.00,0.00,0,NULL,'2026-01-06 06:48:13'),(91,10,34,9,83,'2025-12-24','636529','EL LOCO JR',43.00,0.00,43.00,0.00,0,NULL,'2026-01-06 06:48:57'),(92,10,34,9,84,'2025-12-24','47160','VANI',2892.50,0.00,2892.50,0.00,0,NULL,'2026-01-06 06:49:46'),(93,10,34,9,85,'2025-12-24','28742','DEL RIO',34.00,0.00,34.00,0.00,0,NULL,'2026-01-06 06:50:09'),(94,10,34,9,86,'2025-12-25','1','SUPERMERCADO GONZALEZ',471.10,0.00,471.10,0.00,0,NULL,'2026-01-06 06:50:56'),(95,10,34,9,87,'2025-12-26','1','SUPERMERCADO GONZALEZ',274.40,0.00,274.40,0.00,0,NULL,'2026-01-06 06:51:42'),(96,10,34,9,88,'2025-12-26','47166','VANI',1467.50,0.00,1467.50,0.00,0,NULL,'2026-01-06 06:52:13'),(97,10,34,9,89,'2025-12-26','30045','DEL RIO',68.00,0.00,68.00,0.00,0,NULL,'2026-01-06 06:52:37'),(98,10,34,9,90,'2025-12-27','47173','VANI',3707.50,0.00,3707.50,0.00,0,NULL,'2026-01-06 06:53:43'),(99,10,34,9,91,'2025-12-27','1','Costco de Mexico S de RL  de CV',488.98,0.00,488.98,0.00,0,NULL,'2026-01-06 06:54:47'),(100,10,34,9,92,'2025-12-28','31479','DEL RIO',34.00,0.00,34.00,0.00,0,NULL,'2026-01-06 06:55:14'),(101,10,34,9,93,'2025-12-28','637420','EL LOCO JR',115.00,0.00,115.00,0.00,0,NULL,'2026-01-06 06:55:42'),(102,10,34,9,94,'2025-12-28','1','Waldos Dolar Mart de Mexico SdeRLdeCV',104.97,0.00,104.97,0.00,0,NULL,'2026-01-06 06:56:05'),(103,10,34,9,95,'2025-12-28','637418','EL LOCO JR',728.00,0.00,728.00,0.00,0,NULL,'2026-01-06 07:00:20'),(104,10,34,9,96,'2025-12-29','114051','POSTRES CONGELADOS JUAREZ SA DE CV',500.00,0.00,500.00,0.00,0,NULL,'2026-01-06 07:00:54'),(105,10,34,9,97,'2025-12-29','1','SUPERMERCADO GONZALEZ',274.40,0.00,274.40,0.00,0,NULL,'2026-01-06 07:02:33'),(106,10,34,9,98,'2025-12-29','637600','EL LOCO JR',183.00,0.00,183.00,0.00,0,NULL,'2026-01-06 07:03:14'),(107,10,34,9,99,'2025-12-31','33128','DEL RIO',34.00,0.00,34.00,0.00,0,NULL,'2026-01-06 07:03:48'),(108,10,34,9,100,'2025-12-31','638317','EL LOCO JR',180.00,0.00,180.00,0.00,0,NULL,'2026-01-06 07:05:40'),(109,10,34,9,101,'2025-12-31','1','SUPERMERCADO GONZALEZ',399.50,0.00,399.50,0.00,0,NULL,'2026-01-06 07:06:09'),(110,10,34,9,102,'2026-01-02','114431','POSTRES CONGELADOS JUAREZ SA DE CV',684.26,0.00,684.26,0.00,0,NULL,'2026-01-10 18:09:12');
/*!40000 ALTER TABLE `compras_credito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras_detalle`
--

DROP TABLE IF EXISTS `compras_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compras_detalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `compra_id` int(11) NOT NULL,
  `producto_base_id` int(11) NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `iva` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `compra_id` (`compra_id`),
  KEY `producto_base_id` (`producto_base_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras_detalle`
--

LOCK TABLES `compras_detalle` WRITE;
/*!40000 ALTER TABLE `compras_detalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `compras_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras_gastos`
--

DROP TABLE IF EXISTS `compras_gastos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compras_gastos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `compra_id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `cuenta_contable_id` int(11) DEFAULT NULL,
  `subcuenta_contable_id` int(11) DEFAULT NULL,
  `concepto` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `monto` decimal(12,2) NOT NULL DEFAULT 0.00,
  `fecha` date DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  `registrado_por` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cuenta_contable_id` (`cuenta_contable_id`),
  KEY `subcuenta_contable_id` (`subcuenta_contable_id`),
  KEY `idx_compra` (`compra_id`),
  KEY `idx_empresa` (`empresa_id`),
  KEY `idx_fecha` (`fecha`),
  CONSTRAINT `compras_gastos_ibfk_1` FOREIGN KEY (`compra_id`) REFERENCES `compras` (`id`) ON DELETE CASCADE,
  CONSTRAINT `compras_gastos_ibfk_2` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  CONSTRAINT `compras_gastos_ibfk_3` FOREIGN KEY (`cuenta_contable_id`) REFERENCES `cuentas_contables` (`id`),
  CONSTRAINT `compras_gastos_ibfk_4` FOREIGN KEY (`subcuenta_contable_id`) REFERENCES `subcuentas_contables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras_gastos`
--

LOCK TABLES `compras_gastos` WRITE;
/*!40000 ALTER TABLE `compras_gastos` DISABLE KEYS */;
INSERT INTO `compras_gastos` VALUES (1,102,10,302,NULL,'6119 - IEPS','',30.74,'2026-01-02','2026-01-10 11:09:12',34);
/*!40000 ALTER TABLE `compras_gastos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras_recepciones`
--

DROP TABLE IF EXISTS `compras_recepciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compras_recepciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `compra_id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `recibido_por` int(11) DEFAULT NULL,
  `fecha_recepcion` datetime DEFAULT current_timestamp(),
  `notas` text DEFAULT NULL,
  `estado` enum('parcial','completa') DEFAULT 'completa',
  PRIMARY KEY (`id`),
  KEY `recibido_por` (`recibido_por`),
  KEY `idx_compra` (`compra_id`),
  KEY `idx_empresa` (`empresa_id`),
  KEY `idx_fecha` (`fecha_recepcion`),
  CONSTRAINT `compras_recepciones_ibfk_1` FOREIGN KEY (`compra_id`) REFERENCES `compras` (`id`) ON DELETE CASCADE,
  CONSTRAINT `compras_recepciones_ibfk_2` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  CONSTRAINT `compras_recepciones_ibfk_3` FOREIGN KEY (`recibido_por`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras_recepciones`
--

LOCK TABLES `compras_recepciones` WRITE;
/*!40000 ALTER TABLE `compras_recepciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `compras_recepciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras_recepciones_detalle`
--

DROP TABLE IF EXISTS `compras_recepciones_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compras_recepciones_detalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recepcion_id` int(11) NOT NULL,
  `detalle_compra_id` int(11) NOT NULL,
  `mercancia_id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `cantidad_esperada` decimal(12,2) NOT NULL,
  `cantidad_recibida` decimal(12,2) NOT NULL,
  `ubicacion_id` int(11) DEFAULT NULL,
  `notas` text DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `detalle_compra_id` (`detalle_compra_id`),
  KEY `empresa_id` (`empresa_id`),
  KEY `idx_recepcion` (`recepcion_id`),
  KEY `idx_mercancia` (`mercancia_id`),
  KEY `idx_ubicacion` (`ubicacion_id`),
  CONSTRAINT `compras_recepciones_detalle_ibfk_1` FOREIGN KEY (`recepcion_id`) REFERENCES `compras_recepciones` (`id`) ON DELETE CASCADE,
  CONSTRAINT `compras_recepciones_detalle_ibfk_2` FOREIGN KEY (`detalle_compra_id`) REFERENCES `detalle_compra` (`id`),
  CONSTRAINT `compras_recepciones_detalle_ibfk_3` FOREIGN KEY (`mercancia_id`) REFERENCES `mercancia` (`id`),
  CONSTRAINT `compras_recepciones_detalle_ibfk_4` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  CONSTRAINT `compras_recepciones_detalle_ibfk_5` FOREIGN KEY (`ubicacion_id`) REFERENCES `ubicaciones_valores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras_recepciones_detalle`
--

LOCK TABLES `compras_recepciones_detalle` WRITE;
/*!40000 ALTER TABLE `compras_recepciones_detalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `compras_recepciones_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consumos_internos`
--

DROP TABLE IF EXISTS `consumos_internos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consumos_internos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL,
  `registro_id` int(11) DEFAULT NULL,
  `fecha` date NOT NULL,
  `producto_id` int(11) NOT NULL,
  `producto_nombre` varchar(255) DEFAULT NULL,
  `cantidad` decimal(10,3) NOT NULL DEFAULT 1.000,
  `costo_unitario` decimal(12,2) DEFAULT 0.00,
  `costo_total` decimal(12,2) DEFAULT 0.00,
  `responsable` varchar(100) DEFAULT NULL,
  `motivo` varchar(255) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `registro_id` (`registro_id`),
  KEY `producto_id` (`producto_id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `idx_fecha` (`fecha`),
  KEY `idx_empresa_fecha` (`empresa_id`,`fecha`),
  CONSTRAINT `consumos_internos_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  CONSTRAINT `consumos_internos_ibfk_2` FOREIGN KEY (`registro_id`) REFERENCES `registros_diarios` (`id`),
  CONSTRAINT `consumos_internos_ibfk_3` FOREIGN KEY (`producto_id`) REFERENCES `mercancia` (`id`),
  CONSTRAINT `consumos_internos_ibfk_4` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumos_internos`
--

LOCK TABLES `consumos_internos` WRITE;
/*!40000 ALTER TABLE `consumos_internos` DISABLE KEYS */;
/*!40000 ALTER TABLE `consumos_internos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consumos_propios`
--

DROP TABLE IF EXISTS `consumos_propios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consumos_propios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) DEFAULT NULL,
  `turno_id` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `producto_id` int(11) NOT NULL,
  `producto_nombre` varchar(200) DEFAULT NULL,
  `cantidad` decimal(10,3) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `notas` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `producto_id` (`producto_id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `idx_consumos_turno` (`turno_id`),
  KEY `idx_consumos_fecha` (`fecha`),
  CONSTRAINT `consumos_propios_ibfk_1` FOREIGN KEY (`turno_id`) REFERENCES `turnos` (`id`),
  CONSTRAINT `consumos_propios_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `mercancia` (`id`),
  CONSTRAINT `consumos_propios_ibfk_3` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumos_propios`
--

LOCK TABLES `consumos_propios` WRITE;
/*!40000 ALTER TABLE `consumos_propios` DISABLE KEYS */;
INSERT INTO `consumos_propios` VALUES (1,1,2,'2025-12-04 21:27:48',56,'Cono Galleta',1.000,18.00,18.00,13,''),(2,1,2,'2025-12-04 21:28:04',62,'Agua 500ml',2.000,8.00,16.00,13,'');
/*!40000 ALTER TABLE `consumos_propios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contratantes`
--

DROP TABLE IF EXISTS `contratantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contratantes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(255) NOT NULL,
  `tipo_organizacion` enum('grupo','empresa_unica') DEFAULT 'empresa_unica',
  `tipo_industria` enum('manufactura','servicios','retail','distribucion','mixto') DEFAULT 'mixto',
  `rfc` varchar(13) NOT NULL,
  `email_contacto` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `ciudad` varchar(100) DEFAULT NULL,
  `estado` varchar(100) DEFAULT NULL,
  `cp` varchar(10) DEFAULT NULL,
  `pais` varchar(100) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_suspension` timestamp NULL DEFAULT NULL,
  `notas` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_rfc` (`rfc`),
  KEY `idx_email` (`email_contacto`),
  KEY `idx_activo` (`activo`),
  KEY `idx_email_contacto` (`email_contacto`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contratantes`
--

LOCK TABLES `contratantes` WRITE;
/*!40000 ALTER TABLE `contratantes` DISABLE KEYS */;
INSERT INTO `contratantes` VALUES (1,'Empresa Demo','empresa_unica','mixto','XAXX010101000','demo@empresa.com','0000000000',NULL,NULL,NULL,NULL,'M?xico',1,'2025-12-26 05:42:02',NULL,NULL),(6,'Yolo Postres SA CV','grupo','mixto','GAEF760207I26','pakogranados1@hotmail.com','6567921773','Avenida 2da de Ugarte 574 local 16','Ciudad Juarez','Chihuahua','32130',NULL,1,'2025-12-31 04:20:03',NULL,NULL),(9,'Yolo Postres SA CV','grupo','mixto','gaef760207i26','pakogranados1@hotmail.com','6567921773','Solar de Azaleas 5441','Ciudad Juarez','Chihuahua','32500',NULL,1,'2025-12-31 05:48:01',NULL,NULL);
/*!40000 ALTER TABLE `contratantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuentas`
--

DROP TABLE IF EXISTS `cuentas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuentas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo` enum('activo','pasivo','capital','ingreso','egreso') NOT NULL,
  `nivel` int(11) NOT NULL,
  `padre_id` int(11) DEFAULT NULL,
  `naturaleza` enum('deudora','acreedora') NOT NULL,
  `activa` tinyint(1) DEFAULT 1,
  `empresa_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `padre_id` (`padre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuentas`
--

LOCK TABLES `cuentas` WRITE;
/*!40000 ALTER TABLE `cuentas` DISABLE KEYS */;
/*!40000 ALTER TABLE `cuentas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuentas_contables`
--

DROP TABLE IF EXISTS `cuentas_contables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuentas_contables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contratante_id` int(11) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `tipo` enum('Activo','Pasivo','Patrimonio','Ingresos','Gastos') NOT NULL,
  `naturaleza` enum('Deudora','Acreedora') NOT NULL,
  `nivel` tinyint(4) NOT NULL,
  `padre_id` int(11) DEFAULT NULL,
  `permite_subcuentas` tinyint(1) NOT NULL DEFAULT 0,
  `empresa_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_codigo_empresa` (`codigo`,`empresa_id`),
  KEY `cuenta_padre_id` (`padre_id`),
  CONSTRAINT `cuentas_contables_ibfk_1` FOREIGN KEY (`padre_id`) REFERENCES `cuentas_contables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=321 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuentas_contables`
--

LOCK TABLES `cuentas_contables` WRITE;
/*!40000 ALTER TABLE `cuentas_contables` DISABLE KEYS */;
INSERT INTO `cuentas_contables` VALUES (1,1,'100-000-000','ACTIVO','Activo','Deudora',1,NULL,0,NULL),(2,1,'200-000-000','PASIVO','Pasivo','Acreedora',1,NULL,0,NULL),(3,1,'300-000-000','PATRIMONIO','Patrimonio','Acreedora',1,NULL,0,NULL),(4,1,'110-000-000','ACTIVO CIRCULANTE','Activo','Deudora',1,1,0,NULL),(5,1,'112-000-000','INVENTARIOS','Activo','Deudora',1,4,0,NULL),(6,1,'112-001-000','MERCANCÍAS','Activo','Deudora',2,5,1,NULL),(7,1,'112-001-001','AZUCAR 2KG','Activo','Deudora',3,6,0,NULL),(8,1,'111-000-000','EFECTIVO Y EQUIVALENTES','Activo','Deudora',1,4,0,NULL),(9,1,'111-001-000','CAJA','Activo','Deudora',2,8,0,NULL),(10,1,'111-002-000','BANCOS','Activo','Deudora',2,8,0,NULL),(11,1,'111-003-000','CUENTAS DE TERCEROS','Activo','Deudora',2,8,1,NULL),(12,1,'111-004-000','OTROS EFECTIVOS','Activo','Deudora',2,8,0,NULL),(13,1,'112-002-000','MATERIAS PRIMAS','Activo','Deudora',2,5,1,NULL),(14,1,'112-003-000','PRODUCTOS EN PROCESO','Activo','Deudora',2,5,1,NULL),(15,1,'113-000-000','CUENTAS POR COBRAR','Activo','Deudora',1,4,0,NULL),(16,1,'113-001-000','CLIENTES','Activo','Deudora',2,15,1,NULL),(17,1,'113-002-000','DEUDORES DIVERSOS','Activo','Deudora',2,15,1,NULL),(18,1,'114-000-000','OTROS ACTIVOS CIRCULANTES','Activo','Deudora',1,4,0,NULL),(19,1,'114-001-000','ANTICIPOS','Activo','Deudora',2,18,1,NULL),(20,1,'114-002-000','IMPUESTOS A FAVOR','Activo','Deudora',2,18,1,NULL),(21,1,'130-000-000','INVENTARIOS (ALTERNOS)','Activo','Deudora',1,1,0,NULL),(22,1,'130-001-000','MERCANCÍAS A','Activo','Deudora',2,21,1,NULL),(23,1,'130-002-000','MERCANCÍAS B','Activo','Deudora',2,21,1,NULL),(24,1,'130-003-000','MERCANCÍAS C','Activo','Deudora',2,21,1,NULL),(25,1,'130-004-000','MERCANCÍAS D','Activo','Deudora',2,21,1,NULL),(26,1,'130-005-000','MERCANCÍAS E','Activo','Deudora',2,21,1,NULL),(27,1,'130-006-000','MERCANCÍAS F','Activo','Deudora',2,21,1,NULL),(28,1,'130-007-000','MERCANCÍAS G','Activo','Deudora',2,21,1,NULL),(29,1,'130-008-000','MERCANCÍAS H','Activo','Deudora',2,21,1,NULL),(30,1,'150-000-000','ACTIVO NO CIRCULANTE','Activo','Deudora',1,1,0,NULL),(31,1,'151-000-000','ACTIVOS FIJOS','Activo','Deudora',1,30,0,NULL),(32,1,'151-001-000','MOBILIARIO Y EQUIPO','Activo','Deudora',2,31,1,NULL),(33,1,'151-002-000','EQUIPO DE CÓMPUTO','Activo','Deudora',2,31,1,NULL),(34,1,'151-003-000','EQUIPO DE TRANSPORTE','Activo','Deudora',2,31,1,NULL),(35,1,'151-004-000','OTROS ACTIVOS FIJOS','Activo','Deudora',2,31,1,NULL),(36,1,'210-000-000','PASIVO CIRCULANTE','Pasivo','Acreedora',1,2,0,NULL),(37,1,'211-000-000','PROVEEDORES Y ACREEDORES','Pasivo','Acreedora',1,36,0,NULL),(38,1,'211-001-000','PROVEEDORES','Pasivo','Acreedora',2,37,1,NULL),(39,1,'211-002-000','ACREEDORES','Pasivo','Acreedora',2,37,1,NULL),(40,1,'212-000-000','PASIVOS ACUMULADOS','Pasivo','Acreedora',1,36,0,NULL),(41,1,'212-001-000','IMPUESTOS POR PAGAR','Pasivo','Acreedora',2,40,1,NULL),(42,1,'212-002-000','OTROS PASIVOS','Pasivo','Acreedora',2,40,0,NULL),(43,1,'220-000-000','PASIVO A LARGO PLAZO','Pasivo','Acreedora',1,2,0,NULL),(44,1,'221-000-000','CRÉDITOS DE LARGO PLAZO','Pasivo','Acreedora',1,43,0,NULL),(45,1,'221-001-000','CRÉDITOS BANCARIOS','Pasivo','Acreedora',2,44,1,NULL),(46,1,'301-000-000','CAPITAL SOCIAL Y RESULTADOS','Patrimonio','Acreedora',1,3,0,NULL),(47,1,'301-001-000','CAPITAL SOCIAL','Patrimonio','Acreedora',2,46,0,NULL),(48,1,'301-002-000','RESERVAS','Patrimonio','Acreedora',2,46,0,NULL),(49,1,'301-003-000','RESULTADOS ACUMULADOS','Patrimonio','Acreedora',2,46,0,NULL),(50,1,'301-004-000','RESULTADO DEL EJERCICIO','Patrimonio','Acreedora',2,46,0,NULL),(51,1,'400-000-000','INGRESOS','Ingresos','Acreedora',1,NULL,0,NULL),(52,1,'401-000-000','INGRESOS ORDINARIOS','Ingresos','Acreedora',1,51,0,NULL),(53,1,'401-001-000','VENTAS','Ingresos','Acreedora',2,52,1,NULL),(54,1,'402-000-000','OTROS INGRESOS','Ingresos','Acreedora',1,51,0,NULL),(55,1,'402-001-000','OTROS PRODUCTOS','Ingresos','Acreedora',2,54,1,NULL),(56,1,'500-000-000','COSTOS Y CUENTAS RELACIONADAS','Gastos','Deudora',1,NULL,0,NULL),(57,1,'501-000-000','COSTO DE VENTAS','Gastos','Deudora',1,56,0,NULL),(58,1,'501-001-000','COSTO MERCANCÍAS','Gastos','Deudora',2,57,1,NULL),(59,1,'501-002-000','OTROS COSTOS','Gastos','Deudora',2,57,1,NULL),(60,1,'502-000-000','CLIENTES / CUENTAS RELACIONADAS','Gastos','Deudora',1,56,1,NULL),(61,1,'600-000-000','GASTOS','Gastos','Deudora',1,NULL,1,NULL),(62,1,'600-001-001','Sueldos y Salarios','Gastos','Deudora',3,108,0,NULL),(63,1,'600-001-002','Horas Extras','Gastos','Deudora',3,108,0,NULL),(64,1,'600-001-003','Comisiones de venta','Gastos','Deudora',3,108,0,NULL),(65,1,'600-001-004','Renta','Gastos','Deudora',3,108,0,NULL),(66,1,'600-001-005','Mejoras en Imagen','Gastos','Deudora',3,108,0,NULL),(67,1,'600-001-006','Luz','Gastos','Deudora',3,108,0,NULL),(68,1,'600-001-007','Agua','Gastos','Deudora',3,108,0,NULL),(69,1,'600-001-008','Gas','Gastos','Deudora',3,108,0,NULL),(70,1,'600-001-009','Aseguranza','Gastos','Deudora',3,108,0,NULL),(71,1,'600-001-010','Articulos de limpieza','Gastos','Deudora',3,108,0,NULL),(72,1,'600-001-011','Mantenimiento de equipo','Gastos','Deudora',3,108,0,NULL),(73,1,'600-001-012','Suministro de oficina','Gastos','Deudora',3,108,0,NULL),(74,1,'600-001-013','Gasolina','Gastos','Deudora',3,108,0,NULL),(75,1,'600-001-014','Publicidad','Gastos','Deudora',3,108,0,NULL),(76,1,'600-001-015','Reclutamiento','Gastos','Deudora',3,108,0,NULL),(77,1,'600-001-016','Capacitaci?n','Gastos','Deudora',3,108,0,NULL),(78,1,'600-001-017','Gastos de Transporte','Gastos','Deudora',3,108,0,NULL),(79,1,'600-001-018','Comida empleados','Gastos','Deudora',3,108,0,NULL),(80,1,'600-001-019','Cortesias empleados','Gastos','Deudora',3,108,0,NULL),(81,1,'600-001-020','Gastos Varios','Gastos','Deudora',3,108,0,NULL),(82,1,'600-001-021','Gastos Corporativos','Gastos','Deudora',3,108,0,NULL),(83,1,'600-001-022','Intereses financieros','Gastos','Deudora',3,108,0,NULL),(84,1,'600-001-023','Comisiones bancarias','Gastos','Deudora',3,108,0,NULL),(85,1,'600-001-024','ISR','Gastos','Deudora',3,108,0,NULL),(86,1,'600-001-025','IEPS','Gastos','Deudora',3,108,0,NULL),(87,1,'212-002-001','OTRO PASIVO 001','Pasivo','Acreedora',3,42,0,NULL),(88,1,'212-002-002','OTRO PASIVO 002','Pasivo','Acreedora',3,42,0,NULL),(89,1,'212-002-003','OTRO PASIVO 003','Pasivo','Acreedora',3,42,0,NULL),(90,1,'212-002-004','OTRO PASIVO 004','Pasivo','Acreedora',3,42,0,NULL),(91,1,'212-002-005','OTRO PASIVO 005','Pasivo','Acreedora',3,42,0,NULL),(92,1,'212-002-006','OTRO PASIVO 006','Pasivo','Acreedora',3,42,0,NULL),(93,1,'212-002-007','OTRO PASIVO 007','Pasivo','Acreedora',3,42,0,NULL),(94,1,'212-002-008','OTRO PASIVO 008','Pasivo','Acreedora',3,42,0,NULL),(95,1,'212-002-009','OTRO PASIVO 009','Pasivo','Acreedora',3,42,0,NULL),(96,1,'212-002-010','OTRO PASIVO 010','Pasivo','Acreedora',3,42,0,NULL),(97,1,'301-003-001','RESULTADOS ACUMULADOS DETALLE','Patrimonio','Acreedora',3,49,0,NULL),(98,1,'301-004-001','RESULTADO 001','Patrimonio','Acreedora',3,50,0,NULL),(99,1,'301-004-002','RESULTADO 002','Patrimonio','Acreedora',3,50,0,NULL),(100,1,'301-004-003','RESULTADO 003','Patrimonio','Acreedora',3,50,0,NULL),(101,1,'301-004-004','RESULTADO 004','Patrimonio','Acreedora',3,50,0,NULL),(102,1,'301-004-005','RESULTADO 005','Patrimonio','Acreedora',3,50,0,NULL),(103,1,'301-004-006','RESULTADO 006','Patrimonio','Acreedora',3,50,0,NULL),(104,1,'301-004-007','RESULTADO 007','Patrimonio','Acreedora',3,50,0,NULL),(105,1,'301-004-008','RESULTADO 008','Patrimonio','Acreedora',3,50,0,NULL),(106,1,'301-004-009','RESULTADO 009','Patrimonio','Acreedora',3,50,0,NULL),(107,1,'112-001-002','AZUCAR 5KG','Activo','Deudora',3,6,0,NULL),(108,1,'600-001-000','GASTOS OPERATIVOS','Gastos','Deudora',2,61,1,NULL),(109,1,'600-001-026','IVA','Gastos','Deudora',3,108,0,NULL),(110,1,'112-001-003','HIELO','Activo','Deudora',3,6,0,NULL),(111,1,'112-001-004','GASOLINA','Activo','Deudora',3,6,0,NULL),(112,1,'112-001-005','AZUCAR 1 KG','Activo','Deudora',3,6,0,NULL),(113,1,'112-001-006','CACAHUATE','Activo','Deudora',3,6,0,NULL),(114,1,'112-001-007','CAJETA 1KG','Activo','Deudora',3,6,0,NULL),(115,1,'112-001-008','CAJETA 5KG','Activo','Deudora',3,6,0,NULL),(116,1,'112-001-009','CONO WAFFLE','Activo','Deudora',3,6,0,NULL),(117,1,'112-001-010','CONO CHOCOLATE','Activo','Deudora',3,6,0,NULL),(118,1,'112-001-011','IEPS','Activo','Deudora',3,6,0,NULL),(119,1,'112-001-012','IVA','Activo','Deudora',3,6,0,NULL),(120,1,'112-001-013','HARINA PARA BROWNIES 3.4KG','Activo','Deudora',3,6,0,NULL),(121,1,'112-001-014','HARINA PARA BROWNIES 2.26KG','Activo','Deudora',3,6,0,NULL),(122,1,'112-001-015','FRESA 1KG','Activo','Deudora',3,6,0,NULL),(123,0,'1000','ACTIVO','Activo','Deudora',1,NULL,1,6),(124,0,'1100','ACTIVO CIRCULANTE','Activo','Deudora',2,NULL,1,6),(125,0,'1101','Caja','Activo','Deudora',3,NULL,0,6),(126,0,'1102','Bancos','Activo','Deudora',3,NULL,0,6),(127,0,'1103','Clientes','Activo','Deudora',3,NULL,0,6),(128,0,'1104','Inventarios','Activo','Deudora',3,NULL,0,6),(129,0,'1200','ACTIVO FIJO','Activo','Deudora',2,NULL,1,6),(130,0,'1201','Mobiliario y Equipo','Activo','Deudora',3,NULL,0,6),(131,0,'2000','PASIVO','Pasivo','Acreedora',1,NULL,1,6),(132,0,'2100','PASIVO CIRCULANTE','Pasivo','Acreedora',2,NULL,1,6),(133,0,'2101','Proveedores','Pasivo','Acreedora',3,NULL,0,6),(134,0,'2102','Acreedores Diversos','Pasivo','Acreedora',3,NULL,0,6),(135,0,'2103','Impuestos por Pagar','Pasivo','Acreedora',3,NULL,0,6),(136,0,'3000','CAPITAL','Patrimonio','Acreedora',1,NULL,1,6),(137,0,'3101','Capital Social','Patrimonio','Acreedora',2,NULL,0,6),(138,0,'3102','Utilidades Retenidas','Patrimonio','Acreedora',2,NULL,0,6),(139,0,'3103','Utilidad del Ejercicio','Patrimonio','Acreedora',2,NULL,0,6),(140,0,'4000','INGRESOS','Ingresos','Acreedora',1,NULL,1,6),(141,0,'4101','Ventas','Ingresos','Acreedora',2,NULL,0,6),(142,0,'4102','Otros Ingresos','Ingresos','Acreedora',2,NULL,0,6),(143,0,'5000','COSTOS','Gastos','Deudora',1,NULL,1,6),(144,0,'5101','Costo de Ventas','Gastos','Deudora',2,NULL,0,6),(145,0,'5102','Costo de Producción','Gastos','Deudora',2,NULL,0,6),(146,0,'6000','GASTOS','Gastos','Deudora',1,NULL,1,6),(147,0,'6101','Gastos de Operación','Gastos','Deudora',2,NULL,0,6),(148,0,'6102','Gastos de Administración','Gastos','Deudora',2,NULL,0,6),(149,0,'6103','Gastos Financieros','Gastos','Deudora',2,NULL,0,6),(178,9,'1000','ACTIVO','Activo','Deudora',1,NULL,1,10),(179,9,'1100','ACTIVO CIRCULANTE','Activo','Deudora',2,NULL,1,10),(180,9,'1101','Caja','Activo','Deudora',3,NULL,0,10),(181,9,'1102','Bancos','Activo','Deudora',3,NULL,0,10),(182,9,'1103','Clientes','Activo','Deudora',3,NULL,0,10),(183,9,'1104','Inventarios','Activo','Deudora',3,NULL,0,10),(184,9,'1200','ACTIVO FIJO','Activo','Deudora',2,NULL,1,10),(185,9,'1201','Mobiliario y Equipo','Activo','Deudora',3,NULL,0,10),(186,9,'2000','PASIVO','Pasivo','Acreedora',1,NULL,1,10),(187,9,'2100','PASIVO CIRCULANTE','Pasivo','Acreedora',2,NULL,1,10),(188,9,'2101','Proveedores','Pasivo','Acreedora',3,NULL,0,10),(189,9,'2102','Acreedores Diversos','Pasivo','Acreedora',3,NULL,0,10),(190,9,'2103','Impuestos por Pagar','Pasivo','Acreedora',3,NULL,0,10),(191,9,'3000','CAPITAL','Patrimonio','Acreedora',1,NULL,1,10),(192,9,'3101','Capital Social','Patrimonio','Acreedora',2,NULL,0,10),(193,9,'3102','Utilidades Retenidas','Patrimonio','Acreedora',2,NULL,0,10),(194,9,'3103','Utilidad del Ejercicio','Patrimonio','Acreedora',2,NULL,0,10),(195,9,'4000','INGRESOS','Ingresos','Acreedora',1,NULL,1,10),(196,9,'4101','Ventas','Ingresos','Acreedora',2,NULL,0,10),(197,9,'4102','Otros Ingresos','Ingresos','Acreedora',2,NULL,0,10),(198,9,'5000','COSTOS','Gastos','Deudora',1,NULL,1,10),(199,9,'5101','Costo de Ventas','Gastos','Deudora',2,NULL,0,10),(200,9,'5102','Costo de Producción','Gastos','Deudora',2,NULL,0,10),(209,9,'1104-001','Inventario Materia Prima','Activo','Deudora',4,183,1,10),(211,9,'1104-001-001','INV MP - Galleta Oreo','Activo','Deudora',5,209,0,10),(212,9,'1104-001-002','INV MP - Nieve de Chorro Vainilla','Activo','Deudora',5,209,0,10),(215,9,'1104-001-003','INV MP - Nieve de Chorro Chocolate','Activo','Deudora',5,209,0,10),(216,9,'1104-001-004','INV MP - Leche','Activo','Deudora',5,209,0,10),(217,9,'1104-001-005','INV MP - Crema batida','Activo','Deudora',5,209,0,10),(218,9,'1104-001-006','INV MP - Cono Waffle','Activo','Deudora',5,209,0,10),(219,9,'1104-001-007','INV MP - Fresa','Activo','Deudora',5,209,0,10),(220,9,'1104-001-008','INV MP - Cono Oblea','Activo','Deudora',5,209,0,10),(221,9,'1104-001-009','INV MP - Servilletas','Activo','Deudora',5,209,0,10),(222,9,'1104-001-010','INV MP - Cajeta','Activo','Deudora',5,209,0,10),(223,9,'1104-001-011','INV MP - Plato brownie','Activo','Deudora',5,209,0,10),(224,9,'1104-001-012','INV MP - Tapa Vaso 16oz','Activo','Deudora',5,209,0,10),(225,9,'1104-001-013','INV MP - Vaso 16oz','Activo','Deudora',5,209,0,10),(228,9,'2101-001-001','PROV NAL - VANI','Pasivo','Acreedora',5,188,0,10),(229,9,'2101-001-002','PROV NAL - EL LOCO JR','Pasivo','Acreedora',5,188,0,10),(230,9,'2101-001-003','PROV NAL - DEL RIO','Pasivo','Acreedora',5,188,0,10),(231,9,'2101-001-004','PROV NAL - OXXO','Pasivo','Acreedora',5,188,0,10),(232,9,'2101-001-005','PROV NAL - SUPERMERCADO GONZALEZ','Pasivo','Acreedora',5,188,0,10),(233,9,'2101-001-006','PROV NAL - POSTRES CONGELADOS JUAREZ SA DE CV','Pasivo','Acreedora',5,188,0,10),(234,9,'1104-001-014','INV MP - Impuestos','Activo','Deudora',5,209,0,10),(235,9,'1104-001-015','INV MP - Popotes','Activo','Deudora',5,209,0,10),(236,9,'1104-001-016','INV MP - Cerezas','Activo','Deudora',5,209,0,10),(237,9,'2101-001-007','PROV NAL - Waldos Dolar Mart de Mexico SdeRLdeCV','Pasivo','Acreedora',5,188,0,10),(238,9,'1104-001-017','INV MP - Hielo','Activo','Deudora',5,209,0,10),(239,9,'1104-001-018','INV MP - Azucar','Activo','Deudora',5,209,0,10),(240,9,'1104-001-019','INV MP - Cono Galleta','Activo','Deudora',5,209,0,10),(241,9,'2101-001-008','PROV NAL - Costco de Mexico S de RL  de CV','Pasivo','Acreedora',5,188,0,10),(242,9,'2101-001-009','PROV NAL - Sams Club. Nueva Walmart de Mexico SdeRL de CV','Pasivo','Acreedora',5,188,0,10),(243,9,'1104-001-020','INV MP - Harina Brownie','Activo','Deudora',5,209,0,10),(244,9,'1104-001-021','INV MP - Huevo','Activo','Deudora',5,209,0,10),(245,9,'1104-001-022','INV MP - Hershey Chocolate','Activo','Deudora',5,209,0,10),(246,9,'1104-001-023','INV MP - Agua individual','Activo','Deudora',5,209,0,10),(247,9,'1104-001-024','INV MP - Mazapan','Activo','Deudora',5,209,0,10),(248,9,'1104-001-025','INV MP - Mermelada','Activo','Deudora',5,209,0,10),(249,9,'1104-001-026','INV MP - Bolsas Churros','Activo','Deudora',5,209,0,10),(250,9,'1104-001-027','INV MP - Coca cola bote','Activo','Deudora',5,209,0,10),(251,9,'1104-001-028','INV MP - 9oz vaso','Activo','Deudora',5,209,0,10),(252,9,'1104-001-029','INV MP - Chocochip','Activo','Deudora',5,209,0,10),(253,9,'1104-001-030','INV MP - Hershey Fresa','Activo','Deudora',5,209,0,10),(254,9,'1104-001-031','INV MP - Hershey Caramelo','Activo','Deudora',5,209,0,10),(255,9,'2101-002-001','PROV EXT - Walmart Supercenter','Pasivo','Acreedora',5,188,0,10),(256,9,'2101-002-002','PROV EXT - Sams Club ELP','Pasivo','Acreedora',5,188,0,10),(257,9,'1104-001-032','INV MP - Lechera','Activo','Deudora',5,209,0,10),(258,9,'1104-001-033','INV MP - Cuchara','Activo','Deudora',5,209,0,10),(259,9,'1104-001-034','INV MP - Cacahuate','Activo','Deudora',5,209,0,10),(282,1,'6000','GASTOS OPERATIVOS','Gastos','Deudora',1,NULL,1,10),(283,1,'6100','Gastos de Administraci?n y Ventas','Gastos','Deudora',2,NULL,1,10),(284,1,'6101','Sueldos y salarios','Gastos','Deudora',3,NULL,0,10),(285,1,'6102','Renta','Gastos','Deudora',3,NULL,0,10),(286,1,'6103','Publicidad e Imagen','Gastos','Deudora',3,NULL,0,10),(287,1,'6104','Luz','Gastos','Deudora',3,NULL,0,10),(288,1,'6105','Agua','Gastos','Deudora',3,NULL,0,10),(289,1,'6106','Gas','Gastos','Deudora',3,NULL,0,10),(290,1,'6107','Seguros y fianzas','Gastos','Deudora',3,NULL,0,10),(291,1,'6108','Limpieza','Gastos','Deudora',3,NULL,0,10),(292,1,'6109','Mantenimiento equipo','Gastos','Deudora',3,NULL,0,10),(293,1,'6110','Papeler?a y equipo oficina','Gastos','Deudora',3,NULL,0,10),(294,1,'6111','Honorarios profesionales','Gastos','Deudora',3,NULL,0,10),(295,1,'6112','Reclutamiento','Gastos','Deudora',3,NULL,0,10),(296,1,'6113','Capacitaci?n','Gastos','Deudora',3,NULL,0,10),(297,1,'6114','Comida empleados','Gastos','Deudora',3,NULL,0,10),(298,1,'6115','Gastos varios','Gastos','Deudora',3,NULL,0,10),(299,1,'6116','Gastos Corporativos','Gastos','Deudora',3,NULL,0,10),(300,1,'6117','Comisiones','Gastos','Deudora',3,NULL,0,10),(301,1,'6118','ISR','Gastos','Deudora',3,NULL,0,10),(302,1,'6119','IEPS','Gastos','Deudora',3,NULL,0,10),(303,1,'6120','IVA','Gastos','Deudora',3,NULL,0,10),(312,9,'1104-001-035','INV MP - Aceite Vegetal','Activo','Deudora',5,209,0,10),(313,9,'1104-001-036','INV MP - Agua Natural','Activo','Deudora',5,209,0,10),(316,9,'1104-001-037','INV MP - Huevo','Activo','Deudora',5,209,0,10),(317,9,'1104-001-038','INV MP - Mazapan','Activo','Deudora',5,209,0,10),(318,9,'1104-001-039','INV MP - Etiquetas','Activo','Deudora',5,209,0,10),(320,9,'1104-001-040','INV MP - Vaso 16 EU','Activo','Deudora',5,209,0,10);
/*!40000 ALTER TABLE `cuentas_contables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuentas_por_pagar`
--

DROP TABLE IF EXISTS `cuentas_por_pagar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuentas_por_pagar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL,
  `factura_b2b_id` int(11) DEFAULT NULL,
  `cfdi_id` int(11) DEFAULT NULL,
  `compra_id` int(11) DEFAULT NULL,
  `proveedor_empresa_id` int(11) DEFAULT NULL,
  `proveedor_nombre` varchar(255) DEFAULT NULL,
  `proveedor_rfc` varchar(20) DEFAULT NULL,
  `tipo_documento` enum('factura_b2b','cfdi','compra_manual') NOT NULL,
  `numero_documento` varchar(50) DEFAULT NULL,
  `fecha_documento` date DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `monto_original` decimal(12,2) NOT NULL,
  `monto_pagado` decimal(12,2) DEFAULT 0.00,
  `saldo` decimal(12,2) NOT NULL,
  `estado` enum('pendiente','parcial','pagada','cancelada') DEFAULT 'pendiente',
  `autorizado_por_usuario_id` int(11) DEFAULT NULL,
  `fecha_autorizacion` datetime DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `empresa_id` (`empresa_id`),
  KEY `factura_b2b_id` (`factura_b2b_id`),
  KEY `cfdi_id` (`cfdi_id`),
  KEY `compra_id` (`compra_id`),
  KEY `proveedor_empresa_id` (`proveedor_empresa_id`),
  KEY `autorizado_por_usuario_id` (`autorizado_por_usuario_id`),
  CONSTRAINT `cuentas_por_pagar_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  CONSTRAINT `cuentas_por_pagar_ibfk_2` FOREIGN KEY (`factura_b2b_id`) REFERENCES `facturas_b2b` (`id`),
  CONSTRAINT `cuentas_por_pagar_ibfk_3` FOREIGN KEY (`cfdi_id`) REFERENCES `cfdi_importados` (`id`),
  CONSTRAINT `cuentas_por_pagar_ibfk_4` FOREIGN KEY (`compra_id`) REFERENCES `compras` (`id`),
  CONSTRAINT `cuentas_por_pagar_ibfk_5` FOREIGN KEY (`proveedor_empresa_id`) REFERENCES `empresas` (`id`),
  CONSTRAINT `cuentas_por_pagar_ibfk_6` FOREIGN KEY (`autorizado_por_usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuentas_por_pagar`
--

LOCK TABLES `cuentas_por_pagar` WRITE;
/*!40000 ALTER TABLE `cuentas_por_pagar` DISABLE KEYS */;
/*!40000 ALTER TABLE `cuentas_por_pagar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_videos`
--

DROP TABLE IF EXISTS `dashboard_videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modulo` varchar(50) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `youtube_url` varchar(500) DEFAULT NULL,
  `duracion` varchar(20) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `orden` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `modulo` (`modulo`),
  KEY `idx_modulo` (`modulo`),
  KEY `idx_activo` (`activo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_videos`
--

LOCK TABLES `dashboard_videos` WRITE;
/*!40000 ALTER TABLE `dashboard_videos` DISABLE KEYS */;
INSERT INTO `dashboard_videos` VALUES (1,'administracion','Gesti?n de Usuarios y Permisos','Aprende a crear usuarios, asignar roles y gestionar ?reas de producci?n','','3:45',1,1,'2026-02-05 23:06:43','2026-02-05 23:06:43'),(2,'compras','Sistema de Compras y ?rdenes','C?mo crear ?rdenes de compra, gestionar proveedores y dar seguimiento','','4:20',1,2,'2026-02-05 23:06:43','2026-02-05 23:06:43'),(3,'ventas','Punto de Venta y Reportes','Uso del POS, generaci?n de tickets y an?lisis de ventas','','5:10',1,3,'2026-02-05 23:06:43','2026-02-05 23:06:43'),(4,'inventario','Control de Inventarios','Gesti?n de stock, movimientos y alertas de existencias','','4:05',1,4,'2026-02-05 23:06:43','2026-02-05 23:06:43'),(5,'produccion','?rdenes de Producci?n','Creaci?n de recetas, ?rdenes de producci?n y seguimiento WIP','','6:30',1,5,'2026-02-05 23:06:43','2026-02-05 23:06:43');
/*!40000 ALTER TABLE `dashboard_videos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_compra`
--

DROP TABLE IF EXISTS `detalle_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalle_compra` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `compra_id` int(11) NOT NULL,
  `empresa_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `contratante_id` int(11) DEFAULT NULL,
  `mercancia_id` int(11) DEFAULT NULL,
  `producto` varchar(255) DEFAULT NULL,
  `unidades` decimal(10,2) DEFAULT NULL,
  `contenido_neto_total` decimal(10,2) DEFAULT NULL,
  `precio_unitario` decimal(10,2) DEFAULT NULL,
  `precio_total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `compra_id` (`compra_id`),
  KEY `idx_dc_mercancia` (`mercancia_id`),
  CONSTRAINT `fk_dc_mercancia` FOREIGN KEY (`mercancia_id`) REFERENCES `mercancia` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_detalle_compra_compras` FOREIGN KEY (`compra_id`) REFERENCES `compras` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=233 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_compra`
--

LOCK TABLES `detalle_compra` WRITE;
/*!40000 ALTER TABLE `detalle_compra` DISABLE KEYS */;
INSERT INTO `detalle_compra` VALUES (32,4,10,34,9,76,'Leche Lucerna 1.8L',1.00,1800.00,42.00,42.00),(33,5,10,34,9,37,'Nieve de Chorro Chocolate',1.00,18000.00,595.00,595.00),(34,5,10,34,9,36,'Nieve de Chorro Vainilla',1.00,18000.00,585.00,585.00),(35,6,10,34,9,77,'Crema batida Prices',2.00,736.00,79.90,159.80),(40,9,10,34,9,78,'Cono dorado doble rustico',1.00,125.00,384.26,384.26),(41,9,10,34,9,77,'Crema batida Prices',5.00,1840.00,73.00,365.00),(42,9,10,34,9,79,'Fresa Comercial 1kg',4.00,4000.00,100.00,400.00),(43,9,10,34,9,NULL,'ieps',1.00,1.00,30.74,30.74),(44,10,10,34,9,76,'Leche Lucerna 1.8L',2.00,3600.00,42.00,84.00),(45,11,10,34,9,36,'Nieve de Chorro Vainilla',1.00,18000.00,585.00,585.00),(46,11,10,34,9,80,'Cono Oblea',3.00,300.00,75.00,225.00),(47,12,10,34,9,76,'Leche Lucerna 1.8L',1.00,1800.00,42.00,42.00),(48,13,10,34,9,NULL,'Servilleta restaurantera',1.00,500.00,22.50,22.50),(50,15,10,34,9,76,'Leche Lucerna 1.8L',1.00,1800.00,42.00,42.00),(51,15,10,34,9,NULL,'Leche Lucerna 1L',1.00,1000.00,27.00,27.00),(52,16,10,34,9,82,'Cajeta Zagala 5kg',1.00,5000.00,325.00,325.00),(53,16,10,34,9,83,'Bisagra 1312-44',30.00,30.00,1.80,54.00),(54,16,10,34,9,NULL,'Servilleta restaurantera',4.00,2000.00,43.00,172.00),(55,16,10,34,9,NULL,'Inix Tapa DL98',2.00,200.00,65.00,130.00),(56,16,10,34,9,NULL,'Reyma Vaso 16EU',3.00,150.00,59.00,177.00),(57,16,10,34,9,NULL,'Popote Polyenkel',1.00,1000.00,65.00,65.00),(58,16,10,34,9,90,'Cerezas',1.00,4250.00,280.00,280.00),(59,17,10,34,9,77,'Crema batida Prices',5.00,1840.00,79.90,399.50),(60,18,10,34,9,NULL,'Leche Lala Nutri',2.00,2000.00,26.99,53.98),(61,19,10,34,9,NULL,'Servilleta restaurantera',1.00,500.00,22.50,22.50),(62,20,10,34,9,78,'Cono dorado doble rustico',1.00,125.00,384.26,384.26),(63,20,10,34,9,NULL,'ieps',1.00,1.00,30.74,30.74),(64,21,10,34,9,36,'Nieve de Chorro Vainilla',3.00,54000.00,585.00,1755.00),(65,21,10,34,9,37,'Nieve de Chorro Chocolate',1.50,27000.00,595.00,892.50),(66,21,10,34,9,80,'Cono Oblea',2.00,200.00,75.00,150.00),(67,22,10,34,9,NULL,'Leche NutriVakita',10.00,10000.00,17.90,179.00),(68,23,10,34,9,77,'Crema batida Prices',3.00,1104.00,79.90,239.70),(69,24,10,34,9,NULL,'Hielo 5kg',1.00,5000.00,34.00,34.00),(70,25,10,34,9,94,'Azucar Morena 5kg',1.00,5000.00,110.00,110.00),(71,26,10,34,9,NULL,'Oreo 252 grs',10.00,2520.00,25.95,259.50),(72,26,10,34,9,77,'Crema batida Prices',6.00,2208.00,79.90,479.40),(73,27,10,34,9,NULL,'Hielo 5kg',1.00,5000.00,34.00,34.00),(74,28,10,34,9,36,'Nieve de Chorro Vainilla',3.00,54000.00,585.00,1755.00),(75,28,10,34,9,95,'Cono 432 J/L',1.00,432.00,835.00,835.00),(76,29,10,34,9,96,'Harina Brownie 2.2kg',2.00,4400.00,244.49,488.98),(77,30,10,34,9,77,'Crema batida Prices',2.00,736.00,79.90,159.80),(78,30,10,34,9,NULL,'Oreo 252 grs',15.00,3780.00,25.95,389.25),(79,30,10,34,9,NULL,'Leche NutriVakita',6.00,6000.00,17.90,107.40),(80,31,10,34,9,NULL,'Huevo',1.00,12.00,49.50,49.50),(81,32,10,34,9,99,'Agua 500ml 45pz',1.00,45.00,111.00,111.00),(82,32,10,34,9,77,'Crema batida Prices',6.00,2208.00,65.47,392.82),(83,32,10,34,9,98,'Hershey Chocolate galon',2.00,6800.00,214.83,429.66),(84,33,10,34,9,NULL,'Leche NutriVakita',7.00,7000.00,17.90,125.30),(86,35,10,34,9,NULL,'Mazapan polvo',2.00,1816.00,99.00,198.00),(87,35,10,34,9,NULL,'Servilleta restaurantera',4.00,2000.00,43.00,172.00),(88,35,10,34,9,NULL,'Reyma Vaso 16EU',4.00,200.00,59.00,236.00),(89,36,10,34,9,NULL,'Hielo 5kg',1.00,5000.00,34.00,34.00),(90,37,10,34,9,78,'Cono dorado doble rustico',1.00,125.00,384.26,384.26),(91,37,10,34,9,77,'Crema batida Prices',5.00,1840.00,73.00,365.00),(92,37,10,34,9,79,'Fresa Comercial 1kg',3.00,3000.00,100.00,300.00),(93,37,10,34,9,NULL,'ieps',1.00,1.00,30.74,30.74),(94,38,10,34,9,36,'Nieve de Chorro Vainilla',2.00,36000.00,585.00,1170.00),(95,38,10,34,9,37,'Nieve de Chorro Chocolate',1.00,18000.00,595.00,595.00),(96,38,10,34,9,95,'Cono 432 J/L',1.00,432.00,835.00,835.00),(97,38,10,34,9,80,'Cono Oblea',3.00,300.00,75.00,225.00),(98,39,10,34,9,37,'Nieve de Chorro Chocolate',0.50,9000.00,595.00,297.50),(99,39,10,34,9,36,'Nieve de Chorro Vainilla',0.50,9000.00,585.00,292.50),(100,39,10,34,9,80,'Cono Oblea',2.00,200.00,75.00,150.00),(101,40,10,34,9,77,'Crema batida Prices',12.00,4416.00,65.47,785.64),(102,40,10,34,9,98,'Hershey Chocolate galon',1.00,3400.00,243.47,243.47),(103,40,10,34,9,NULL,'Mermelada Fresa 5kg',1.00,5000.00,306.90,306.90),(104,41,10,34,9,76,'Leche Lucerna 1.8L',1.00,1800.00,43.00,43.00),(105,42,10,34,9,102,'Bolsa churro',10.00,1000.00,9.00,90.00),(106,43,10,34,9,77,'Crema batida Prices',3.00,1104.00,79.90,239.70),(107,44,10,34,9,NULL,'Leche NutriVakita',13.00,13000.00,17.90,232.70),(108,45,10,34,9,36,'Nieve de Chorro Vainilla',4.00,72000.00,585.00,2340.00),(109,45,10,34,9,37,'Nieve de Chorro Chocolate',2.00,36000.00,595.00,1190.00),(110,46,10,34,9,NULL,'Hielo 5kg',1.00,5000.00,34.00,34.00),(111,47,10,34,9,77,'Crema batida Prices',7.00,2576.00,79.90,559.30),(112,48,10,34,9,78,'Cono dorado doble rustico',1.00,125.00,384.26,384.26),(113,48,10,34,9,79,'Fresa Comercial 1kg',4.00,4000.00,100.00,400.00),(114,48,10,34,9,NULL,'ieps',1.00,1.00,30.74,30.74),(115,49,10,34,9,37,'Nieve de Chorro Chocolate',0.50,9000.00,595.00,297.50),(116,49,10,34,9,36,'Nieve de Chorro Vainilla',2.00,36000.00,585.00,1170.00),(117,49,10,34,9,80,'Cono Oblea',3.00,300.00,75.00,225.00),(118,50,10,34,9,36,'Nieve de Chorro Vainilla',2.00,36000.00,585.00,1170.00),(119,50,10,34,9,37,'Nieve de Chorro Chocolate',1.00,18000.00,595.00,595.00),(120,50,10,34,9,80,'Cono Oblea',2.00,200.00,75.00,150.00),(121,51,10,34,9,NULL,'Servilleta restaurantera',3.00,1500.00,43.00,129.00),(122,52,10,34,9,95,'Cono 432 J/L',1.00,432.00,835.00,835.00),(123,52,10,34,9,80,'Cono Oblea',3.00,300.00,75.00,225.00),(124,53,10,34,9,77,'Crema batida Prices',5.00,1840.00,79.90,399.50),(125,54,10,34,9,NULL,'Hielo 5kg',2.00,10000.00,34.00,68.00),(127,56,10,34,9,NULL,'Leche NutriVakita',14.00,14000.00,17.90,250.60),(128,56,10,34,9,NULL,'Oreo 252 grs',4.00,1008.00,25.95,103.80),(129,56,10,34,9,NULL,'Oreo 252 grs',11.00,2772.00,25.95,285.45),(131,58,10,34,9,106,'Hershey Fresa 1.38kg',2.00,2760.00,132.83,265.66),(132,58,10,34,9,107,'Hershey Caramelo 623g',4.00,2492.00,73.26,293.04),(134,60,10,34,9,105,'Famous Amos galleta 2.38kg',1.00,2380.00,330.78,330.78),(135,60,10,34,9,103,'Coca cola Bote 35pz',1.00,35.00,328.93,328.93),(136,60,10,34,9,104,'9oz Vaso',1.00,264.00,221.63,221.63),(137,61,10,34,9,107,'Hershey Caramelo 623g',4.00,2492.00,73.26,293.04),(138,61,10,34,9,106,'Hershey Fresa 1.38kg',4.00,5520.00,132.83,531.32),(139,62,10,34,9,NULL,'Lechera 8pz',1.00,3000.00,225.06,225.06),(140,62,10,34,9,77,'Crema batida Prices',15.00,5520.00,65.47,982.05),(141,62,10,34,9,98,'Hershey Chocolate galon',1.00,3400.00,243.47,243.47),(143,64,10,34,9,NULL,'Oreo 252 grs',10.00,2520.00,33.40,334.00),(144,64,10,34,9,NULL,'Leche NutriVakita',10.00,10000.00,17.90,179.00),(145,65,10,34,9,82,'Cajeta Zagala 5kg',1.00,5000.00,325.00,325.00),(146,65,10,34,9,94,'Azucar Morena 5kg',1.00,5000.00,115.00,115.00),(147,65,10,34,9,109,'Cuchara Inix 25pz',22.00,550.00,5.50,121.00),(148,65,10,34,9,NULL,'Inix Tapa DL98',2.00,200.00,65.00,130.00),(149,65,10,34,9,NULL,'Reyma Vaso 16EU',3.00,150.00,59.00,177.00),(150,65,10,34,9,NULL,'Servilleta restaurantera',5.00,2500.00,43.00,215.00),(151,66,10,34,9,36,'Nieve de Chorro Vainilla',1.50,27000.00,585.00,877.50),(152,66,10,34,9,37,'Nieve de Chorro Chocolate',1.00,18000.00,595.00,595.00),(153,67,10,34,9,36,'Nieve de Chorro Vainilla',1.50,27000.00,585.00,877.50),(154,67,10,34,9,37,'Nieve de Chorro Chocolate',0.50,9000.00,595.00,297.50),(155,68,10,34,9,79,'Fresa Comercial 1kg',4.00,4000.00,100.00,400.00),(156,69,10,34,9,78,'Cono dorado doble rustico',1.00,125.00,384.26,384.26),(157,69,10,34,9,79,'Fresa Comercial 1kg',3.00,3000.00,100.00,300.00),(158,69,10,34,9,NULL,'ieps',1.00,1.00,30.74,30.74),(159,70,10,34,9,36,'Nieve de Chorro Vainilla',2.00,36000.00,585.00,1170.00),(160,70,10,34,9,37,'Nieve de Chorro Chocolate',1.00,18000.00,595.00,595.00),(161,70,10,34,9,95,'Cono 432 J/L',1.00,432.00,835.00,835.00),(162,70,10,34,9,80,'Cono Oblea',3.00,300.00,75.00,225.00),(163,71,10,34,9,NULL,'Hielo 5kg',2.00,10000.00,34.00,68.00),(164,72,10,34,9,36,'Nieve de Chorro Vainilla',2.50,45000.00,585.00,1462.50),(165,72,10,34,9,37,'Nieve de Chorro Chocolate',1.50,27000.00,595.00,892.50),(166,73,10,34,9,99,'Agua 500ml 45pz',1.00,45.00,111.00,111.00),(167,73,10,34,9,77,'Crema batida Prices',12.00,4416.00,65.47,785.64),(168,74,10,34,9,76,'Leche Lucerna 1.8L',1.00,1800.00,42.00,42.00),(169,74,10,34,9,NULL,'Hielo 5kg',1.00,5000.00,34.00,34.00),(170,75,10,34,9,NULL,'Leche NutriVakita',10.00,10000.00,17.90,179.00),(171,75,10,34,9,NULL,'Oreo 252 grs',15.00,3780.00,33.40,501.00),(172,76,10,34,9,36,'Nieve de Chorro Vainilla',3.00,54000.00,585.00,1755.00),(173,76,10,34,9,37,'Nieve de Chorro Chocolate',1.50,27000.00,595.00,892.50),(174,76,10,34,9,95,'Cono 432 J/L',1.00,432.00,835.00,835.00),(175,76,10,34,9,80,'Cono Oblea',3.00,300.00,75.00,225.00),(176,77,10,34,9,NULL,'Leche NutriVakita',12.00,12000.00,17.90,214.80),(177,77,10,34,9,NULL,'Oreo 252 grs',10.00,2520.00,33.40,334.00),(178,78,10,34,9,78,'Cono dorado doble rustico',1.00,125.00,384.26,384.26),(179,78,10,34,9,77,'Crema batida Prices',6.00,2208.00,73.00,438.00),(180,78,10,34,9,79,'Fresa Comercial 1kg',4.00,4000.00,100.00,400.00),(181,78,10,34,9,NULL,'ieps',1.00,1.00,30.74,30.74),(182,79,10,34,9,78,'Cono dorado doble rustico',2.00,250.00,384.26,768.52),(183,79,10,34,9,77,'Crema batida Prices',9.00,3312.00,73.00,657.00),(184,79,10,34,9,NULL,'ieps',1.00,1.00,61.48,61.48),(185,80,10,34,9,36,'Nieve de Chorro Vainilla',3.00,54000.00,585.00,1755.00),(186,80,10,34,9,37,'Nieve de Chorro Chocolate',1.50,27000.00,595.00,892.50),(187,80,10,34,9,80,'Cono Oblea',3.00,300.00,75.00,225.00),(188,81,10,34,9,83,'Bisagra 1312-44',29.00,29.00,1.60,46.40),(189,81,10,34,9,NULL,'Inix Tapa DL98',2.00,200.00,65.00,130.00),(190,81,10,34,9,NULL,'Reyma Vaso 16EU',2.00,100.00,59.00,118.00),(191,81,10,34,9,NULL,'Servilleta restaurantera',4.00,2000.00,43.00,172.00),(192,82,10,34,9,82,'Cajeta Zagala 5kg',1.00,5000.00,325.00,325.00),(193,82,10,34,9,NULL,'Servilleta restaurantera',3.00,1500.00,43.00,129.00),(194,83,10,34,9,NULL,'Servilleta restaurantera',1.00,500.00,43.00,43.00),(195,84,10,34,9,37,'Nieve de Chorro Chocolate',1.00,18000.00,595.00,595.00),(196,84,10,34,9,36,'Nieve de Chorro Vainilla',2.50,45000.00,585.00,1462.50),(197,84,10,34,9,95,'Cono 432 J/L',1.00,432.00,835.00,835.00),(198,85,10,34,9,NULL,'Hielo 5kg',1.00,5000.00,34.00,34.00),(199,86,10,34,9,NULL,'Leche NutriVakita',4.00,4000.00,17.90,71.60),(200,86,10,34,9,77,'Crema batida Prices',5.00,1840.00,79.90,399.50),(201,87,10,34,9,NULL,'Leche NutriVakita',6.00,6000.00,17.90,107.40),(202,87,10,34,9,NULL,'Oreo 252 grs',5.00,1260.00,33.40,167.00),(203,88,10,34,9,36,'Nieve de Chorro Vainilla',2.00,36000.00,585.00,1170.00),(204,88,10,34,9,37,'Nieve de Chorro Chocolate',0.50,9000.00,595.00,297.50),(205,89,10,34,9,NULL,'Hielo 5kg',2.00,10000.00,34.00,68.00),(206,90,10,34,9,37,'Nieve de Chorro Chocolate',1.50,27000.00,595.00,892.50),(207,90,10,34,9,36,'Nieve de Chorro Vainilla',3.00,54000.00,585.00,1755.00),(208,90,10,34,9,95,'Cono 432 J/L',1.00,432.00,835.00,835.00),(209,90,10,34,9,80,'Cono Oblea',3.00,300.00,75.00,225.00),(210,91,10,34,9,96,'Harina Brownie 2.2kg',2.00,4400.00,244.49,488.98),(211,92,10,34,9,NULL,'Hielo 5kg',1.00,5000.00,34.00,34.00),(212,93,10,34,9,94,'Azucar Morena 5kg',1.00,5000.00,115.00,115.00),(213,94,10,34,9,NULL,'Oreo 252 grs',3.00,756.00,34.99,104.97),(214,95,10,34,9,110,'Cacahuate .5kg',2.00,1000.00,58.00,116.00),(215,95,10,34,9,NULL,'Mazapan polvo',2.00,1816.00,99.00,198.00),(216,95,10,34,9,NULL,'Popote Polyenkel',1.00,1000.00,65.00,65.00),(217,95,10,34,9,NULL,'Servilleta restaurantera',4.00,2000.00,43.00,172.00),(218,95,10,34,9,NULL,'Reyma Vaso 16EU',3.00,150.00,59.00,177.00),(219,96,10,34,9,79,'Fresa Comercial 1kg',5.00,5000.00,100.00,500.00),(220,97,10,34,9,NULL,'Oreo 252 grs',5.00,1260.00,33.40,167.00),(221,97,10,34,9,NULL,'Leche NutriVakita',6.00,6000.00,17.90,107.40),(222,98,10,34,9,NULL,'Inix Tapa DL98',1.00,100.00,65.00,65.00),(223,98,10,34,9,NULL,'Reyma Vaso 16EU',2.00,100.00,59.00,118.00),(224,99,10,34,9,NULL,'Hielo 5kg',1.00,5000.00,34.00,34.00),(225,100,10,34,9,NULL,'Lechera indiv',6.00,2250.00,30.00,180.00),(226,101,10,34,9,77,'Crema batida Prices',5.00,1840.00,79.90,399.50),(227,102,10,34,9,78,'Cono dorado doble rustico',1.00,125.00,384.26,384.26),(228,102,10,34,9,79,'Fresa Comercial 1kg',3.00,3000.00,100.00,300.00),(230,104,10,9,9,165,'Agua 20 lts dispensador',1.00,20000.00,80.00,80.00),(231,105,10,9,9,168,'Etiquetas Frappe',2500.00,2500.00,0.53,1312.50),(232,105,10,9,9,169,'Etiquetas Malteadas',2500.00,2500.00,0.53,1312.50);
/*!40000 ALTER TABLE `detalle_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_venta`
--

DROP TABLE IF EXISTS `detalle_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalle_venta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_terminado_id` int(11) DEFAULT NULL,
  `venta_id` int(11) NOT NULL,
  `mercancia_id` int(11) NOT NULL,
  `unidades` decimal(10,2) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_venta`
--

LOCK TABLES `detalle_venta` WRITE;
/*!40000 ALTER TABLE `detalle_venta` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresa_configuracion`
--

DROP TABLE IF EXISTS `empresa_configuracion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empresa_configuracion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL,
  `empleados_rango` enum('1-5','6-10','11-25','26-99','100-200','200+') NOT NULL,
  `tipo_comprobantes` enum('solo_facturas','solo_tickets','mixto') NOT NULL,
  `tipo_mercancia` enum('materia_prima','producto_directo') NOT NULL,
  `requiere_manufactura` tinyint(1) DEFAULT 0,
  `requiere_wip` tinyint(1) DEFAULT 0,
  `requiere_recetas` tinyint(1) DEFAULT 0,
  `nivel_complejidad` enum('basico','intermedio','avanzado') DEFAULT 'basico',
  `modulo_compras` tinyint(1) DEFAULT 1,
  `modulo_ventas` tinyint(1) DEFAULT 1,
  `modulo_inventario_mp` tinyint(1) DEFAULT 1,
  `modulo_inventario_wip` tinyint(1) DEFAULT 0,
  `modulo_inventario_pt` tinyint(1) DEFAULT 1,
  `modulo_produccion` tinyint(1) DEFAULT 0,
  `modulo_contabilidad` tinyint(1) DEFAULT 0,
  `frecuencia_inventario` enum('turno','diario','semanal','mensual','anual','otro') DEFAULT 'turno',
  `frecuencia_inventario_desc` varchar(255) DEFAULT NULL,
  `fecha_configuracion` datetime DEFAULT current_timestamp(),
  `configuracion_completada` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_empresa` (`empresa_id`),
  KEY `idx_empresa` (`empresa_id`),
  CONSTRAINT `empresa_configuracion_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa_configuracion`
--

LOCK TABLES `empresa_configuracion` WRITE;
/*!40000 ALTER TABLE `empresa_configuracion` DISABLE KEYS */;
INSERT INTO `empresa_configuracion` VALUES (1,1,'1-5','mixto','producto_directo',0,0,0,'basico',1,1,1,0,1,0,1,'turno',NULL,'2025-12-02 22:50:50',1),(3,12,'1-5','solo_facturas','materia_prima',0,0,0,'basico',1,1,1,0,1,0,0,'turno',NULL,'2026-01-08 22:36:01',0),(4,13,'1-5','solo_facturas','materia_prima',0,0,0,'basico',1,1,1,0,1,0,0,'turno',NULL,'2026-01-09 17:02:47',0);
/*!40000 ALTER TABLE `empresa_configuracion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresa_modulos`
--

DROP TABLE IF EXISTS `empresa_modulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empresa_modulos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL,
  `modulo_id` int(11) NOT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `fecha_activacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_desactivacion` timestamp NULL DEFAULT NULL,
  `configuracion` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`configuracion`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_empresa_modulo` (`empresa_id`,`modulo_id`),
  KEY `idx_empresa` (`empresa_id`),
  KEY `idx_modulo` (`modulo_id`),
  KEY `idx_activo` (`activo`),
  CONSTRAINT `fk_em_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_em_modulo` FOREIGN KEY (`modulo_id`) REFERENCES `catalogo_modulos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa_modulos`
--

LOCK TABLES `empresa_modulos` WRITE;
/*!40000 ALTER TABLE `empresa_modulos` DISABLE KEYS */;
INSERT INTO `empresa_modulos` VALUES (5,5,1,1,'2025-12-29 04:48:00',NULL,NULL),(6,5,3,1,'2025-12-29 04:48:01',NULL,NULL),(7,5,2,1,'2025-12-29 04:48:06',NULL,NULL),(14,9,1,1,'2025-12-31 05:43:16',NULL,NULL),(15,9,2,1,'2025-12-31 05:43:16',NULL,NULL),(16,9,3,1,'2025-12-31 05:43:16',NULL,NULL),(17,9,4,1,'2025-12-31 05:43:16',NULL,NULL),(18,9,7,1,'2025-12-31 05:43:16',NULL,NULL),(19,10,1,1,'2025-12-31 05:48:43',NULL,NULL),(20,10,2,1,'2025-12-31 05:48:43',NULL,NULL),(21,10,3,1,'2025-12-31 05:48:43',NULL,NULL),(22,10,4,1,'2025-12-31 05:48:43',NULL,NULL),(23,10,7,1,'2025-12-31 05:48:43',NULL,NULL);
/*!40000 ALTER TABLE `empresa_modulos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresas`
--

DROP TABLE IF EXISTS `empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empresas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contratante_id` int(11) DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  `rfc` varchar(20) DEFAULT NULL,
  `puede_compartir_rfc` tinyint(1) DEFAULT 1,
  `direccion` text DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `uso_descripcion` text DEFAULT NULL,
  `tipo_empresa` enum('holding','produccion','punto_venta','administracion','logistica') DEFAULT 'punto_venta',
  `destino_inventario_b2b` enum('pt','mp','manual') NOT NULL DEFAULT 'manual',
  `responsable_nombre` varchar(100) DEFAULT NULL,
  `responsable_puesto` varchar(100) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_registro` datetime DEFAULT current_timestamp(),
  `logo_url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_rfc` (`rfc`),
  KEY `idx_contratante` (`contratante_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresas`
--

LOCK TABLES `empresas` WRITE;
/*!40000 ALTER TABLE `empresas` DISABLE KEYS */;
INSERT INTO `empresas` VALUES (1,1,'Yolo SA de CV',NULL,1,NULL,NULL,NULL,NULL,'holding','mp',NULL,NULL,1,'2025-12-02 22:50:02','2025-12-02 22:50:02',NULL),(5,5,'Yolo Pasaje','GAEF760207I26',1,NULL,NULL,NULL,NULL,'punto_venta','mp',NULL,NULL,0,'2025-12-28 21:45:47','2025-12-28 21:45:47',NULL),(9,8,'Centro de Produccion','gaef760207i26',1,NULL,NULL,NULL,NULL,'punto_venta','manual',NULL,NULL,0,'2025-12-30 22:43:00','2025-12-30 22:43:00',NULL),(10,9,'Centro de Produccion','gaef760207i26',1,NULL,NULL,NULL,NULL,'produccion','pt',NULL,NULL,1,'2025-12-30 22:48:16','2025-12-30 22:48:16','/static/logos/empresa_10_3f8505f8-ada4-4b96-a452-b84e2215ecc3.jpg'),(12,9,'Yolo Pasaje','GAEF760207I26',1,'','','',NULL,'punto_venta','pt',NULL,NULL,1,'2026-01-08 22:36:01','2026-01-08 22:36:01','/static/logos/empresa_12_WhatsApp_Image_2026-01-24_at_4.23.17_PM.jpeg'),(13,9,'Yolo Cines','',1,'','','','Empresa a la que se surte mercancia para Punto de venta final al cliente publico en general','punto_venta','pt','','',1,'2026-01-09 17:02:47','2026-01-09 17:02:47','/static/logos/empresa_13_WhatsApp_Image_2026-01-24_at_4.22.38_PM.jpeg');
/*!40000 ALTER TABLE `empresas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura_b2b_checklist`
--

DROP TABLE IF EXISTS `factura_b2b_checklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factura_b2b_checklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `factura_id` int(11) NOT NULL,
  `detalle_id` int(11) NOT NULL,
  `rol` varchar(50) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `verificado` tinyint(1) DEFAULT 0,
  `cantidad_verificada` decimal(12,3) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `usuario_nombre` varchar(100) DEFAULT NULL,
  `fecha_verificacion` datetime DEFAULT NULL,
  `tiene_diferencia` tinyint(1) DEFAULT 0,
  `tipo_diferencia` varchar(50) DEFAULT NULL,
  `cantidad_diferencia` decimal(12,3) DEFAULT NULL,
  `notas` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_detalle_rol` (`detalle_id`,`rol`,`empresa_id`),
  KEY `idx_factura` (`factura_id`),
  KEY `idx_detalle` (`detalle_id`),
  KEY `idx_rol` (`rol`),
  CONSTRAINT `factura_b2b_checklist_ibfk_1` FOREIGN KEY (`factura_id`) REFERENCES `facturas_b2b` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura_b2b_checklist`
--

LOCK TABLES `factura_b2b_checklist` WRITE;
/*!40000 ALTER TABLE `factura_b2b_checklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `factura_b2b_checklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura_b2b_tracking`
--

DROP TABLE IF EXISTS `factura_b2b_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factura_b2b_tracking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `factura_id` int(11) NOT NULL,
  `estado_anterior` varchar(50) DEFAULT NULL,
  `estado_nuevo` varchar(50) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `usuario_nombre` varchar(100) DEFAULT NULL,
  `rol` varchar(50) DEFAULT NULL,
  `empresa_id` int(11) DEFAULT NULL,
  `accion` varchar(100) DEFAULT NULL,
  `notas` text DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_factura` (`factura_id`),
  KEY `idx_fecha` (`fecha`),
  CONSTRAINT `factura_b2b_tracking_ibfk_1` FOREIGN KEY (`factura_id`) REFERENCES `facturas_b2b` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura_b2b_tracking`
--

LOCK TABLES `factura_b2b_tracking` WRITE;
/*!40000 ALTER TABLE `factura_b2b_tracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `factura_b2b_tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facturas_b2b`
--

DROP TABLE IF EXISTS `facturas_b2b`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facturas_b2b` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_emisora_id` int(11) NOT NULL,
  `empresa_receptora_id` int(11) NOT NULL,
  `turno_id` int(11) DEFAULT NULL,
  `orden_compra_id` int(11) DEFAULT NULL,
  `folio` varchar(30) NOT NULL,
  `fecha_emision` datetime NOT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `iva` decimal(12,2) DEFAULT 0.00,
  `total` decimal(12,2) NOT NULL,
  `forma_pago` varchar(50) DEFAULT 'Transferencia',
  `metodo_pago` enum('PUE','PPD') DEFAULT 'PUE',
  `condiciones_pago` varchar(255) DEFAULT NULL,
  `estado` enum('emitida','pendiente','en_revision','recibida','con_diferencias','cancelada') DEFAULT 'emitida',
  `estado_almacen` varchar(30) DEFAULT 'pendiente',
  `estado_reparto` varchar(30) DEFAULT 'pendiente',
  `estado_entrega` varchar(30) DEFAULT 'pendiente',
  `fecha_recepcion` datetime DEFAULT NULL,
  `recibida_por_usuario_id` int(11) DEFAULT NULL,
  `almacen_completado_por` int(11) DEFAULT NULL,
  `almacen_completado_fecha` datetime DEFAULT NULL,
  `reparto_asignado_a` int(11) DEFAULT NULL,
  `reparto_recogido_fecha` datetime DEFAULT NULL,
  `reparto_entregado_fecha` datetime DEFAULT NULL,
  `cliente_almacen_usuario_id` int(11) DEFAULT NULL,
  `cliente_almacen_fecha` datetime DEFAULT NULL,
  `notas_recepcion` text DEFAULT NULL,
  `emitida_por_usuario_id` int(11) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_actualizacion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `recibida_por_usuario_id` (`recibida_por_usuario_id`),
  KEY `emitida_por_usuario_id` (`emitida_por_usuario_id`),
  KEY `idx_emisora` (`empresa_emisora_id`),
  KEY `idx_receptora` (`empresa_receptora_id`),
  KEY `idx_estado` (`estado`),
  CONSTRAINT `facturas_b2b_ibfk_1` FOREIGN KEY (`empresa_emisora_id`) REFERENCES `empresas` (`id`),
  CONSTRAINT `facturas_b2b_ibfk_2` FOREIGN KEY (`empresa_receptora_id`) REFERENCES `empresas` (`id`),
  CONSTRAINT `facturas_b2b_ibfk_3` FOREIGN KEY (`recibida_por_usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `facturas_b2b_ibfk_4` FOREIGN KEY (`emitida_por_usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facturas_b2b`
--

LOCK TABLES `facturas_b2b` WRITE;
/*!40000 ALTER TABLE `facturas_b2b` DISABLE KEYS */;
/*!40000 ALTER TABLE `facturas_b2b` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facturas_b2b_detalle`
--

DROP TABLE IF EXISTS `facturas_b2b_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facturas_b2b_detalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `factura_id` int(11) NOT NULL,
  `mercancia_id` int(11) DEFAULT NULL,
  `descripcion` varchar(500) NOT NULL,
  `cantidad_facturada` decimal(12,3) NOT NULL,
  `cantidad_recibida` decimal(12,3) DEFAULT NULL,
  `precio_unitario` decimal(12,2) NOT NULL,
  `descuento` decimal(12,2) DEFAULT 0.00,
  `iva_rate` decimal(5,4) DEFAULT 0.1600,
  `importe` decimal(12,2) NOT NULL,
  `verificado` tinyint(1) DEFAULT 0,
  `verificado_por_usuario_id` int(11) DEFAULT NULL,
  `fecha_verificacion` datetime DEFAULT NULL,
  `tiene_diferencia` tinyint(1) DEFAULT 0,
  `tipo_diferencia` enum('faltante','sobrante','da?ado','otro') DEFAULT NULL,
  `notas_verificacion` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `factura_id` (`factura_id`),
  KEY `mercancia_id` (`mercancia_id`),
  KEY `verificado_por_usuario_id` (`verificado_por_usuario_id`),
  CONSTRAINT `facturas_b2b_detalle_ibfk_1` FOREIGN KEY (`factura_id`) REFERENCES `facturas_b2b` (`id`) ON DELETE CASCADE,
  CONSTRAINT `facturas_b2b_detalle_ibfk_2` FOREIGN KEY (`mercancia_id`) REFERENCES `mercancia` (`id`),
  CONSTRAINT `facturas_b2b_detalle_ibfk_3` FOREIGN KEY (`verificado_por_usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facturas_b2b_detalle`
--

LOCK TABLES `facturas_b2b_detalle` WRITE;
/*!40000 ALTER TABLE `facturas_b2b_detalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `facturas_b2b_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facturas_notificaciones`
--

DROP TABLE IF EXISTS `facturas_notificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facturas_notificaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_destino_id` int(11) NOT NULL,
  `tipo_origen` enum('b2b','cfdi','cxp','cxc') NOT NULL,
  `origen_id` int(11) NOT NULL,
  `tipo_notificacion` enum('nueva','recibida','diferencia','pago','vencimiento','cancelada') NOT NULL,
  `mensaje` text DEFAULT NULL,
  `leida` tinyint(1) DEFAULT 0,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `empresa_destino_id` (`empresa_destino_id`),
  CONSTRAINT `facturas_notificaciones_ibfk_1` FOREIGN KEY (`empresa_destino_id`) REFERENCES `empresas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facturas_notificaciones`
--

LOCK TABLES `facturas_notificaciones` WRITE;
/*!40000 ALTER TABLE `facturas_notificaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `facturas_notificaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_asignaciones_area`
--

DROP TABLE IF EXISTS `historial_asignaciones_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historial_asignaciones_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `rol_anterior` varchar(50) DEFAULT NULL,
  `rol_nuevo` varchar(50) DEFAULT NULL,
  `accion` enum('asignado','modificado','removido') NOT NULL,
  `realizado_por` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `notas` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `empresa_id` (`empresa_id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `area_id` (`area_id`),
  KEY `realizado_por` (`realizado_por`),
  CONSTRAINT `historial_asignaciones_area_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  CONSTRAINT `historial_asignaciones_area_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `historial_asignaciones_area_ibfk_3` FOREIGN KEY (`area_id`) REFERENCES `areas_sistema` (`id`),
  CONSTRAINT `historial_asignaciones_area_ibfk_4` FOREIGN KEY (`realizado_por`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial_asignaciones_area`
--

LOCK TABLES `historial_asignaciones_area` WRITE;
/*!40000 ALTER TABLE `historial_asignaciones_area` DISABLE KEYS */;
/*!40000 ALTER TABLE `historial_asignaciones_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_pagos`
--

DROP TABLE IF EXISTS `historial_pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historial_pagos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `suscripcion_id` int(11) NOT NULL,
  `contratante_id` int(11) NOT NULL,
  `fecha_pago` timestamp NOT NULL DEFAULT current_timestamp(),
  `monto` decimal(10,2) NOT NULL,
  `metodo_pago` varchar(50) DEFAULT NULL,
  `referencia` varchar(100) DEFAULT NULL,
  `estado` enum('PENDIENTE','COMPLETADO','FALLIDO','REEMBOLSADO') DEFAULT 'PENDIENTE',
  `factura_id` int(11) DEFAULT NULL,
  `notas` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_suscripcion` (`suscripcion_id`),
  KEY `idx_contratante` (`contratante_id`),
  KEY `idx_fecha` (`fecha_pago`),
  CONSTRAINT `fk_pago_contratante` FOREIGN KEY (`contratante_id`) REFERENCES `contratantes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_pago_suscripcion` FOREIGN KEY (`suscripcion_id`) REFERENCES `suscripciones` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial_pagos`
--

LOCK TABLES `historial_pagos` WRITE;
/*!40000 ALTER TABLE `historial_pagos` DISABLE KEYS */;
/*!40000 ALTER TABLE `historial_pagos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incidencias`
--

DROP TABLE IF EXISTS `incidencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incidencias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  `tipo_tarea` enum('produccion','compras','recepcion','almacen','reparto','cobranza','cuentas_pagar','ventas','contabilidad','mantenimiento','general') DEFAULT 'general',
  `categoria` enum('operacional','calidad','seguridad','mejora','reporte','mantenimiento','administrativo','rrhh','sistemas') DEFAULT 'operacional',
  `titulo` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `responsable_id` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `estado` enum('nueva','asignada','en_analisis','en_proceso','en_revision','resuelta','cerrada','reabierta','cancelada') DEFAULT 'nueva',
  `prioridad` enum('baja','normal','alta','urgente') DEFAULT 'normal',
  `severidad` enum('critica','alta','media','baja') DEFAULT 'media',
  `fecha_asignacion` datetime DEFAULT current_timestamp(),
  `fecha_cumplimiento` date DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_completado` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `area_id` (`area_id`),
  KEY `responsable_id` (`responsable_id`),
  KEY `created_by` (`created_by`),
  KEY `idx_incidencias_empresa` (`empresa_id`),
  CONSTRAINT `incidencias_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  CONSTRAINT `incidencias_ibfk_2` FOREIGN KEY (`area_id`) REFERENCES `areas_produccion` (`id`),
  CONSTRAINT `incidencias_ibfk_3` FOREIGN KEY (`responsable_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `incidencias_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidencias`
--

LOCK TABLES `incidencias` WRITE;
/*!40000 ALTER TABLE `incidencias` DISABLE KEYS */;
/*!40000 ALTER TABLE `incidencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incidencias_bitacora`
--

DROP TABLE IF EXISTS `incidencias_bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incidencias_bitacora` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `incidencia_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `accion` varchar(100) NOT NULL,
  `detalle` text DEFAULT NULL,
  `fecha_accion` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `incidencia_id` (`incidencia_id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `incidencias_bitacora_ibfk_1` FOREIGN KEY (`incidencia_id`) REFERENCES `incidencias` (`id`) ON DELETE CASCADE,
  CONSTRAINT `incidencias_bitacora_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidencias_bitacora`
--

LOCK TABLES `incidencias_bitacora` WRITE;
/*!40000 ALTER TABLE `incidencias_bitacora` DISABLE KEYS */;
/*!40000 ALTER TABLE `incidencias_bitacora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_movimientos_mp`
--

DROP TABLE IF EXISTS `inventario_movimientos_mp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventario_movimientos_mp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mp_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `tipo_movimiento` enum('entrada','salida') NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `costo_unitario` decimal(10,2) NOT NULL,
  `costo_total` decimal(10,2) NOT NULL,
  `referencia_tipo` varchar(50) DEFAULT NULL,
  `referencia_id` int(11) DEFAULT NULL,
  `almacen_id` int(11) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `empresa_id` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `mp_id` (`mp_id`),
  KEY `almacen_id` (`almacen_id`),
  KEY `idx_referencia` (`referencia_tipo`,`referencia_id`),
  KEY `idx_empresa` (`empresa_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_movimientos_mp`
--

LOCK TABLES `inventario_movimientos_mp` WRITE;
/*!40000 ALTER TABLE `inventario_movimientos_mp` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventario_movimientos_mp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_movimientos_producto_base`
--

DROP TABLE IF EXISTS `inventario_movimientos_producto_base`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventario_movimientos_producto_base` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_base_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `tipo_movimiento` enum('entrada','salida') NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `costo_unitario` decimal(10,2) NOT NULL,
  `costo_total` decimal(10,2) NOT NULL,
  `referencia_tipo` varchar(50) DEFAULT NULL,
  `referencia_id` int(11) DEFAULT NULL,
  `almacen_id` int(11) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `empresa_id` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `producto_base_id` (`producto_base_id`),
  KEY `almacen_id` (`almacen_id`),
  KEY `idx_referencia` (`referencia_tipo`,`referencia_id`),
  KEY `idx_empresa` (`empresa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_movimientos_producto_base`
--

LOCK TABLES `inventario_movimientos_producto_base` WRITE;
/*!40000 ALTER TABLE `inventario_movimientos_producto_base` DISABLE KEYS */;
INSERT INTO `inventario_movimientos_producto_base` VALUES (1,54,'2025-09-03','',1.00,615.00,615.00,'manual',NULL,1,'51',NULL,'2026-01-16 14:52:08',1);
/*!40000 ALTER TABLE `inventario_movimientos_producto_base` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_movimientos_pt`
--

DROP TABLE IF EXISTS `inventario_movimientos_pt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventario_movimientos_pt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pt_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `tipo_movimiento` enum('entrada','salida') NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `costo_unitario` decimal(10,2) NOT NULL,
  `costo_total` decimal(10,2) NOT NULL,
  `referencia_tipo` varchar(50) DEFAULT NULL,
  `referencia_id` int(11) DEFAULT NULL,
  `almacen_id` int(11) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `empresa_id` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `pt_id` (`pt_id`),
  KEY `almacen_id` (`almacen_id`),
  KEY `idx_referencia` (`referencia_tipo`,`referencia_id`),
  KEY `idx_empresa` (`empresa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_movimientos_pt`
--

LOCK TABLES `inventario_movimientos_pt` WRITE;
/*!40000 ALTER TABLE `inventario_movimientos_pt` DISABLE KEYS */;
INSERT INTO `inventario_movimientos_pt` VALUES (1,76,'2025-12-03','entrada',1800.00,42.00,42.00,'compra',4,NULL,NULL,34,'2026-05-07 03:50:44',10),(2,77,'2025-12-03','entrada',736.00,79.90,159.80,'compra',6,NULL,NULL,34,'2026-05-07 03:50:44',10),(3,77,'2025-12-04','entrada',1840.00,73.00,365.00,'compra',9,NULL,NULL,34,'2026-05-07 03:50:44',10),(4,76,'2025-12-04','entrada',3600.00,42.00,84.00,'compra',10,NULL,NULL,34,'2026-05-07 03:50:44',10),(5,80,'2025-12-04','entrada',300.00,75.00,225.00,'compra',11,NULL,NULL,34,'2026-05-07 03:50:44',10),(6,76,'2025-12-05','entrada',1800.00,42.00,42.00,'compra',12,NULL,NULL,34,'2026-05-07 03:50:44',10),(7,76,'2025-12-06','entrada',1800.00,42.00,42.00,'compra',15,NULL,NULL,34,'2026-05-07 03:50:44',10),(8,77,'2025-12-06','entrada',1840.00,79.90,399.50,'compra',17,NULL,NULL,34,'2026-05-07 03:50:44',10),(9,80,'2025-12-07','entrada',200.00,75.00,150.00,'compra',21,NULL,NULL,34,'2026-05-07 03:50:44',10),(10,77,'2025-12-07','entrada',1104.00,79.90,239.70,'compra',23,NULL,NULL,34,'2026-05-07 03:50:44',10),(11,77,'2025-12-07','entrada',2208.00,79.90,479.40,'compra',26,NULL,NULL,34,'2026-05-07 03:50:44',10),(12,77,'2025-12-09','entrada',736.00,79.90,159.80,'compra',30,NULL,NULL,34,'2026-05-07 03:50:44',10),(13,99,'2025-12-09','entrada',45.00,111.00,111.00,'compra',32,NULL,NULL,34,'2026-05-07 03:50:44',10),(14,77,'2025-12-09','entrada',2208.00,65.47,392.82,'compra',32,NULL,NULL,34,'2026-05-07 03:50:44',10),(15,77,'2025-12-12','entrada',1840.00,73.00,365.00,'compra',37,NULL,NULL,34,'2026-05-07 03:50:44',10),(16,80,'2025-12-12','entrada',300.00,75.00,225.00,'compra',38,NULL,NULL,34,'2026-05-07 03:50:44',10),(17,80,'2025-12-12','entrada',200.00,75.00,150.00,'compra',39,NULL,NULL,34,'2026-05-07 03:50:44',10),(18,77,'2025-12-13','entrada',4416.00,65.47,785.64,'compra',40,NULL,NULL,34,'2026-05-07 03:50:44',10),(19,76,'2025-12-13','entrada',1800.00,43.00,43.00,'compra',41,NULL,NULL,34,'2026-05-07 03:50:44',10),(20,77,'2025-12-13','entrada',1104.00,79.90,239.70,'compra',43,NULL,NULL,34,'2026-05-07 03:50:44',10),(21,77,'2025-12-13','entrada',2576.00,79.90,559.30,'compra',47,NULL,NULL,34,'2026-05-07 03:50:44',10),(22,80,'2025-12-14','entrada',300.00,75.00,225.00,'compra',49,NULL,NULL,34,'2026-05-07 03:50:44',10),(23,80,'2025-12-16','entrada',200.00,75.00,150.00,'compra',50,NULL,NULL,34,'2026-05-07 03:50:44',10),(24,80,'2025-12-17','entrada',300.00,75.00,225.00,'compra',52,NULL,NULL,34,'2026-05-07 03:50:44',10),(25,77,'2025-12-17','entrada',1840.00,79.90,399.50,'compra',53,NULL,NULL,34,'2026-05-07 03:50:44',10),(26,107,'2025-12-18','entrada',2492.00,73.26,293.04,'compra',58,NULL,NULL,34,'2026-05-07 03:50:44',10),(27,103,'2025-12-18','entrada',35.00,328.93,328.93,'compra',60,NULL,NULL,34,'2026-05-07 03:50:44',10),(28,104,'2025-12-18','entrada',264.00,221.63,221.63,'compra',60,NULL,NULL,34,'2026-05-07 03:50:44',10),(29,107,'2025-12-18','entrada',2492.00,73.26,293.04,'compra',61,NULL,NULL,34,'2026-05-07 03:50:44',10),(30,77,'2025-12-18','entrada',5520.00,65.47,982.05,'compra',62,NULL,NULL,34,'2026-05-07 03:50:44',10),(31,109,'2025-12-19','entrada',550.00,5.50,121.00,'compra',65,NULL,NULL,34,'2026-05-07 03:50:44',10),(32,80,'2025-12-20','entrada',300.00,75.00,225.00,'compra',70,NULL,NULL,34,'2026-05-07 03:50:44',10),(33,99,'2025-12-21','entrada',45.00,111.00,111.00,'compra',73,NULL,NULL,34,'2026-05-07 03:50:44',10),(34,77,'2025-12-21','entrada',4416.00,65.47,785.64,'compra',73,NULL,NULL,34,'2026-05-07 03:50:44',10),(35,76,'2025-12-21','entrada',1800.00,42.00,42.00,'compra',74,NULL,NULL,34,'2026-05-07 03:50:44',10),(36,80,'2025-12-21','entrada',300.00,75.00,225.00,'compra',76,NULL,NULL,34,'2026-05-07 03:50:44',10),(37,77,'2025-12-22','entrada',2208.00,73.00,438.00,'compra',78,NULL,NULL,34,'2026-05-07 03:50:44',10),(38,77,'2025-12-23','entrada',3312.00,73.00,657.00,'compra',79,NULL,NULL,34,'2026-05-07 03:50:44',10),(39,80,'2025-12-23','entrada',300.00,75.00,225.00,'compra',80,NULL,NULL,34,'2026-05-07 03:50:44',10),(40,77,'2025-12-25','entrada',1840.00,79.90,399.50,'compra',86,NULL,NULL,34,'2026-05-07 03:50:44',10),(41,80,'2025-12-27','entrada',300.00,75.00,225.00,'compra',90,NULL,NULL,34,'2026-05-07 03:50:44',10),(42,77,'2025-12-31','entrada',1840.00,79.90,399.50,'compra',101,NULL,NULL,34,'2026-05-07 03:50:44',10);
/*!40000 ALTER TABLE `inventario_movimientos_pt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_mp`
--

DROP TABLE IF EXISTS `inventario_mp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventario_mp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL,
  `mercancia_id` int(11) NOT NULL,
  `producto` varchar(255) NOT NULL,
  `inventario_inicial` decimal(10,2) DEFAULT 0.00,
  `entradas` decimal(10,2) DEFAULT 0.00,
  `salidas` decimal(10,2) DEFAULT 0.00,
  `aprobado` tinyint(4) DEFAULT 0,
  `disponible_base` decimal(10,2) DEFAULT 0.00,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_mp`
--

LOCK TABLES `inventario_mp` WRITE;
/*!40000 ALTER TABLE `inventario_mp` DISABLE KEYS */;
INSERT INTO `inventario_mp` VALUES (1,10,104,'9oz Vaso',0.00,0.00,0.00,0,0.00),(2,10,113,'Azucar 1 kg',0.00,0.00,0.00,0,0.00),(3,10,99,'Agua 500ml 45pz',0.00,0.00,0.00,0,0.00),(4,10,113,'Azucar 1 kg',0.00,0.00,0.00,0,0.00),(5,10,94,'Azucar Morena 5kg',0.00,0.00,0.00,0,0.00),(6,10,83,'Bisagra 1312-44',0.00,0.00,0.00,0,0.00),(7,10,102,'Bolsa churro',0.00,0.00,0.00,0,0.00),(8,10,110,'Cacahuate .5kg',0.00,0.00,0.00,0,0.00),(9,10,82,'Cajeta Zagala 5kg',0.00,0.00,0.00,0,0.00),(10,10,90,'Cerezas',0.00,0.00,0.00,0,0.00),(11,10,103,'Coca cola Bote 35pz',0.00,0.00,0.00,0,0.00),(12,10,109,'Cuchara Inix 25pz',0.00,0.00,0.00,0,0.00),(13,10,101,'Tapa Plastica 100pz',0.00,0.00,0.00,0,0.00),(14,10,81,'Servilletas',0.00,0.00,0.00,0,0.00),(15,10,99,'Agua 500ml 45pz',0.00,0.00,0.00,0,0.00),(16,10,113,'Azucar 1 kg',0.00,0.00,0.00,0,0.00),(17,10,94,'Azucar Morena 5kg',0.00,0.00,0.00,0,0.00),(18,10,83,'Bisagra 1312-44',0.00,0.00,0.00,0,0.00),(19,10,102,'Bolsa churro',0.00,0.00,0.00,0,0.00),(20,10,110,'Cacahuate .5kg',0.00,0.00,0.00,0,0.00),(21,10,82,'Cajeta Zagala 5kg',0.00,0.00,0.00,0,0.00),(22,10,90,'Cerezas galon',0.00,0.00,0.00,0,0.00),(23,10,103,'Coca cola Bote 35pz',0.00,0.00,0.00,0,0.00),(24,10,95,'Cono 432 J/L',0.00,0.00,0.00,0,0.00),(25,10,78,'Cono dorado doble rustico',0.00,0.00,0.00,0,0.00),(26,10,78,'Cono dorado doble rustico',0.00,0.00,0.00,0,0.00),(27,10,80,'Cono Oblea',0.00,0.00,0.00,0,0.00),(28,10,77,'Crema batida Prices',0.00,0.00,0.00,0,0.00),(29,10,109,'Cuchara Inix 25pz',0.00,0.00,0.00,0,0.00),(30,10,105,'Famous Amos galleta 2.38kg',0.00,0.00,0.00,0,0.00),(31,10,79,'Fresa Comercial 1kg',0.00,0.00,0.00,0,0.00),(32,10,35,'Galleta Oreo 252gr',0.00,0.00,0.00,0,0.00),(33,10,96,'Harina Brownie 2.2kg',0.00,0.00,0.00,0,0.00),(34,10,107,'Hershey Caramelo 623g',0.00,0.00,0.00,0,0.00),(35,10,98,'Hershey Chocolate galon',0.00,0.00,0.00,0,0.00),(36,10,106,'Hershey Fresa 1.38kg',0.00,0.00,0.00,0,0.00),(37,10,38,'Leche Vitalait',0.00,0.00,0.00,0,0.00),(38,10,76,'Leche Lucerna 1.8L',0.00,0.00,0.00,0,0.00),(39,10,37,'Nieve de Chorro Chocolate',0.00,0.00,0.00,0,0.00),(40,10,36,'Nieve de Chorro Vainilla',0.00,0.00,0.00,0,0.00),(41,10,100,'Popotes',0.00,0.00,0.00,0,0.00),(42,10,81,'Servilleta restaurantera',0.00,0.00,0.00,0,0.00),(43,10,101,'Tapa Plastica 100pz',0.00,0.00,0.00,0,0.00),(45,10,116,'',0.00,0.00,0.00,0,0.00),(46,10,117,'',0.00,0.00,0.00,0,0.00),(47,10,118,'',0.00,0.00,0.00,0,0.00),(48,10,119,'',0.00,0.00,0.00,0,0.00),(49,10,120,'',0.00,0.00,0.00,0,0.00),(50,10,121,'',0.00,0.00,0.00,0,0.00),(51,10,122,'',0.00,0.00,0.00,0,0.00),(53,10,124,'',0.00,0.00,0.00,0,0.00),(54,10,125,'',0.00,0.00,0.00,0,0.00),(55,10,126,'',0.00,0.00,0.00,0,0.00),(56,10,127,'',0.00,0.00,0.00,0,0.00),(57,10,128,'',0.00,0.00,0.00,0,0.00),(58,10,129,'',0.00,0.00,0.00,0,0.00),(59,10,130,'',0.00,0.00,0.00,0,0.00),(61,10,132,'',0.00,0.00,0.00,0,0.00),(62,10,133,'',0.00,0.00,0.00,0,0.00),(63,10,134,'',0.00,0.00,0.00,0,0.00),(64,10,135,'',0.00,0.00,0.00,0,0.00),(65,10,136,'',0.00,0.00,0.00,0,0.00),(66,10,137,'',0.00,0.00,0.00,0,0.00),(67,10,138,'',0.00,0.00,0.00,0,0.00),(68,10,139,'',0.00,0.00,0.00,0,0.00),(69,10,140,'',0.00,0.00,0.00,0,0.00),(70,10,141,'',0.00,0.00,0.00,0,0.00),(71,10,142,'',0.00,0.00,0.00,0,0.00),(72,10,143,'',0.00,0.00,0.00,0,0.00),(73,10,144,'',0.00,0.00,0.00,0,0.00),(74,10,145,'',0.00,0.00,0.00,0,0.00),(75,12,146,'',0.00,0.00,0.00,0,0.00),(76,12,147,'',0.00,0.00,0.00,0,0.00),(77,12,148,'',0.00,0.00,0.00,0,0.00),(78,12,149,'',0.00,0.00,0.00,0,0.00),(79,12,150,'',0.00,0.00,0.00,0,0.00),(80,12,151,'',0.00,0.00,0.00,0,0.00),(81,12,152,'',0.00,0.00,0.00,0,0.00),(82,12,153,'',0.00,0.00,0.00,0,0.00),(83,12,154,'',0.00,0.00,0.00,0,0.00),(84,12,155,'',0.00,0.00,0.00,0,0.00),(85,12,156,'',0.00,0.00,0.00,0,0.00),(86,12,157,'',0.00,0.00,0.00,0,0.00),(92,10,163,'Agua Natural 500ml',0.00,0.00,0.00,0,0.00),(93,10,164,'Aceite capullo 5lt',0.00,0.00,0.00,0,0.00),(94,10,165,'Agua 20 lts dispensador',0.00,0.00,0.00,0,0.00),(95,10,165,'',0.00,20000.00,0.00,0,20000.00),(96,10,166,'Huevo docena',0.00,0.00,0.00,0,0.00),(97,10,167,'Mazapan polvo 908 grs',0.00,0.00,0.00,0,0.00),(98,10,168,'Etiquetas Frappe',0.00,0.00,0.00,0,0.00),(99,10,169,'Etiquetas Malteadas',0.00,0.00,0.00,0,0.00),(100,10,168,'',0.00,2500.00,0.00,0,2500.00),(101,10,169,'',0.00,2500.00,0.00,0,2500.00),(102,10,170,'Vaso tipo 16 EU Reyma',0.00,0.00,0.00,0,0.00);
/*!40000 ALTER TABLE `inventario_mp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_productos_almacen`
--

DROP TABLE IF EXISTS `inventario_productos_almacen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventario_productos_almacen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_base_id` int(11) NOT NULL,
  `almacen_id` int(11) NOT NULL,
  `cantidad` decimal(10,2) NOT NULL DEFAULT 0.00,
  `costo_promedio` decimal(10,2) NOT NULL DEFAULT 0.00,
  `valor_inventario` decimal(10,2) NOT NULL DEFAULT 0.00,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_producto_almacen` (`producto_base_id`,`almacen_id`),
  KEY `almacen_id` (`almacen_id`),
  KEY `producto_base_id` (`producto_base_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_productos_almacen`
--

LOCK TABLES `inventario_productos_almacen` WRITE;
/*!40000 ALTER TABLE `inventario_productos_almacen` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventario_productos_almacen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_pt`
--

DROP TABLE IF EXISTS `inventario_pt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventario_pt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL DEFAULT 10,
  `inventario_inicial` decimal(10,2) DEFAULT 0.00,
  `entradas` decimal(10,2) DEFAULT 0.00,
  `precio_unitario` decimal(10,2) DEFAULT NULL,
  `salidas` decimal(10,2) DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `idx_inventario_pt_empresa` (`empresa_id`),
  KEY `idx_inventario_pt_producto_empresa` (`producto_id`,`empresa_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_pt`
--

LOCK TABLES `inventario_pt` WRITE;
/*!40000 ALTER TABLE `inventario_pt` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventario_pt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invitaciones`
--

DROP TABLE IF EXISTS `invitaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invitaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `nombre_sugerido` varchar(100) DEFAULT NULL,
  `rol` varchar(50) DEFAULT 'operador',
  `areas_asignadas` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`areas_asignadas`)),
  `token` varchar(100) NOT NULL,
  `estado` enum('pendiente','aceptada','expirada','cancelada') DEFAULT 'pendiente',
  `creada_por` int(11) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_expiracion` datetime DEFAULT NULL,
  `fecha_aceptacion` datetime DEFAULT NULL,
  `usuario_creado_id` int(11) DEFAULT NULL,
  `notas` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `empresa_id` (`empresa_id`),
  KEY `creada_por` (`creada_por`),
  KEY `usuario_creado_id` (`usuario_creado_id`),
  KEY `idx_invitacion_token` (`token`),
  KEY `idx_invitacion_correo` (`correo`),
  CONSTRAINT `invitaciones_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  CONSTRAINT `invitaciones_ibfk_2` FOREIGN KEY (`creada_por`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `invitaciones_ibfk_3` FOREIGN KEY (`usuario_creado_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invitaciones`
--

LOCK TABLES `invitaciones` WRITE;
/*!40000 ALTER TABLE `invitaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `invitaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listado_compras`
--

DROP TABLE IF EXISTS `listado_compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `listado_compras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT NULL,
  `numero_factura` varchar(50) DEFAULT NULL,
  `proveedor` varchar(255) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `iva` decimal(10,2) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `empresa_id` int(11) DEFAULT NULL,
  `contratante_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listado_compras`
--

LOCK TABLES `listado_compras` WRITE;
/*!40000 ALTER TABLE `listado_compras` DISABLE KEYS */;
INSERT INTO `listado_compras` VALUES (37,'2025-08-01 00:00:00','75930','Del Rio',34.00,NULL,NULL,NULL,NULL,NULL,NULL),(38,'2025-08-01 00:00:00','45573','Vani',1990.00,NULL,NULL,NULL,NULL,NULL,NULL),(39,'2025-08-01 00:00:00','1708825','Gazpro',379.80,NULL,NULL,NULL,NULL,NULL,NULL),(58,'2025-12-03 00:00:00','46944','VANI',1368.80,1180.00,188.80,'',10,9,34),(59,'2025-12-03 00:00:00','46944','VANI',1368.80,1180.00,188.80,'',10,9,34),(60,'2025-12-03 00:00:00','46944','VANI',1368.80,1180.00,188.80,'',10,9,34),(61,'2025-12-03 00:00:00','46944','VANI',1368.80,1180.00,188.80,'',10,9,34);
/*!40000 ALTER TABLE `listado_compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materia_prima`
--

DROP TABLE IF EXISTS `materia_prima`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `materia_prima` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_base_id` int(11) NOT NULL,
  `proveedor_preferido_id` int(11) DEFAULT NULL,
  `tiempo_entrega_dias` int(11) DEFAULT NULL,
  `lote_minimo_compra` decimal(10,2) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `empresa_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `producto_base_id` (`producto_base_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materia_prima`
--

LOCK TABLES `materia_prima` WRITE;
/*!40000 ALTER TABLE `materia_prima` DISABLE KEYS */;
/*!40000 ALTER TABLE `materia_prima` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mercancia`
--

DROP TABLE IF EXISTS `mercancia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mercancia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_base_id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `codigo_barras` varchar(50) DEFAULT NULL,
  `presentacion` varchar(100) DEFAULT NULL,
  `cont_neto` decimal(10,2) DEFAULT 1.00,
  `unidad_id` int(11) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `iva` tinyint(1) DEFAULT 0,
  `ieps` tinyint(1) DEFAULT 0,
  `graba_iva` tinyint(1) DEFAULT 0,
  `graba_ieps` tinyint(1) DEFAULT 0,
  `precio_venta` decimal(10,2) DEFAULT 0.00,
  `unidad_base` varchar(20) DEFAULT 'pz',
  `catalogo_id` int(11) DEFAULT NULL,
  `tipo_inventario_id` int(11) DEFAULT NULL,
  `minimo_existencia` decimal(10,2) DEFAULT 0.00,
  `maximo_existencia` decimal(10,2) DEFAULT 0.00,
  `orden` int(11) DEFAULT 0,
  `cuenta_id` int(11) DEFAULT NULL,
  `subcuenta_id` int(11) DEFAULT NULL,
  `tipo` varchar(10) DEFAULT 'MP',
  `activo` tinyint(1) DEFAULT 1,
  `empresa_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `producto_base_id` (`producto_base_id`)
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mercancia`
--

LOCK TABLES `mercancia` WRITE;
/*!40000 ALTER TABLE `mercancia` DISABLE KEYS */;
INSERT INTO `mercancia` VALUES (35,29,'Galleta Oreo 252gr',NULL,NULL,252.00,3,NULL,0,0,0,0,0.00,'pz',NULL,1,756.00,15000.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-01-24 19:29:18'),(36,19,'Nieve de Chorro Vainilla',NULL,NULL,18000.00,2,NULL,0,0,0,0,0.00,'pz',NULL,1,18000.00,180000.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-01-24 19:29:18'),(37,20,'Nieve de Chorro Chocolate',NULL,NULL,18000.00,2,NULL,0,0,0,0,0.00,'pz',NULL,1,18000.00,180000.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-01-24 19:29:18'),(38,17,'Leche Vitalait',NULL,NULL,1000.00,2,NULL,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-05-07 03:15:12'),(76,17,'Leche Lucerna 1.8L',NULL,NULL,1800.00,2,NULL,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-05-07 03:15:12'),(77,11,'Crema batida Prices',NULL,NULL,368.00,3,NULL,0,0,0,0,0.00,'pz',NULL,3,1400.00,18000.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-05-07 03:15:12'),(78,26,'Cono dorado doble rustico',NULL,NULL,125.00,1,NULL,0,0,0,0,0.00,'pz',NULL,1,80.00,1000.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-01-24 19:29:18'),(79,16,'Fresa Comercial 1kg',NULL,NULL,1000.00,1,NULL,0,0,0,0,0.00,'pz',NULL,1,1000.00,20000.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-01-24 19:29:18'),(80,27,'Cono Oblea',NULL,NULL,100.00,1,NULL,0,0,0,0,0.00,'pz',NULL,3,100.00,1000.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-05-07 03:15:12'),(81,24,'Servilleta restaurantera',NULL,NULL,500.00,1,NULL,0,0,0,0,0.00,'pz',NULL,3,100.00,10000.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-05-07 03:15:12'),(82,7,'Cajeta Zagala 5kg',NULL,NULL,5000.00,1,NULL,0,0,0,0,0.00,'pz',NULL,1,2000.00,15000.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-01-24 19:29:18'),(83,4,'Bisagra 1312-44',NULL,NULL,1.00,1,NULL,0,0,0,0,0.00,'pz',NULL,1,12.00,120.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-01-24 19:29:18'),(90,8,'Cerezas galon',NULL,NULL,3400.00,1,NULL,0,0,0,0,0.00,'pz',NULL,1,800.00,8000.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-01-24 19:29:18'),(94,3,'Azucar Morena 5kg',NULL,NULL,5000.00,1,NULL,0,0,0,0,0.00,'pz',NULL,1,0.00,0.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-01-24 19:29:18'),(95,10,'Cono 432 J/L',NULL,NULL,432.00,1,NULL,0,0,0,0,0.00,'pz',NULL,1,200.00,1000.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-01-24 19:29:18'),(96,14,'Harina Brownie 2.2kg',NULL,NULL,2200.00,3,NULL,0,0,0,0,0.00,'pz',NULL,1,3400.00,22000.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-01-24 19:29:18'),(98,15,'Hershey Chocolate galon',NULL,NULL,3400.00,3,NULL,0,0,0,0,0.00,'pz',NULL,1,0.00,0.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-01-24 19:29:18'),(99,2,'Agua 500ml 45pz',NULL,NULL,45.00,1,NULL,0,0,0,0,0.00,'pz',NULL,3,30.00,450.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-05-07 03:15:12'),(100,23,'Popotes',NULL,NULL,1000.00,3,NULL,0,0,0,0,0.00,'pz',NULL,1,400.00,5000.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-01-24 19:29:18'),(101,25,'Tapa Plastica 100pz',NULL,NULL,100.00,1,NULL,0,0,0,0,0.00,'pz',NULL,3,200.00,2000.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-05-07 03:15:12'),(102,5,'Bolsa churro',NULL,NULL,100.00,1,NULL,0,0,0,0,0.00,'pz',NULL,1,200.00,3000.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-01-24 19:29:18'),(103,9,'Coca cola Bote 35pz',NULL,NULL,35.00,1,NULL,0,0,0,0,0.00,'pz',NULL,3,30.00,350.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-05-07 03:15:12'),(104,1,'9oz Vaso',NULL,NULL,264.00,1,NULL,0,0,0,0,0.00,'pz',NULL,3,200.00,2640.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-05-07 03:15:12'),(105,13,'Famous Amos galleta 2.38kg',NULL,NULL,2380.00,1,NULL,0,0,0,0,0.00,'pz',NULL,1,4000.00,2380.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-01-24 19:29:18'),(106,21,'Hershey Fresa 1.38kg',NULL,NULL,1380.00,3,NULL,0,0,0,0,0.00,'pz',NULL,1,2700.00,1500.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-01-24 19:29:18'),(107,22,'Hershey Caramelo 623g',NULL,NULL,623.00,3,NULL,0,0,0,0,0.00,'pz',NULL,3,3000.00,9345.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-05-07 03:15:12'),(109,12,'Cuchara Inix 25pz',NULL,NULL,25.00,1,NULL,0,0,0,0,0.00,'pz',NULL,3,125.00,1000.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-05-07 03:15:12'),(110,6,'Cacahuate .5kg',NULL,NULL,500.00,1,NULL,0,0,0,0,0.00,'pz',NULL,1,500.00,5000.00,0,NULL,NULL,'MP',1,10,'2026-01-16 15:57:55','2026-01-24 19:29:18'),(113,3,'Azucar 1 kg',NULL,NULL,1000.00,3,NULL,0,0,0,0,0.00,'pz',NULL,1,500.00,10000.00,0,179,NULL,'MP',1,10,'2026-01-18 17:47:10','2026-01-24 19:29:18'),(116,0,'Cono Galleta',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-24 19:43:08','2026-01-24 19:43:08'),(117,0,'Cono Wafle',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-24 19:43:14','2026-01-24 19:43:14'),(118,0,'Vaso 16oz Frappe',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-24 19:43:32','2026-01-24 20:01:30'),(119,0,'Vaso 16oz Malteada',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-24 19:43:47','2026-01-24 20:01:39'),(120,0,'Vaso 9oz',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-24 20:01:49','2026-01-24 20:01:49'),(121,0,'Cono Chocolate',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:07:46','2026-01-25 04:07:46'),(122,0,'Soda de Lata 355ml',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:08:21','2026-01-25 04:08:21'),(124,0,'Brownie individual',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:09:03','2026-01-25 04:09:03'),(125,0,'Churro para rellenar',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:09:19','2026-01-25 04:09:19'),(126,0,'Fresa 500 grs',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:10:17','2026-01-25 04:10:17'),(127,0,'Nieve de Chorro Vainilla',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:10:27','2026-01-25 04:10:27'),(128,0,'Nieve de Chorro Chocolate',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:10:33','2026-01-25 04:10:33'),(129,0,'Hielo 5kg',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:10:41','2026-01-25 04:10:41'),(130,0,'Cacahuate 500 grs',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:11:04','2026-01-25 04:11:04'),(132,0,'Leche 1 litro',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:11:45','2026-01-25 04:11:45'),(133,0,'Leche 1.8 lts',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:11:52','2026-01-25 04:11:52'),(134,0,'Whip Cream 368grs',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:12:45','2026-01-25 04:12:45'),(135,0,'Azucar 500 grs',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:13:28','2026-01-25 04:13:28'),(136,0,'Hershey Fresa 589 gr',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:14:57','2026-01-25 04:14:57'),(137,0,'Hershey Caramelo 623g',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:16:20','2026-01-25 04:16:20'),(138,0,'Hershey Chocolate 589 gr',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:16:57','2026-01-25 04:16:57'),(139,0,'Oreo 1260 grs',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:18:16','2026-01-25 04:18:16'),(140,0,'Lechera 375 grs',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:19:56','2026-01-25 04:19:56'),(141,0,'Chocochip 336 grs',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:21:04','2026-04-17 05:36:39'),(142,0,'Popote 100 grs',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:21:23','2026-01-25 04:21:23'),(143,0,'Cuchara 25 pz',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:22:00','2026-01-25 04:22:00'),(144,0,'Servilleta restaurantera 500 pz',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:23:06','2026-01-25 04:23:06'),(145,0,'Tapa Inix DL 98',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-01-25 04:24:11','2026-01-25 04:24:11'),(146,0,'Cono Oblea',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,12,'2026-02-05 02:58:44','2026-02-05 02:58:44'),(147,0,'Cono Galleta',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,12,'2026-02-05 02:58:55','2026-02-05 02:58:55'),(148,0,'Cono Wafle',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,12,'2026-02-05 02:59:02','2026-02-05 02:59:02'),(149,0,'Cono Chocolate',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,12,'2026-02-05 02:59:11','2026-02-05 02:59:11'),(150,0,'Vaso Chocoice',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,12,'2026-02-05 02:59:23','2026-02-05 02:59:23'),(151,0,'Vaso 16oz Frappe',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,12,'2026-02-05 02:59:44','2026-02-05 03:01:26'),(152,0,'Coca Cola Bote',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,12,'2026-02-05 03:00:29','2026-02-05 03:00:29'),(153,0,'Agua',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,12,'2026-02-05 03:00:34','2026-02-05 03:00:34'),(154,0,'Brownie individual',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,12,'2026-02-05 03:00:40','2026-02-05 03:01:02'),(155,0,'Vaso 16oz Malteada',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,12,'2026-02-05 03:01:13','2026-02-05 03:01:13'),(156,0,'Fresas Con Crema',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,12,'2026-02-05 03:03:41','2026-02-05 03:03:41'),(157,0,'Churro relleno',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,12,'2026-02-05 03:03:57','2026-02-05 03:03:57'),(163,0,'Agua Natural 500ml',NULL,NULL,1.00,1,0.00,0,0,0,0,0.00,'pz',NULL,3,0.00,0.00,0,NULL,NULL,'PT',1,10,'2026-04-17 05:07:15','2026-04-17 05:07:15'),(164,31,'Aceite capullo 5lt',NULL,NULL,5000.00,2,NULL,0,0,0,0,0.00,'pz',NULL,NULL,0.00,0.00,0,179,312,'MP',1,10,'2026-04-21 02:58:44','2026-04-21 02:58:44'),(165,32,'Agua 20 lts dispensador',NULL,NULL,20000.00,2,NULL,0,0,0,0,0.00,'pz',NULL,NULL,0.00,0.00,0,179,313,'MP',1,10,'2026-05-01 17:53:04','2026-05-01 17:53:04'),(166,33,'Huevo docena',NULL,NULL,12.00,1,NULL,0,0,0,0,0.00,'pz',NULL,NULL,0.00,0.00,0,179,316,'MP',1,10,'2026-05-01 18:30:57','2026-05-01 18:30:57'),(167,34,'Mazapan polvo 908 grs',NULL,NULL,908.00,3,NULL,0,0,0,0,0.00,'pz',NULL,NULL,0.00,0.00,0,179,317,'MP',1,10,'2026-05-02 23:44:24','2026-05-02 23:44:24'),(168,35,'Etiquetas Frappe',NULL,NULL,1.00,1,NULL,0,0,0,0,0.00,'pz',NULL,NULL,0.00,0.00,0,179,318,'MP',1,10,'2026-05-03 03:00:08','2026-05-03 03:00:08'),(169,35,'Etiquetas Malteadas',NULL,NULL,1.00,1,NULL,0,0,0,0,0.00,'pz',NULL,NULL,0.00,0.00,0,179,318,'MP',1,10,'2026-05-03 03:00:36','2026-05-03 03:00:36'),(170,36,'Vaso tipo 16 EU Reyma',NULL,NULL,50.00,1,NULL,0,0,0,0,0.00,'pz',NULL,NULL,0.00,0.00,0,179,320,'MP',1,10,'2026-05-03 03:46:24','2026-05-03 03:46:24');
/*!40000 ALTER TABLE `mercancia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mermas`
--

DROP TABLE IF EXISTS `mermas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mermas` (
  `id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `registro_id` int(11) DEFAULT NULL,
  `fecha` date NOT NULL,
  `producto_id` int(11) NOT NULL,
  `producto_nombre` varchar(255) DEFAULT NULL,
  `cantidad` decimal(10,3) NOT NULL DEFAULT 1.000,
  `costo_unitario` decimal(12,2) DEFAULT 0.00,
  `costo_total` decimal(12,2) DEFAULT 0.00,
  `motivo` enum('caducado','da?ado','perdido','robo','otro') DEFAULT 'otro',
  `descripcion` varchar(255) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mermas`
--

LOCK TABLES `mermas` WRITE;
/*!40000 ALTER TABLE `mermas` DISABLE KEYS */;
/*!40000 ALTER TABLE `mermas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientos_inventario`
--

DROP TABLE IF EXISTS `movimientos_inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movimientos_inventario` (
  `id` int(11) NOT NULL,
  `mercancia_id` int(11) DEFAULT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `tipo` enum('entrada','salida') NOT NULL,
  `cantidad` decimal(12,2) NOT NULL,
  `costo_unitario` decimal(12,2) NOT NULL,
  `referencia` varchar(255) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos_inventario`
--

LOCK TABLES `movimientos_inventario` WRITE;
/*!40000 ALTER TABLE `movimientos_inventario` DISABLE KEYS */;
INSERT INTO `movimientos_inventario` VALUES (4,35,NULL,'entrada',10.00,0.00,NULL,'2025-08-16 01:26:31'),(9,36,NULL,'entrada',50.00,12.50,NULL,'2025-08-17 02:57:31'),(10,36,NULL,'salida',10.00,12.50,NULL,'2025-08-17 02:57:47'),(11,NULL,3,'entrada',20.00,0.00,NULL,'2025-08-17 02:58:01'),(12,NULL,3,'salida',5.00,0.00,NULL,'2025-08-17 02:58:14'),(13,NULL,3,'salida',5.00,0.00,NULL,'2025-08-17 03:01:23'),(14,36,NULL,'entrada',50.00,12.50,NULL,'2025-08-17 03:01:41'),(15,36,NULL,'salida',10.00,12.50,NULL,'2025-08-17 03:01:56'),(16,NULL,3,'entrada',50.00,20.00,'Producci?n Lote 001','2025-08-18 04:53:21'),(17,NULL,3,'salida',10.00,20.00,'Venta Cliente X','2025-08-18 04:53:46'),(18,NULL,1,'entrada',50.00,20.00,'Producci?n Lote 001','2025-08-18 05:03:19'),(19,NULL,3,'entrada',50.00,20.00,'Producci?n Lote Test','2025-08-19 16:29:33');
/*!40000 ALTER TABLE `movimientos_inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificaciones`
--

DROP TABLE IF EXISTS `notificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notificaciones` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `tipo` enum('tarea_asignada','tarea_vencida','tarea_completada','aprobacion_requerida','tarea_rechazada','comentario','otro') NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `mensaje` text NOT NULL,
  `url` varchar(500) DEFAULT NULL,
  `leida` tinyint(1) DEFAULT 0,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_lectura` datetime DEFAULT NULL,
  `referencia_tipo` varchar(50) DEFAULT NULL,
  `referencia_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificaciones`
--

LOCK TABLES `notificaciones` WRITE;
/*!40000 ALTER TABLE `notificaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `notificaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificaciones_usuario`
--

DROP TABLE IF EXISTS `notificaciones_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notificaciones_usuario` (
  `id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `usuario_destino_id` int(11) NOT NULL,
  `usuario_origen_id` int(11) DEFAULT NULL,
  `tipo` enum('bienvenida','asignacion','alerta','mensaje','sistema') DEFAULT 'mensaje',
  `titulo` varchar(200) NOT NULL,
  `mensaje` text DEFAULT NULL,
  `referencia_tipo` varchar(50) DEFAULT NULL,
  `referencia_id` int(11) DEFAULT NULL,
  `leida` tinyint(1) DEFAULT 0,
  `fecha_lectura` datetime DEFAULT NULL,
  `importante` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificaciones_usuario`
--

LOCK TABLES `notificaciones_usuario` WRITE;
/*!40000 ALTER TABLE `notificaciones_usuario` DISABLE KEYS */;
INSERT INTO `notificaciones_usuario` VALUES (0,1,31,NULL,'bienvenida','¡Bienvenido al equipo!','\n        <h4>¡Bienvenido al Sistema ERP!</h4>\n        <p>Tu registro ha sido completado exitosamente.</p>\n        <p>Has sido asignado al área <strong>Ventas / Punto de Venta</strong> como <strong>OPERADOR</strong>.</p>\n        <p><em>Gestión de ventas, caja y atención al cliente</em></p>\n        <hr>\n        <p>Para comenzar:</p>\n        <ol>\n            <li>Explora el menú lateral para conocer las opciones disponibles</li>\n            <li>Revisa las tareas pendientes en tu dashboard</li>\n            <li>Si tienes dudas, contacta a tu supervisor</li>\n        </ol>\n        <p>¡Éxito en tu nuevo rol!</p>\n    ',NULL,NULL,0,NULL,1,'2025-12-21 17:27:41');
/*!40000 ALTER TABLE `notificaciones_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orden_mp`
--

DROP TABLE IF EXISTS `orden_mp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orden_mp` (
  `id` bigint(20) NOT NULL,
  `orden_id` bigint(20) NOT NULL,
  `mp_mercancia_id` int(11) NOT NULL,
  `unidades` decimal(14,4) NOT NULL,
  `empresa_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orden_mp`
--

LOCK TABLES `orden_mp` WRITE;
/*!40000 ALTER TABLE `orden_mp` DISABLE KEYS */;
/*!40000 ALTER TABLE `orden_mp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orden_produccion`
--

DROP TABLE IF EXISTS `orden_produccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orden_produccion` (
  `id` bigint(20) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `pt_mercancia_id` int(11) NOT NULL,
  `cantidad` decimal(14,4) NOT NULL,
  `estado` enum('abierta','cerrada') NOT NULL DEFAULT 'abierta',
  `referencia` varchar(100) DEFAULT NULL,
  `empresa_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orden_produccion`
--

LOCK TABLES `orden_produccion` WRITE;
/*!40000 ALTER TABLE `orden_produccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `orden_produccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes_compra`
--

DROP TABLE IF EXISTS `ordenes_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordenes_compra` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `folio` varchar(50) NOT NULL,
  `proveedor_id` int(11) NOT NULL,
  `fecha_orden` date NOT NULL,
  `fecha_entrega_esperada` date DEFAULT NULL,
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `iva` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `estado` varchar(20) DEFAULT 'pendiente',
  `almacen_id` int(11) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `empresa_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `folio` (`folio`),
  KEY `proveedor_id` (`proveedor_id`),
  KEY `almacen_id` (`almacen_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes_compra`
--

LOCK TABLES `ordenes_compra` WRITE;
/*!40000 ALTER TABLE `ordenes_compra` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordenes_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes_compra_automaticas`
--

DROP TABLE IF EXISTS `ordenes_compra_automaticas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordenes_compra_automaticas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL,
  `folio` varchar(30) NOT NULL,
  `fecha_generacion` datetime NOT NULL DEFAULT current_timestamp(),
  `tipo_orden` enum('automatica','manual') DEFAULT 'automatica',
  `estado` varchar(30) DEFAULT 'pendiente_revision',
  `solicitado_por` varchar(50) DEFAULT 'SISTEMA',
  `revisado_por_usuario_id` int(11) DEFAULT NULL,
  `fecha_revision` datetime DEFAULT NULL,
  `aprobado_por_usuario_id` int(11) DEFAULT NULL,
  `fecha_aprobacion` datetime DEFAULT NULL,
  `notas_revision` text DEFAULT NULL,
  `notas_rechazo` text DEFAULT NULL,
  `subtotal` decimal(12,2) DEFAULT 0.00,
  `iva` decimal(12,2) DEFAULT 0.00,
  `total` decimal(12,2) DEFAULT 0.00,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_actualizacion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `folio` (`folio`),
  KEY `idx_empresa` (`empresa_id`),
  KEY `idx_folio` (`folio`),
  KEY `idx_estado` (`estado`),
  KEY `idx_fecha` (`fecha_generacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes_compra_automaticas`
--

LOCK TABLES `ordenes_compra_automaticas` WRITE;
/*!40000 ALTER TABLE `ordenes_compra_automaticas` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordenes_compra_automaticas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes_compra_automaticas_detalle`
--

DROP TABLE IF EXISTS `ordenes_compra_automaticas_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordenes_compra_automaticas_detalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orden_id` int(11) NOT NULL,
  `mercancia_id` int(11) NOT NULL,
  `producto_base_id` int(11) DEFAULT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `cantidad_solicitada` decimal(12,3) NOT NULL,
  `cantidad_aprobada` decimal(12,3) DEFAULT NULL,
  `cantidad_recibida` decimal(12,3) DEFAULT 0.000,
  `precio_estimado` decimal(12,2) DEFAULT 0.00,
  `importe` decimal(12,2) DEFAULT 0.00,
  `criterio` varchar(100) DEFAULT NULL,
  `stock_actual` decimal(12,3) DEFAULT NULL,
  `stock_minimo` decimal(12,3) DEFAULT NULL,
  `stock_maximo` decimal(12,3) DEFAULT NULL,
  `fecha_primera_solicitud` datetime DEFAULT NULL,
  `dias_pendiente` int(11) DEFAULT 0,
  `estado` varchar(30) DEFAULT 'pendiente',
  `proveedor_sugerido_id` int(11) DEFAULT NULL,
  `notas` text DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_orden` (`orden_id`),
  KEY `idx_mercancia` (`mercancia_id`),
  KEY `idx_estado` (`estado`),
  CONSTRAINT `ordenes_compra_automaticas_detalle_ibfk_1` FOREIGN KEY (`orden_id`) REFERENCES `ordenes_compra_automaticas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes_compra_automaticas_detalle`
--

LOCK TABLES `ordenes_compra_automaticas_detalle` WRITE;
/*!40000 ALTER TABLE `ordenes_compra_automaticas_detalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordenes_compra_automaticas_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes_compra_b2b_detalle`
--

DROP TABLE IF EXISTS `ordenes_compra_b2b_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordenes_compra_b2b_detalle` (
  `id` int(11) NOT NULL,
  `orden_id` int(11) NOT NULL,
  `mercancia_id` int(11) DEFAULT NULL,
  `descripcion` varchar(500) NOT NULL,
  `cantidad_solicitada` decimal(12,3) NOT NULL,
  `cantidad_aprobada` decimal(12,3) DEFAULT NULL,
  `precio_unitario` decimal(12,2) NOT NULL DEFAULT 0.00,
  `importe` decimal(12,2) NOT NULL DEFAULT 0.00,
  `notas` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes_compra_b2b_detalle`
--

LOCK TABLES `ordenes_compra_b2b_detalle` WRITE;
/*!40000 ALTER TABLE `ordenes_compra_b2b_detalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordenes_compra_b2b_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes_compra_detalle`
--

DROP TABLE IF EXISTS `ordenes_compra_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordenes_compra_detalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orden_compra_id` int(11) NOT NULL,
  `producto_base_id` int(11) NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `iva` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `orden_compra_id` (`orden_compra_id`),
  KEY `producto_base_id` (`producto_base_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes_compra_detalle`
--

LOCK TABLES `ordenes_compra_detalle` WRITE;
/*!40000 ALTER TABLE `ordenes_compra_detalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordenes_compra_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes_compra_tracking`
--

DROP TABLE IF EXISTS `ordenes_compra_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordenes_compra_tracking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `detalle_id` int(11) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `estado_anterior` varchar(30) DEFAULT NULL,
  `estado_nuevo` varchar(30) DEFAULT NULL,
  `cantidad_anterior` decimal(12,3) DEFAULT NULL,
  `cantidad_nueva` decimal(12,3) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `notas` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_detalle` (`detalle_id`),
  CONSTRAINT `ordenes_compra_tracking_ibfk_1` FOREIGN KEY (`detalle_id`) REFERENCES `ordenes_compra_automaticas_detalle` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes_compra_tracking`
--

LOCK TABLES `ordenes_compra_tracking` WRITE;
/*!40000 ALTER TABLE `ordenes_compra_tracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordenes_compra_tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes_produccion`
--

DROP TABLE IF EXISTS `ordenes_produccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordenes_produccion` (
  `id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `proceso_id` int(11) NOT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  `cantidad_solicitada` decimal(10,3) NOT NULL,
  `cantidad_producida` decimal(10,3) DEFAULT 0.000,
  `estado` enum('borrador','pendiente','en_proceso','pausada','completada','cancelada') DEFAULT 'borrador',
  `fecha_solicitud` date DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `prioridad` enum('baja','normal','alta','urgente') DEFAULT 'normal',
  `notas` text DEFAULT NULL,
  `creado_por` int(11) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes_produccion`
--

LOCK TABLES `ordenes_produccion` WRITE;
/*!40000 ALTER TABLE `ordenes_produccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordenes_produccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagos_b2b`
--

DROP TABLE IF EXISTS `pagos_b2b`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagos_b2b` (
  `id` int(11) NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `cuenta_por_pagar_id` int(11) DEFAULT NULL,
  `cuenta_por_cobrar_id` int(11) DEFAULT NULL,
  `factura_b2b_id` int(11) DEFAULT NULL,
  `monto` decimal(12,2) NOT NULL,
  `metodo_pago` varchar(50) DEFAULT NULL,
  `referencia_pago` varchar(100) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `fecha_pago` datetime NOT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  `notas` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagos_b2b`
--

LOCK TABLES `pagos_b2b` WRITE;
/*!40000 ALTER TABLE `pagos_b2b` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagos_b2b` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paso_insumos`
--

DROP TABLE IF EXISTS `paso_insumos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paso_insumos` (
  `id` int(11) NOT NULL,
  `paso_id` int(11) NOT NULL,
  `mercancia_id` int(11) NOT NULL,
  `cantidad` decimal(12,3) NOT NULL,
  `unidad_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paso_insumos`
--

LOCK TABLES `paso_insumos` WRITE;
/*!40000 ALTER TABLE `paso_insumos` DISABLE KEYS */;
INSERT INTO `paso_insumos` VALUES (0,0,19,9000.000,NULL),(0,0,19,9000.000,NULL),(0,3,19,9000.000,NULL),(0,6,13,336.000,NULL),(0,15,4,1.000,NULL),(0,16,34,500.000,NULL),(0,18,27,1.000,NULL),(0,19,26,1.000,NULL),(0,20,1,1.000,NULL),(0,23,36,50.000,NULL),(0,23,35,50.000,NULL),(0,24,36,50.000,NULL),(0,24,35,50.000,NULL),(0,26,16,1000.000,NULL),(0,27,15,589.000,NULL),(0,30,20,9000.000,NULL),(0,31,20,9000.000,NULL),(0,34,23,100.000,NULL);
/*!40000 ALTER TABLE `paso_insumos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paso_responsables`
--

DROP TABLE IF EXISTS `paso_responsables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paso_responsables` (
  `id` int(11) NOT NULL,
  `paso_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paso_responsables`
--

LOCK TABLES `paso_responsables` WRITE;
/*!40000 ALTER TABLE `paso_responsables` DISABLE KEYS */;
/*!40000 ALTER TABLE `paso_responsables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `presentaciones`
--

DROP TABLE IF EXISTS `presentaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `presentaciones` (
  `id` int(11) NOT NULL,
  `empresa_id` int(11) DEFAULT NULL,
  `mercancia_id` int(11) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `contenido_neto` varchar(50) DEFAULT NULL,
  `unidad` varchar(50) DEFAULT NULL,
  `factor_conversion` decimal(10,4) DEFAULT 1.0000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presentaciones`
--

LOCK TABLES `presentaciones` WRITE;
/*!40000 ALTER TABLE `presentaciones` DISABLE KEYS */;
INSERT INTO `presentaciones` VALUES (0,10,104,'9oz Vaso 264 uds','264','uds',264.0000),(0,10,113,'Azucar 1 kg 1000 gramos','1000','gramos',1000.0000),(0,10,99,'Agua 500ml 45pz 1.00 uds','1.00','uds',1.0000),(0,10,113,'Azucar 1 kg 1000.00 gramos','1000.00','gramos',1000.0000),(0,10,94,'Azucar Morena 5kg 1.00 uds','1.00','uds',1.0000),(0,10,83,'Bisagra 1312-44 1.00 uds','1.00','uds',1.0000),(0,10,102,'Bolsa churro 1.00 uds','1.00','uds',1.0000),(0,10,110,'Cacahuate .5kg 1.00 uds','1.00','uds',1.0000),(0,10,82,'Cajeta Zagala 5kg 1.00 uds','1.00','uds',1.0000),(0,10,90,'Cerezas 1.00 uds','1.00','uds',1.0000),(0,10,103,'Coca cola Bote 35pz 1.00 uds','1.00','uds',1.0000),(0,10,109,'Cuchara Inix 25pz 1.00 uds','1.00','uds',1.0000),(0,10,101,'Tapa Plastica 100pz 1.00 uds','1.00','uds',1.0000),(0,10,81,'Servilletas 1.00 uds','1.00','uds',1.0000),(0,10,99,'Agua 500ml 45pz 45 uds','45','uds',45.0000),(0,10,113,'Azucar 1 kg 1000.00 gramos','1000.00','gramos',1000.0000),(0,10,94,'Azucar Morena 5kg 5000 uds','5000','uds',5000.0000),(0,10,83,'Bisagra 1312-44 1.00 uds','1.00','uds',1.0000),(0,10,102,'Bolsa churro 100 uds','100','uds',100.0000),(0,10,110,'Cacahuate .5kg 500 uds','500','uds',500.0000),(0,10,82,'Cajeta Zagala 5kg 5000 uds','5000','uds',5000.0000),(0,10,90,'Cerezas galon 3400 uds','3400','uds',3400.0000),(0,10,103,'Coca cola Bote 35pz 35 uds','35','uds',35.0000),(0,10,95,'Cono 432 J/L 432 uds','432','uds',432.0000),(0,10,78,'Cono dorado doble rustico 125 uds','125','uds',125.0000),(0,10,78,'Cono dorado doble rustico 125.00 uds','125.00','uds',125.0000),(0,10,80,'Cono Oblea 100 uds','100','uds',100.0000),(0,10,77,'Crema batida Prices 368 gramos','368','gramos',368.0000),(0,10,109,'Cuchara Inix 25pz 25 uds','25','uds',25.0000),(0,10,105,'Famous Amos galleta 2.38kg 2380 uds','2380','uds',2380.0000),(0,10,79,'Fresa Comercial 1kg 1000 uds','1000','uds',1000.0000),(0,10,35,'Galleta Oreo 252gr 252 gramos','252','gramos',252.0000),(0,10,96,'Harina Brownie 2.2kg 2200 gramos','2200','gramos',2200.0000),(0,10,107,'Hershey Caramelo 623g 623 gramos','623','gramos',623.0000),(0,10,98,'Hershey Chocolate galon 3400 gramos','3400','gramos',3400.0000),(0,10,106,'Hershey Fresa 1.38kg 1380 gramos','1380','gramos',1380.0000),(0,10,38,'Leche Vitalait 1000 mililitro','1000','mililitro',1000.0000),(0,10,76,'Leche Lucerna 1.8L 1800 mililitro','1800','mililitro',1800.0000),(0,10,37,'Nieve de Chorro Chocolate 18000 mililitro','18000','mililitro',18000.0000),(0,10,36,'Nieve de Chorro Vainilla 18000 mililitro','18000','mililitro',18000.0000),(0,10,100,'Popotes 1000 gramos','1000','gramos',1000.0000),(0,10,81,'Servilleta restaurantera 500 uds','500','uds',500.0000),(0,10,101,'Tapa Plastica 100pz 100 uds','100','uds',100.0000),(0,10,164,'Aceite capullo 5lt 5000 mililitro','5000','mililitro',5000.0000),(0,10,165,'Agua 20 lts dispensador 20000 mililitro','20000','mililitro',20000.0000),(0,10,166,'Huevo docena 12 uds','12','uds',12.0000),(0,10,167,'Mazapan polvo 908 grs 908 gramos','908','gramos',908.0000),(0,10,168,'Etiquetas Frappe 1 uds','1','uds',1.0000),(0,10,169,'Etiquetas Malteadas 1 uds','1','uds',1.0000),(0,10,170,'Vaso tipo 16 EU Reyma 50 uds','50','uds',50.0000);
/*!40000 ALTER TABLE `presentaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proceso_pasos`
--

DROP TABLE IF EXISTS `proceso_pasos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proceso_pasos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL DEFAULT 1,
  `proceso_id` int(11) NOT NULL,
  `numero_paso` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `responsable` varchar(255) DEFAULT NULL,
  `requiere_validez` tinyint(1) DEFAULT 1,
  `minutos_estimados` int(11) DEFAULT NULL,
  `costo_estimado` decimal(10,2) DEFAULT 0.00,
  `estado` varchar(50) DEFAULT 'borrador',
  `bloqueado` tinyint(1) DEFAULT 0,
  `fecha_guardado` datetime DEFAULT NULL,
  `tiempo_estimado` int(11) DEFAULT 0,
  `costo_mano_obra` decimal(10,2) DEFAULT 0.00,
  `activo` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `idx_empresa` (`empresa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proceso_pasos`
--

LOCK TABLES `proceso_pasos` WRITE;
/*!40000 ALTER TABLE `proceso_pasos` DISABLE KEYS */;
INSERT INTO `proceso_pasos` VALUES (3,1,1,1,'Almacenamiento de Nieve de Vainilla','Almacenar la nieve en bolsas de 9 litros',22,'Caja uno',1,NULL,0.00,'guardado',1,'2026-04-16 22:04:31',0,0.00,1),(6,1,4,1,'Triturado de Chocochip','Trituracion del contenido de 6 bolsas individuales de galletas de Marxa Famous Amos de 56 gramos cada bolsa',20,'Caja uno',1,NULL,0.00,'guardado',1,'2026-04-16 23:43:23',0,0.00,1),(7,1,4,2,'Embasar Galleta Chochochip triturada','El contenido de la galleta quedara envasado y tapado debidamente',21,'Caja uno',1,2,0.00,'guardado',1,'2026-04-16 23:44:40',0,0.00,1),(8,1,4,3,'Almacenar Chocochip de 336 grs','Almacenar en Productos Terminados el bote de Chocochips de 336 grs',22,'Caja uno',1,NULL,0.00,'guardado',1,'2026-04-16 23:46:29',0,0.00,1),(12,1,6,1,'Batido de Ingredientes','1. En un bowl se mezcla 3/4 taza de agua, 3/4 de taza de aceite vegetal y 2 huevos y se bate hasta que se mezclen completamente los ingredientes\r\n2. En este mismo bowl con la mezcla anterior se incorporan 1130 gramos de harina para brownies de la marca Ghirardelli y se mezclan hasta tener una consistencia homogenea',19,'Caja uno',1,NULL,0.00,'borrador',0,'2026-05-01 12:34:30',0,0.00,1),(13,1,6,2,'Horneado de mezcla','1. Se vierte la mezcla en el molde de 34 x 29 cms y 2.5 de profundidad y se deja por 48 minutos a una temperatura de 325 grados Farenheit.',23,'Caja uno',1,48,0.00,'borrador',0,'2026-05-01 12:45:05',0,0.00,1),(14,1,6,3,'Corte de unidades','1. Se corta en cuadros de 8 x 9 cms con un resultado de 12 brownies',18,'Caja uno',1,8,0.00,'guardado',1,'2026-05-01 12:47:39',0,0.00,1),(15,1,6,4,'Empaquetado de Brownies','Se empaqueta cada brownie de forma individual en el plato de plastico',21,'Caja uno',1,4,0.00,'guardado',1,'2026-05-01 12:48:56',0,0.00,1),(16,1,7,1,'Envasado de Mazapan','1. Envasar el polvo de mazapan ya sea de la bolsa en polvo o de los individuales en los vasos de plastico hasta completar 500 grs',21,'Caja uno',1,3,0.00,'guardado',1,'2026-05-02 17:48:56',0,0.00,1),(17,1,8,1,'Extracción y embalaje','Extraer de la caja con 432 piezas de Cono Galleta hacie depositos que contengan 100 piezas por contenedor',21,'Caja uno',1,3,0.00,'borrador',0,'2026-05-02 18:17:03',0,0.00,1),(18,1,9,1,'Extracción y embalaje','Extraer de la caja con 360 piezas de Cono Galleta hacie depositos que contengan 142 piezas por contenedor',21,'Caja uno',1,10,0.00,'guardado',1,'2026-05-02 20:44:39',0,0.00,1),(19,1,10,1,'Extracción y embalaje','Extraer de la caja con 125 piezas de Cono Waffle hacia depositos que contengan 80 piezas por contenedor maximo',21,'Caja uno',1,10,0.00,'guardado',1,'2026-05-02 20:48:31',0,0.00,1),(20,1,11,1,'Almacenaje de vasos en bolsa completa','Se dispondra de las existencias de vasos del almacen segun necesidades',22,'Caja uno',1,1,0.00,'guardado',1,'2026-05-02 20:52:13',0,0.00,1),(23,1,12,1,'Etiquetado de vaso Frappe','Etiquetar los vasos 16EU con el logo de Yolo Frappe',17,'Caja uno',1,10,0.00,'guardado',1,'2026-05-02 21:57:10',0,0.00,1),(24,1,13,1,'Etiquetado de vaso Malteada','Etiquetar los vasos 16EU con el logo de Yolo Malteada',17,'Caja uno',1,10,0.00,'guardado',1,'2026-05-02 21:59:09',0,0.00,1),(26,1,15,1,'Corte de fresas','Cuando previamente este debidamente desinfectada y seleccionada la fresa se procedera al corte de estas en 3 partes si la fresa es tamaño normal, si es mas pequeña sera a la mitad. De un kilo de fresas se obtendran 2 vasos de 500 gramos cada uno',18,'Caja uno',1,12,0.00,'guardado',1,'2026-05-02 23:26:43',0,0.00,1),(27,1,16,1,'Rellenar botellas de hershey','Del garrafón de 4.20 kilios rellenar las botellas de hershey',21,'Caja uno',1,NULL,0.00,'guardado',1,'2026-05-02 23:33:49',0,0.00,1),(28,1,17,1,'Rellenar botellas de hershey','Rellenar botellas de hershey de fresac con las de 1.36 kg',21,'Caja uno',1,3,0.00,'borrador',0,'2026-05-02 23:45:40',0,0.00,1),(29,1,18,1,'Trituración de Oreo','1. Desempacar Galleta Oreo con un peso de 1260 gramos\r\n2. Triturar 30 galletas 3 veces una duracion de 2 segundos por cada vez , se almacena y se sigue con las siguientes 30 galletas',20,'Caja uno',1,10,0.00,'borrador',0,'2026-05-05 22:02:23',0,0.00,1),(30,1,1,2,'Nieve de Chorro Chocolate','Almacenar la nieve en bolsas de 9 litros',22,'Caja uno',1,NULL,0.00,'guardado',1,'2026-05-05 22:05:31',0,0.00,1),(31,1,19,1,'Nieve de Chorro Chocolate','Almacenar la nieve en bolsas de 9 litros',22,'Caja uno',1,NULL,0.00,'guardado',1,'2026-05-05 22:14:02',0,0.00,1),(34,1,22,1,'Empaquetado de popotes','Empaquetar popotes gruesos con un peso de 100 gramos',21,'Caja uno',1,2,0.00,'guardado',1,'2026-05-05 22:27:37',0,0.00,1);
/*!40000 ALTER TABLE `proceso_pasos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proceso_pasos_materiales`
--

DROP TABLE IF EXISTS `proceso_pasos_materiales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proceso_pasos_materiales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL DEFAULT 1,
  `paso_id` int(11) NOT NULL,
  `producto_base_id` int(11) NOT NULL,
  `cantidad` decimal(10,3) NOT NULL,
  `unidad_medida` varchar(20) DEFAULT NULL,
  `es_opcional` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `paso_id` (`paso_id`),
  KEY `producto_base_id` (`producto_base_id`),
  KEY `idx_empresa` (`empresa_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proceso_pasos_materiales`
--

LOCK TABLES `proceso_pasos_materiales` WRITE;
/*!40000 ALTER TABLE `proceso_pasos_materiales` DISABLE KEYS */;
/*!40000 ALTER TABLE `proceso_pasos_materiales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `procesos`
--

DROP TABLE IF EXISTS `procesos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `procesos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `producto_terminado_id` int(11) DEFAULT NULL,
  `producto_wip_id` int(11) DEFAULT NULL,
  `cantidad_producida` decimal(10,3) DEFAULT 1.000,
  `unidad_produccion_id` int(11) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `areas_involucradas` text DEFAULT NULL,
  `responsables` text DEFAULT NULL,
  `materiales` text DEFAULT NULL,
  `costo_estimado` decimal(12,2) DEFAULT 0.00,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procesos`
--

LOCK TABLES `procesos` WRITE;
/*!40000 ALTER TABLE `procesos` DISABLE KEYS */;
INSERT INTO `procesos` VALUES (1,10,'Nieve de Chorro Vainilla','',NULL,NULL,1.000,NULL,1,'','','',0.00,'2026-04-09 17:44:30'),(4,10,'Chocochip 336 grs','',NULL,NULL,1.000,NULL,1,'','','',0.00,'2026-04-16 23:37:06'),(6,10,'Elaboracion de Brownies','',NULL,NULL,1.000,NULL,1,'','','',0.00,'2026-04-20 20:48:27'),(7,10,'Embasado de Mazapan','',NULL,NULL,1.000,NULL,1,'','','',0.00,'2026-05-02 17:32:08'),(8,10,'Cono Galleta','',NULL,NULL,1.000,NULL,1,'','','',0.00,'2026-05-02 18:14:49'),(9,10,'Cono Chocolate','',NULL,NULL,1.000,NULL,1,'','','',0.00,'2026-05-02 19:42:35'),(10,10,'Cono Waffle','',NULL,NULL,1.000,NULL,1,'','','',0.00,'2026-05-02 20:46:09'),(11,10,'Vasos 9 oz','',NULL,NULL,1.000,NULL,1,'','','',0.00,'2026-05-02 20:51:04'),(12,10,'Vasos Frappe','',NULL,NULL,1.000,NULL,1,'','','',0.00,'2026-05-02 20:55:26'),(13,10,'Vaso Malteada','',NULL,NULL,1.000,NULL,1,'','','',0.00,'2026-05-02 21:57:42'),(15,10,'Fresa','',NULL,NULL,1.000,NULL,1,'','','',0.00,'2026-05-02 23:23:20'),(16,10,'Hershey Chocolate','',NULL,NULL,1.000,NULL,1,'','','',0.00,'2026-05-02 23:28:20'),(17,10,'Hershey fresa','',NULL,NULL,1.000,NULL,1,'','','',0.00,'2026-05-02 23:39:11'),(18,10,'Oreo molido','',NULL,NULL,1.000,NULL,1,'','','',0.00,'2026-05-05 21:48:13'),(19,10,'Nieve de Chorro Chocolate','',NULL,NULL,1.000,NULL,1,'','','',0.00,'2026-05-05 22:13:17'),(22,10,'Popotes','',NULL,NULL,1.000,NULL,1,'','','',0.00,'2026-05-05 22:26:18');
/*!40000 ALTER TABLE `procesos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produccion`
--

DROP TABLE IF EXISTS `produccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produccion` (
  `id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `producto_terminado_id` int(11) NOT NULL,
  `cantidad_producida` decimal(10,2) NOT NULL,
  `estado` enum('en_proceso','terminado') DEFAULT 'en_proceso',
  `empresa_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produccion`
--

LOCK TABLES `produccion` WRITE;
/*!40000 ALTER TABLE `produccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `produccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produccion_detalle_mp`
--

DROP TABLE IF EXISTS `produccion_detalle_mp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produccion_detalle_mp` (
  `id` int(11) NOT NULL,
  `produccion_id` int(11) NOT NULL,
  `mercancia_id` int(11) NOT NULL,
  `cantidad_usada` decimal(10,2) NOT NULL,
  `empresa_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produccion_detalle_mp`
--

LOCK TABLES `produccion_detalle_mp` WRITE;
/*!40000 ALTER TABLE `produccion_detalle_mp` DISABLE KEYS */;
/*!40000 ALTER TABLE `produccion_detalle_mp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto_base`
--

DROP TABLE IF EXISTS `producto_base`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto_base` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `tipo_inventario_id` int(11) NOT NULL DEFAULT 1,
  `requiere_produccion` tinyint(1) DEFAULT 1,
  `activo` tinyint(1) DEFAULT 1,
  `minimo_existencia` decimal(10,2) DEFAULT 0.00,
  `maximo_existencia` decimal(10,2) DEFAULT 0.00,
  `empresa_id` int(11) DEFAULT NULL,
  `subcuenta_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto_base`
--

LOCK TABLES `producto_base` WRITE;
/*!40000 ALTER TABLE `producto_base` DISABLE KEYS */;
INSERT INTO `producto_base` VALUES (1,NULL,'Vasos 9oz',NULL,1,0,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-05-07 02:57:49'),(2,NULL,'Agua 500ml',NULL,1,0,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-05-07 02:55:39'),(3,NULL,'Az?car',NULL,1,1,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-01-18 07:10:43'),(4,NULL,'Plato brownie',NULL,1,1,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-01-18 07:10:43'),(5,NULL,'Bolsas churro',NULL,1,1,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-01-18 07:10:43'),(6,NULL,'Cacahuate',NULL,1,1,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-01-18 07:10:43'),(7,NULL,'Cajeta',NULL,1,1,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-01-18 07:10:43'),(8,NULL,'Cerezas',NULL,1,1,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-01-18 07:10:43'),(9,NULL,'Soda lata',NULL,1,0,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-05-07 02:57:13'),(10,NULL,'Conos Galleta',NULL,1,1,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-01-18 07:10:43'),(11,NULL,'Crema batida',NULL,1,0,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-05-07 02:56:07'),(12,NULL,'Cucharas',NULL,1,0,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-05-07 02:56:14'),(13,NULL,'Chocochip',NULL,1,1,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-01-18 07:10:43'),(14,NULL,'Harina brownie',NULL,1,1,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-01-18 07:10:43'),(15,NULL,'Hershey Chocolate',NULL,1,1,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-01-18 07:10:43'),(16,NULL,'Fresa',NULL,1,1,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-01-18 07:10:43'),(17,NULL,'Leche',NULL,1,0,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-05-07 02:56:44'),(18,NULL,'M&M',NULL,1,1,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-01-18 07:10:43'),(19,NULL,'Nieve Chorro Vainilla',NULL,1,1,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-01-18 07:10:43'),(20,NULL,'Nieve Chorro Chocolate',NULL,1,1,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-01-18 07:10:43'),(21,NULL,'Hershey Fresa',NULL,1,1,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-01-18 07:10:43'),(22,NULL,'Hershey Caramelo',NULL,1,0,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-05-07 02:56:25'),(23,NULL,'Popotes',NULL,1,1,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-01-18 07:10:43'),(24,NULL,'Servilletas',NULL,1,0,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-05-07 02:57:05'),(25,NULL,'Tapas vaso 16oz',NULL,1,0,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-05-07 02:57:22'),(26,NULL,'Cono Waffle',NULL,1,1,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-01-18 07:10:43'),(27,NULL,'Cono Oblea',NULL,1,0,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-05-07 02:55:58'),(28,NULL,'Cono Chocolate',NULL,1,1,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-01-18 07:10:43'),(29,NULL,'Oreo',NULL,1,1,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-01-18 07:10:43'),(30,NULL,'Hershey Chocolate',NULL,1,1,1,0.00,0.00,10,NULL,'2026-01-18 07:10:43','2026-01-18 07:10:43'),(31,NULL,'Aceite Vegetal',NULL,1,1,1,0.00,0.00,10,312,'2026-04-21 02:58:44','2026-05-07 02:51:43'),(32,NULL,'Agua Natural',NULL,1,1,1,0.00,0.00,10,313,'2026-05-01 17:53:04','2026-05-01 17:53:04'),(33,NULL,'Huevo',NULL,1,1,1,0.00,0.00,10,316,'2026-05-01 18:30:57','2026-05-01 18:30:57'),(34,NULL,'Mazapan',NULL,1,1,1,0.00,0.00,10,317,'2026-05-02 23:44:24','2026-05-02 23:44:24'),(35,NULL,'Etiquetas',NULL,1,1,1,0.00,0.00,10,318,'2026-05-03 03:00:08','2026-05-03 03:00:08'),(36,NULL,'Vaso 16 EU',NULL,1,1,1,0.00,0.00,10,320,'2026-05-03 03:46:24','2026-05-03 03:46:24');
/*!40000 ALTER TABLE `producto_base` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto_base_proveedores`
--

DROP TABLE IF EXISTS `producto_base_proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto_base_proveedores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_base_id` int(11) NOT NULL,
  `proveedor_id` int(11) NOT NULL,
  `codigo_proveedor` varchar(100) DEFAULT NULL,
  `precio_compra` decimal(10,2) DEFAULT NULL,
  `tiempo_entrega_dias` int(11) DEFAULT NULL,
  `es_preferido` tinyint(1) DEFAULT 0,
  `activo` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_producto_proveedor` (`producto_base_id`,`proveedor_id`),
  KEY `proveedor_id` (`proveedor_id`),
  KEY `producto_base_id` (`producto_base_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto_base_proveedores`
--

LOCK TABLES `producto_base_proveedores` WRITE;
/*!40000 ALTER TABLE `producto_base_proveedores` DISABLE KEYS */;
/*!40000 ALTER TABLE `producto_base_proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto_terminado`
--

DROP TABLE IF EXISTS `producto_terminado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto_terminado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_base_id` int(11) NOT NULL,
  `precio_venta` decimal(10,2) DEFAULT NULL,
  `margen_utilidad` decimal(5,2) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `empresa_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `producto_base_id` (`producto_base_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto_terminado`
--

LOCK TABLES `producto_terminado` WRITE;
/*!40000 ALTER TABLE `producto_terminado` DISABLE KEYS */;
/*!40000 ALTER TABLE `producto_terminado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos_terminados`
--

DROP TABLE IF EXISTS `productos_terminados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productos_terminados` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `unidad_id` int(11) DEFAULT NULL,
  `cont_neto` decimal(10,2) DEFAULT NULL,
  `cuenta_id` int(11) DEFAULT NULL,
  `subcuenta_id` int(11) DEFAULT NULL,
  `unidad_medida` varchar(50) DEFAULT NULL,
  `precio_venta` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos_terminados`
--

LOCK TABLES `productos_terminados` WRITE;
/*!40000 ALTER TABLE `productos_terminados` DISABLE KEYS */;
INSERT INTO `productos_terminados` VALUES (1,'Producto Trigger Test','Verificar inventario',1,25.00,NULL,NULL,NULL,0.00),(2,'Producto Trigger Test','Creado para prueba de inventario',1,25.00,NULL,NULL,NULL,0.00),(3,'Producto Terminado Test','Para prueba',1,50.00,NULL,NULL,NULL,0.00);
/*!40000 ALTER TABLE `productos_terminados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contratante_id` int(11) DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  `rfc` varchar(20) DEFAULT NULL,
  `subcuenta_id` int(11) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `ciudad` varchar(100) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `empresa_id` int(11) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `fk_proveedores_subcuenta` (`subcuenta_id`),
  CONSTRAINT `fk_proveedores_subcuenta` FOREIGN KEY (`subcuenta_id`) REFERENCES `cuentas_contables` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (1,NULL,'El Loco Jr',NULL,NULL,'Ave Mariscal','Ciudad Juarez Chih','6566121866',NULL,1),(2,NULL,'Vani',NULL,NULL,'Gral Jose Trinidad','Ciudad Juarez Chih','656 626 9313',NULL,1),(3,NULL,'SAMS Juarez',NULL,NULL,'Ave Ejercito Nacional','Ciudad Juarez Chih','800',NULL,1),(4,NULL,'Trevly',NULL,NULL,'Calle Apolo 1050','Ciudad Juarez Chih','656 311 2760',NULL,1),(5,NULL,'VANI',NULL,228,NULL,NULL,NULL,10,1),(6,NULL,'EL LOCO JR',NULL,229,NULL,NULL,NULL,10,1),(7,NULL,'DEL RIO',NULL,230,NULL,NULL,NULL,10,1),(9,NULL,'SUPERMERCADO GONZALEZ',NULL,232,NULL,NULL,NULL,10,1),(10,NULL,'POSTRES CONGELADOS JUAREZ SA DE CV',NULL,233,NULL,NULL,NULL,10,1),(11,NULL,'Waldos Dolar Mart de Mexico SdeRLdeCV',NULL,237,NULL,NULL,NULL,10,1),(12,NULL,'Costco de Mexico S de RL de CV',NULL,241,NULL,NULL,NULL,10,1),(13,NULL,'Sams Club. Nueva Walmart de Mexico SdeRL de CV',NULL,242,NULL,NULL,NULL,10,1),(14,NULL,'Walmart Supercenter ELP','',255,'','','',10,1),(15,NULL,'Sams Club ELP',NULL,256,NULL,NULL,NULL,10,1),(16,9,'Top Marketing','',NULL,'','','',10,1);
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pt_precios`
--

DROP TABLE IF EXISTS `pt_precios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pt_precios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL,
  `mercancia_id` int(11) NOT NULL,
  `modo` varchar(50) DEFAULT 'manual',
  `markup_pct` decimal(5,2) DEFAULT 0.30,
  `precio_manual` decimal(10,2) DEFAULT NULL,
  `alias` varchar(100) DEFAULT NULL,
  `orden` int(11) DEFAULT 0,
  `visible` tinyint(1) DEFAULT 1,
  `activo` tinyint(1) DEFAULT 1,
  `fecha_actualizacion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_precio` (`empresa_id`,`mercancia_id`),
  KEY `mercancia_id` (`mercancia_id`),
  CONSTRAINT `pt_precios_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  CONSTRAINT `pt_precios_ibfk_2` FOREIGN KEY (`mercancia_id`) REFERENCES `mercancia` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pt_precios`
--

LOCK TABLES `pt_precios` WRITE;
/*!40000 ALTER TABLE `pt_precios` DISABLE KEYS */;
INSERT INTO `pt_precios` VALUES (2,12,146,'manual',0.30,18.00,'Cono Oblea',0,1,1,'2026-04-04 20:58:07'),(3,12,147,'manual',0.30,22.00,'Cono Galleta',0,1,1,'2026-04-04 20:58:07'),(4,12,148,'manual',0.30,30.00,'Cono Wafle',0,1,1,'2026-04-04 20:58:07'),(5,12,149,'manual',0.30,18.00,'Cono Chocolate',0,1,1,'2026-04-04 20:58:07'),(6,12,150,'manual',0.30,46.00,'Chocoice',0,1,1,'2026-04-04 20:58:07'),(7,12,151,'manual',0.30,74.00,'Frappe',0,1,1,'2026-04-04 20:58:07'),(8,12,152,'manual',0.30,25.00,'Soda Bote',0,1,1,'2026-04-04 20:58:07'),(9,12,153,'manual',0.30,8.00,'Agua Individual',0,1,1,'2026-02-04 20:35:58'),(10,12,154,'manual',0.30,62.00,'Brownie',0,1,1,'2026-04-04 20:58:07'),(11,12,155,'manual',0.30,74.00,'Malteada',0,1,1,'2026-04-04 20:58:07'),(12,12,156,'manual',0.30,74.00,'Fresas con Crema',0,1,1,'2026-04-04 20:58:07'),(13,12,157,'manual',0.30,22.00,'Churro Relleno',0,1,1,'2026-02-04 20:35:58'),(49,10,116,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(50,10,117,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(51,10,118,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(52,10,119,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(53,10,120,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(54,10,121,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(55,10,122,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(56,10,124,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(57,10,125,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(58,10,126,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(59,10,127,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(60,10,128,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(61,10,129,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(62,10,130,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(64,10,132,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(65,10,133,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(66,10,134,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(67,10,135,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(68,10,136,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(69,10,137,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(70,10,138,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(71,10,139,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(72,10,140,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(73,10,141,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(74,10,142,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(75,10,143,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(76,10,144,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(77,10,145,'auto',0.30,0.00,NULL,0,1,1,'2026-02-04 20:30:44'),(180,10,163,'auto',0.30,NULL,NULL,0,1,1,'2026-04-16 23:07:15');
/*!40000 ALTER TABLE `pt_precios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pt_precios_backup_20260204`
--

DROP TABLE IF EXISTS `pt_precios_backup_20260204`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pt_precios_backup_20260204` (
  `id` int(11) NOT NULL,
  `empresa_id` int(11) DEFAULT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT 0.00,
  `precio_especial` decimal(10,2) DEFAULT 0.00,
  `activo` tinyint(1) DEFAULT 1,
  `precio_manual` decimal(10,2) DEFAULT 0.00,
  `mercancia_id` int(11) DEFAULT NULL,
  `modo` varchar(50) DEFAULT 'manual',
  `markup_pct` decimal(5,2) DEFAULT 0.00,
  `costo_base` decimal(10,2) DEFAULT 0.00,
  `precio_calculado` decimal(10,2) DEFAULT 0.00,
  `fecha_actualizacion` datetime DEFAULT current_timestamp(),
  `alias` varchar(100) DEFAULT NULL,
  `orden` int(11) DEFAULT 0,
  `visible` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pt_precios_backup_20260204`
--

LOCK TABLES `pt_precios_backup_20260204` WRITE;
/*!40000 ALTER TABLE `pt_precios_backup_20260204` DISABLE KEYS */;
INSERT INTO `pt_precios_backup_20260204` VALUES (1,NULL,NULL,0.00,0.00,1,0.00,55,'manual',0.30,0.00,0.00,'2025-12-03 22:37:54',NULL,0,1),(2,NULL,NULL,0.00,0.00,1,0.00,56,'manual',0.30,0.00,0.00,'2025-12-03 22:38:01',NULL,0,1),(3,NULL,NULL,0.00,0.00,1,0.00,57,'manual',0.30,0.00,0.00,'2025-12-03 22:38:10',NULL,0,1),(4,NULL,NULL,0.00,0.00,1,0.00,58,'manual',0.30,0.00,0.00,'2025-12-03 22:38:18',NULL,0,1),(5,NULL,NULL,0.00,0.00,1,0.00,59,'manual',0.30,0.00,0.00,'2025-12-03 22:38:32',NULL,0,1),(6,NULL,NULL,0.00,0.00,1,0.00,60,'manual',0.30,0.00,0.00,'2025-12-03 22:38:46',NULL,0,1),(7,NULL,NULL,0.00,0.00,1,0.00,61,'manual',0.30,0.00,0.00,'2025-12-03 22:38:49',NULL,0,1),(8,NULL,NULL,0.00,0.00,1,0.00,62,'manual',0.30,0.00,0.00,'2025-12-03 22:38:55',NULL,0,1),(9,NULL,NULL,0.00,0.00,1,0.00,63,'manual',0.30,0.00,0.00,'2025-12-03 22:39:02',NULL,0,1),(10,NULL,NULL,0.00,0.00,1,0.00,64,'manual',0.30,0.00,0.00,'2025-12-03 22:39:08',NULL,0,1),(11,NULL,NULL,0.00,0.00,1,0.00,65,'manual',0.30,0.00,0.00,'2025-12-03 22:39:17',NULL,0,1),(12,NULL,NULL,0.00,0.00,1,0.00,66,'manual',0.30,0.00,0.00,'2025-12-03 22:39:26',NULL,0,1),(25,1,NULL,0.00,0.00,1,8.00,62,'manual',0.30,0.00,0.00,'2025-12-03 23:50:01','Agua individual',0,1),(26,1,NULL,0.00,0.00,1,58.00,63,'manual',0.30,0.00,0.00,'2025-12-03 23:50:01','Brownie',0,1),(27,1,NULL,0.00,0.00,1,22.00,65,'manual',0.30,0.00,0.00,'2025-12-03 23:50:01','Churro Relleno',0,1),(28,1,NULL,0.00,0.00,1,16.00,57,'manual',0.30,0.00,0.00,'2025-12-03 23:50:01','Cono Choco',0,1),(29,1,NULL,0.00,0.00,1,18.00,56,'manual',0.30,0.00,0.00,'2025-12-03 23:50:01','Cono Galleta',0,1),(30,1,NULL,0.00,0.00,1,15.00,55,'manual',0.30,0.00,0.00,'2025-12-03 23:50:01','Cono Oblea',0,1),(31,1,NULL,0.00,0.00,1,27.00,58,'manual',0.30,0.00,0.00,'2025-12-03 23:50:01','Cono Waffle',0,1),(32,1,NULL,0.00,0.00,1,68.00,66,'manual',0.30,0.00,0.00,'2025-12-03 23:50:01','Fresas Con Crema',0,1),(33,1,NULL,0.00,0.00,1,22.00,61,'manual',0.30,0.00,0.00,'2025-12-03 23:50:01','Soda de Bote',0,1),(34,1,NULL,0.00,0.00,1,42.00,59,'manual',0.30,0.00,0.00,'2025-12-03 23:50:01','Chocoice',0,1),(35,1,NULL,0.00,0.00,1,65.00,60,'manual',0.30,0.00,0.00,'2025-12-03 23:50:01','Frappe',0,1),(36,1,NULL,0.00,0.00,1,68.00,64,'manual',0.30,0.00,0.00,'2025-12-03 23:50:01','Malteada',0,1),(0,NULL,NULL,0.00,0.00,1,0.00,115,'auto',0.30,0.00,0.00,'2026-01-24 12:42:57',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,116,'auto',0.30,0.00,0.00,'2026-01-24 12:43:08',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,117,'auto',0.30,0.00,0.00,'2026-01-24 12:43:14',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,118,'auto',0.30,0.00,0.00,'2026-01-24 12:43:32',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,119,'auto',0.30,0.00,0.00,'2026-01-24 12:43:47',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,120,'auto',0.30,0.00,0.00,'2026-01-24 13:01:49',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,121,'auto',0.30,0.00,0.00,'2026-01-24 21:07:46',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,122,'auto',0.30,0.00,0.00,'2026-01-24 21:08:21',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,123,'auto',0.30,0.00,0.00,'2026-01-24 21:08:45',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,124,'auto',0.30,0.00,0.00,'2026-01-24 21:09:03',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,125,'auto',0.30,0.00,0.00,'2026-01-24 21:09:19',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,126,'auto',0.30,0.00,0.00,'2026-01-24 21:10:17',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,127,'auto',0.30,0.00,0.00,'2026-01-24 21:10:27',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,128,'auto',0.30,0.00,0.00,'2026-01-24 21:10:33',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,129,'auto',0.30,0.00,0.00,'2026-01-24 21:10:41',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,130,'auto',0.30,0.00,0.00,'2026-01-24 21:11:04',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,131,'auto',0.30,0.00,0.00,'2026-01-24 21:11:27',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,132,'auto',0.30,0.00,0.00,'2026-01-24 21:11:45',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,133,'auto',0.30,0.00,0.00,'2026-01-24 21:11:52',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,134,'auto',0.30,0.00,0.00,'2026-01-24 21:12:45',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,135,'auto',0.30,0.00,0.00,'2026-01-24 21:13:28',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,136,'auto',0.30,0.00,0.00,'2026-01-24 21:14:57',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,137,'auto',0.30,0.00,0.00,'2026-01-24 21:16:20',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,138,'auto',0.30,0.00,0.00,'2026-01-24 21:16:57',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,139,'auto',0.30,0.00,0.00,'2026-01-24 21:18:16',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,140,'auto',0.30,0.00,0.00,'2026-01-24 21:19:56',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,141,'auto',0.30,0.00,0.00,'2026-01-24 21:21:04',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,142,'auto',0.30,0.00,0.00,'2026-01-24 21:21:23',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,143,'auto',0.30,0.00,0.00,'2026-01-24 21:22:00',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,144,'auto',0.30,0.00,0.00,'2026-01-24 21:23:06',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,145,'auto',0.30,0.00,0.00,'2026-01-24 21:24:11',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,146,'manual',0.30,0.00,0.00,'2026-02-04 19:58:44',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,147,'manual',0.30,0.00,0.00,'2026-02-04 19:58:55',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,148,'manual',0.30,0.00,0.00,'2026-02-04 19:59:02',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,149,'manual',0.30,0.00,0.00,'2026-02-04 19:59:11',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,150,'manual',0.30,0.00,0.00,'2026-02-04 19:59:23',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,151,'manual',0.30,0.00,0.00,'2026-02-04 19:59:44',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,152,'manual',0.30,0.00,0.00,'2026-02-04 20:00:29',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,153,'manual',0.30,0.00,0.00,'2026-02-04 20:00:34',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,154,'manual',0.30,0.00,0.00,'2026-02-04 20:00:40',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,155,'manual',0.30,0.00,0.00,'2026-02-04 20:01:13',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,156,'manual',0.30,0.00,0.00,'2026-02-04 20:03:41',NULL,0,1),(0,NULL,NULL,0.00,0.00,1,0.00,157,'manual',0.30,0.00,0.00,'2026-02-04 20:03:57',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,153,'manual',0.30,0.00,0.00,'2026-02-04 20:05:31',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,154,'auto',0.30,0.00,0.00,'2026-02-04 20:05:31',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,157,'auto',0.30,0.00,0.00,'2026-02-04 20:05:31',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,152,'auto',0.30,0.00,0.00,'2026-02-04 20:05:31',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,149,'auto',0.30,0.00,0.00,'2026-02-04 20:05:31',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,147,'auto',0.30,0.00,0.00,'2026-02-04 20:05:31',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,146,'auto',0.30,0.00,0.00,'2026-02-04 20:05:31',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,148,'auto',0.30,0.00,0.00,'2026-02-04 20:05:31',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,156,'auto',0.30,0.00,0.00,'2026-02-04 20:05:31',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,151,'auto',0.30,0.00,0.00,'2026-02-04 20:05:31',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,155,'auto',0.30,0.00,0.00,'2026-02-04 20:05:31',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,150,'auto',0.30,0.00,0.00,'2026-02-04 20:05:31',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,153,'manual',0.30,0.00,0.00,'2026-02-04 20:05:32',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,154,'auto',0.30,0.00,0.00,'2026-02-04 20:05:32',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,157,'auto',0.30,0.00,0.00,'2026-02-04 20:05:32',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,152,'auto',0.30,0.00,0.00,'2026-02-04 20:05:32',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,149,'auto',0.30,0.00,0.00,'2026-02-04 20:05:32',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,147,'auto',0.30,0.00,0.00,'2026-02-04 20:05:32',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,146,'auto',0.30,0.00,0.00,'2026-02-04 20:05:32',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,148,'auto',0.30,0.00,0.00,'2026-02-04 20:05:32',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,156,'auto',0.30,0.00,0.00,'2026-02-04 20:05:32',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,151,'auto',0.30,0.00,0.00,'2026-02-04 20:05:32',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,155,'auto',0.30,0.00,0.00,'2026-02-04 20:05:32',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,150,'auto',0.30,0.00,0.00,'2026-02-04 20:05:32',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,153,'manual',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,153,'manual',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,154,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,154,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,157,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,157,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,152,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,152,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,149,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,149,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,147,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,147,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,146,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,146,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,148,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,148,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,156,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,156,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,151,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,151,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,155,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,155,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,150,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,150,'auto',0.30,0.00,0.00,'2026-02-04 20:05:35',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,153,'manual',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,153,'manual',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,153,'manual',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,153,'manual',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,154,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,154,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,154,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,154,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,157,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,157,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,157,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,157,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,152,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,152,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,152,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,152,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,149,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,149,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,149,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,149,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,147,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,147,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,147,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,147,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,146,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,146,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,146,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,146,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,148,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,148,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,148,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,148,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,156,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,156,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,156,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,156,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,151,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,151,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,151,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,151,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,155,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,155,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,155,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,155,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,150,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,150,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,150,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1),(0,12,NULL,0.00,0.00,1,NULL,150,'auto',0.30,0.00,0.00,'2026-02-04 20:05:37',NULL,0,1);
/*!40000 ALTER TABLE `pt_precios_backup_20260204` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pt_reglas_markup`
--

DROP TABLE IF EXISTS `pt_reglas_markup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pt_reglas_markup` (
  `id` int(11) NOT NULL,
  `empresa_id` int(11) DEFAULT NULL,
  `costo_min` decimal(12,2) DEFAULT 0.00,
  `costo_max` decimal(12,2) DEFAULT 9999999.00,
  `markup_pct` decimal(5,2) DEFAULT 0.30,
  `descripcion` varchar(100) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pt_reglas_markup`
--

LOCK TABLES `pt_reglas_markup` WRITE;
/*!40000 ALTER TABLE `pt_reglas_markup` DISABLE KEYS */;
/*!40000 ALTER TABLE `pt_reglas_markup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rangos_organizacionales`
--

DROP TABLE IF EXISTS `rangos_organizacionales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rangos_organizacionales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `nivel` int(11) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `puede_crear_usuarios` tinyint(1) DEFAULT 0,
  `puede_editar_configuracion` tinyint(1) DEFAULT 0,
  `puede_ver_reportes_consolidados` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  UNIQUE KEY `nivel` (`nivel`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rangos_organizacionales`
--

LOCK TABLES `rangos_organizacionales` WRITE;
/*!40000 ALTER TABLE `rangos_organizacionales` DISABLE KEYS */;
INSERT INTO `rangos_organizacionales` VALUES (1,'Director General',1,'M?xima autoridad del contratante',1,1,1),(2,'Gerente',2,'Gerente de ?rea o sucursal',1,1,1),(3,'Jefe de Departamento',3,'Jefe de departamento espec?fico',0,0,0),(4,'Empleado',4,'Personal operativo',0,0,0);
/*!40000 ALTER TABLE `rangos_organizacionales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relaciones_b2b`
--

DROP TABLE IF EXISTS `relaciones_b2b`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relaciones_b2b` (
  `id` int(11) NOT NULL,
  `empresa_proveedor_id` int(11) NOT NULL,
  `empresa_cliente_id` int(11) NOT NULL,
  `activa` tinyint(1) DEFAULT 1,
  `dias_credito` int(11) DEFAULT 0,
  `limite_credito` decimal(12,2) DEFAULT 0.00,
  `descuento_default` decimal(5,2) DEFAULT 0.00,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relaciones_b2b`
--

LOCK TABLES `relaciones_b2b` WRITE;
/*!40000 ALTER TABLE `relaciones_b2b` DISABLE KEYS */;
/*!40000 ALTER TABLE `relaciones_b2b` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `retiros_efectivo`
--

DROP TABLE IF EXISTS `retiros_efectivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `retiros_efectivo` (
  `id` int(11) NOT NULL,
  `empresa_id` int(11) DEFAULT NULL,
  `turno_id` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `motivo` varchar(255) DEFAULT NULL,
  `usuario_id` int(11) NOT NULL,
  `billetes_20` int(11) DEFAULT 0,
  `billetes_50` int(11) DEFAULT 0,
  `billetes_100` int(11) DEFAULT 0,
  `billetes_200` int(11) DEFAULT 0,
  `billetes_500` int(11) DEFAULT 0,
  `dolares` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retiros_efectivo`
--

LOCK TABLES `retiros_efectivo` WRITE;
/*!40000 ALTER TABLE `retiros_efectivo` DISABLE KEYS */;
/*!40000 ALTER TABLE `retiros_efectivo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_b2b_empresa`
--

DROP TABLE IF EXISTS `roles_b2b_empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles_b2b_empresa` (
  `id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `es_supervisor` tinyint(1) DEFAULT 0,
  `es_ventas` tinyint(1) DEFAULT 0,
  `es_cxc` tinyint(1) DEFAULT 0,
  `es_cxp` tinyint(1) DEFAULT 0,
  `es_almacen` tinyint(1) DEFAULT 0,
  `es_reparto` tinyint(1) DEFAULT 0,
  `telefono_whatsapp` varchar(20) DEFAULT NULL,
  `notificar_whatsapp` tinyint(1) DEFAULT 1,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_b2b_empresa`
--

LOCK TABLES `roles_b2b_empresa` WRITE;
/*!40000 ALTER TABLE `roles_b2b_empresa` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles_b2b_empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subcuentas`
--

DROP TABLE IF EXISTS `subcuentas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subcuentas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cuenta_id` int(11) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `activa` tinyint(1) DEFAULT 1,
  `empresa_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `cuenta_id` (`cuenta_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subcuentas`
--

LOCK TABLES `subcuentas` WRITE;
/*!40000 ALTER TABLE `subcuentas` DISABLE KEYS */;
/*!40000 ALTER TABLE `subcuentas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suscripciones`
--

DROP TABLE IF EXISTS `suscripciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suscripciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contratante_id` int(11) NOT NULL,
  `tipo_plan` enum('MENSUAL','ANUAL') NOT NULL DEFAULT 'MENSUAL',
  `fecha_inicio` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `fecha_proximo_pago` date NOT NULL,
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `descuento_porcentaje` decimal(5,2) DEFAULT 0.00,
  `descuento_monto` decimal(10,2) DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `estado` enum('ACTIVA','VENCIDA','SUSPENDIDA','CANCELADA') DEFAULT 'ACTIVA',
  `metodo_pago` varchar(50) DEFAULT NULL,
  `referencia_pago` varchar(100) DEFAULT NULL,
  `notas` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_contratante` (`contratante_id`),
  KEY `idx_estado` (`estado`),
  KEY `idx_vencimiento` (`fecha_vencimiento`),
  CONSTRAINT `fk_suscripcion_contratante` FOREIGN KEY (`contratante_id`) REFERENCES `contratantes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suscripciones`
--

LOCK TABLES `suscripciones` WRITE;
/*!40000 ALTER TABLE `suscripciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `suscripciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_inventario`
--

DROP TABLE IF EXISTS `tipo_inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_inventario` (
  `id` int(11) NOT NULL,
  `nombre` enum('MP','WIP','PT') NOT NULL,
  `empresa_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_inventario`
--

LOCK TABLES `tipo_inventario` WRITE;
/*!40000 ALTER TABLE `tipo_inventario` DISABLE KEYS */;
INSERT INTO `tipo_inventario` VALUES (1,'MP',NULL),(2,'WIP',NULL),(3,'PT',NULL);
/*!40000 ALTER TABLE `tipo_inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_inventario`
--

DROP TABLE IF EXISTS `tipos_inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipos_inventario` (
  `id` tinyint(4) NOT NULL,
  `clave` enum('MP','WIP','PT') NOT NULL,
  `empresa_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_inventario`
--

LOCK TABLES `tipos_inventario` WRITE;
/*!40000 ALTER TABLE `tipos_inventario` DISABLE KEYS */;
INSERT INTO `tipos_inventario` VALUES (1,'MP',NULL),(2,'WIP',NULL),(3,'PT',NULL);
/*!40000 ALTER TABLE `tipos_inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transferencias_detalle`
--

DROP TABLE IF EXISTS `transferencias_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transferencias_detalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transferencia_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` decimal(15,4) NOT NULL,
  `precio_unitario` decimal(15,2) NOT NULL,
  `subtotal` decimal(15,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_transferencia` (`transferencia_id`),
  KEY `idx_producto` (`producto_id`),
  CONSTRAINT `fk_transdet_transferencia` FOREIGN KEY (`transferencia_id`) REFERENCES `transferencias_intercompany` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transferencias_detalle`
--

LOCK TABLES `transferencias_detalle` WRITE;
/*!40000 ALTER TABLE `transferencias_detalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `transferencias_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transferencias_intercompany`
--

DROP TABLE IF EXISTS `transferencias_intercompany`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transferencias_intercompany` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contratante_id` int(11) NOT NULL,
  `empresa_origen_id` int(11) NOT NULL,
  `empresa_destino_id` int(11) NOT NULL,
  `folio` varchar(50) NOT NULL,
  `fecha_transferencia` date NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `subtotal` decimal(15,2) NOT NULL DEFAULT 0.00,
  `total` decimal(15,2) NOT NULL DEFAULT 0.00,
  `estado` enum('PENDIENTE','EN_TRANSITO','RECIBIDA','CANCELADA') DEFAULT 'PENDIENTE',
  `fecha_envio` timestamp NULL DEFAULT NULL,
  `fecha_recepcion` timestamp NULL DEFAULT NULL,
  `usuario_recibe_id` int(11) DEFAULT NULL,
  `notas` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `folio` (`folio`),
  KEY `idx_contratante` (`contratante_id`),
  KEY `idx_origen` (`empresa_origen_id`),
  KEY `idx_destino` (`empresa_destino_id`),
  KEY `idx_folio` (`folio`),
  KEY `idx_fecha` (`fecha_transferencia`),
  KEY `idx_estado` (`estado`),
  KEY `fk_trans_usuario` (`usuario_id`),
  KEY `fk_trans_usuario_recibe` (`usuario_recibe_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transferencias_intercompany`
--

LOCK TABLES `transferencias_intercompany` WRITE;
/*!40000 ALTER TABLE `transferencias_intercompany` DISABLE KEYS */;
/*!40000 ALTER TABLE `transferencias_intercompany` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turno_arqueo`
--

DROP TABLE IF EXISTS `turno_arqueo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turno_arqueo` (
  `id` int(11) NOT NULL,
  `turno_id` int(11) NOT NULL,
  `billetes_20` int(11) DEFAULT 0,
  `billetes_50` int(11) DEFAULT 0,
  `billetes_100` int(11) DEFAULT 0,
  `billetes_200` int(11) DEFAULT 0,
  `billetes_500` int(11) DEFAULT 0,
  `dolares` decimal(10,2) DEFAULT 0.00,
  `monedas` decimal(10,2) DEFAULT 0.00,
  `total_efectivo` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turno_arqueo`
--

LOCK TABLES `turno_arqueo` WRITE;
/*!40000 ALTER TABLE `turno_arqueo` DISABLE KEYS */;
/*!40000 ALTER TABLE `turno_arqueo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turno_gastos`
--

DROP TABLE IF EXISTS `turno_gastos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turno_gastos` (
  `id` int(11) NOT NULL,
  `empresa_id` int(11) DEFAULT NULL,
  `turno_id` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `concepto` varchar(255) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `tipo` enum('compra','gasto') NOT NULL,
  `notas` text DEFAULT NULL,
  `usuario_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turno_gastos`
--

LOCK TABLES `turno_gastos` WRITE;
/*!40000 ALTER TABLE `turno_gastos` DISABLE KEYS */;
INSERT INTO `turno_gastos` VALUES (1,1,2,'2025-12-04 21:59:26','Baño',15.00,'gasto','',13),(2,1,2,'2025-12-04 22:01:21','Leche',84.00,'gasto','',13),(3,1,2,'2025-12-04 22:02:30','Sueldo Odalis',500.00,'gasto','',13);
/*!40000 ALTER TABLE `turno_gastos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turno_inventario`
--

DROP TABLE IF EXISTS `turno_inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turno_inventario` (
  `id` int(11) NOT NULL,
  `turno_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `producto_nombre` varchar(200) NOT NULL,
  `cantidad_inicial` decimal(10,2) NOT NULL,
  `cantidad_final` decimal(10,2) DEFAULT NULL,
  `empresa_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turno_inventario`
--

LOCK TABLES `turno_inventario` WRITE;
/*!40000 ALTER TABLE `turno_inventario` DISABLE KEYS */;
INSERT INTO `turno_inventario` VALUES (1,2,62,'Agua 500ml',5.00,NULL,1),(2,2,63,'Brownie',4.00,NULL,1),(3,2,65,'Churro relleno',0.00,NULL,1),(4,2,57,'Cono Choco',62.00,NULL,1),(5,2,56,'Cono Galleta',137.00,NULL,1),(6,2,55,'Cono Oblea',55.00,NULL,1),(7,2,58,'Cono Wafle',20.00,NULL,1),(8,2,66,'Fresa',9.00,NULL,1),(9,2,61,'Sodas',6.00,NULL,1),(10,2,59,'Vaso Chocoice',11.00,NULL,1),(11,2,60,'Vaso Frappe',21.00,NULL,1),(12,2,64,'Vaso Malteada 16oz',1.00,NULL,1),(0,0,62,'Agua 500ml',3.00,NULL,1),(0,0,63,'Brownie',5.00,NULL,1),(0,0,65,'Churro relleno',0.00,NULL,1),(0,0,57,'Cono Choco',0.00,NULL,1),(0,0,56,'Cono Galleta',119.00,NULL,1),(0,0,55,'Cono Oblea',122.00,NULL,1),(0,0,58,'Cono Wafle',84.00,NULL,1),(0,0,66,'Fresa',11.00,NULL,1),(0,0,61,'Sodas',11.00,NULL,1),(0,0,59,'Vaso Chocoice',25.00,NULL,1),(0,0,60,'Vaso Frappe',44.00,NULL,1),(0,0,64,'Vaso Malteada 16oz',9.00,NULL,1),(0,0,62,'Agua 500ml',0.00,NULL,1),(0,0,63,'Brownie',1.00,NULL,1),(0,0,65,'Churro relleno',0.00,NULL,1),(0,0,57,'Cono Choco',0.00,NULL,1),(0,0,56,'Cono Galleta',56.00,NULL,1),(0,0,55,'Cono Oblea',21.00,NULL,1),(0,0,58,'Cono Wafle',30.00,NULL,1),(0,0,66,'Fresa',8.00,NULL,1),(0,0,61,'Sodas',1.00,NULL,1),(0,0,59,'Vaso Chocoice',23.00,NULL,1),(0,0,60,'Vaso Frappe',8.00,NULL,1),(0,0,64,'Vaso Malteada 16oz',23.00,NULL,1),(0,1,153,'Agua',90.00,NULL,12),(0,1,154,'Brownie individual',3.00,NULL,12),(0,1,157,'Churro relleno',0.00,NULL,12),(0,1,152,'Coca Cola Bote',8.00,NULL,12),(0,1,149,'Cono Chocolate',0.00,NULL,12),(0,1,147,'Cono Galleta',170.00,NULL,12),(0,1,146,'Cono Oblea',90.00,NULL,12),(0,1,148,'Cono Wafle',67.00,NULL,12),(0,1,156,'Fresas Con Crema',10.00,NULL,12),(0,1,151,'Vaso 16oz Frappe',25.00,NULL,12),(0,1,155,'Vaso 16oz Malteada',25.00,NULL,12),(0,1,150,'Vaso Chocoice',17.00,NULL,12),(0,2,153,'Agua',0.00,NULL,12),(0,2,154,'Brownie individual',0.00,NULL,12),(0,2,157,'Churro relleno',0.00,NULL,12),(0,2,152,'Coca Cola Bote',5.00,NULL,12),(0,2,149,'Cono Chocolate',0.00,NULL,12),(0,2,147,'Cono Galleta',72.00,NULL,12),(0,2,146,'Cono Oblea',90.00,NULL,12),(0,2,148,'Cono Wafle',74.00,NULL,12),(0,2,156,'Fresas Con Crema',0.00,NULL,12),(0,2,151,'Vaso 16oz Frappe',28.00,NULL,12),(0,2,155,'Vaso 16oz Malteada',29.00,NULL,12),(0,2,150,'Vaso Chocoice',18.00,NULL,12),(0,3,153,'Agua',0.00,NULL,12),(0,3,154,'Brownie individual',0.00,NULL,12),(0,3,157,'Churro relleno',0.00,NULL,12),(0,3,152,'Coca Cola Bote',6.00,NULL,12),(0,3,149,'Cono Chocolate',0.00,NULL,12),(0,3,147,'Cono Galleta',80.00,NULL,12),(0,3,146,'Cono Oblea',40.00,NULL,12),(0,3,148,'Cono Wafle',30.00,NULL,12),(0,3,156,'Fresas Con Crema',0.00,NULL,12),(0,3,151,'Vaso 16oz Frappe',15.00,NULL,12),(0,3,155,'Vaso 16oz Malteada',15.00,NULL,12),(0,3,150,'Vaso Chocoice',15.00,NULL,12),(0,4,153,'Agua',7.00,NULL,12),(0,4,154,'Brownie individual',3.00,NULL,12),(0,4,157,'Churro relleno',0.00,NULL,12),(0,4,152,'Coca Cola Bote',8.00,NULL,12),(0,4,149,'Cono Chocolate',50.00,NULL,12),(0,4,147,'Cono Galleta',60.00,NULL,12),(0,4,146,'Cono Oblea',0.00,NULL,12),(0,4,148,'Cono Wafle',25.00,NULL,12),(0,4,156,'Fresas Con Crema',9.00,NULL,12),(0,4,151,'Vaso 16oz Frappe',25.00,NULL,12),(0,4,155,'Vaso 16oz Malteada',30.00,NULL,12),(0,4,150,'Vaso Chocoice',20.00,NULL,12),(0,5,153,'Agua',4.00,NULL,12),(0,5,154,'Brownie individual',1.00,NULL,12),(0,5,157,'Churro relleno',0.00,NULL,12),(0,5,152,'Coca Cola Bote',2.00,NULL,12),(0,5,149,'Cono Chocolate',36.00,NULL,12),(0,5,147,'Cono Galleta',46.00,NULL,12),(0,5,146,'Cono Oblea',110.00,NULL,12),(0,5,148,'Cono Wafle',94.00,NULL,12),(0,5,156,'Fresas Con Crema',7.00,NULL,12),(0,5,151,'Vaso 16oz Frappe',26.00,NULL,12),(0,5,155,'Vaso 16oz Malteada',31.00,NULL,12),(0,5,150,'Vaso Chocoice',13.00,NULL,12),(0,6,154,'Brownie individual',4.00,NULL,12),(0,6,157,'Churro relleno',0.00,NULL,12),(0,6,152,'Coca Cola Bote',0.00,NULL,12),(0,6,149,'Cono Chocolate',40.00,NULL,12),(0,6,147,'Cono Galleta',86.00,NULL,12),(0,6,146,'Cono Oblea',32.00,NULL,12),(0,6,148,'Cono Wafle',59.00,NULL,12),(0,6,156,'Fresas Con Crema',7.00,NULL,12),(0,6,151,'Vaso 16oz Frappe',35.00,NULL,12),(0,6,155,'Vaso 16oz Malteada',20.00,NULL,12),(0,6,150,'Vaso Chocoice',13.00,NULL,12);
/*!40000 ALTER TABLE `turno_inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turno_inventario_final`
--

DROP TABLE IF EXISTS `turno_inventario_final`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turno_inventario_final` (
  `id` int(11) NOT NULL,
  `turno_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `producto_nombre` varchar(200) DEFAULT NULL,
  `cantidad_final` decimal(10,3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turno_inventario_final`
--

LOCK TABLES `turno_inventario_final` WRITE;
/*!40000 ALTER TABLE `turno_inventario_final` DISABLE KEYS */;
/*!40000 ALTER TABLE `turno_inventario_final` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turno_mermas`
--

DROP TABLE IF EXISTS `turno_mermas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turno_mermas` (
  `id` int(11) NOT NULL,
  `empresa_id` int(11) DEFAULT NULL,
  `turno_id` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `producto_id` int(11) NOT NULL,
  `producto_nombre` varchar(200) DEFAULT NULL,
  `cantidad` decimal(10,3) NOT NULL,
  `costo_unitario` decimal(10,2) DEFAULT 0.00,
  `costo_total` decimal(10,2) DEFAULT 0.00,
  `motivo` varchar(100) DEFAULT NULL,
  `notas` varchar(255) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turno_mermas`
--

LOCK TABLES `turno_mermas` WRITE;
/*!40000 ALTER TABLE `turno_mermas` DISABLE KEYS */;
INSERT INTO `turno_mermas` VALUES (1,1,2,'2025-12-04 21:42:21',62,'Agua 500ml',1.000,0.00,0.00,'roto',NULL,13);
/*!40000 ALTER TABLE `turno_mermas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turnos`
--

DROP TABLE IF EXISTS `turnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turnos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa_id` int(11) NOT NULL DEFAULT 1,
  `caja_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) NOT NULL,
  `usuario_nombre` varchar(200) DEFAULT NULL,
  `fecha_apertura` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_cierre` datetime DEFAULT NULL,
  `fondo_inicial` decimal(10,2) NOT NULL DEFAULT 0.00,
  `efectivo_final` decimal(10,2) DEFAULT NULL,
  `tipo_cambio` decimal(10,2) DEFAULT 20.00,
  `total_ventas` decimal(10,2) DEFAULT 0.00,
  `total_gastos` decimal(10,2) DEFAULT 0.00,
  `total_retiros` decimal(10,2) DEFAULT 0.00,
  `diferencia` decimal(10,2) DEFAULT 0.00,
  `estado` enum('abierto','cerrado') DEFAULT 'abierto',
  `observaciones` text DEFAULT NULL,
  `notas` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `caja_id` (`caja_id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `idx_estado` (`estado`),
  KEY `idx_fecha_apertura` (`fecha_apertura`),
  KEY `idx_empresa` (`empresa_id`),
  CONSTRAINT `turnos_ibfk_1` FOREIGN KEY (`caja_id`) REFERENCES `cajas` (`id`),
  CONSTRAINT `turnos_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `turnos_ibfk_3` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turnos`
--

LOCK TABLES `turnos` WRITE;
/*!40000 ALTER TABLE `turnos` DISABLE KEYS */;
INSERT INTO `turnos` VALUES (1,12,NULL,9,'Pako','2026-02-04 20:39:35','2026-02-08 10:15:17',500.00,500.00,20.00,0.00,0.00,0.00,0.00,'cerrado','\n[CIERRE RÁPIDO] ','','2026-02-05 03:39:35','2026-02-08 17:15:17'),(2,12,NULL,9,'Pako','2026-02-08 22:42:00','2026-02-10 08:26:58',500.00,500.00,18.00,0.00,0.00,0.00,0.00,'cerrado','\n[CIERRE RÁPIDO] ','','2026-02-09 05:42:00','2026-02-10 15:26:58'),(3,12,NULL,9,'Pako','2026-02-10 08:43:55','2026-04-04 20:46:58',500.00,500.00,18.00,0.00,0.00,0.00,0.00,'cerrado','\n[CIERRE RÁPIDO] ','','2026-02-10 15:43:55','2026-04-05 02:46:58'),(4,12,NULL,9,'Pako','2026-04-04 20:49:45','2026-04-07 17:41:08',500.00,500.00,18.00,0.00,0.00,0.00,0.00,'cerrado','\n[CIERRE RÁPIDO] ','','2026-04-05 02:49:45','2026-04-07 23:41:08'),(5,12,NULL,9,'Pako','2026-04-07 17:48:29','2026-04-09 14:25:38',500.00,500.00,17.00,0.00,0.00,0.00,0.00,'cerrado','\n[CIERRE RÁPIDO] ','','2026-04-07 23:48:29','2026-04-09 20:25:38'),(6,12,NULL,9,'Pako','2026-04-09 14:36:04',NULL,500.00,NULL,17.00,0.00,0.00,0.00,0.00,'abierto',NULL,'','2026-04-09 20:36:04','2026-04-09 20:36:04');
/*!40000 ALTER TABLE `turnos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ubicaciones_config`
--

DROP TABLE IF EXISTS `ubicaciones_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ubicaciones_config` (
  `id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `nivel` int(11) NOT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `nombre_nivel` varchar(50) NOT NULL,
  `nombre_personalizado` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ubicaciones_config`
--

LOCK TABLES `ubicaciones_config` WRITE;
/*!40000 ALTER TABLE `ubicaciones_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `ubicaciones_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ubicaciones_valores`
--

DROP TABLE IF EXISTS `ubicaciones_valores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ubicaciones_valores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `almacen_id` int(11) NOT NULL,
  `elemento_id` int(11) DEFAULT NULL COMMENT 'FK a almacenes_elementos si la ubicaci?n pertenece a un elemento espec?fico',
  `empresa_id` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL COMMENT 'C?digo ?nico de la ubicaci?n ej: A-1-2-3',
  `fila` char(2) DEFAULT NULL COMMENT 'Fila alfab?tica A, B, C...',
  `columna` int(11) DEFAULT NULL COMMENT 'N?mero de columna',
  `nivel` int(11) DEFAULT NULL COMMENT 'Nivel vertical 1, 2, 3...',
  `compartimento` int(11) DEFAULT NULL COMMENT 'Compartimento dentro del nivel',
  `descripcion` varchar(255) DEFAULT NULL,
  `capacidad_kg` decimal(8,2) DEFAULT NULL COMMENT 'Capacidad en kilogramos',
  `capacidad_unidades` int(11) DEFAULT NULL COMMENT 'Capacidad en unidades',
  `ocupado` tinyint(1) DEFAULT 0 COMMENT '1 si est? ocupada, 0 si est? libre',
  `activo` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unique_ubicacion` (`almacen_id`,`codigo`,`empresa_id`),
  KEY `idx_empresa` (`empresa_id`),
  KEY `idx_almacen` (`almacen_id`),
  KEY `idx_elemento` (`elemento_id`),
  KEY `idx_activo` (`activo`),
  CONSTRAINT `ubicaciones_valores_ibfk_1` FOREIGN KEY (`almacen_id`) REFERENCES `almacenes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ubicaciones_valores_ibfk_2` FOREIGN KEY (`elemento_id`) REFERENCES `almacenes_elementos` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ubicaciones_valores_ibfk_3` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Ubicaciones espec?ficas dentro de almacenes y elementos para control de inventario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ubicaciones_valores`
--

LOCK TABLES `ubicaciones_valores` WRITE;
/*!40000 ALTER TABLE `ubicaciones_valores` DISABLE KEYS */;
/*!40000 ALTER TABLE `ubicaciones_valores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidades_medida`
--

DROP TABLE IF EXISTS `unidades_medida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unidades_medida` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `empresa_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidades_medida`
--

LOCK TABLES `unidades_medida` WRITE;
/*!40000 ALTER TABLE `unidades_medida` DISABLE KEYS */;
INSERT INTO `unidades_medida` VALUES (1,'uds',10),(2,'mililitro',10),(3,'gramos',10),(4,'KG',10);
/*!40000 ALTER TABLE `unidades_medida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_areas`
--

DROP TABLE IF EXISTS `usuario_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario_areas` (
  `id` int(11) NOT NULL,
  `empresa_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `es_responsable` tinyint(1) DEFAULT 0,
  `fecha_asignacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `rol_area` enum('responsable','supervisor','operador','consulta') DEFAULT 'operador',
  `puede_autorizar` tinyint(1) DEFAULT 0,
  `puede_editar` tinyint(1) DEFAULT 1,
  `puede_eliminar` tinyint(1) DEFAULT 0,
  `notificar_alertas` tinyint(1) DEFAULT 1,
  `asignado_por` int(11) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `notas` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_areas`
--

LOCK TABLES `usuario_areas` WRITE;
/*!40000 ALTER TABLE `usuario_areas` DISABLE KEYS */;
INSERT INTO `usuario_areas` VALUES (3,1,9,1,0,'2025-12-12 01:15:30','responsable',0,1,0,1,9,0,NULL);
/*!40000 ALTER TABLE `usuario_areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `usuario` varchar(50) DEFAULT NULL,
  `correo` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `rol` enum('admin','editor') NOT NULL,
  `email_confirmado` tinyint(1) DEFAULT 0,
  `token_confirmacion` varchar(100) DEFAULT NULL,
  `token_reset` varchar(100) DEFAULT NULL,
  `token_reset_expira` datetime DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  `empresa_id` int(11) DEFAULT NULL,
  `contratante_id` int(11) DEFAULT NULL,
  `rango` int(11) DEFAULT 4,
  `empresas_acceso` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`empresas_acceso`)),
  `puede_agregar_usuarios` tinyint(1) DEFAULT 0,
  `tipo_usuario` varchar(50) DEFAULT 'operador',
  `activo` tinyint(1) DEFAULT 1,
  `fecha_ingreso` date DEFAULT NULL,
  `ultimo_acceso` datetime DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `puesto` varchar(100) DEFAULT NULL,
  `estado_registro` enum('pendiente','invitado','activo','inactivo') DEFAULT 'pendiente',
  `token_invitacion` varchar(100) DEFAULT NULL,
  `fecha_invitacion` datetime DEFAULT NULL,
  `invitado_por` int(11) DEFAULT NULL,
  `fecha_token_expira` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_usuario_contratante` (`contratante_id`),
  CONSTRAINT `fk_usuario_contratante` FOREIGN KEY (`contratante_id`) REFERENCES `contratantes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (6,'Admin Principal','admin','admin@miapp.com','$2b$12$VeOkED27Wc7gX2M2IMcNuuia7PfwIe9PsIOu2R0DWGoZNnMORyOrm','admin',0,NULL,NULL,NULL,'2025-12-02 22:41:03',1,NULL,4,NULL,0,'operador',1,NULL,NULL,NULL,NULL,'pendiente',NULL,NULL,NULL,NULL),(8,'Editor Uno','editor','editor@miapp.com','$2b$12$pqrosBEHOdv8gB0VavMRi.VfciJJVI.qyKNvOSvSykG/Lh/R36s5W','editor',0,NULL,NULL,NULL,'2025-12-02 22:41:03',1,NULL,4,NULL,0,'operador',1,NULL,NULL,NULL,NULL,'pendiente',NULL,NULL,NULL,NULL),(9,'Pako','pako','fcogranados@yahoo.com','$2b$12$evl1sJT9IW9ch6eK8GlhIeCw5Zq4IOAVTYPXn47LGguwoDoV5zUPK','admin',1,NULL,NULL,NULL,'2025-12-02 22:41:03',1,9,4,'[10,12,13]',0,'operador',1,NULL,NULL,NULL,'Mostrador','activo',NULL,NULL,NULL,NULL),(12,'Admin','admin2','admin@local','$2b$12$abcdefghijklmnopqrstuvCnxm0mVwQ1JxWw1m0Q3v0','admin',0,NULL,NULL,NULL,'2025-12-02 22:41:03',1,NULL,4,NULL,0,'operador',1,NULL,NULL,NULL,NULL,'pendiente',NULL,NULL,NULL,NULL),(13,'Luis Juarez','luis','yolopostres@gmail.com','$2b$12$s3Nwh8lMCicAt/w9fcLxkeibv9d.eybZam9awWprFLWDub.NUJaQ.','admin',1,NULL,NULL,NULL,'2025-12-02 22:50:03',1,NULL,4,NULL,0,'admin_empresa',1,NULL,NULL,NULL,NULL,'pendiente',NULL,NULL,NULL,NULL),(24,'Pako Usuario','pakogranados1','pakogranados1@gmail.com','$2b$12$yISSo.2PSf7aVqZ.SCatTu14/53TkKV7QsVB/YVs4VYY31QDW3hF6','editor',1,NULL,NULL,NULL,'2025-12-12 10:58:15',1,NULL,4,NULL,0,'operador',1,NULL,NULL,NULL,'Mostrador','activo',NULL,'2025-12-12 10:58:15',13,'2025-12-13 10:58:15'),(31,'Caja uno','cajerounoyolo','cajerounoyolo@gmail.com','scrypt:32768:8:1$22OYIW3fDbpbLUKc$d6a834f0e6ea61f986932556a37ee46e53a8b6850a08b865d61e70be021ccdb5db07cac284c343762f6feaf0d4f5051b9a718217c310922cf80e0ba887dd76ff','editor',1,NULL,NULL,NULL,'2025-12-21 17:22:08',10,NULL,4,NULL,0,'operador',1,NULL,NULL,NULL,'Cajero','activo',NULL,'2025-12-21 17:22:08',13,'2025-12-22 17:22:08'),(32,'Usuario Temporal',NULL,'pakogranados1@hotmail.com','scrypt:32768:8:1$5ucuR6K8OiLWHIdX$882c7cbb5a8d4da1addd161b425acce9b2d00c8f19d048dae9891a7b0cf25d63c955fa64a436e869fbdffd12552bb2ff2e7c9b4044371239164c2c6edc23692e','admin',0,NULL,NULL,NULL,'2025-12-27 05:19:02',NULL,NULL,1,NULL,1,'operador',0,NULL,NULL,NULL,NULL,'pendiente',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios_areas`
--

DROP TABLE IF EXISTS `usuarios_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios_areas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `es_responsable` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_usuario_area` (`usuario_id`,`area_id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `area_id` (`area_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios_areas`
--

LOCK TABLES `usuarios_areas` WRITE;
/*!40000 ALTER TABLE `usuarios_areas` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios_areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios_empresas`
--

DROP TABLE IF EXISTS `usuarios_empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios_empresas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `contratante_id` int(11) DEFAULT NULL,
  `estado` enum('pendiente','activo','inactivo') DEFAULT 'pendiente',
  `invitado_por` int(11) DEFAULT NULL,
  `fecha_invitacion` datetime DEFAULT current_timestamp(),
  `fecha_activacion` datetime DEFAULT NULL,
  `token_confirmacion` varchar(100) DEFAULT NULL,
  `fecha_token_expira` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_usuario_empresa` (`usuario_id`,`empresa_id`),
  KEY `idx_usuario` (`usuario_id`),
  KEY `idx_empresa` (`empresa_id`),
  CONSTRAINT `usuarios_empresas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `usuarios_empresas_ibfk_2` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios_empresas`
--

LOCK TABLES `usuarios_empresas` WRITE;
/*!40000 ALTER TABLE `usuarios_empresas` DISABLE KEYS */;
INSERT INTO `usuarios_empresas` VALUES (1,35,10,9,'pendiente',34,'2026-01-07 16:06:02',NULL,'BCeQcebAaCOomrhi74XQZ8rdC2vBXMwcsiBEm0yd9Lg','2026-01-09 16:06:02'),(2,9,1,9,'activo',NULL,'2026-01-17 19:21:32',NULL,NULL,NULL),(3,9,10,9,'activo',NULL,'2026-01-17 19:21:32',NULL,NULL,NULL),(4,9,12,9,'activo',NULL,'2026-01-17 19:21:32',NULL,NULL,NULL),(5,9,13,9,'activo',NULL,'2026-01-17 19:21:32',NULL,NULL,NULL);
/*!40000 ALTER TABLE `usuarios_empresas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventas` (
  `id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `turno_id` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `subtotal` decimal(10,2) NOT NULL,
  `iva` decimal(10,2) DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL,
  `metodo_pago` varchar(50) DEFAULT 'efectivo',
  `estado` varchar(20) DEFAULT 'completada',
  `usuario_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas_historicas`
--

DROP TABLE IF EXISTS `ventas_historicas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventas_historicas` (
  `id` int(11) NOT NULL,
  `empresa_id` int(11) NOT NULL,
  `registro_id` int(11) DEFAULT NULL,
  `fecha` date NOT NULL,
  `producto_id` int(11) NOT NULL,
  `producto_nombre` varchar(255) DEFAULT NULL,
  `cantidad` decimal(10,3) NOT NULL DEFAULT 1.000,
  `precio_unitario` decimal(12,2) NOT NULL DEFAULT 0.00,
  `subtotal` decimal(12,2) NOT NULL DEFAULT 0.00,
  `metodo_pago` varchar(50) DEFAULT 'efectivo',
  `notas` varchar(255) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_historicas`
--

LOCK TABLES `ventas_historicas` WRITE;
/*!40000 ALTER TABLE `ventas_historicas` DISABLE KEYS */;
/*!40000 ALTER TABLE `ventas_historicas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wip_asignaciones`
--

DROP TABLE IF EXISTS `wip_asignaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wip_asignaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orden_id` int(11) NOT NULL,
  `paso_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `fecha_asignacion` datetime NOT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `estado` enum('pendiente','en_proceso','completado','cancelado') DEFAULT 'pendiente',
  `observaciones` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `orden_id` (`orden_id`),
  KEY `paso_id` (`paso_id`),
  KEY `usuario_id` (`usuario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wip_asignaciones`
--

LOCK TABLES `wip_asignaciones` WRITE;
/*!40000 ALTER TABLE `wip_asignaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `wip_asignaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wip_ordenes`
--

DROP TABLE IF EXISTS `wip_ordenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wip_ordenes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `folio` varchar(50) NOT NULL,
  `proceso_id` int(11) NOT NULL,
  `cantidad_planeada` decimal(10,2) NOT NULL,
  `cantidad_completada` decimal(10,2) DEFAULT 0.00,
  `fecha_inicio_planeada` date NOT NULL,
  `fecha_fin_planeada` date DEFAULT NULL,
  `fecha_inicio_real` datetime DEFAULT NULL,
  `fecha_fin_real` datetime DEFAULT NULL,
  `estado` enum('planeada','en_proceso','completada','cancelada') DEFAULT 'planeada',
  `prioridad` enum('baja','media','alta','urgente') DEFAULT 'media',
  `almacen_destino_id` int(11) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `usuario_creador_id` int(11) DEFAULT NULL,
  `empresa_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `folio` (`folio`),
  KEY `proceso_id` (`proceso_id`),
  KEY `almacen_destino_id` (`almacen_destino_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wip_ordenes`
--

LOCK TABLES `wip_ordenes` WRITE;
/*!40000 ALTER TABLE `wip_ordenes` DISABLE KEYS */;
/*!40000 ALTER TABLE `wip_ordenes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-03 23:11:17
