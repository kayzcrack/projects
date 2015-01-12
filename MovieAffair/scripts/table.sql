/*
******table scipt for movieAffair********
******Author: voti@quanteq.com********
******14/07/2010********
*/
-- ---------------------------
DROP DATABASE IF EXISTS movieAffair;

CREATE DATABASE movieAffair;

USE movieAffair;

-- ------------------------------
/*Stores identification numbers for video*/
SET FOREIGN_KEY_CHECKS  = 0;
DROP TABLE IF EXISTS  SDINs;
SET FOREIGN_KEY_CHECKS  = 1;
CREATE TABLE SDINs(
	`SDIN` CHAR(9) NOT NULL,
	DateUsed DATETIME NULL,
	PRIMARY KEY(SDIN)
)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- ---------------------------
SET FOREIGN_KEY_CHECKS  = 0;
DROP TABLE IF EXISTS Tag;
SET FOREIGN_KEY_CHECKS  = 1;
create table Tag(
TagID char(5),
Value varchar(128),
primary key(TagID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS UserRole;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE UserRole(
	RoleID Varchar(5) NOT NULL,
	Name Varchar(128) NOT NULL,
	Description Varchar(32),
	PRIMARY KEY(RoleID)
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- ----------------------------
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Permission;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE  Permission(
	PermissionID varchar(16) NOT NULL,
	RoleID Varchar(5) NOT NULL,
	Description Varchar(128),
	PRIMARY KEY(PermissionID),
        FOREIGN KEY(RoleID) REFERENCES UserRole(RoleID) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
	
-- ------------------------------
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `User`;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE `User`(
	Username Varchar(16) NOT NULL,
	Surname Varchar(32),
	Firstname Varchar(32),
	RoleID Varchar(5) NOT NULL,
	`Password` Varchar(255),
	PRIMARY KEY(Username),
	FOREIGN KEY(RoleID) REFERENCES UserRole(RoleID) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
	
-- -------------------------------
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
	FOREIGN KEY(`User`) REFERENCES User(Username) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
	
-- ---------------------------------
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Author;
SET FOREIGN_KEY_CHECKS = 1;
create table Author(
AuthorID Int Not null auto_increment,
Surname Varchar(16),
Firstname varchar(16),
Description Varchar(128),
Primary key(AuthorID)
)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- --------------------------------
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS VideoFormat;
SET FOREIGN_KEY_CHECKS = 1;
create table VideoFormat(
FormatID char(3),
Name varchar(8),
Primary key(FormatID)
)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- --------------------------------
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Category;
SET FOREIGN_KEY_CHECKS = 1;
create table Category(
CategoryID char(8),
Name varchar(16),
Description varchar(128),
Primary key(CategoryID)
)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- -----------------------------
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS SubCategory;
SET FOREIGN_KEY_CHECKS = 1;
create table SubCategory(
SubCategoryID char(8),
CategoryID char(8),
Name varchar(16),
Description varchar(128),
Primary key(SubCategoryID),
Foreign key(CategoryID) References Category(CategoryID)
)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- -----------------------------
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Video;
SET FOREIGN_KEY_CHECKS = 1;
create table Video(
VideoID varchar(16),
VideoTitle varchar(64),
AuthorID Int,
CategoryID char(8),
DateUploaded Datetime,
Size varchar(8),
Duration time,
FormatID char(3),
SubCategoryID char(8),
Current_Rating Double,
Url varchar(128),
primary key(VideoID),
Foreign key(AuthorID) References Author(AuthorID) on delete no action on update cascade,
Foreign key(CategoryID) References Category(CategoryID) on delete no action on update cascade,
Foreign key(FormatID) References VideoFormat(FormatID) on delete no action on update cascade,
Foreign key(SubCategoryID) References SubCategory(SubCategoryID) on delete no action on update cascade
)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- --------------------------
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS VideoTag;
SET FOREIGN_KEY_CHECKS = 1;
create table VideoTag(
VideoID Varchar(16),
TagID char(5),
Primary key(VideoID,TagID),
Foreign key(VideoID) References Video(VideoID) on delete no action on update cascade,
Foreign key(TagID) References Tag(TagID) on delete no action on update cascade
)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- --------------------------
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS VideoRating;
SET FOREIGN_KEY_CHECKS = 1;
create table VideoRating(
VideoID varchar(16) not null,
Username varchar(16),
Rank Double,
DateRated timestamp default current_timestamp,
Review Varchar(128),
Primary key(VideoID,Username),
Foreign key(VideoID) References Video(VideoID) on delete no action on update cascade,
Foreign key(Username) References User(Username) on delete no action on update cascade
)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- --------------------------
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS UserFavourite;
SET FOREIGN_KEY_CHECKS = 1;
create table UserFavourite(
VideoID Varchar(16),
Username Varchar(16),
Primary key(VideoID,Username),
Foreign key(VideoID) references Video(VideoID) on delete no action on update cascade,
Foreign key(Username) References User(Username) on delete no action on update cascade
)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- -------------------------
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS VideoViewCount;
SET FOREIGN_KEY_CHECKS = 1;
create table VideoViewCount(
VideoID varchar(16), 
ViewDateTime timestamp default current_timestamp,
Username varchar(16),
Primary key(VideoID,ViewDateTime),
Foreign key(Username) References User(Username) on delete no action on update cascade
)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- ------------------------
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS VideoHistory;
SET FOREIGN_KEY_CHECKS = 1;

create table VideoHistory(
VideoID varchar(16) not null,
Username varchar(16) not null,
primary key(VideoID,Username),
constraint fk_vh_1 foreign key(VideoID,Username) references VideoVeiwCount(VideoID,Username) on delete no action on update cascade
-- constraint fk_vh_2 foreign key(Username) references User(Username) on delete no action on update cascade
);
-- ------------------------

