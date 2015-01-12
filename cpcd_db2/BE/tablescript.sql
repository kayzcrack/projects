
/*
 ***cpcd TABLE SCRIPTS***
 AUTHOR: Anthonia
 13/03/14
*/


DROP DATABASE IF EXISTS cpcd;

CREATE DATABASE cpcd;

USE cpcd;
-- ---------------------------
SET FOREIGN_KEY_CHECKS  = 0;
DROP TABLE IF EXISTS Constant;
SET FOREIGN_KEY_CHECKS  = 1;

CREATE TABLE `Constant` (
  `Name` varchar(32) NOT NULL,
  `Value` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- ---------------------------
--
-- Table structure for table `Title`
--
SET FOREIGN_KEY_CHECKS  = 0;
DROP TABLE IF EXISTS `Title`;
SET FOREIGN_KEY_CHECKS  = 1;

CREATE TABLE `Title` (
  `TitleID` varchar(5) NOT NULL,
  `Description` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`TitleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
/*Stores identification numbers for Trainees*/
SET FOREIGN_KEY_CHECKS  = 0;
DROP TABLE IF EXISTS  CDINs;
SET FOREIGN_KEY_CHECKS  = 1;
CREATE TABLE CDINs(
	`CDIN` CHAR(9) NOT NULL,
	DateUsed DATETIME NULL,
	PRIMARY KEY(CDIN)
)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- ----------------------------
/*Stores identification numbers for Trainees*/
SET FOREIGN_KEY_CHECKS  = 0;
DROP TABLE IF EXISTS  SIINs;
SET FOREIGN_KEY_CHECKS  = 1;
CREATE TABLE SIINs(
	`SIIN` CHAR(9) NOT NULL,
	DateUsed DATETIME NULL,
	PRIMARY KEY(SIIN)
)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- ----------------------------
SET FOREIGN_KEY_CHECKS  = 0;
DROP TABLE IF EXISTS Gender;
SET FOREIGN_KEY_CHECKS  = 1;
CREATE TABLE Gender(
	Sex Char(1) NOT NULL,
	Description Varchar (16),
	PRIMARY KEY(Sex)
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- ----------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS RelationshipType;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE RelationshipType(
	RelationID Char(8) NOT NULL,
	Description Varchar(16),
	PRIMARY KEY(RelationID)
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- -------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS FRSCSectorCommand;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE FRSCSectorCommand(
	SectorCode Varchar(16) NOT NULL,
	Name Varchar(32) NOT NULL,
	Officer Varchar(60) NOT NULL,
	EmailAddress Varchar(50),
	AddressLine1 Varchar(255) NOT NULL,
	AddressLine2 Varchar(255),
	PRIMARY KEY(SectorCode)
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- -------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Module;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE Module(
	ModuleID Char(1) NOT NULL,
	Description Varchar(64),
	PRIMARY KEY(ModuleID)
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- --------------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Menu;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE Menu(
	MenuID Varchar(16) NOT NULL,
	Description Varchar(128),
	PRIMARY KEY(MenuID)
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- ---------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS UserRole;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE UserRole(
	RoleID Varchar(5) NOT NULL,
	Name Varchar(128) NOT NULL,
	Description Varchar(32),
	PRIMARY KEY(RoleID)
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- ---------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Driver;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE Driver(
	DriverID Varchar(16) NOT NULL,
	Surname Varchar(32) NOT NULL,
	Othernames Varchar(32),
	DateOfBirth Date NOT NULL,
	PhoneNumber Varchar(16),
	LicenseNumber Varchar(16) NOT NULL,
	Email Varchar(32),
	DateOfLicenseFirstIssue Datetime NOT NULL,
	DateOfCurLicenseFirstIssue Datetime NOT NULL,
	DateOfExpiryOfCurLicense Datetime NOT NULL,
	Sex Char(1) NOT NULL,
	CurLicenseClass Varchar(16) NOT NULL,
	PlaceOfReg Varchar(16) NOT NULL,
        DateOfCommencement Datetime NOT NULL,
	PRIMARY KEY(DriverID),
	FOREIGN KEY(Sex) REFERENCES Gender(Sex) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(PlaceOfReg) REFERENCES FRSCSectorCommand(SectorCode) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;

	
-- ----------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS NOK;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE NOK(
	NokID INT AUTO_INCREMENT,
	Surname Varchar(32) NOT NULL,
	Othernames Varchar(32),
	DriverID Varchar(16) NOT NULL,
	RelationID Char(8) NOT NULL,
	PhoneNumber Varchar(16),
	PRIMARY KEY(NokID),
	FOREIGN KEY(DriverID) REFERENCES Driver(DriverID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(RelationID) REFERENCES RelationshipType(RelationID) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
	
-- ------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS ModuleSubType;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE ModuleSubType(
	ModuleSubTypeID INT AUTO_INCREMENT,
	ModuleID Char(1) NOT NULL,
	Description Varchar(255),
	MaxTime Decimal(2,2) NOT NULL,
	MaxScore Decimal(5,2) NOT NULL,
	PRIMARY KEY(ModuleSubTypeID,ModuleID),
	FOREIGN KEY(ModuleID) REFERENCES Module(ModuleID) ON UPDATE CASCADE ON DELETE NO ACTION
        )ENGINE=INNODB DEFAULT CHARSET=utf8;
        
-- ---------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS SectorInstructor;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE SectorInstructor(
	InstructorID Varchar(16) NOT NULL,
	SectorCode Varchar(16) NOT NULL,
	Surname Varchar(32) NOT NULL,
	Othernames Varchar(32),
	PRIMARY KEY(InstructorID,SectorCode),
	FOREIGN KEY(SectorCode) REFERENCES FRSCSectorCommand(SectorCode) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
	
-- ---------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Training;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE Training(
	TrainingID INT AUTO_INCREMENT,
	InstructorID Varchar(16) NOT NULL,
	SectorCode Varchar(16) NOT NULL,
	NoOfHours Decimal(5,2) NOT NULL,
	Score Decimal(5,2),
	ModuleSubTypeID INT NOT NULL,
	ModuleID Char(1) NOT NULL,
	DriverID Varchar(16) NOT NULL,
	DateOfTraining TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	DateOfCompletion DATETIME,
	PRIMARY KEY(TrainingID),
	FOREIGN KEY(InstructorID,SectorCode) REFERENCES SectorInstructor(InstructorID,SectorCode) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(ModuleSubTypeID,ModuleID) REFERENCES ModuleSubType(ModuleSubTypeID,ModuleID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(DriverID) REFERENCES Driver(DriverID) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
	
-- ------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS MenuLink;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE MenuLink(
	LinkID Varchar(5) NOT NULL,
	Description Varchar(255),
	MenuID Varchar(16) NOT NULL,
	url Varchar(255),
	PRIMARY KEY(LinkID),
	FOREIGN KEY(MenuID) REFERENCES Menu(MenuID) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
	
-- -----------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Permission;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE  Permission(
	RoleID Varchar(5) NOT NULL,
	`Mode` Varchar(16) NOT NULL,
	LinkID Varchar(5) NOT NULL,
	PRIMARY KEY(RoleID,`Mode`),
        FOREIGN KEY(RoleID) REFERENCES UserRole(RoleID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(LinkID) REFERENCES MenuLink(LinkID) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
	
-- --------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `User`;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE `User`(
	`User` Varchar(16) NOT NULL,
	Surname Varchar(32),
	Othernames Varchar(32),
	RoleID Varchar(5) NOT NULL,
        SectorCode Varchar(16),
	`Password` Varchar(255),
	PRIMARY KEY(`User`),
        FOREIGN KEY(SectorCode) REFERENCES FRSCSectorCommand(SectorCode) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(RoleID) REFERENCES UserRole(RoleID) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
	
-- ------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS UserLogin;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE  UserLogin(
	`User` Varchar(16) NOT NULL,
	LoginTime Datetime,
	RemoteHost Varchar(128),
	MachineID Varchar(128),
	LogoutTime Datetime,
	PRIMARY KEY(`User`,LoginTime),
	FOREIGN KEY(`User`) REFERENCES `User`(`User`) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
	
-- ---------------------------------------------------------------
