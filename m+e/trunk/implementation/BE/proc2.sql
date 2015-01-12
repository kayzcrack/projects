DELIMITER //
DROP FUNCTION IF EXISTS authenticateUser //
CREATE FUNCTION authenticateUser(in_Username VARCHAR(16), in_Password VARCHAR(255))
RETURNS BOOLEAN READS SQL DATA

BEGIN
    RETURN (SELECT COUNT(*) FROM `User`
	WHERE Username=in_Username AND Password= PASSWORD(in_Password));

	END //
DELIMITER ;
-- -----------------------
DELIMITER //
DROP PROCEDURE IF EXISTS LoginUser //
CREATE PROCEDURE LoginUser(in_Username VARCHAR(16), in_Password VARCHAR(255))READS SQL DATA
BEGIN
			IF(authenticateUser(in_Username,in_Password)) THEN
				BEGIN
					DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN
					ROLLBACK;
					SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT =  '-45000: loginUser: Error logging in';
					END;
					
					START TRANSACTION;
					INSERT INTO UserLogin(LoginTime,Username,LogoutTime)
					VALUES(NOW(),in_Username,'');
					COMMIT;
					SELECT u.Surname, u.FirstName,u.RoleID, l.LoginTime
						    FROM `User` u LEFT JOIN UserLogin l ON l.Username=u.Username
						    WHERE u.Username=in_Username AND l.loginTime=
						    (select max(LoginTime) from UserLogin where Username=in_Username);
				END;
			ELSE
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT =  '-45000: loginUser: User authen fail';
			END IF;

END //
DELIMITER ;
-- =======================
-- procedure to logout user
DELIMITER //
DROP PROCEDURE IF EXISTS LogoutUser //
CREATE PROCEDURE LogoutUser(IN in_username VARCHAR(16) )
BEGIN
    UPDATE  UserLogin
    SET LogoutTime = NOW()
    WHERE Username = in_username  AND LogoutTime = '0000-00-00 00:00:00' LIMIT 1;

END //
DELIMITER ;
-- ====================

-- ==========================================================================
-- Adds Selector

DELIMITER //
DROP PROCEDURE IF EXISTS addSelector //
CREATE PROCEDURE addSelector
			   (IN in_Description VARCHAR(64))

			    
BEGIN

			INSERT INTO Selector(Description) VALUES (in_Description);


END //
DELIMITER ;

-- ====================================================================
-- Adds New IndicatorClass

DELIMITER //
DROP PROCEDURE IF EXISTS addIndicatorClass //
CREATE PROCEDURE addIndicatorClass 
			       (IN in_IndicatorclassID VARCHAR(16),
			        IN in_Description VARCHAR(64))
 
BEGIN

				INSERT INTO IndicatorClass (IndicatorClassID,Description)
				VALUES (in_IndicatorclassID,in_Description);

END //
DELIMITER ;


-- =================================================================================

-- Adds Indicator for an indicator class

DELIMITER //
DROP PROCEDURE IF EXISTS addIndicator //
CREATE PROCEDURE addIndicator
			    (IN in_Name VARCHAR(255),
			    IN in_StatusID CHAR(3),
			    IN in_IndicatorClassID VARCHAR(16))
			    
BEGIN
			  INSERT INTO `Indicator`(Name,StatusID,IndicatorClassID)
			  VALUES (in_Name,in_StatusID,in_IndicatorClassID);
			 
END //
DELIMITER ;


-- =================================================================================

-- Adds Frequency of Measures to the database

DELIMITER //
DROP PROCEDURE IF EXISTS addFrequencyOfMeasure //
CREATE PROCEDURE addFrequencyOfMeasure
				     (IN in_FrequencyID CHAR(3),
				     IN in_Description VARCHAR(32),
				     IN in_EffectiveStartDate DATE,
				     IN in_EffectiveEndDate DATE)
				     
BEGIN
				    INSERT INTO FrequencyOfMeasure(FrequencyID,Description,EffectiveStartDATE,EffectiveEndDATE)
				    VALUES (in_FrequencyID, in_Description, in_EffectiveStartDate, in_EffectiveEndDate);
				    
END //
DELIMITER ;


--================================================================
-- Adds method of measurement
DELIMITER //
DROP PROCEDURE IF EXISTS addMethodOfMeasurement //
CREATE PROCEDURE addMethodOfMeasurement
				     (IN in_Description VARCHAR(32))
				     
				     
BEGIN
				    INSERT INTO MethodOfMeasurement (Description)
				    VALUES (in_Description);
				    
END //
DELIMITER ;

-- ===========================================================

-- Adds User Roles

DELIMITER //
DROP PROCEDURE IF EXISTS addUserRole //
CREATE PROCEDURE addUserRole
			    (IN in_RoleID VARCHAR(5),
			    IN in_Description VARCHAR(64))
			    
BEGIN
			  INSERT INTO UserRole(RoleID, Description)
			  VALUES (in_RoleID, in_Description);
			  
END //
DELIMITER ;

-- =====================================================================


-- Adds User

DELIMITER //
DROP PROCEDURE IF EXISTS addUser //
CREATE PROCEDURE addUser
			(
			IN in_Password VARCHAR(255),
			IN in_Username VARCHAR(16),
			IN in_Firstname VARCHAR(32),
			IN in_UserStatusID CHAR(3),
			IN in_RoleID VARCHAR(5),
			IN in_Surname VARCHAR(32))
			 
BEGIN
			INSERT INTO `User`(PASSWORD(Password),Username,Firstname,UserStatusID,RoleID,Surname)
			VALUES (in_Password,in_Username,in_Firstname,in_UserStatusID,in_RoleID,in_Surname);
END //
DELIMITER ;

-- =====================================================================

-- Adds premission types

DELIMITER //
DROP PROCEDURE IF EXISTS addPermissionType //
CREATE PROCEDURE addPermissionType
				  (IN in_PermissionID VARCHAR(32),
				  IN in_Description VARCHAR(128))
				  
BEGIN
				INSERT INTO PermissionType(PermissionID, Description)
				VALUES (in_PermissionID,in_Description);
			
END //
DELIMITER ;


-- =====================================================================
-- Adds Permission  to the database

DELIMITER //
DROP PROCEDURE IF EXISTS addPermission //
CREATE PROCEDURE addPermission
			      (IN in_PermissionID VARCHAR(5),
			      IN in_RoleID VARCHAR(5))
			      
BEGIN
			    INSERT INTO Permission(PermissionID,RoleID)
			    VALUES (in_PermissionID,in_RoleID);
			    
END //
DELIMITER ;



-- =======================================================================

-- Add Teams

DELIMITER //
DROP PROCEDURE IF EXISTS addTeam //
CREATE PROCEDURE addTeam
			(IN in_TeamID VARCHAR(16),
			 IN in_Description VARCHAR(64))
			
		
BEGIN
			INSERT INTO Team(TeamID,Description,DateFormed)
			VALUES (in_TeamID, in_Description, NOW());
			
END //
DELIMITER ;

-- ========================================================================

-- Add Data sources

DELIMITER //
DROP PROCEDURE IF EXISTS addDataSource //
CREATE PROCEDURE addDataSource
			(IN in_SourceID VARCHAR(16),
			IN in_Description VARCHAR(64))
			
		
BEGIN
			INSERT INTO DataSource(SourceID, Description)
			VALUES (in_SourceID,in_Description);
			
END //
DELIMITER ;

-- ========================================================================

-- Add members to a team

DELIMITER //
DROP PROCEDURE IF EXISTS addTeamMember //
CREATE PROCEDURE addTeamMember 
			(IN in_TeamID VARCHAR(16),
			IN in_Username VARCHAR(16),
			IN in_SourceID VARCHAR(16),
			IN in_TeamLead VARCHAR(16))
BEGIN
			INSERT INTO TeamMember(TeamID,Username,SourceID,TeamLead)
			VALUES (in_TeamID,in_Username,in_SourceID,in_TeamLead);
END //
DELIMITER ;


-- =============================================================


-- Adds Facility Type

DELIMITER //
DROP PROCEDURE IF EXISTS addFacilityType //
CREATE PROCEDURE addFacilityType
			(IN in_FacilityTypeID CHAR(3),
			IN in_Description VARCHAR(64))
			
		
BEGIN
			INSERT INTO FacilityType(FacilityTypeID,Description)
			VALUES(in_FacilityTypeID,in_Description);
			
END //
DELIMITER ;

-- =======================================================================
-- Adds Facility Services

DELIMITER //
DROP PROCEDURE IF EXISTS addFacilityService //
CREATE PROCEDURE addFacilityService
				   (IN in_ServiceTypeID CHAR(3),
				   IN in_Name VARCHAR(64))
				   
BEGIN 
				  INSERT INTO FacilityService(ServiceTypeID,Name)
				  VALUES (in_ServiceTypeID,in_Name);
END //
DELIMITER ;

-- =======================================================================

-- Adds Address to the database

DELIMITER //
DROP PROCEDURE IF EXISTS addAddress //
CREATE PROCEDURE addAddress
			  (IN in_AddressTypeID VARCHAR(5),
			  IN in_CountryCode CHAR(3),
			  IN in_AULevel1ID VARCHAR(5),
			  IN in_AULevel2ID VARCHAR(5),
			  IN in_AULevel3ID VARCHAR(5),
			  IN in_Addressline1 VARCHAR(255),
			  IN in_Addressline2 VARCHAR(255))
BEGIN 
			  SET @r = (SELECT max(RespondentID) FROM Respondent);
			  SET @d = (SELECT max(DateVisited) FROM Respondent);
			  INSERT INTO Address(AddressTypeID,CountryCode,AULevel1ID,AULevel2ID,AULevel3ID,RespondentID,DateVisited,Addressline1,Addressline2)
			  VALUES (in_AddressTypeID,in_CountryCode,in_AULevel1ID,in_AULevel2ID,in_AULevel3ID,@r,@d,in_Addressline1,in_Addressline2);

 END //

 DELIMITER ;


-- ====================================================================

-- Adds Facility

DELIMITER //
DROP PROCEDURE IF EXISTS addFacility //
CREATE PROCEDURE addFacility
			   (
			   IN in_FacilityTypeID CHAR(3),
			   IN in_Name VARCHAR(64),
			   IN in_FacilityStatusID CHAR(3),
			   IN in_ServiceTypeID CHAR(3),
			   IN in_TitleID VARCHAR(16),
			   IN in_ContactEmail VARCHAR(32),
			   IN in_PhoneNumber VARCHAR(32),
			   IN in_Surname VARCHAR(32),
			   IN in_Firstname VARCHAR(32),
			   IN in_Middlename VARCHAR(32),
			   IN in_AddressTypeID VARCHAR(5),
			   IN in_CountryCode CHAR(3),
			   IN in_AULevel1ID VARCHAR(5),
			   IN in_AULevel2ID VARCHAR(5),
			   IN in_AULevel3ID VARCHAR(5),
			   IN in_Addressline1 VARCHAR(255),
			   IN in_Addressline2 VARCHAR(255))
			   
BEGIN 

			    INSERT INTO Facility(FacilityTypeID,Name,FacilityStatusID,ServiceTypeID) 
			    VALUES (in_FacilityTypeID,in_Name,in_FacilityStatusID,in_ServiceTypeID); 

			    CALL addFacilityContact(in_TitleID,in_ContactEmail,in_PhoneNumber,in_Surname,in_Firstname,in_Middlename);
			    call addAddress(in_AddressTypeID,in_CountryCode,in_AULevel1ID,in_AULevel2ID,in_AULevel3ID,in_Addressline1,in_Addressline2);

 

 END //
DELIMITER ;

-- =========================================================================
-- Adds HumanRespondent


DELIMITER //
DROP PROCEDURE IF EXISTS addHumanRespondent //
CREATE PROCEDURE addHumanRespondent 
				  (IN in_Surname VARCHAR(32),
				  IN in_OtherNames VARCHAR(32),
				  IN in_DateOfBirth DATE,
				  IN in_Sex CHAR(1),
				  IN in_MaritalID CHAR(1),
				  IN in_AddressTypeID VARCHAR(5),
				  IN in_CountryCode CHAR(3),
				  IN in_AULevel1ID VARCHAR(5),
				  IN in_AULevel2ID VARCHAR(5),
				  IN in_AULevel3ID VARCHAR(5),
				  IN in_Addressline1 VARCHAR(255),
				  IN in_Addressline2 VARCHAR(255))
				  
BEGIN
INSERT INTO HumanRespondent(Surname,OtherNames,DateOfBirth,Sex,MaritalID)
VALUES(in_Surname,in_OtherNames,in_DateOfBirth,in_Sex,in_MaritalID);

CALL addAddress(in_AddressTypeID,in_CountryCode,in_AULevel1ID,in_AULevel2ID,in_AULevel3ID,in_Addressline1,in_Addressline2);

END //
DELIMITER ;

-- ==========================================================================

-- Adds Respondent

DELIMITER //
DROP PROCEDURE IF EXISTS addRespondent //
CREATE PROCEDURE addRespondent
			    (
			    IN in_Description VARCHAR(255),
			    IN in_FacilityID INT,
			    IN in_HumanID INT)
BEGIN
    IF (in_FacilityID is null) THEN

	    INSERT INTO Respondent(Description,FacilityID,HumanID)
	    VALUES (in_Description,null,in_HumanID);

    ELSE 

	    INSERT INTO Respondent(Description,FacilityID,HumanID)
	    VALUES (in_Description,in_FacilityID,null);
    END IF; 
    
END //
DELIMITER ;
-- =============================================================
-- Adds Team respondent

DELIMITER //
DROP PROCEDURE IF EXISTS addTeamRespondent //
CREATE PROCEDURE addTeamRespondent
				  (
				  IN in_TeamID VARCHAR(16),
				  IN in_StartDate DATETIME,
				  IN in_EndDate DATETIME)
				  
				  
BEGIN
			    set @r = (select max(RespondentID) from Respondent);
			    set @d = (select max(DateVisited)from Respondent);
			    INSERT INTO TeamRespondent(DateVisited,RespondentID,TeamID,StartDate,EndDate)

			    VALUES(@d,@r,in_TeamID,in_StartDate,in_EndDate);
END //
DELIMITER ;

-- ========================================================================

-- Adds Facility Contact
DELIMITER //
DROP PROCEDURE IF EXISTS addFacilityContact //
CREATE PROCEDURE addFacilityContact
				   (
				   IN in_TitleID VARCHAR(16),
				    IN in_ContactEmail VARCHAR(32),
				    IN in_PhoneNumber VARCHAR(32),
				    IN in_Surname VARCHAR(32),
				    IN in_Firstname VARCHAR(32),
				    IN in_Middlename VARCHAR(32))
				    
BEGIN

set @t = (SELECT max(FacilityID) FROM Facility);
INSERT INTO FacilityContact(FacilityID,TitleID,ContactEmail,PhoneNumber,SurName,FirstName,MiddleName) 
VALUES
(@t,in_TitleID,in_ContactEmail,in_PhoneNumber, in_Surname, in_Firstname, in_Middlename);


END //
DELIMITER ;

-- -- =======================================================================


-- Adds Continent

DELIMITER //
DROP PROCEDURE IF EXISTS addContinent //
CREATE PROCEDURE addContinent 
			    (IN in_ContinentCode CHAR(5),
			    IN in_Name VARCHAR(16))
			   
BEGIN
			    INSERT INTO Continent(ContinentCode,Name)
			    VALUES (in_ContinentCode,in_Name);
END //
DELIMITER ;


-- =======================================================================

-- Adds a Country

DELIMITER //
DROP PROCEDURE IF EXISTS addCountry //
CREATE PROCEDURE addCountry
			  (IN in_CountryCode CHAR(3),
			  IN in_Name VARCHAR(64),
			  IN in_ContinentCode CHAR(5))
BEGIN 
			  INSERT INTO Country(CountryCode,Name,ContinentCode)
			  VALUES (in_CountryCode,in_Name,in_ContinentCode);
			  
END //
DELIMITER ;


-- ======================================================================

-- Adds level names

DELIMITER //
DROP PROCEDURE IF EXISTS addLevelName //
CREATE PROCEDURE addLevelName
			    (IN in_CountryCode CHAR(3),
			    IN in_Level1name VARCHAR(64),
			    IN in_Level2name VARCHAR(64),
			    IN in_Level3name VARCHAR(64))
BEGIN
			    INSERT INTO LevelName(CountryCode,Level1name,Level2name,Level3name)
			    VALUES (in_CountryCode,in_Level1name,in_Level2name,in_Level3name);
END //
DELIMITER ;

-- ==================================================================

-- Adds Country Zone
DELIMITER //
DROP PROCEDURE IF EXISTS addCountryZone //
CREATE PROCEDURE addCountryZone
			      (IN in_CountryCode CHAR(3),
			      IN in_ZoneCode VARCHAR(5),
			      IN in_Description VARCHAR(64))
BEGIN
			    INSERT INTO Zone(CountryCode,ZoneCode,Description)
			    VALUES(in_CountryCode,in_ZoneCode,in_Description);
END //
DELIMITER ;

-- =====================================================================

-- Adds AULevel1

DELIMITER //
DROP PROCEDURE IF EXISTS addAULevel1 //
CREATE PROCEDURE addAULevel1 
			   (IN in_CountryCode CHAR(3),
			   IN in_AULevel1ID VARCHAR(5),
			   IN in_Name VARCHAR(100))
BEGIN
			  INSERT INTO AULevel1(CountryCode,AULevel1ID,Name)
			  VALUES (in_CountryCode,in_AULevel1ID,in_Name);
END //
DELIMITER ;

-- ===============================================================
-- Adds AULevel2
DELIMITER //
DROP PROCEDURE IF EXISTS addAULevel2 //
CREATE PROCEDURE addAULevel2 
			    (IN in_CountryCode CHAR(3),
			    IN in_AULevel1ID VARCHAR(5),
			    IN in_Name VARCHAR(100),
			    IN in_AULevel2ID VARCHAR(5))
BEGIN 


			    INSERT INTO AULevel2(CountryCode,AULevel1ID,Name,AULevel2ID)
			    VALUES(in_CountryCode,in_AULevel1ID,in_Name,in_AULevel2ID);
END //
DELIMITER ;

-- ==================================================================
-- Adds AULevel3
DELIMITER //
DROP PROCEDURE IF EXISTS addAULevel3 //
CREATE PROCEDURE addAULevel3
			    (IN in_CountryCode CHAR(3),
			    IN in_AULevel1ID VARCHAR(5),
			    IN in_Name VARCHAR(100),
			    IN in_AULevel2ID VARCHAR(5),
			    IN in_AULevel3ID VARCHAR(5))
			    
BEGIN
			    INSERT INTO AULevel3(CountryCode,AULevel1ID,Name,AULevel2ID,AULevel3ID)
			    VALUES (in_CountryCode,in_AULevel1ID,in_Name,in_AULevel2ID,in_AULevel3ID);
END //
DELIMITER ;

-- =========================================================================

-- Schedule active indicator
DELIMITER //
DROP PROCEDURE IF EXISTS addScheduleActiveIndicator //
CREATE PROCEDURE addScheduleActiveIndicator
					   (
					    IN in_QuestionID INT,
					    IN in_StatusID CHAR(3),
					    IN in_StartDate DATE,
					    IN in_EndDate DATE,
					    IN in_FrequencyID CHAR(3),
					    IN in_MethodMeasureID INT)
					    
BEGIN
INSERT INTO ScheduledActiveIndicator(QuestionID,StatusID,StartDate,EndDate,FrequencyID,MethodMeasureID)
VALUES(in_QuestionID,in_StatusID,in_StartDate,in_EndDate,in_FrequencyID,in_MethodMeasureID);

END //
DELIMITER ;


-- ========================================================================
-- Adds Measure to the database

DELIMITER //
DROP PROCEDURE IF EXISTS addMeasure //
CREATE PROCEDURE addMeasure 
			  (
			   IN in_ScheduleID INT,
			   IN in_QuestionID INT,
			   IN in_TeamResID INT,
			   IN in_Username VARCHAR(16),
			   IN in_Answer VARCHAR(255),
			   IN in_TeamID VARCHAR(20))
			   
BEGIN

INSERT INTO Measure(ScheduleID,QuestionID,TeamResID,Username,Answer,TeamID)
VALUES(in_ScheduleID,in_QuestionID,in_TeamResID,in_Username,in_Answer,in_TeamID);

END //
DELIMITER ;

-- ==============================================================================

-- Adds Team area of coverage

DELIMITER //
DROP PROCEDURE IF EXISTS addTeamAreaOfCoverage //
CREATE PROCEDURE addTeamAreaOfCoverage
				      (IN in_TeamID VARCHAR(16),
				      IN in_AULevel3ID CHAR(5),
				      IN in_CountryCode CHAR(3),
				      IN in_AULevel1ID VARCHAR(5),
				      IN in_AULevel2ID VARCHAR(5),
				      IN in_StartDate DATETIME,
				      IN in_EndDate DATETIME)
				      
BEGIN

INSERT INTO TeamAreaOfCoverage(TeamID,AULevel3ID,CountryCode,AULevel1ID,AULevel2ID,StartDate,EndDate)
VALUES(in_TeamID,in_AULevel3ID,in_CountryCode,in_AULevel1ID,in_AULevel2ID,in_StartDate,in_EndDate);

END //
DELIMITER ;

-- ================================================
-- Adds Questions

DELIMITER //
DROP PROCEDURE IF EXISTS addQuestion //
CREATE PROCEDURE addQuestion
			  (IN in_IndicatorID INT,
			   IN in_TypeID CHAR(3),
			   IN in_StatusID CHAR(3),
			   IN in_Question VARCHAR(255),
			   IN in_Instructions VARCHAR(255),
			   IN in_HINT VARCHAR(255),
			   IN in_SelectorID INT)
				      
BEGIN

INSERT INTO Question(IndicatorID,TypeID,StatusID,Question,Instructions,HINT,SelectorID)
VALUES(in_IndicatorID,in_TypeID,in_StatusID,in_Question,in_Instructions,in_HINT,in_SelectorID);

END //
DELIMITER ;
-- ======================================================