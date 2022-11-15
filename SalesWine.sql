-- Borramos la base de datos SalesWine si es que existe
		USE MASTER
		DROP DATABASE IF EXISTS SalesWine
--Crear base de datos GerichSoft
CREATE DATABASE SalesWine
GO

--Definimos el formato de fecha
SET DATEFORMAT dmy

--Ponemos en uso la base de datos SalesWine
USE SalesWine

DROP TABLE IF EXISTS VENTA_DETALLE;
--Creamos la tabla VENTA_DETALLE
CREATE TABLE VENTA_DETALLE (
	IDVENDET int IDENTITY(1,1),
	IDVEN int,
	CODPRO char(3),
	CANVENDET int,
	CONSTRAINT VENTA_DETALLE_pk PRIMARY KEY (IDVENDET)
	)
GO

DROP TABLE IF EXISTS VENTA;
--Creamos la tabla VENTA
CREATE TABLE VENTA (
	IDVEN int IDENTITY(1,1),
	FECVENT datetime DEFAULT GETDATE(), 
	IDVEND int,
	IDCLI int,
	TIPPAGVEN char(1), 
	TIPENTVEN char(1),
	ESTVENT char(1) DEFAULT 'A' CHECK(ESTVENT='A' OR ESTVENT='I')
	CONSTRAINT VENTA_pk PRIMARY KEY (IDVEN)
	)
GO

DROP TABLE IF EXISTS PERSONA;
--Creamos la tabla PERSONA
create table PERSONA (	
	IDPER int IDENTITY(100,1) NOT NULL,
	DNIPER char(8) NOT NULL UNIQUE CHECK(DNIPER LIKE '%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%') ,
	APEPER varchar(80) NOT NULL,
	NOMPER varchar(80) NOT NULL ,
	CELPER char(9) NOT NULL UNIQUE,
	EMAPER varchar(150) NOT NULL UNIQUE,
	FECNACPER date DEFAULT GETDATE(),
	TIPPER char(1) NOT NULL CHECK(TIPPER='J' OR TIPPER='C' OR TIPPER='V'),
	ESTPER char(1) NOT NULL DEFAULT 'A' CHECK(ESTPER='A' OR ESTPER='I')
	CONSTRAINT PERSONA_pk PRIMARY KEY (IDPER)
	)
GO

DROP TABLE IF EXISTS PRODUCTO;
--Creamos la tabla PRODUCTO
CREATE TABLE PRODUCTO (
	CODPRO char(3) NOT NULL, 
	NOMPRO varchar(100) NOT NULL,
	TIPPRO char(1) NOT NULL,
	VOLPRO char(3) NOT NULL,
	PREPRO decimal(8,2) NOT NULL,
	STOPRO int NOT NULL,
	PAIPRO char(1) NOT NULL,
	ESTPRO char(1)  DEFAULT 'A' NOT NULL CHECK(ESTPRO='A' OR ESTPRO='I')
	CONSTRAINT PRODUCTO_pk PRIMARY KEY (CODPRO)
	)
GO

-- Establecemos relaciones
ALTER TABLE VENTA ADD CONSTRAINT VENTA_PERSONA_CLI
    FOREIGN KEY (IDCLI)
    REFERENCES PERSONA (IDPER)
GO

ALTER TABLE VENTA ADD CONSTRAINT VENTA_PERSONA_VEND
    FOREIGN KEY (IDVEND)
    REFERENCES PERSONA (IDPER)
GO

ALTER TABLE VENTA_DETALLE ADD CONSTRAINT VENTA_DETALLE_VENTA
    FOREIGN KEY (IDVEN)
    REFERENCES VENTA (IDVEN)
GO

ALTER TABLE VENTA_DETALLE ADD CONSTRAINT VENTA_DETALLE_PRODUCTO
    FOREIGN KEY (CODPRO)
    REFERENCES PRODUCTO (CODPRO)
GO

--Insertar registros en la tabla PERSONA
INSERT INTO PERSONA
(DNIPER, NOMPER, APEPER, EMAPER, CELPER, FECNACPER, TIPPER)
VALUES
('15288111', 'Adriana', 'Vásquez Carranza', 'adriana.vasquez@saleswine.com', '991548789', '10/03/1985', 'C'),
('45781236', 'Carlos', 'Guerra Tasayco', 'carlos.guerra@saleswine.com','987845123', '20/10/1980','J'),
('15263698', 'Daniel', 'Lombardi Pérez', 'daniel.lombardi@saleswine.com','998523641', '06/06/1982','J'),
('45123698', 'Roberto', 'Palacios Castillo', 'roberto.palacios@saleswine.com','985236417', '15/10/1988','V'),
('15264477', 'Carlos', 'Palomino Fernández', 'carlos.palomino@saleswine.com','984512557', '30/01/1989','V'),
('45127866', 'Fabricio', 'Rosales Zegarra', 'fabricio@yahoo.com','974815231', '02/03/1975','C'),
('15487865', 'Rosaura', 'Dávila Sánchez', 'rosaurao@gmail.com','974815254', '16/06/1979','C'),
('46632157', 'Noemí', 'Juárez Martínez', 'noemi.juarez@gmail.com','984525741', '25/09/1979','C'),
('47258533', 'Issac', 'Sánchez Jobs', 'issac.sanchez@outlook.com','953625147', '30/10/1995','C'),
('15258544', 'Fabiana', 'Carrizales Campos', 'fabiana.carrizales@outlook.com','951144236', '05/04/1997','C'),
('44/12214', 'Valeria', 'Mendoza Solano', 'valeria.mendoza@yahoo.com','972544681', '06/06/1997','C')
GO

--Insertar registros en la tabla PRODUCTO
INSERT INTO PRODUCTO
(CODPRO, NOMPRO, TIPPRO, VOLPRO, PAIPRO, PREPRO, STOPRO)
VALUES
('P01','Ramos Pinto Porto','V','750','P','119.00','60'),
('P02','Santa Julia Cabernet','V','750','A','119.00','45'),
('P03','Pulenta Estate Cabernet Sauvignon','V','750','A','189.00','70'),
('P04','La Rioja Alta Viña Alberdi','V','500','E','540.00','80'),
('P05','Amayna Pinot Noir','V','750','C','774.00','100'),
('P06','Pisco Don Santiago Mosto Verde Italia','P','750','P','59.00','75'),
('P07','Pisco Portón Mosto Verde Torontel','P','750','P','89.00','100'),
('P08','Tequila Olmeca Blanco','T','500','M','54.00','85'),
('P09','Tequila Olmeca Reposado','T','750','M','54.00','85'),
('P10','Black Whiskey Don Michael','W','750','P','159.00','70'),
('P11','Whisky Chivas Regal 12 Años','W','500','E','89.00','70')
GO

--Insertar registros en la tabla VENTA
INSERT INTO VENTA
(IDVEND, IDCLI, TIPPAGVEN, TIPENTVEN)
VALUES
('100','105','E','D'),
('103','107','T','T'),
('104','110','Y','D'),
('100','106','Y','T'),
('103','105','E','T'),
('100','109','P','T'),
('100','108','T','T')
GO

--Insertar registros en la tabla VENTA_DETALLE
INSERT INTO VENTA_DETALLE
(IDVEN,CODPRO,CANVENDET)
values
('1','P01','5'),
('1','P06','2'),
('2','P01','2'),
('3','P05','6'),
('3','P02','10'),
('3','P03','15'),
('3','P04','8'),
('4','P07','6'),
('4','P01','12'),
('4','P03','8'),
('4','P06','7'),
('5','P08','6'),
('5','P10','12'),
('5','P04','8'),
('6','P02','4'),
('6','P11','10'),
('6','P03','2'),
('7','P04','6'),
('7','P02','3'),
('7','P06','1')
GO


-- Consulta tabla PRODUCTO
SELECT
CODPRO AS CODIGO,
NOMPRO AS PRODUCTO,
CASE TIPPRO
	WHEN 'V' THEN 'VINO'	
	WHEN 'P' THEN 'PISCO'
	WHEN 'T' THEN 'TEQUILA'
	WHEN 'W' THEN 'WHISKY'
	END AS PRODUCTO,
CONCAT(VOLPRO,' ml.') AS VOLUMEN,
CASE PAIPRO 
	WHEN 'P' THEN 'Perú'
	WHEN 'A' THEN 'Argentina'
	WHEN 'C' THEN 'Chile'
	WHEN 'E' THEN 'España'
	WHEN 'M' THEN 'Mexico'
	END AS PAIS,
	CONCAT('S/',PRODUCTO.PREPRO) AS PRECIO,
	STOPRO AS STOCK,
	CASE ESTPRO 
		WHEN 'A' THEN 'Activo'
		WHEN 'I' THEN 'Inactivo'
		END AS ESTADO
FROM PRODUCTO
GO

-- Consulta tabla PERSONA
SELECT 
	IDPER  AS ID,
    DNIPER AS DNI,
    CONCAT(UPPER(APEPER),', ', NOMPER) AS PERSONA,
	CELPER AS CELULAR,
	EMAPER AS EMAIL,
    FORMAT(FECNACPER,'dd-MMM-yy') AS 'FECHA NACIMIENTO',
	CASE TIPPER 
		WHEN 'C' THEN 'Cliente'
		WHEN 'V' THEN 'Vendedor' 
		WHEN 'J' THEN 'Jefe'
		ELSE 'No se reconoce tipo de persona'
	END AS 'Tipo'
FROM PERSONA 
GO

-- Consulta tabla VENTA
SELECT 
	VENTA.IDVEN AS VENTA,
	FORMAT(FECVENT, 'dd-MM-yy - HH:MM') AS 'FEC. VENTA',
	CONCAT (UPPER(VEND.APEPER), ', ',VEND.NOMPER) AS VENDEDOR,
	CONCAT (UPPER(CLI.APEPER), ', ',CLI.NOMPER) AS CLIENTE,
	CASE VENTA.TIPPAGVEN
		WHEN 'T' THEN 'TARJETA'
		WHEN 'E' THEN 'EFECTIVO'
		WHEN 'Y' THEN 'YAPE'
		WHEN 'P' THEN 'PLIN'
		ELSE 'No se reconoce tipo de pago'
	END AS 'TIPO PAGO',
	CASE VENTA.TIPENTVEN 
		WHEN 'T' THEN 'Tienda'
		WHEN 'D' THEN 'Delivery'
		ELSE 'No se reconoce tipo de venta'
	END AS 'TIPO ENTREGA',
	CASE VENTA.ESTVENT 
		WHEN 'A' THEN 'Activo'
		WHEN 'I' THEN 'Inactivo'
		ELSE 'No se renoce estado'
	END AS 'EST.VENTA'
FROM VENTA 
	INNER JOIN PERSONA VEND ON VENTA.IDVEND = VEND.IDPER
	INNER JOIN PERSONA CLI ON VENTA.IDCLI = CLI.IDPER
GO

-- Consulta tabla VENTA_DETALLE
SELECT 
    IDVENDET AS 'ID DETALLE',
    IDVEN AS 'ID VENTA',
    NOMPRO AS 'PRODUCTO',
    CANVENDET AS 'CANTIDAD'
FROM VENTA_DETALLE
	INNER JOIN PRODUCTO ON VENTA_DETALLE.CODPRO = PRODUCTO.CODPRO
GO
