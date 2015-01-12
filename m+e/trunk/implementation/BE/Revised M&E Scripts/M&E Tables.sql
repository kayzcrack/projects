DROP DATABASE IF EXISTS evaluation;
CREATE DATABASE evaluation;
USE evaluation;

DROP TABLE IF EXISTS DataSources;
CREATE TABLE DataSources(
SourceID Char(10) NOT NULL,
Description Varchar(64) NOT NULL,
CONSTRAINT PK_DataSource PRIMARY KEY(SourceID));

DROP TABLE IF EXISTS UserStatus;
CREATE TABLE UserStatus(
UserStatusID Char(3) NOT NULL,
Description Varchar(16) NOT NULL,
CONSTRAINT PK_UserStatus PRIMARY KEY(UserStatusID));

DROP TABLE IF EXISTS UserRoles;
CREATE TABLE UserRoles(
RoleID Varchar(20) NOT NULL,
Description Varchar(50) NOT NULL,
CONSTRAINT PK_UserRole PRIMARY KEY(RoleID));

DROP TABLE IF EXISTS FacilityContacts;
CREATE TABLE FacilityContacts(
ContactID int(11) NOT NULL AUTO_INCREMENT,
Description varchar(100) DEFAULT NULL,
ContactEmail varchar(32) NOT NULL,
PhoneNumber varchar(32) NOT NULL,
Surname varchar(32) NOT NULL,
FirstName varchar(32) NOT NULL,
MiddleName varchar(32),
CONSTRAINT PK_FacilityContacts PRIMARY KEY (ContactID));


DROP TABLE IF EXISTS Users;
CREATE TABLE Users(
Username varchar(30) NOT NULL,
Password varchar(255) NOT NULL,
Surname varchar(32) NOT NULL,
FirstName varchar(32),
SourceID char(10) NOT NULL,
RoleID Varchar(20) NOT NULL,
CapturePeriod Date,
UserStatusID char(5),
CONSTRAINT PK_Users PRIMARY KEY(Username), 
CONSTRAINT FK_Users_SourceID FOREIGN KEY(SourceID) REFERENCES DataSources(SourceID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_Users_RoleID FOREIGN KEY(RoleID) REFERENCES UserRoles(RoleID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_Users_UserStatusID FOREIGN KEY(UserStatusID) REFERENCES UserStatus (UserStatusID) ON DELETE NO ACTION ON UPDATE CASCADE);

DROP TABLE IF EXISTS UserLogin;
CREATE TABLE UserLogin (
UserName varchar(255) NOT NULL,
LoginTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
LogoutTime timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
PRIMARY KEY (UserName,LoginTime));


DROP TABLE IF EXISTS MethodOfMeasurements;
CREATE TABLE MethodOfMeasurements(
MethodOfMeasureID Varchar(8) NOT NULL,
Description Varchar(32) NOT NULL, 
CONSTRAINT pk_methodOfMeasurement PRIMARY KEY(MethodOfMeasureID));

DROP TABLE IF EXISTS QuestionStatus;
CREATE TABLE QuestionStatus(
QuestionStatusID Char(3) NOT NULL,
Description Varchar(16) NOT NULL,
CONSTRAINT PK_QuestionStatus PRIMARY KEY(QuestionStatusID));

DROP TABLE IF EXISTS ResultTypes;
CREATE TABLE ResultTypes(
ResultTypeID Char(3) NOT NULL,
Description Varchar(16) NOT NULL,
CONSTRAINT PK_ResultTypes PRIMARY KEY(ResultTypeID));

DROP TABLE IF EXISTS IndicatorStatus;
CREATE TABLE IndicatorStatus(
IndicatorStatusID Char(3) NOT NULL,
Description Varchar(16) NOT NULL,
CONSTRAINT PK_IndicatorStatus PRIMARY KEY(IndicatorStatusID));

DROP TABLE IF EXISTS IndicatorClasses;
CREATE TABLE IndicatorClasses(
IndicatorClassID Char(10) NOT NULL,
Description Varchar(100) NOT NULL,
CONSTRAINT PK_IndicatorClasses PRIMARY KEY(IndicatorClassID));

DROP TABLE IF EXISTS Indicators;
CREATE TABLE Indicators(
IndicatorID Char(10) NOT NULL,
Name Varchar(60),
IndicatorStatusID Char(3) NOT NULL,
IndicatorClassID Char(10) NOT NULL,
ModifiedBy varchar(30) NOT NULL,
ModifiedAt Timestamp, 
CONSTRAINT PK_Indicators PRIMARY KEY(IndicatorID),
CONSTRAINT FK_Indicators_ModifiedBy FOREIGN KEY(ModifiedBy) REFERENCES Users(Username) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_IndicatorStatus FOREIGN KEY(IndicatorStatusID) REFERENCES IndicatorStatus(IndicatorStatusID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_IndicatorClasses FOREIGN KEY(IndicatorClassID) REFERENCES IndicatorClasses(IndicatorClassID) ON DELETE NO ACTION ON UPDATE CASCADE);

DROP TABLE IF EXISTS Questions;
CREATE TABLE Questions(
QuestionID INT(5) NOT NULL AUTO_INCREMENT,
IndicatorID Char(10) NOT NULL,
QuestionStatusID Char(3) NOT NULL,
Description Varchar(255),
Instructions Varchar(255),
Hint Varchar(255) NOT NULL,
TypeID Char(3),
ModifiedBy varchar(30) NOT NULL,
ModifiedAt Timestamp, 
CONSTRAINT PK_Questions PRIMARY KEY(QuestionID),
CONSTRAINT FK_Questions_ModifiedBy FOREIGN KEY(ModifiedBy) REFERENCES Users(Username) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_Questions_IndicatorID FOREIGN KEY(IndicatorID) REFERENCES Indicators(IndicatorID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_Questions_QuestionStatusID FOREIGN KEY(QuestionStatusID) REFERENCES QuestionStatus(QuestionStatusID) ON DELETE NO ACTION ON UPDATE CASCADE);

DROP TABLE IF EXISTS FrequencyOfMeasures;
CREATE TABLE FrequencyOfMeasures(
FrequencyID Char(3) NOT NULL,
Description Varchar(32) NOT NULL,
EffectiveStartDate Date NOT NULL,
EffectiveEndDate Date NOT NULL,
CONSTRAINT PK_Frequency PRIMARY KEY(FrequencyID));

DROP TABLE IF EXISTS ScheduleActiveStatus;
CREATE TABLE ScheduleActiveStatus(
StatusID Char(3) NOT NULL,
Description Varchar(16) NOT NULL,
CONSTRAINT PK_ScheduleActiveStatus PRIMARY KEY(StatusID));

DROP TABLE IF EXISTS FacilityServices;
CREATE TABLE FacilityServices(
ServiceTypeID Char(10) NOT NULL,
Name Varchar(60) NOT NULL,
CONSTRAINT PK_FacilityServices PRIMARY KEY(ServiceTypeID));

DROP TABLE IF EXISTS FacilityStatus;
CREATE TABLE FacilityStatus(
FacilityStatusID Char(3) NOT NULL,
Description Varchar(16) NOT NULL,
CONSTRAINT PK_FacilityStatus PRIMARY KEY(FacilityStatusID));

DROP TABLE IF EXISTS FacilityTypes;
CREATE TABLE FacilityTypes(
FacilityTypeID Char(10) NOT NULL,
Name Varchar(50) NOT NULL,
CONSTRAINT PK_FacilityTypes PRIMARY KEY(FacilityTypeID));

DROP TABLE IF EXISTS Teams;
CREATE TABLE Teams(
TeamID Varchar(5) NOT NULL,
Description Varchar(32) NOT NULL,
CONSTRAINT PK_Teams PRIMARY KEY(TeamID));

DROP TABLE IF EXISTS MaritalStatus;
CREATE TABLE MaritalStatus(
MaritalID Char(3) NOT NULL,
Description Varchar(16) NOT NULL,
CONSTRAINT PK_MaritalStatus PRIMARY KEY(MaritalID));

DROP TABLE IF EXISTS Gender;
CREATE TABLE Gender(
Sex Char(1) NOT NULL,
Description Varchar(6) NOT NULL,
CONSTRAINT PK_Gender PRIMARY KEY(Sex));


DROP TABLE IF EXISTS PermissionTypes;
CREATE TABLE PermissionTypes(
PermissionID Varchar(20) NOT NULL,
Description Varchar(100) NOT NULL,
CONSTRAINT PK_PermissionTypes PRIMARY KEY(PermissionID));

DROP TABLE IF EXISTS  AddressTypes;
CREATE TABLE AddressTypes(
AddressTypeID Varchar(5) NOT NULL,
Description Varchar(16) NOT NULL,
CONSTRAINT PK_AddressTypes PRIMARY KEY(AddressTypeID));

DROP TABLE IF EXISTS Continents;
CREATE TABLE Continents(
ContinentCode Char(5) NOT NULL,
Name Varchar(30) NOT NULL,
CONSTRAINT PK_ContinentCodes PRIMARY KEY(ContinentCode));

DROP TABLE IF EXISTS Countries;
CREATE TABLE Countries(
CountryCode Char(3) NOT NULL,
Name Varchar(64) NOT NULL,
ContinentCode Char(5), 
CONSTRAINT PK_Countries PRIMARY KEY(CountryCode),
CONSTRAINT FK_Countries_ContinentCode FOREIGN KEY(ContinentCode) REFERENCES Continents(ContinentCode) ON DELETE NO ACTION ON UPDATE CASCADE);

DROP TABLE IF EXISTS Zones;
CREATE TABLE Zones(
ZoneCode Varchar(5) NOT NULL,
CountryCode Char(3),
Description Varchar(64) NOT NULL,
CONSTRAINT PK_Zones PRIMARY KEY(ZoneCode),
CONSTRAINT FK_Zones_CountryCode FOREIGN KEY(CountryCode) REFERENCES Countries(CountryCode) ON DELETE NO ACTION ON UPDATE CASCADE);

DROP TABLE IF EXISTS LevelNames;
CREATE TABLE LevelNames(
CountryCode Char(3) NOT NULL,
Level1name Varchar(64),
Level2name Varchar(64),
Level3name Varchar(64),
ModifiedBy varchar(30) NOT NULL,
ModifiedAt Timestamp, 
CONSTRAINT PK_LevelNames PRIMARY KEY(CountryCode),
CONSTRAINT FK_LevelNames_CountryCode FOREIGN KEY(CountryCode) REFERENCES Countries(CountryCode) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_LevelNames_ModifiedBy FOREIGN KEY(ModifiedBy) REFERENCES Users(Username) ON DELETE NO ACTION ON UPDATE CASCADE);

DROP TABLE IF EXISTS ScheduleActiveIndicators;
CREATE TABLE ScheduleActiveIndicators(
ScheduleID Varchar(16) NOT NULL,
QuestionID INT NOT NULL AUTO_INCREMENT,
IndicatorStatusID Char(3) NOT NULL,
IndicatorID char(10) NOT NULL,
StartDate Date  NOT NULL,
EndDate Date NOT NULL,
MinimumScoreValue INT,
MaximumScoreValue INT,
FrequencyID Char(3) NOT NULL,
MethodOfMeasureID Varchar(8) NOT NULL,
ModifiedBy varchar(30) NOT NULL,
ModifiedAt Timestamp, 
CONSTRAINT PK_ScheduleActiveIndicators PRIMARY KEY(ScheduleID),
CONSTRAINT FK_ScheduleActiveIndicators_ModifiedBy FOREIGN KEY(ModifiedBy) REFERENCES Users(Username) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_ScheduleActiveIndicators_QuestionID FOREIGN KEY(QuestionID) REFERENCES Questions(QuestionID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_ScheduleActiveIndicators_StatusID FOREIGN KEY(IndicatorStatusID) REFERENCES Indicators(IndicatorStatusID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_ScheduleActiveIndicators_IndicatorID FOREIGN KEY(IndicatorID) REFERENCES Indicators(IndicatorID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_ScheduleActiveIndicators_FrequencyID FOREIGN KEY(FrequencyID) REFERENCES FrequencyOfMeasures(FrequencyID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_ScheduleActiveIndicators_MethodOfMeasureID FOREIGN KEY(MethodOfMeasureID) REFERENCES MethodOfMeasurements(MethodOfMeasureID) ON DELETE NO ACTION ON UPDATE CASCADE);

DROP TABLE IF EXISTS HumanRespondents;
CREATE TABLE HumanRespondents(
HumanID INT(11) NOT NULL AUTO_INCREMENT,
Surname Varchar(32) NOT NULL,
MiddleName varchar(32),
FirstName varchar(32) NOT NULL,
DateOfBirth date NOT NULL,
Sex Char(1) NOT NULL,
MaritalID char(5) NOT NULL,
ModifiedBy varchar(30) NOT NULL,
ModifiedAt Timestamp,
CONSTRAINT PK_HumanRespondents PRIMARY KEY(HumanID),
CONSTRAINT FK_HumanRespondent_ModifiedBy FOREIGN KEY(ModifiedBy) REFERENCES Users(Username) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_HumanRespondent_Sex FOREIGN KEY(Sex) REFERENCES Gender(Sex) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_HumanRespondent_MritalID FOREIGN KEY(MaritalID) REFERENCES MaritalStatus(MaritalID));

DROP TABLE IF EXISTS Facilities;
CREATE TABLE Facilities(
FacilityID int NOT NULL AUTO_INCREMENT,
FacilityTypeID char(3) NOT NULL,
ContactID int(11) NOT NULL,
FacilityStatusID Char(3) NOT NULL,
ServiceTypeID char(10) NOT NULL,
ModifiedBy varchar(30) NOT NULL,
ModifiedAt Timestamp, 
CONSTRAINT PK_Facilities PRIMARY KEY(FacilityID),
CONSTRAINT FK_Facilities_ModifiedBy FOREIGN KEY(ModifiedBy) REFERENCES Users(Username) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_Facility_FacilityTypeID FOREIGN KEY(FacilityTypeID) REFERENCES FacilityTypes(FacilityTypeID) ON DELETE NO ACTION ON UPDATE CASCADE, 
CONSTRAINT FK_Facility_ContactID FOREIGN KEY(ContactID) REFERENCES FacilityContacts(ContactID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_Facilities_StatusID FOREIGN KEY(FacilityStatusID) REFERENCES FacilityStatus(FacilityStatusID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_Facilities_ServiceTypeID FOREIGN KEY(ServiceTypeID) REFERENCES FacilityServices(ServiceTypeID) ON DELETE NO ACTION ON UPDATE CASCADE);

DROP TABLE IF EXISTS Respondents;
CREATE TABLE Respondents(
RespondentID int NOT NULL AUTO_INCREMENT,
Description Varchar(50),
FacilityID INT,
HumanID INT,
ModifiedBy varchar(30) NOT NULL,
ModifiedAt Timestamp, 
CONSTRAINT PK_RespondentID PRIMARY KEY(RespondentID),
CONSTRAINT FK_Respondent_ModifiedBy FOREIGN KEY(ModifiedBy) REFERENCES Users(Username) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_Respondents_FacilityID FOREIGN KEY(FacilityID) REFERENCES Facilities(FacilityID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_Respondent_HumanID FOREIGN KEY(HumanID) REFERENCES HumanRespondents(HumanID) ON DELETE NO ACTION ON UPDATE CASCADE);

DROP TABLE IF EXISTS TeamRespondents;
CREATE TABLE TeamRespondents(
RespondentID int(11) NOT NULL,
TeamID Varchar(5) NOT NULL,
ModifiedBy varchar(30) NOT NULL,
ModifiedAt Timestamp, 
CONSTRAINT PK_Respondent PRIMARY KEY(RespondentID,TeamID),
CONSTRAINT FK_TeamRespondent_ModifiedBy FOREIGN KEY(ModifiedBy) REFERENCES Users(Username) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_TeamRespondents_Respondents FOREIGN KEY(RespondentID) REFERENCES Respondents(RespondentID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_TeamRespondents_Team FOREIGN KEY(TeamID) REFERENCES Teams(TeamID) ON DELETE NO ACTION ON UPDATE CASCADE);


DROP TABLE IF EXISTS TeamMembers;
CREATE TABLE TeamMembers(
TeamID varchar(5) NOT NULL,
Username varchar(20) NOT NULL,
TeamLead varchar(20) NOT NULL,
ModifiedBy varchar(30) NOT NULL,
ModifiedAt Timestamp,
CONSTRAINT PK_TeamMembers PRIMARY KEY(TeamID,Username),
CONSTRAINT FK_TeamMembers_TeamID FOREIGN KEY(TeamID) REFERENCES Teams(TeamID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_TeamMembers_Username FOREIGN KEY(Username) REFERENCES Users(Username) ON DELETE NO ACTION ON UPDATE CASCADE);

DROP TABLE IF EXISTS Measures;
CREATE TABLE Measures(
ScheduleID Varchar(16) NOT NULL,
QuestionID INT NOT NULL AUTO_INCREMENT,
IndicatorID Char(10) NOT NULL,
DateOfMeasurement Date NOT NULL,
CollectedOn Date NOT NULL,
CollectedBy Varchar(16),
TeamID Varchar(5),
Score INT NOT NULL,
RespondentID Integer,
ModifiedBy varchar(30) NOT NULL,
ModifiedAt Timestamp, 
CONSTRAINT PK_Measures PRIMARY KEY(ScheduleID,QuestionID,IndicatorID),
CONSTRAINT FK_Measures_ModifiedBy FOREIGN KEY(ModifiedBy) REFERENCES Users(Username) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_Measures_ScheduleActiveIndicators FOREIGN KEY(ScheduleID) REFERENCES ScheduleActiveIndicators(ScheduleID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_Measures_ScheduleActiveIndicators_Questions FOREIGN KEY(QuestionID) REFERENCES ScheduleActiveIndicators(QuestionID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_Measures_ScheduleActiveIndicators_Indicators FOREIGN KEY(IndicatorID) REFERENCES ScheduleActiveIndicators(IndicatorID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_Measures_TeamMembers FOREIGN KEY(CollectedBy) REFERENCES TeamMembers(Username) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_Measures_TeamMemebers FOREIGN KEY(TeamID) REFERENCES TeamMembers(TeamID) ON DELETE NO ACTION ON UPDATE CASCADE);

DROP TABLE IF EXISTS Permissions;
CREATE TABLE Permissions(
PermissionID varchar(20) NOT NULL,
RoleID varchar(20) NOT NULL,
ModifiedBy varchar(30) NOT NULL,
ModifiedAt Timestamp, 
CONSTRAINT PK_Permissions PRIMARY KEY(PermissionID,RoleID),
CONSTRAINT FK_Permissions_ModifiedBy FOREIGN KEY(ModifiedBy) REFERENCES Users(Username) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_Permissions_PermissionID FOREIGN KEY(PermissionID) REFERENCES PermissionTypes(PermissionID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_Permissions_RoleID FOREIGN KEY(RoleID) REFERENCES UserRoles(RoleID) ON DELETE NO ACTION ON UPDATE CASCADE);

DROP TABLE IF EXISTS AULevel1;
CREATE TABLE AULevel1(
CountryCode Char(3) NOT NULL,
AULevel1ID varchar(5) NOT NULL,
Name varchar(100) NOT NULL,
CONSTRAINT PK_AULevel1 PRIMARY KEY(CountryCode,AULevel1ID),
CONSTRAINT FK_AULevel1_CountryCode FOREIGN KEY(CountryCode) REFERENCES Countries(CountryCode) ON DELETE NO ACTION ON UPDATE CASCADE);

DROP TABLE IF EXISTS AULevel2;
CREATE TABLE AULevel2 (
CountryCode char(3) NOT NULL,
AULevel1ID varchar(5) NOT NULL,
Name varchar(100) NOT NULL,
AULevel2ID varchar(5) NOT NULL,
PRIMARY KEY (CountryCode, AULevel1ID, AULevel2ID),
CONSTRAINT FK_AULevel2_AULevel1ID FOREIGN KEY (CountryCode, AULevel1ID) REFERENCES AULevel1 (CountryCode, AULevel1ID) ON DELETE NO ACTION ON UPDATE CASCADE);

DROP TABLE IF EXISTS AULevel3;
CREATE TABLE AULevel3(
CountryCode char(3) NOT NULL,
AULevel1ID varchar(5) NOT NULL,
Name varchar(100) NOT NULL,
AULevel2ID varchar(5) NOT NULL,
AULevel3ID varchar(5) NOT NULL,
PRIMARY KEY (CountryCode,AULevel1ID,AULevel2ID,AULevel3ID),
CONSTRAINT AULevel3_AULevel3ID_1 FOREIGN KEY (CountryCode, AULevel1ID,AULevel2ID) REFERENCES AULevel2(CountryCode, AULevel1ID,AULevel2ID) ON DELETE NO ACTION ON UPDATE CASCADE);

DROP TABLE IF EXISTS Addresses;
CREATE TABLE Addresses(
AddressID int(11) NOT NULL AUTO_INCREMENT,
AddressTypeID varchar(5) NOT NULL,
CountryCode char(3) NOT NULL,
AULevel1ID varchar(5) NOT NULL,
AULevel2ID varchar(5) NOT NULL,
AULevel3ID varchar(5) NOT NULL,
RespondentID int(11) NOT NULL,
Addressline1 varchar(255) NOT NULL,
Addressline2 varchar(255) DEFAULT NULL,
ModifiedBy varchar(30) NOT NULL,
ModifiedAt timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (AddressID),
CONSTRAINT FK_Addresses FOREIGN KEY (CountryCode, AULevel1ID, AULevel2ID, AULevel3ID) REFERENCES AULevel3 (CountryCode, AULevel1ID, AULevel2ID, AULevel3ID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_Addresses_AddressTypeID FOREIGN KEY (AddressTypeID) REFERENCES AddressTypes (AddressTypeID) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_Addresses_ModifiedBy FOREIGN KEY (ModifiedBy) REFERENCES Users (Username) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT FK_Adresses_RespondentID FOREIGN KEY (RespondentID) REFERENCES Respondents (RespondentID) ON DELETE NO ACTION ON UPDATE CASCADE);






