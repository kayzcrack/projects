/*
 ***SCHOOL TABLE SCRIPTS***
 AUTHOR: Obot
 19/05/14
*/


DROP DATABASE IF EXISTS School;

CREATE DATABASE School;

USE School;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Job;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Job(
	JobID Varchar(32) NOT NULL,
	Name Varchar(128) NOT NULL,
	Description Varchar(32),
	PRIMARY KEY(JobID)
	)ENGINE=INNODB DEFAULT CHARSET=utf8;

-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@0
/*Stores identification numbers for Staffs*/
SET FOREIGN_KEY_CHECKS  = 0;
DROP TABLE IF EXISTS  STINs;
SET FOREIGN_KEY_CHECKS  = 1;
CREATE TABLE STINs(
	`STIN` CHAR(9) NOT NULL,
	DateUsed DATETIME NULL,
	PRIMARY KEY(STIN)
)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
/*Stores identification numbers for Students*/
SET FOREIGN_KEY_CHECKS  = 0;
DROP TABLE IF EXISTS  SDINs;
SET FOREIGN_KEY_CHECKS  = 1;
CREATE TABLE SDINs(
	`SDIN` CHAR(9) NOT NULL,
	DateUsed DATETIME NULL,
	PRIMARY KEY(SDIN)
)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@1
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Menu;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Menu(
	MenuID Varchar(16) NOT NULL,
	Description Varchar(128),
	PRIMARY KEY(MenuID)
	)ENGINE=INNODB DEFAULT CHARSET=utf8;

-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2	
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS UserRole;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE UserRole(
	RoleID Varchar(16) NOT NULL,
	Name Varchar(128) NOT NULL,
	Description Varchar(32),
	PRIMARY KEY(RoleID)
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@3
SET FOREIGN_KEY_CHECKS  = 0;
DROP TABLE IF EXISTS Gender;
SET FOREIGN_KEY_CHECKS  = 1;
CREATE TABLE Gender(
	Sex Char(1) NOT NULL,
	Description Varchar (16),
	PRIMARY KEY(Sex)
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
	
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@4
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Faculty;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Faculty(
	-- ID INT AUTO_INCREMENT NOT NULL,
	FacultyID Varchar(16) NOT NULL,
	FacultyName Varchar(128) NOT NULL,
	Description Varchar(128),
	PRIMARY KEY(FacultyID)
	)ENGINE=INNODB DEFAULT CHARSET=utf8;

-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@5
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Semester;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Semester(
	SemesterID Varchar(16) NOT NULL,
	SemesterName Varchar(32) NOT NULL,
	StartDate DateTime,
	EndDate DateTime,
	PRIMARY KEY(SemesterID)
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@6
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Department;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Department(
	DeptID Varchar(16) NOT NULL,
	DeptName Varchar(128) NOT NULL,
	FacultyID Varchar(16) NOT NULL,
	Description Varchar(255),
	PRIMARY KEY(DeptID),
	FOREIGN KEY(FacultyID) REFERENCES Faculty(FacultyID) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@7
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Level;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Level(
	LevelID Varchar(16) NOT NULL,
	LevelName Varchar(128) NOT NULL,
    Flag Int NOT NULL,
	PRIMARY KEY(LevelID)
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@8
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Course;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Course(
	CourseID Varchar(16) NOT NULL,
	CourseName Varchar(128) NOT NULL,
	CourseHours INT,
	LevelID Varchar(16) NOT NULL,
	SemesterID Varchar(16) NOT NULL,
	StaffID Varchar(16) NOT NULL,
	CourseDescription Varchar(128),
	PRIMARY KEY(CourseID),
	FOREIGN KEY(LevelID) REFERENCES Level(LevelID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(SemesterID) REFERENCES Semester(SemesterID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(StaffID) REFERENCES Staff(StaffID) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@9
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Staff;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Staff(
	StaffID Varchar(16) NOT NULL,
	SurName Varchar(128) NOT NULL,
	FirstName Varchar(128) NOT NULL,
	OtherNames Varchar(128),
	Sex Char(1) NOT NULL,
	FacultyID Varchar(16),
	DeptID Varchar(16),
	Position Varchar(32),
	Email Varchar(32),
    -- StaffImage BLOB,
	Address Varchar(255) NOT NULL,
	Country Varchar(32) NOT NULL,
	State Varchar(32) NOT NULL,
	LGA Varchar(32), 
	PRIMARY KEY(StaffID),
	FOREIGN KEY(Sex) REFERENCES Gender(Sex) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(FacultyID) REFERENCES Faculty(FacultyID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(DeptID) REFERENCES Department(DeptID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(Position) REFERENCES Job(JobID) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@10
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS SubjectStaff;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE SubjectStaff(
	SubjectStaffID Varchar(16) NOT NULL,
	StaffID Varchar(16),
	CourseID Varchar(16) NOT NULL,
	PRIMARY KEY(SubjectStaffID),
	FOREIGN KEY(StaffID) REFERENCES Staff(StaffID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(CourseID) REFERENCES Course(CourseID) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@11
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS StudentSubject;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE StudentSubject(
	StudentSubjectID INT AUTO_INCREMENT NOT NULL,
	StudentID Varchar(16),
	CourseID Varchar(16) NOT NULL,
	PRIMARY KEY(StudentSubjectID),
	FOREIGN KEY(StudentID) REFERENCES Student(StudentID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(CourseID) REFERENCES Course(CourseID) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- =======================================
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Student;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Student(
	StudentID Varchar(16) NOT NULL,
	SurName Varchar(128) NOT NULL,
	FirstName Varchar(128) NOT NULL,
	OtherNames Varchar(128),
	Sex Char(1) NOT NULL,
	DOB Date,
	FacultyID Varchar(16),
	-- CourseID Varchar(16) NOT NULL,
	DeptID Varchar(16) NOT NULL,
	LevelID Varchar(16) NOT NULL,
	-- Image BLOB,
	Address Varchar(255) NOT NULL,
	Country Varchar(32) NOT NULL,
	State Varchar(32) NOT NULL,
	LGA Varchar(32),
	PRIMARY KEY(StudentID),
	FOREIGN KEY(FacultyID) REFERENCES Faculty(FacultyID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(Sex) REFERENCES Gender(Sex) ON UPDATE CASCADE ON DELETE NO ACTION,
	-- FOREIGN KEY(CourseID) REFERENCES Course(CourseID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(LevelID) REFERENCES Level(LevelID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(DeptID) REFERENCES Department(DeptID) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@12
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Result;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Result(
	ResultID INT NOT NULL AUTO_INCREMENT,
	StudentID Varchar(16) NOT NULL,
	CourseID Varchar(16) NOT NULL,
	Score Double,
	Grade Char(1),
	LevelID Varchar(16) NOT NULL,
	SemesterID Varchar(16) NOT NULL,
	ResultDate Timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(ResultID),
	FOREIGN KEY(StudentID) REFERENCES Student(StudentID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(CourseID) REFERENCES Course(CourseID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(LevelID) REFERENCES Student(LevelID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(SemesterID) REFERENCES Semester(SemesterID) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@13
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS TimeTable;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE TimeTable(
	TimeTableID Varchar(16) NOT NULL,
	TermDate INT,
	LevelID Varchar(16) NOT NULL,
	CourseID Varchar(16) NOT NULL,
	StaffID Varchar(16) Not NULL,
	PRIMARY KEY(TimeTableID),
	FOREIGN KEY(LevelID) REFERENCES Level(LevelID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(StaffID) REFERENCES Staff(StaffID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(CourseID) REFERENCES Course(CourseID) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@14
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS MenuLink;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE MenuLink(
	LinkID Varchar(16) NOT NULL,
	Description Varchar(255),
	MenuID Varchar(16) NOT NULL,
	url Varchar(255),
	PRIMARY KEY(LinkID),
	FOREIGN KEY(MenuID) REFERENCES Menu(MenuID) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;

-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@15
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Permission;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE  Permission(
	RoleID Varchar(16) NOT NULL,
	Mode Varchar(16) NOT NULL,
	LinkID Varchar(16) NOT NULL,
	PRIMARY KEY(RoleID,Mode),
    FOREIGN KEY(RoleID) REFERENCES UserRole(RoleID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(LinkID) REFERENCES MenuLink(LinkID) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@16
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS User;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE User(
	User Varchar(16) NOT NULL,
	Surname Varchar(32),
	Othernames Varchar(32),
	RoleID Varchar(16) NOT NULL,
	Password Varchar(255),
	PRIMARY KEY(User),
	FOREIGN KEY(RoleID) REFERENCES UserRole(RoleID) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@17
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS UserLogin;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE  UserLogin(
	User Varchar(16) NOT NULL,
	LoginTime Datetime,
	RemoteHost Varchar(128),
	MachineID Varchar(128),
	LogoutTime Datetime,
	PRIMARY KEY(User,LoginTime),
	FOREIGN KEY(User) REFERENCES User(User) ON UPDATE CASCADE ON DELETE NO ACTION
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- ========================================
SET FOREIGN_KEY_CHECKS  = 0;
DROP TABLE IF EXISTS Country;
SET FOREIGN_KEY_CHECKS  = 1;
CREATE TABLE Country(
	CountryCode CHAR(3),
       `Name`	VARCHAR(64) NOT NULL,
	ContinentCode CHAR(5),
	PRIMARY KEY(CountryCode)
	)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- -----------------------------------------------

SET FOREIGN_KEY_CHECKS  = 0;
DROP TABLE IF EXISTS AULevel1;
SET FOREIGN_KEY_CHECKS  = 1;
CREATE TABLE AULevel1(
CountryCode Char(3) NOT NULL,
AULevel1ID varchar(5) NOT NULL,
Name varchar(100) NOT NULL,
PRIMARY KEY(CountryCode,AULevel1ID),
FOREIGN KEY(CountryCode) REFERENCES Country(CountryCode) ON DELETE NO ACTION ON UPDATE CASCADE)ENGINE=INNODB DEFAULT CHARSET=utf8;

-- =====================================================================
SET FOREIGN_KEY_CHECKS  = 0;
DROP TABLE IF EXISTS AULevel2;
SET FOREIGN_KEY_CHECKS  = 1;
CREATE TABLE AULevel2 (
CountryCode char(3) NOT NULL,
AULevel1ID varchar(5) NOT NULL,
Name varchar(100) NOT NULL,
AULevel2ID varchar(5) NOT NULL,
PRIMARY KEY (CountryCode, AULevel1ID, AULevel2ID),
CONSTRAINT FK_AULevel2_AULevel1ID FOREIGN KEY (CountryCode, AULevel1ID) REFERENCES AULevel1 (CountryCode, AULevel1ID) ON DELETE NO ACTION ON UPDATE CASCADE)ENGINE=INNODB DEFAULT CHARSET=utf8;
 
-- ====================================================================
SET FOREIGN_KEY_CHECKS  = 0;
DROP TABLE IF EXISTS AULevel3;
SET FOREIGN_KEY_CHECKS  = 1;
CREATE TABLE AULevel3(
CountryCode Char(3) NOT NULL,
AULevel1ID Varchar(5) NOT NULL,
Name Varchar(100) NOT NULL,
AULevel2ID Varchar(5) NOT NULL,
AULevel3ID Varchar(5) NOT NULL,
CONSTRAINT PK_AULevel3 PRIMARY KEY(CountryCode,AULevel1ID,AULevel2ID,AULevel3ID),
CONSTRAINT FK_AULevel3 FOREIGN KEY(CountryCode,AULevel1ID,AULevel2ID) REFERENCES AULevel2(CountryCode,AULevel1ID,AULevel2ID) ON DELETE NO ACTION ON UPDATE CASCADE)ENGINE=INNODB DEFAULT CHARSET=utf8;
-- ------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS GPA;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE GPA(
StudentID Varchar(16),
SemesterID Varchar(16),
LevelID Varchar(16),
GPA Double,
CONSTRAINT pk_GPA PRIMARY KEY(StudentID,SemesterID,LevelID),
CONSTRAINT fk_GPA_Student FOREIGN KEY(StudentID) REFERENCES Student(StudentID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT fk_GPA_Semester FOREIGN KEY(SemesterID) REFERENCES Semester(SemesterID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT fk_GPA_Level FOREIGN KEY(LevelID) REFERENCES `Level`(LevelID) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8;

-- ==============================================
SET FOREIGN_KEY_CHECKS  = 0;
DROP TABLE IF EXISTS Constant;
SET FOREIGN_KEY_CHECKS  = 1;
CREATE TABLE Constant(
Name Varchar(32) NOT NULL,
Value Varchar(128),
CONSTRAINT pk_Constant PRIMARY KEY(Name)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
-- insert into Constant values('A','5');
-- insert into Constant values('B','4');
-- insert into Constant values('C','3');
-- insert into Constant values('D','2');
-- insert into Constant values('E','1');
-- insert into Constant values('F','0');
-- ===========================================
SET FOREIGN_KEY_CHECKS  = 0;
DROP TABLE IF EXISTS Result_Calc;
SET FOREIGN_KEY_CHECKS  = 1;
CREATE TABLE Result_Calc(
Result_CalcID INT NOT NULL AUTO_INCREMENT,
StudentID Varchar(16),
LevelID Varchar(16),
Total_Score Double,
Total_Unit Double,
CONSTRAINT pk_Result_Calc PRIMARY KEY(Result_CalcID),
CONSTRAINT fk_Result_Calc_Student FOREIGN KEY(StudentID) REFERENCES Student(StudentID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT fk_Result_Calc_Level FOREIGN KEY(LevelID) REFERENCES `Level`(LevelID) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8;

-- ============================================
