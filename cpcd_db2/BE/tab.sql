--#SET TERMINATOR ;
-- voti, 03-Dec-2014
-- db2 -td\; -f tables.sql

-- db2 connect to cpcd;

drop table constant;
CREATE TABLE constant (name varchar(32) NOT NULL primary key, value varchar(256) DEFAULT NULL);
-- --------------------------------

drop table title;
create table title(titleid varchar(5) not null primary key, description varchar(64) default null);
-- --------------------------------
drop table cdins;
create table cdins(cdin char(9) not null primary key, dateused timestamp null default current_timestamp);

-- --------------------------------
drop table siins;
create table siins(siins char(9) not null primary key, dateused timestamp null default current_timestamp);

-- -------------------------------
drop table gender; 
CREATE TABLE gender(sex Char(1) NOT NULL primary key, description Varchar (16));

-- ------------------------------
drop table relationshipType;
CREATE TABLE relationshipType(relationid Char(8) primary key NOT NULL,description Varchar(32));

-- -----------------------------
drop table frscSectorCommand;
CREATE TABLE frscSectorCommand(
sectorcode Varchar(16) NOT NULL primary key,
	name Varchar(32) NOT NULL,
	officer Varchar(60) NOT NULL,
	emailAddress Varchar(50),
	addressLine1 Varchar(255) NOT NULL,
	addressLine2 Varchar(255)
	);
-- ------------------------------
drop table module;
CREATE TABLE module(
	moduleid Char(1) NOT NULL primary key,
	description Varchar(64)
	);
-- --------------------------------------------------------
drop table menu;
CREATE TABLE menu(
	menuid Varchar(16) NOT NULL primary key,
	Description Varchar(128)
	);
-- ---------------------------------------------------------------
drop table userRole;
CREATE TABLE userRole(
	roleid Varchar(5) NOT NULL primary key,
	name Varchar(128) NOT NULL,
	description Varchar(32)
	);
-- ---------------------------------------------------------------------
drop table driver;
CREATE TABLE driver(
	driverid Varchar(16) NOT NULL primary key,
	surname Varchar(32) NOT NULL,
	othernames Varchar(32),
	dateOfBirth Date NOT NULL,
	phoneNumber Varchar(16),
	licenseNumber Varchar(16) NOT NULL,
	email Varchar(32),
	dateOfLicenseFirstIssue Date NOT NULL,
	dateOfCurLicenseFirstIssue Date NOT NULL,
	dateOfExpiryOfCurLicense Date NOT NULL,
	sex Char(1) NOT NULL,
	curLicenseClass Varchar(16) NOT NULL,
	placeOfReg Varchar(16) NOT NULL,
        dateOfCommencement Date NOT NULL,
	FOREIGN KEY(Sex) REFERENCES Gender(Sex)  ON DELETE NO ACTION,
	FOREIGN KEY(placeOfReg) REFERENCES frscSectorCommand(sectorCode) ON DELETE NO ACTION
	);
-- --------------------------------------------------------------
drop table nok;
CREATE TABLE nok(
	nokid integer generated always as identity not null primary key,
	surname Varchar(32) NOT NULL,
	othernames Varchar(32),
	driverid Varchar(16) NOT NULL,
	relationid Char(8) NOT NULL,
	phoneNumber Varchar(16),
	FOREIGN KEY(driverid) REFERENCES driver(driverid)  ON DELETE NO ACTION,
	FOREIGN KEY(relationid) REFERENCES relationshipType(relationid) ON DELETE NO ACTION
	);
	
-- ------------------------------------------------------
drop table moduleSubType;
CREATE TABLE moduleSubType(
	moduleSubTypeID integer generated always as identity not null,
	moduleID Char(1) NOT NULL,
	description Varchar(255),
	maxTime Decimal(5,2) NOT NULL,
	maxScore Decimal(5,2) NOT NULL,
	PRIMARY KEY(moduleSubTypeID,moduleID),
	FOREIGN KEY(moduleID) REFERENCES module(moduleID) ON DELETE NO ACTION
        );		
-- -----------------------------------------------------
drop table sectorInstructor;
CREATE TABLE sectorInstructor(
	instructorID Varchar(16) NOT NULL,
	sectorCode Varchar(16) NOT NULL,
	surname Varchar(32) NOT NULL,
	othernames Varchar(32),
	PRIMARY KEY(instructorid,sectorCode),
	FOREIGN KEY(sectorCode) REFERENCES frscSectorCommand(sectorCode)  ON DELETE NO ACTION
	);      
-- ------------------------------------------------------
drop table training;
CREATE TABLE training(
	trainingif integer generated always as identity not null primary key,
	instructorid Varchar(16) NOT NULL,
	sectorCode Varchar(16) NOT NULL,
	noOfHours Decimal(5,2) NOT NULL,
	score Decimal(5,2),
	moduleSubTypeID INT NOT NULL,
	moduleID Char(1) NOT NULL,
	driverID Varchar(16) NOT NULL,
	dateOfTraining TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	dateOfCompletion DATE,
	FOREIGN KEY(instructorid,sectorCode) REFERENCES sectorInstructor(instructorID,sectorCode)  ON DELETE NO ACTION,
	FOREIGN KEY(moduleSubTypeID,moduleID) REFERENCES moduleSubType(moduleSubTypeID,moduleID)  ON DELETE NO ACTION,
	FOREIGN KEY(driverID) REFERENCES driver(driverID) ON DELETE NO ACTION
	);
-- -----------------------------------------------------
drop table menuLink;
CREATE TABLE menuLink(
	linkID Varchar(5) NOT NULL primary key,
	description Varchar(255),
	menuID Varchar(16) NOT NULL,
	url Varchar(255),
	FOREIGN KEY(menuID) REFERENCES menu(menuID) ON DELETE NO ACTION
	);		
-- ------------------------------------------------------
drop table permission;
CREATE TABLE  permission(
	roleID Varchar(5) NOT NULL,
	mode Varchar(16) NOT NULL,
	linkID Varchar(5) NOT NULL,
	PRIMARY KEY(roleID,mode),
        FOREIGN KEY(roleID) REFERENCES userRole(roleID)  ON DELETE NO ACTION,
	FOREIGN KEY(LinkID) REFERENCES MenuLink(linkID)  ON DELETE NO ACTION
	);
-- ----------------------------------------------------
drop table user;
CREATE TABLE user(
	user Varchar(16) NOT NULL,
	surname Varchar(32),
	othernames Varchar(32),
	roleID Varchar(5) NOT NULL,
        sectorCode Varchar(16),
	password Varchar(255),
	PRIMARY KEY(user),
        FOREIGN KEY(sectorCode) REFERENCES frscSectorCommand(sectorCode) ON DELETE NO ACTION,
	FOREIGN KEY(roleID) REFERENCES userRole(roleID)  ON DELETE NO ACTION
	);
-- -------------------------------------------------
drop table userLogin;
CREATE TABLE  userLogin(
	user Varchar(16) NOT NULL,
	loginTime timestamp not null default current_timestamp,
	remoteHost Varchar(128),
	machineID Varchar(128),
	logoutTime timestamp,
	PRIMARY KEY(user,loginTime),
	FOREIGN KEY(user) REFERENCES user(user) ON DELETE NO ACTION
	);
-- ---------------------------------------						
