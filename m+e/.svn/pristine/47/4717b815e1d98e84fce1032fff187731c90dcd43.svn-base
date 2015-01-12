-- FUNCTION TO AUTHENTICATE USER
DELIMITER //
DROP FUNCTION IF EXISTS authenticateUser //
CREATE FUNCTION authenticateUser(in_UserName VARCHAR(20), in_Password VARCHAR(255))
RETURNS BOOLEAN
BEGIN
/*Checks if user exists, returns one if User exists*/
    RETURN (SELECT COUNT(*) FROM Users
	WHERE Username=in_UserName AND `Password`= PASSWORD(in_Password));
END //

DELIMITER ;

/* =========================================================================================== */
/*Log in user */
DELIMITER //
DROP PROCEDURE IF EXISTS loginUser //
CREATE PROCEDURE loginUser(in_UserName VARCHAR(20), in_Password VARCHAR(255))
BEGIN
/*Checks if user is Logged in*/
			IF(authenticateUser(in_UserName,in_Password)) THEN
			/*Checks if user exists*/
				BEGIN
					DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN
					ROLLBACK;
					SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT =  '-45000: loginUser: Error logging in';
					END;
					
					START TRANSACTION;
					UPDATE UserLogin SET LogoutTime=NULL WHERE UserName=in_UserName AND LogoutTime IS NULL;
					
					INSERT INTO UserLogin(UserName,LoginTime)
					VALUE(in_UserName,now());
					COMMIT;
					SELECT concat(u.Surname, ' ' ,u.FirstName) 'Full Name',l.LoginTime
						    FROM Users u LEFT JOIN UserLogin l ON l.UserName=u.Username
						    WHERE u.Username=in_UserName AND l.loginTime=
						    (select max(LoginTime) from UserLogin where UserName=in_UserName);
				END;
			ELSE
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT =  '-45000: loginUser: User authen fail';
			END IF;

END //

DELIMITER ;
/*call loginUser('Folaniyi', 'password'); */

/*===================================================================================================*/
/*Checks is user is an Admin*/
DELIMITER //
DROP FUNCTION IF EXISTS Admin//
CREATE FUNCTION Admin(inUsername VARCHAR(20), inPassword VARCHAR(255)) RETURNS BOOLEAN 
BEGIN
/*returns 1 if user is an Admin*/
	RETURN (SELECT COUNT(*) FROM Users WHERE Username = inUsername AND RoleID='Admin');
	/*AND authenticateUser(inUsername, inPassword);*/
END //

DELIMITER ;


/*====================================================================================================*/
/*Checks for Active User*/
DELIMITER //
DROP FUNCTION IF EXISTS checkActiveUser//
CREATE FUNCTION checkActiveUser(inUsername VARCHAR(20)) RETURNS BOOLEAN 
BEGIN
/*returns 1 if user exists*/
	RETURN (SELECT COUNT(*) FROM Users WHERE Username = inUsername AND `UserStatusID` ='Act');
END //

DELIMITER ;

/*===========================================================================================================*/

/*check login status of users*/
DELIMITER //
DROP FUNCTION IF EXISTS checkLoginStatus //
CREATE FUNCTION checkLoginStatus(in_username VARCHAR(255)) 
RETURNS BOOLEAN
  BEGIN
  	/* Returns 1 if the user is logged in */
	RETURN (SELECT COUNT(*) FROM UserLogin
	WHERE UserName=in_username AND LogoutTime='0000-00-00 00:00:00');
	RETURN (SELECT COUNT(*) FROM UserLogin
	WHERE UserName=in_username AND LogoutTime <> '0000-00-00 00:00:00');
	
  END //
  
DELIMITER ;

/*===================================================================================================*/
/*check for user permission*/
DELIMITER //
DROP FUNCTION IF EXISTS checkPermission//
CREATE FUNCTION checkPermission(inUsername VARCHAR(20), in_permission VARCHAR(10)) RETURNS BOOLEAN 
/* returns 1 if user has the given privilege */
BEGIN
  RETURN
    (SELECT COUNT(*) FROM Permissions
     WHERE `PermissionID` = in_permission AND RoleID = (SELECT RoleID FROM Users
														WHERE Username = inUsername LIMIT 1));
END //

DELIMITER ;

/*=============================================================================================*/

/*Add Questions*/
DELIMITER //
DROP PROCEDURE IF EXISTS addQuestion//
CREATE PROCEDURE addQuestion (IN in_indicatorID CHAR(10),IN in_qStatusID CHAR(3),IN in_description VARCHAR(255),IN in_instructions VARCHAR(255),
IN in_hint VARCHAR(255),IN in_resultType CHAR(3),IN in_UserName VARCHAR(20),IN in_Permission VARCHAR(10)) 
BEGIN
/*Add new questions*/
	
		IF (checkLoginStatus(in_UserName)) THEN
		   	IF (checkPermission(in_UserName,in_Permission)) THEN
		
			       
				  INSERT INTO Questions (IndicatorID,QuestionStatusID,Description,Instructions,Hint,TypeID,ModifiedBy)
				  VALUES (in_indicatorID,in_qStatusID,in_description,in_instructions,in_hint,in_resultType,in_UserName);
		
			ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT =  '-45000: permission: Permission Denied';
			END IF;	  
			
		ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT =  '-45000: loginUser: Not logged in';
		
			
			
		END IF;

END //

DELIMITER ;


/*================================================================================================*/

/*to add a team*/
DELIMITER //
DROP PROCEDURE IF EXISTS addTeam//
CREATE PROCEDURE addTeam (IN in_teamID VARCHAR(5),IN in_description VARCHAR(32), IN in_UserName VARCHAR(20), IN in_permission VARCHAR(10)) 
BEGIN
	IF (checkLoginStatus(in_UserName)) THEN
		IF (checkPermission(in_UserName,in_permission)) THEN
		
			  INSERT INTO 
			  Teams (TeamID,Description)
			  VALUES (In_teamID, in_description);
		
		ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT =  '-45000: permission: Permission Denied';
		END IF;	  
			
	ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT =  '-45000: loginUser: Not logged in';
		
			
			
	END IF;
        
END //

DELIMITER ;

/*==========================================================================================*/
/*to add an Indicator*/
DELIMITER //
DROP PROCEDURE IF EXISTS addIndicator//
CREATE PROCEDURE addIndicator(IN in_ID CHAR(10),IN in_name VARCHAR(255),IN in_statusID CHAR(3),IN in_indicatorClassID CHAR(10),IN in_UserName VARCHAR(20),IN in_permission VARCHAR(10))
BEGIN
	IF (checkLoginStatus(in_UserName)) THEN
			IF (checkPermission(in_UserName,in_permission)) THEN
			
				  INSERT INTO 
				  Indicators (IndicatorID,NAME,IndicatorStatusID,IndicatorClassID,ModifiedBy)
				  VALUES (in_ID,in_name,in_statusID,in_indicatorClassID,in_UserName);
  
  
		ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT =  '-45000: permission: Permission Denied';
		END IF;	  
			
	ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT =  '-45000: loginUser: Not logged in';
		
			
			
	END IF;
END //

DELIMITER ;

/*================================================================================================*/
/*to add a Measure*/
DELIMITER //
DROP PROCEDURE IF EXISTS addMeasure//
CREATE PROCEDURE addMeasure (IN in_ScheduleID VARCHAR(16),IN in_QuestionID INT(10),IN in_IndicatorID VARCHAR(16),IN in_DateOfMeasurement DATE,IN in_DateCollected DATE,IN in_Collector VARCHAR(16),
IN in_teamID VARCHAR(16),IN in_score INT(10),IN in_respondentID VARCHAR(6),IN in_userName VARCHAR(20), IN in_permission VARCHAR(30))						
BEGIN
	IF (checkLoginStatus(in_UserName)) THEN
	      IF (checkPermission(in_UserName,in_permission)) THEN
		  INSERT INTO Measures (ScheduleID,QuestionID,IndicatorID,DateOfMeasurement,CollectedOn,CollectedBy,TeamID,Score,RespondentID,ModifiedBy)
		  VALUES (in_ScheduleID,in_QuestionID,in_IndicatorID,in_DateOfMeasurement,in_DateCollected,in_Collector,in_teamID,in_score,in_respondentID,in_UserName);
		  
	      ELSE
	      SIGNAL SQLSTATE '45000'
	      SET MESSAGE_TEXT =  '-45000: permission: Permission Denied';
	      END IF;	   
		 
        ELSE
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT =  '-45000: loginUser: Not logged in';
	END IF;
	    
	    
END //

DELIMITER ;

/*================================================================================================*/
/*to add a User*/
DELIMITER //
DROP PROCEDURE IF EXISTS addUser//
CREATE PROCEDURE addUser (IN in_username VARCHAR(20),IN in_password VARCHAR(255),IN in_surname VARCHAR(32),IN in_firstname VARCHAR(32),
			  IN in_sourceID CHAR(10),IN in_roleID VARCHAR(20),IN in_capturePeriod DATE,IN inUserName VARCHAR(20),IN in_permission VARCHAR(10)) 

BEGIN
	IF (checkLoginStatus(inUserName)) THEN
			IF (checkPermission(inUserName,in_permission)) THEN
			
				  INSERT INTO 
				  Users (Username,`Password`,Surname,FirstName,SourceID,RoleID,CapturePeriod)
				  VALUES (in_username,PASSWORD(in_password),in_surname,in_firstname,in_sourceID,in_roleID,in_capturePeriod);
		  
			  
			ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT =  '-45000: permission: Permission Denied';
			END IF;	  
			
	ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT =  '-45000: loginUser: Not logged in';
		
			
			
	END IF;
END //

DELIMITER ;

/*=========================================================================================================================================*/
/*PROCEDURE TO DEACTIVATE INDICATORS.*/
DELIMITER //
DROP PROCEDURE IF EXISTS deactivateIndicator //
CREATE PROCEDURE deactivateIndicator(in_IndicatorID char(10),IN in_UserName varchar(20),IN in_permission varchar(10))
BEGIN
		 IF (checkLoginStatus(in_UserName)) THEN
				IF (checkPermission(in_UserName,in_permission)) THEN
						IF checkActiveUser( in_UserName) THEN
			   
					 UPDATE Indicators
						 SET IndicatorStatusID = 'Nac',
						 ModifiedBy = in_UserName
						 WHERE IndicatorID = in_IndicatorID;
						 
					UPDATE Questions
						 SET QuestionStatusID = 'Nac',
						 ModifiedBy = in_UserName
						 WHERE IndicatorID = in_IndicatorID;
						 
						 
					ELSE
					SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
					END IF;	
						 
			  
			  
				ELSE
					SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT =  '-45000: permission: Permission Denied';
				END IF;	  
			
	                ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
		
			
			
	       END IF;
END //

DELIMITER ;

/*=============================================================================================================*/
/*PROCEDURE TO ACTIVATE INDICATORS.*/
DELIMITER //
DROP PROCEDURE IF EXISTS activateIndicator //
CREATE PROCEDURE activateIndicator(in_IndicatorID char(10),IN in_UserName varchar(20),IN in_permission varchar(10))
BEGIN
		 IF (checkLoginStatus(in_UserName)) THEN
				IF (checkPermission(in_UserName,in_permission)) THEN
						IF checkActiveUser( in_UserName) THEN
			   
					 UPDATE Indicators
						 SET IndicatorStatusID = 'Act',
						 ModifiedBy = in_UserName
						 WHERE IndicatorID = in_IndicatorID;
						 
					UPDATE Questions
						 SET QuestionStatusID = 'Act',
						 ModifiedBy = in_UserName
						 WHERE IndicatorID = in_IndicatorID;
						 
						 
					ELSE
					SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
					END IF;	
						 
			  
			  
				ELSE
					SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT =  '-45000: permission: Permission Denied';
				END IF;	  
			
	                ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
		
			
			
	       END IF;
END //

DELIMITER ;

/*=============================================================================================================*/
DELIMITER //
DROP PROCEDURE IF EXISTS activateUser //
CREATE  PROCEDURE activateUser (in_Username VARCHAR(30),adminUsername VARCHAR(20), adminPassword VARCHAR(255))
BEGIN
   IF Admin(adminUsername, adminPassword) THEN
     IF checkActiveUser(adminUsername) THEN
  	 
   	  UPDATE Users
   	  SET UserStatusID = 'Act'
   	  WHERE UserName = in_Username;
   	    	
	ELSE
        	SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT =  '-45000: Status: User Not Active ';
		
        END IF;
        
    ELSE 
     SIGNAL SQLSTATE '45000'
	   SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
   END IF;	    
END //

DELIMITER ;

/*=========================================================================*/
/*Deactive a user*/
DELIMITER //
DROP PROCEDURE IF EXISTS deactivateUser//
CREATE  PROCEDURE deactivateUser(IN in_Username VARCHAR(30),
								 IN adminUsername VARCHAR(20),
								 IN adminPassword VARCHAR(255))
BEGIN
   IF Admin(adminUsername, adminPassword) THEN
     IF checkActiveUser(adminUsername) THEN
  	 
   	  UPDATE Users
   	  SET UserStatusID = 'Nac'
   	  WHERE UserName = in_Username;
   	    
   	    	
	ELSE
        	SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT =  '-45000: Status: User Not Active ';
		
        END IF;
        
    ELSE 
     SIGNAL SQLSTATE '45000'
	   SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
   END IF;	    
END //

DELIMITER ;

/*=========================================================================================================*/
/*procedure to change user password(Admin)*/
DELIMITER //
DROP PROCEDURE IF EXISTS changeUserPassword//
CREATE PROCEDURE changeUserPassword(IN in_Admin VARCHAR(30), IN in_Apwd VARCHAR(255),in_username VARCHAR(20),in_Password VARCHAR(255))
BEGIN
	IF Admin(in_Admin, in_Apwd) THEN
	   	                  IF checkActiveUser(in_Admin) THEN
					
						  UPDATE Users SET `Password`=PASSWORD(in_Password)
						  WHERE `Username`=in_username;
				  
				  ELSE
				  SIGNAL SQLSTATE '45000'
				  SET MESSAGE_TEXT =  '-45000: Status: User Not Active ';
			
		                  END IF;
		
		
	ELSE
			SET @ERRMSG:=CONCAT(in_Admin,": Permission denied");
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT =@ERRMSG;
	END IF;
END //

DELIMITER ;

/*========================================================================================================*/
/*procedure to create user*/
DELIMITER //
DROP PROCEDURE IF EXISTS createUserRole//
CREATE PROCEDURE createUserRole(in_RoleID VARCHAR(32),
				in_Description VARCHAR(100),
				in_Admin VARCHAR(20),
				in_Apwd VARCHAR(255))
BEGIN
	 IF Admin(in_Admin, in_Apwd) THEN
		INSERT INTO UserRoles(RoleID,Description) VALUES(in_RoleID,in_Description)
		ON DUPLICATE KEY UPDATE Description=in_Description;
		
	
	ELSE
		SET @ERRMSG:=CONCAT(in_Admin,": Permission denied");
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT =@ERRMSG;
	END IF;
	
END //

DELIMITER ;

/*==============================================================================================================*/
/*procedure to schedule and event.*/
DELIMITER //
DROP PROCEDURE IF EXISTS scheduleActiveIndicator //
CREATE PROCEDURE scheduleActiveIndicator(IN in_ScheduleID VARCHAR(10),
					IN in_QuestionID INT(11),
					IN in_IndicatorStatusID CHAR(3),
					IN in_IndicatorID VARCHAR(16),
					IN in_StartDate DATE,
					IN in_EndDate DATE,
					IN in_MinimumScoreValue INT(11),
					IN in_MaximumScoreValue INT(11),
					IN in_FrequencyID CHAR(3),
					IN in_MethodOfMeasureID VARCHAR(8),
					IN in_UserName VARCHAR(20),
					IN in_permission VARCHAR(10))
BEGIN
	IF (checkLoginStatus(in_UserName)) THEN
		       IF (checkPermission(in_UserName,in_permission)) THEN
				IF checkActiveUser(in_UserName) THEN
					
					INSERT INTO ScheduleActiveIndicators(ScheduleID,QuestionID,IndicatorStatusID,IndicatorID,StartDate,EndDate,MinimumScoreValue,MaximumScoreValue,FrequencyID,MethodOfMeasureID,ModifiedBy)
					VALUES(in_ScheduleID,in_QuestionID,in_IndicatorStatusID,in_IndicatorID,in_StartDate,in_EndDate,in_MinimumScoreValue,in_MaximumScoreValue,in_FrequencyID,in_MethodOfMeasureID,in_UserName);
       		
 
						 
				ELSE
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				END IF;	
						 
			  
			  
			ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT =  '-45000: permission: Permission Denied';
			END IF;	  
			
	ELSE
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
	END IF;					
END //

DELIMITER ;

/*===============================================================================================================*/
/*procedure to logout user*/
DELIMITER //
DROP PROCEDURE IF EXISTS logoutUser //
CREATE PROCEDURE `logoutUser`(IN in_userName VARCHAR(10))
BEGIN
    UPDATE  UserLogin
    SET LogoutTime = NOW()
    WHERE `Username`= in_userName  AND LogoutTime = '0000-00-00 00:00:00' LIMIT 1;

END //

DELIMITER ;

/*===============================================================================================================*/
/*Adds only Human record to the Respondents Table*/
DELIMITER //
DROP PROCEDURE IF EXISTS recordHumanRespondent //
CREATE PROCEDURE recordHumanRespondent(
			        IN in_description VARCHAR(20),
			        IN in_humanID INT(11),
			        IN in_UserName VARCHAR(30),
			        IN in_permission VARCHAR(10))
BEGIN
	IF (checkLoginStatus(in_UserName)) THEN
            IF (checkPermission(in_UserName,in_permission)) THEN
				IF checkActiveUser(in_UserName) THEN
						INSERT INTO Respondents (Description,HumanID,ModifiedBy)
						 VALUES (in_description,in_humanID,in_UserName);
						 
					ELSE
					SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				END IF;	
			  
				ELSE
					SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
			END IF;

		ELSE
		   SIGNAL SQLSTATE '45000'
		   SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
   END IF;
END //

DELIMITER ;
 
/*===============================================================================================================*/
/*Removes Permission Assigned to a Role*/
DELIMITER //
DROP PROCEDURE IF EXISTS removePermissionFromRole //

CREATE PROCEDURE removePermissionFromRole(IN in_PermissionID VARCHAR(20),
									IN in_RoleID VARCHAR(20), 
									IN in_Username VARCHAR(20),
									IN in_permission VARCHAR(20))
BEGIN
		IF (checkLoginStatus(in_UserName)) THEN
				IF (checkPermission(in_UserName,in_permission)) THEN
						IF checkActiveUser(in_UserName) THEN
								DELETE FROM Permissions 
								WHERE PermissionID = in_PermissionID AND RoleID = in_RoleID;
							ELSE
								SIGNAL SQLSTATE '45000'
								SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
						END IF;
					
					ELSE 
						SIGNAL SQLSTATE '45000'
						SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                END IF;
	
			ELSE 
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
				
		END IF;
END //

DELIMITER ;

/*============================================================================================================*/
/*to add a Facility*/
DELIMITER //
DROP PROCEDURE IF EXISTS addFacility//
CREATE PROCEDURE addFacility 
			       (
				IN in_facilityTypeID CHAR(10),
				IN in_contactID VARCHAR(32),
				IN in_statusID VARCHAR(32),
				IN in_serviceTypeID CHAR(10),
				IN in_Username VARCHAR(30),
				IN in_Permission VARCHAR(10)) 
BEGIN

IF (checkLoginStatus(in_UserName)) THEN
          IF (checkPermission(in_UserName,in_permission)) THEN
				IF checkActiveUser(in_UserName) THEN
					
			          INSERT INTO 
				  Facilities (FacilityTypeID,ContactID,FacilityStatusID,ServiceTypeID,ModifiedBy)
				  VALUES (in_facilityTypeID,in_contactID,in_statusID,in_serviceTypeID,in_Username);
				  
				  
				  		 
				ELSE
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				END IF;					  
				  
	    ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
			
	    END IF;


	ELSE
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
	END IF;		    
    
END //

DELIMITER ;

/*=========================================================================================================*/
/*to add a Respondent(Human)*/
DELIMITER //
DROP PROCEDURE IF EXISTS addHumanRespondent//
CREATE PROCEDURE addHumanRespondent 
			       (IN in_surname VARCHAR(32),
			        IN in_middleName VARCHAR(32),
			        IN in_firstName VARCHAR(32),
			        IN in_dob DATE,
			        IN in_sex CHAR(1),
				IN in_maritalID CHAR(5),
				IN in_UserName VARCHAR(30),
				IN in_permission VARCHAR(10))
BEGIN

	IF (checkLoginStatus(in_UserName)) THEN
            IF (checkPermission(in_UserName,in_permission)) THEN
				IF checkActiveUser(in_UserName) THEN
			
					  INSERT INTO 
					  HumanRespondents (Surname,MiddleName,FIrstName,DateOfBirth,Sex,MaritalID,ModifiedBy)
					  VALUES (in_surname,in_middleName,in_firstName,in_dob,in_sex,in_maritalID,in_UserName);
					  
					  
					    		 
				ELSE
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				END IF;	
				  
				  
	    ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
			
	    END IF;


   ELSE
   SIGNAL SQLSTATE '45000'
   SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
   END IF;		  
END //

DELIMITER ;

/*===========================================================================================================*/
/*to add an Address*/
DELIMITER //
DROP PROCEDURE IF EXISTS addAddress//
CREATE PROCEDURE addAddress 
			       (
			        IN in_addressTypeID VARCHAR(5),
			        IN in_cCode CHAR(3),
			        IN in_AUL1ID VARCHAR(5),
			        IN in_AUL2ID VARCHAR(5),
			        IN in_AUL3ID VARCHAR(5),
			        IN in_respondentID CHAR(3),
				IN in_address1 VARCHAR(255),
				IN in_address2 VARCHAR(255),
				IN in_UserName VARCHAR(30),
				IN in_permission VARCHAR(10)) 
BEGIN

IF (checkLoginStatus(in_UserName)) THEN
            IF (checkPermission(in_UserName,in_permission)) THEN
				IF checkActiveUser(in_UserName) THEN

			  INSERT INTO 
			  Addresses (AddressTypeID,CountryCode,AULevel1ID,AULevel2ID,AULevel3ID,RespondentID,Addressline1,Addressline2,ModifiedBy)
			  VALUES (in_addressTypeID,in_cCode,in_AUL1ID,in_AUL2ID,in_AUL3ID,in_respondentID,in_address1,in_address2,in_UserName);
			  
			  
			  	ELSE
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				END IF;	
				 
				  
	    ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
			
	    END IF;


   ELSE
   SIGNAL SQLSTATE '45000'
   SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
   END IF;		 
END //

DELIMITER ;

/*==============================================================================================================*/
/*to add all Respondents*/
DELIMITER //
DROP PROCEDURE IF EXISTS addRespondent//
CREATE PROCEDURE addRespondent 
			       (
			        IN in_description VARCHAR(20),
			        IN in_facilityID INT(10),
			        IN in_humanID INT(10),
			        IN in_UserName VARCHAR(30),
			        IN in_permission VARCHAR(10)) 
BEGIN

IF (checkLoginStatus(in_UserName)) THEN
            IF (checkPermission(in_UserName,in_permission)) THEN
				IF checkActiveUser(in_UserName) THEN
 
  INSERT INTO 
   Respondents (Description,FacilityID,HumanID,ModifiedBy)
  VALUES (in_description,in_facilityID,in_humanID,in_UserName);
  
  
			  	ELSE
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				END IF;	
				  
				  
	    ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
			
	    END IF;


   ELSE
   SIGNAL SQLSTATE '45000'
   SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
   END IF;
   
END //

DELIMITER ;

/*===========================================================================================================*/
/*to add services that can be offered in different facilities*/
DELIMITER //
DROP PROCEDURE IF EXISTS addFacilityService//
CREATE PROCEDURE addFacilityService 
			       (IN in_serviceID CHAR(10),
			        IN in_name VARCHAR(60),
			        IN in_UserName VARCHAR(30),
			        IN in_permission VARCHAR(10)) 
BEGIN

  IF (checkLoginStatus(in_UserName)) THEN
            IF (checkPermission(in_UserName,in_permission)) THEN
				IF checkActiveUser(in_UserName) THEN
 
					  INSERT INTO 
					   FacilityServices (ServiceTypeID,`NAME`)
					  VALUES (in_serviceID,in_name);
				  
				ELSE
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				END IF;	
				  
				  
	    ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
			
	    END IF;


   ELSE
   SIGNAL SQLSTATE '45000'
   SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
   END IF;
   
END //

DELIMITER ;

/*=======================================================================================================*/
/*to add all possible Roles*/
DELIMITER //
DROP PROCEDURE IF EXISTS addUserRole//
CREATE PROCEDURE addUserRole 
			       (IN in_roleID VARCHAR(50),
			        IN in_description VARCHAR(16),
			        IN in_Username VARCHAR(20),
			        IN in_permission VARCHAR(10)) 
BEGIN
     IF (checkLoginStatus(in_UserName)) THEN
                 IF (checkPermission(in_Username,in_permission)) THEN
           		      IF checkActiveUser(in_UserName) THEN
		 
						 INSERT INTO 
						 UserRoles (RoleID,Description)
						 VALUES (in_roleID,in_description);
						 
			       
				ELSE
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				END IF;	
				  
				  
	    ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
			
	    END IF;


   ELSE
   SIGNAL SQLSTATE '45000'
   SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
   END IF;
END //

DELIMITER ;

/*======================================================================================================*/
/*to add a Team and their corresponding Respondent*/
DELIMITER //
DROP PROCEDURE IF EXISTS addTeamRespondent//
CREATE PROCEDURE addTeamRespondent 
			       (IN in_respondentID VARCHAR(6),
			        IN in_teamID VARCHAR(5),
			        IN in_Username VARCHAR(20),
			        IN in_Permission VARCHAR(10))
BEGIN

   IF (checkLoginStatus(in_Username)) THEN
                IF (checkPermission(in_Username,in_Permission)) THEN
           		      IF checkActiveUser(in_Username) THEN
  
						  INSERT INTO 
						  TeamRespondents (RespondentID,TeamID,ModifiedBy)
						  VALUES (in_respondentID,in_teamID, in_Username);
						  
			      ELSE
			      SIGNAL SQLSTATE '45000'
			      SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
			      END IF;
			      
			      
	        ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                END IF;	
                
     
   ELSE
   SIGNAL SQLSTATE '45000'
   SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
   END IF;              
END //

DELIMITER ;

/*=========================================================================================================*/
/*to add a Contact person's details for facilities*/
DELIMITER //
DROP PROCEDURE IF EXISTS addFacilityContact//
CREATE PROCEDURE addFacilityContact 
			       (IN in_Description VARCHAR(30),
			        IN in_contactEmail VARCHAR(32),
			        IN in_phoneNumber VARCHAR(32),
			        IN in_surname VARCHAR(32),
			        IN in_firstName VARCHAR(32),
			        IN in_middleName VARCHAR(32),
			        IN in_Username VARCHAR(30),
			        IN in_Permission VARCHAR(10)) 
BEGIN

      IF (checkLoginStatus(in_UserName)) THEN
                IF (checkPermission(in_Username,in_permission)) THEN
           		           IF checkActiveUser(in_UserName) THEN
           		           
           		           
						  INSERT INTO 
						   FacilityContacts (Description,ContactEmail,PhoneNumber,SurName,FirstName,MiddleName)
						  VALUES (in_Description,in_contactEmail,in_phoneNumber,in_surname,in_firstName,in_middleName);
						  
				   ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;	
				   
		ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                END IF;	
                
      
     ELSE
     SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
     END IF;          
END //

DELIMITER ;

/*=======================================================================================================*/
/*to add Permissions to different userRoles*/
DELIMITER //
DROP PROCEDURE IF EXISTS addPermission//
CREATE PROCEDURE addPermission 
			       (IN in_permissionID VARCHAR(5),
			        IN in_roleID VARCHAR(5),
			        IN in_Username VARCHAR(20),
			        IN in_Permission VARCHAR(10)) 
BEGIN
     IF (Admin(in_Username,in_Permission)) THEN
                 IF checkActiveUser(in_UserName) THEN
                 
                 
		                INSERT INTO 
			        Permissions (PermissionID,RoleID,ModifiedBy)
			   	VALUES (in_permissionID,in_roleID,in_Username);
			   	
		ELSE
	        SIGNAL SQLSTATE '45000'
	        SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
		END IF;	

	   	
     ELSE
     SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
     END IF;	
   			   	
END //

DELIMITER ;

/*====================================================================================================*/
/*to add info about the Second Level of Administration in a Country*/
DELIMITER //
DROP PROCEDURE IF EXISTS addAUL2//
CREATE PROCEDURE addAUL2 
			       (IN in_countryID CHAR(3),
			        IN in_AUL1ID VARCHAR(5),
			        IN in_Name VARCHAR(32),
			        IN in_AUL2ID VARCHAR(5),
			        IN in_UserName VARCHAR(30),
			        IN in_permission VARCHAR(10)) 
BEGIN

     IF (checkLoginStatus(in_UserName)) THEN
                IF (checkPermission(in_Username,in_permission)) THEN
                
                
				  INSERT INTO 
				   AULevel2 (CountryCode,AULevel1ID,`Name`,AULevel2ID)
				  VALUES (in_countryID,in_AUL1ID,in_Name,in_AUL2ID);
				  
				   
		ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                END IF;	
                
      
     ELSE
     SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
     END IF;       		  
END //

DELIMITER ;

/*===========================================================================================*/
/*to add info about the firstLevel of Administration in a Country*/
DELIMITER //
DROP PROCEDURE IF EXISTS addAUL1//
CREATE PROCEDURE addAUL1 
			       (IN in_countryID CHAR(3),
			        IN in_AUL1ID VARCHAR(5),
			        IN in_Name VARCHAR(32),
			        IN in_UserName VARCHAR(30),
			        IN in_permission VARCHAR(10)) 
BEGIN
       IF (checkLoginStatus(in_UserName)) THEN
                IF (checkPermission(in_Username,in_permission)) THEN
        

				  INSERT INTO 
				   AULevel1 (CountryCode,AULevel1ID,`Name`)
				  VALUES (in_countryID,in_AUL1ID,in_Name);
				  
				  
		ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                END IF;	
                
      
     ELSE
     SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
     END IF;       
END //

DELIMITER ;

/*==========================================================================================*/
/*to add info about the third level of Administration in a Country*/
DELIMITER //
DROP PROCEDURE IF EXISTS addAUL3//
CREATE PROCEDURE addAUL3 
			       (IN in_countryID CHAR(3),
			        IN in_AUL1ID VARCHAR(5),
			        IN in_Name VARCHAR(50),
			        IN in_AUL2ID VARCHAR(5),
			        IN in_AUL3ID VARCHAR(5),
			        IN in_UserName VARCHAR(30),
			        IN in_permission VARCHAR(10)) 
BEGIN

      IF (checkLoginStatus(in_UserName)) THEN
                IF (checkPermission(in_Username,in_permission)) THEN
        
				  INSERT INTO 
				   AULevel3 (CountryCode,AULevel1ID,`Name`,AULevel2ID,AULevel3ID)
				  VALUES (in_countryID,in_AUL1ID,in_Name,in_AUL2ID,in_AUL3ID);
				  
				  ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                END IF;	
                
      
     ELSE
     SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
     END IF;     
     
END //

DELIMITER ;

/*======================================================================================*/
/*to add Countries*/
DELIMITER //
DROP PROCEDURE IF EXISTS addCountry//
CREATE PROCEDURE addCountry 
			       (IN in_countryID CHAR(3),
			       	IN in_Name VARCHAR(64),
			        IN in_ContinentCode CHAR(5),
			        IN in_UserName VARCHAR(30),
			        IN in_permission VARCHAR(10)) 
 BEGIN
 
 	IF (checkLoginStatus(in_UserName)) THEN
                IF (checkPermission(in_Username,in_permission)) THEN
        
  		INSERT INTO Countries (CountryCode,`Name`,ContinentCode)
  		VALUES (in_countryID,in_Name,in_ContinentCode);
  		
  	  
  		ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                END IF;	
                
      
     ELSE
     SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
     END IF;     
     
 END //
 
 DELIMITER ;
 
/*======================================================================================*/
/*to add all Continents*/
DELIMITER //
DROP PROCEDURE IF EXISTS addContinent //
CREATE PROCEDURE addContinent 
			       (IN in_continentID CHAR(3),
			        IN in_name VARCHAR(30),
			        IN in_Username VARCHAR(30),
			        IN in_permission VARCHAR(10)) 
BEGIN

       IF (checkLoginStatus(in_UserName)) THEN
                IF (checkPermission(in_Username,in_permission)) THEN
                
                
			   INSERT INTO 
			   Continents (ContinentCode,Name)
			   VALUES (in_continentID,in_name);
			   
	        ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                END IF;	
                
      
     ELSE
     SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
     END IF;     
END //

DELIMITER ;

/*====================================================================================*/
/*to add names of all levels of Administration in a Country*/
DELIMITER //
DROP PROCEDURE IF EXISTS addLevel//
CREATE PROCEDURE addLevel 
			       (IN in_countryID CHAR(3),
			        IN in_lev1Name VARCHAR(64),
			        IN in_lev2Name VARCHAR(64),
			        IN in_lev3Name VARCHAR(64),
			        IN in_Username VARCHAR(30),
			        IN in_permission VARCHAR(10)) 
 BEGIN
 
 	IF (checkLoginStatus(in_UserName)) THEN
                IF (checkPermission(in_Username,in_permission)) THEN
          
			  INSERT INTO 
			   LevelNames (CountryCode,Level1Name,Level2Name,Level3Name,ModifiedBy)
			  VALUES (in_countryID,in_lev1Name,in_lev2Name,in_lev3Name,in_Username);
			  
			  
			   ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                END IF;	
                
      
     ELSE
     SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
     END IF;     
END //
	 
DELIMITER ;

/*=================================================================================*/
/*to add major Divisions(CLasses) for all Indicators*/
DELIMITER //
DROP PROCEDURE IF EXISTS addIndicatorClass//
CREATE PROCEDURE addIndicatorClass 
			       (IN in_classID CHAR(10),
			        IN in_description VARCHAR(100),
			        IN in_Username VARCHAR(20),
			        IN in_permission VARCHAR(10)) 
BEGIN
   IF (checkLoginStatus(in_UserName)) THEN
    		IF (checkPermission(in_Username,in_permission)) THEN
           		           IF checkActiveUser(in_UserName) THEN
           	
						   INSERT INTO 
						   IndicatorClasses (IndicatorClassID,Description)
						   VALUES (in_classID,in_description);
				   
				    ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              


END //

DELIMITER ;

/*=================================================================================*/
/*to add possible Result Types*/
DELIMITER //
DROP PROCEDURE IF EXISTS addResultType//
CREATE PROCEDURE addResultType 
			       (IN in_resultID CHAR(3),
			        IN in_description VARCHAR(16),
			        IN in_Username VARCHAR(20),
			        IN in_Permission VARCHAR(10)) 
BEGIN
 IF (checkLoginStatus(in_UserName)) THEN
    		IF (checkPermission(in_Username,in_permission)) THEN
           		           IF checkActiveUser(in_UserName) THEN
			     
							INSERT INTO 
							ResultTypes (ResultTypeID,Description)
							VALUES (in_resultID,in_description);
	    
				    ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              		   	
			   	
END //

DELIMITER ;

/*===============================================================================*/
/*to add data Sources*/
DELIMITER //
DROP PROCEDURE IF EXISTS addDataSource//
CREATE PROCEDURE addDataSource 
			       (IN in_sourceID CHAR(10),
			        IN in_description VARCHAR(64),
			        IN in_Username varchar(20),
			        IN in_Permission varchar(10)) 
BEGIN
 IF (checkLoginStatus(in_UserName)) THEN
    		IF (checkPermission(in_Username,in_permission)) THEN
           		           IF checkActiveUser(in_UserName) THEN

							   INSERT INTO 
							   DataSources (SourceID,Description)
							   VALUES (in_sourceID,in_description);
			   	
	 
				    ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              	
END //

DELIMITER ;

/*==============================================================================*/
/*to add all Types of Permissions that can be granted to users*/
DELIMITER //
DROP PROCEDURE IF EXISTS addPermissionType//
CREATE PROCEDURE addPermissionType 
			       (IN in_permissionID VARCHAR(10),
			        IN in_description VARCHAR(50),
			        IN in_Username varchar(20),
			        IN in_Permission varchar(10)) 
BEGIN
 IF (checkLoginStatus(in_UserName)) THEN
    		IF (checkPermission(in_Username,in_permission)) THEN
           		           IF checkActiveUser(in_UserName) THEN

						   INSERT INTO 
						   PermissionTypes (PermissionID,Description)
						   VALUES (in_permissionID,in_description);
	                           ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              
END //

DELIMITER ;

/*==============================================================================*/
/*to add types of addresses*/
DELIMITER //
DROP PROCEDURE IF EXISTS addAddressType//
CREATE PROCEDURE addAddressType 
			       (IN in_typeID VARCHAR(5),
			        IN in_description VARCHAR(16),
			        IN in_Username varchar(20),
			        IN in_Permission varchar(10)) 
BEGIN
 IF (checkLoginStatus(in_UserName)) THEN
    		IF (checkPermission(in_Username,in_permission)) THEN
           		           IF checkActiveUser(in_UserName) THEN

						                INSERT INTO 
							        AddressTypes (AddressTypeID,Description)
								VALUES (in_typeID,in_description);
	                           ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              
END //

DELIMITER ;

/*=============================================================================*/
/*to add TYpes of Faciities*/
DELIMITER //
DROP PROCEDURE IF EXISTS addFacilityType//
CREATE PROCEDURE addFacilityType 
			       (IN in_typeID CHAR(10),
			        IN in_name VARCHAR(50),
			        IN in_Username varchar(20),
			        IN in_Permission varchar(10)) 
BEGIN
 IF (checkLoginStatus(in_UserName)) THEN
    		IF (checkPermission(in_Username,in_permission)) THEN
           		           IF checkActiveUser(in_UserName) THEN

		 
						  INSERT INTO 
						  FacilityTypes (FacilityTypeID,`NAME`)
						  VALUES (in_typeID,in_name);
	                           ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              
END //

DELIMITER ;

/*=============================================================================*/
/*to add Members of a Team*/
DELIMITER //
DROP PROCEDURE IF EXISTS addTeamMember//
CREATE PROCEDURE addTeamMember 
			       (IN in_teamID CHAR(10),
			        IN in_Username VARCHAR(20),
			        IN in_teamLead VARCHAR(20),
			        IN inUsername VARCHAR(20),
			        IN in_Permission VARCHAR(10)) 
BEGIN
IF (checkLoginStatus(in_UserName)) THEN
    		IF (checkPermission(in_Username,in_permission)) THEN
           		           IF checkActiveUser(in_UserName) THEN


	                          INSERT INTO 
		                  TeamMembers (TeamID,Username,TeamLead,ModifiedBy)
		   		  VALUES (in_teamID,in_Username,in_teamLead,inUsername);
		   		
			 
	                           ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              	 	

END //

DELIMITER ;

/*=============================================================================================*/
/*to add all possible ZOnes within a Country*/
DELIMITER //
DROP PROCEDURE IF EXISTS addZone//
CREATE PROCEDURE addZone(IN in_zoneCode VARCHAR(5),
			        IN in_countryCode CHAR(3),
			        IN in_description VARCHAR(64),
			        IN in_Username VARCHAR(20),
			        IN in_permission VARCHAR(10))
BEGIN
     IF (checkLoginStatus(in_UserName)) THEN
                 IF (checkPermission(in_Username,in_permission)) THEN
           		      IF checkActiveUser(in_UserName) THEN
		 


					  INSERT INTO 
					   Zones (ZoneCode,CountryCode,Description)
					  VALUES (in_zoneCode,in_countryCode,in_description);
							 
			       
				ELSE
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				END IF;	
				  
				  
	    ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
			
	    END IF;


   ELSE
   SIGNAL SQLSTATE '45000'
   SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
   END IF; 

 END //
 
DELIMITER ;

/*====================================================================================*/
/*to view all Questions in the Questions Table*/
DELIMITER //
DROP PROCEDURE IF EXISTS getAllQuestions//
CREATE PROCEDURE getAllQuestions () 
BEGIN
  SELECT * FROM Questions;
END //

DELIMITER ;

/*=================================================================================*/
/*to view Questions for an Indicator*/
DELIMITER //
DROP PROCEDURE IF EXISTS getQuestionForIndicator//
CREATE PROCEDURE getQuestionForIndicator (IN in_indicatorID CHAR(10)) 
BEGIN

  SELECT * FROM Questions WHERE IndicatorID=in_indicatorID;
END //

DELIMITER ;

/*=================================================================================*/
/*to view Indicators*/
DELIMITER //
DROP PROCEDURE IF EXISTS getAllIndicators//
CREATE PROCEDURE getAllIndicators () 
BEGIN
  SELECT * FROM Indicators;
END //

DELIMITER ;

/*====================================================================================*/
/*to view Countries*/
DELIMITER //
DROP PROCEDURE IF EXISTS getCountries//
CREATE PROCEDURE getCountries ( ) 
BEGIN
  SELECT * FROM Countries;
END //

DELIMITER ;

/*================================================================================*/
/*to view Countries from a given Continent*/
DELIMITER //
DROP PROCEDURE IF EXISTS getCountriesInContinent//
CREATE PROCEDURE getCountriesinContinent (IN in_continentCode CHAR(3)) 
BEGIN
  SELECT * FROM Countries WHERE ContinentCode=in_continentCode;
END //

DELIMITER ;

/*==================================================================================*/
/*to view zones in a Country */
DELIMITER //
DROP PROCEDURE IF EXISTS getZonesInCountry//
CREATE PROCEDURE getZonesinCountry (IN in_countryCode CHAR(3)) 
BEGIN
  SELECT * FROM Zones WHERE CountryCode=in_countryCode;
END //

DELIMITER ;

/*====================================================================================*/
/*to view Names of Administrative Levels for a Country */
DELIMITER //
DROP PROCEDURE IF EXISTS getLevelsInCountry//
CREATE PROCEDURE getLevelsinCountry  (IN in_countryCode CHAR(3)) 
BEGIN
  SELECT * FROM LevelNames WHERE CountryCode=in_countryCode;
END //

DELIMITER ;

/*====================================================================================*/
/*to view Indicators that are Active */
DELIMITER //
DROP PROCEDURE IF EXISTS getActiveIndicators//
CREATE PROCEDURE getActiveIndicators() 
BEGIN
  SELECT * FROM Indicators WHERE IndicatorStatusID='Act';
END //

DELIMITER ;

/*====================================================================================*/
/*to view Indicators that are InActive */
DELIMITER //
DROP PROCEDURE IF EXISTS getInActiveIndicators//
CREATE PROCEDURE getInActiveIndicators() 
BEGIN
  SELECT * FROM Indicators WHERE IndicatorStatusID='Nac';
END //

DELIMITER ;

/*====================================================================================*/
/*to view facilities*/
DELIMITER //
DROP PROCEDURE IF EXISTS getFacilities//
CREATE PROCEDURE getFacilities() 
BEGIN
  SELECT * FROM Facilities;
END //

DELIMITER ;
 
/*====================================================================================*/
/*to view facilities based on the services they offer*/
DELIMITER //
DROP PROCEDURE IF EXISTS getFacilitiesbyServices//
CREATE PROCEDURE getFacilitiesbyServices (IN in_serviceID CHAR(3)) 
BEGIN
  SELECT * FROM Facilities WHERE ServiceTypeID=in_serviceID;
END //

DELIMITER ;

/*====================================================================================*/
/*to view Active facilities */
DELIMITER //
DROP PROCEDURE IF EXISTS getActiveFacilities//
CREATE PROCEDURE getActiveFacilities() 
BEGIN
  SELECT * FROM Facilities WHERE FacilityStatusID='Act';
END //

DELIMITER ;

/*====================================================================================*/
/*to view InActive facilities */
DELIMITER //
DROP PROCEDURE IF EXISTS getInActiveFacilities//
CREATE PROCEDURE getInActiveFacilities() 
BEGIN
  SELECT * FROM Facilities WHERE FacilityStatusID='Nac';
END //

DELIMITER ;

/*====================================================================================*/
/*to view Address for a Facility */
DELIMITER //
DROP PROCEDURE IF EXISTS getFacilityAddress//
CREATE PROCEDURE getFacilityAddress(IN in_facilityID INT(10)) 
 BEGIN
	  SELECT F.FacilityID,F.FacilityTypeID,
	  R.RespondentID,
	  FC.ContactID, FC.Description,
	  A.AddressTypeID,A.CountryCode,A.AULevel1ID,A.Addressline1,A.Addressline2
	  FROM Facilities F
	  LEFT JOIN Respondents R ON F.FacilityID = R.FacilityID
	  LEFT JOIN FacilityContacts FC ON F.ContactID = FC.ContactID
	  LEFT JOIN Addresses A ON R.RespondentID = A.RespondentID
	  WHERE F.FacilityID = in_facilityID;
  
 END //

 DELIMITER ;

/*===================================================================================*/
/*RETURNS the address FOR human Respondents*/
DELIMITER //
DROP PROCEDURE IF EXISTS getHumanAddress//
CREATE PROCEDURE getHumanAddress (IN in_humanID INT(10)) 
 BEGIN
	  SELECT H.HumanID,CONCAT(H.Surname, ' ' ,H.FirstName) 'Full Name',H.Sex,H.MaritalID,
	  A.AddressTypeID,A.CountryCode,A.AULevel1ID,A.RespondentID,A.Addressline1,A.Addressline2
	  FROM HumanRespondents H
	  left JOIN Respondents R ON H.HumanID = R.HumanID
	  left JOIN Addresses A ON R.RespondentID = A.RespondentID
	  WHERE H.HumanID = in_humanID;
  
 END //

 DELIMITER ;

/*====================================================================================*/
/*Returns the details for Respondents(human/Facility/Both)*/
DELIMITER //
DROP PROCEDURE IF EXISTS getRespondentsInfo //
CREATE PROCEDURE getRespondentsInfo (IN in_respondentType CHAR(10)) 
BEGIN
IF (in_respondentType='Human') THEN
SELECT r.HumanID,h.Surname,h.MiddleName,h.FirstName,h.DateOfBirth,h.Sex,h.MaritalID,a.AddressTypeID, a.AddressLine1,a.AddressLine2 FROM HumanRespondents h  
JOIN Respondents r ON r.humanID=h.humanID
LEFT JOIN Addresses a ON a.RespondentID=r.RespondentID;

ELSE
IF (in_respondentType='Facility') THEN
SELECT r.FacilityID,f.FacilityTypeID,f.ContactID,f.FacilityStatusID,f.ServiceTypeID,a.AddressTypeID, a.AddressLine1,a.AddressLine2 FROM Facilities f  
JOIN Respondents r ON r.facilityID=f.facilityID
LEFT JOIN Addresses a ON a.RespondentID=r.RespondentID;

ELSE 
SELECT r.RespondentID,r.HumanID,r.FacilityID,h.Surname,h.MiddleName,h.FirstName,h.Sex,h.MaritalID,f.facilityTypeID,f.ContactID,a.AddressLine1,a.AddressLine2 from Respondents r 
JOIN HumanRespondents h on r.HumanID=h.HumanID
JOIN Facilities f on f.FacilityID=r.FacilityID
LEFT JOIN Addresses a ON a.RespondentID=r.RespondentID;

END IF;
END IF;
END //

DELIMITER ;

/*=====================================================================*/
/*It returns all Permissions assigned to a Role*/
DELIMITER //
DROP PROCEDURE IF EXISTS getRolePermission //
CREATE PROCEDURE getRolePermission(IN inRoleID VARCHAR(20))
BEGIN 
	SELECT P.PermissionID, P.RoleID, PT.Description, PT.PermissionID 
	FROM Permissions P JOIN PermissionTypes PT 
	ON P.PermissionID = PT.PermissionID
	WHERE RoleID = inRoleID;
END //

DELIMITER ;

/*=====================================================================*/
/*Get all Users*/
DELIMITER //
DROP PROCEDURE IF EXISTS getUsers //
CREATE PROCEDURE getUsers()
BEGIN
	SELECT * FROM Users;
END //

DELIMITER ;

/*=====================================================================*/
/*Get Measures from Indicator*/
DELIMITER //
DROP PROCEDURE IF EXISTS getMeasureForIndicator //
CREATE PROCEDURE getMeasureForIndicator(IN in_IndicatorID VARCHAR(20))
BEGIN
	SELECT * FROM Measures WHERE IndicatorID=in_IndicatorID;
END //

DELIMITER ;

/*=====================================================================*/
/*To get Active IndicatorClass*/
DELIMITER //
DROP PROCEDURE IF EXISTS getIndicatorClass //
CREATE PROCEDURE getIndicatorClass()
BEGIN
	SELECT * FROM IndicatorClasses;

END //

DELIMITER ;

/*======================================================================*/
/*Get members of a particular team*/
DELIMITER //
DROP PROCEDURE IF EXISTS getTeamMembers //
CREATE PROCEDURE getTeamMembers(IN in_teamID varchar(5))
BEGIN
	  SELECT * FROM TeamMembers 
	  Where TeamID = in_teamID;

END //

DELIMITER ;

/*============================================================*/
/*Get all permission assigned to a role*/
DELIMITER //
DROP PROCEDURE IF EXISTS getPermission //
CREATE PROCEDURE getPermission(IN in_RoleID varchar(20))
BEGIN
  SELECT p.RoleID, pt.PermissionID, pt.Description 
  FROM Permissions p
  JOIN PermissionTypes pt 
  ON p.PermissionID = pt.PermissionID
  Where RoleID = in_RoleID;
END //

DELIMITER ;

/*=====================================================*/
/*Get all logged-in and logged-out users*/
DELIMITER //
DROP PROCEDURE IF EXISTS getUserLogin //
CREATE PROCEDURE getUserLogin()
BEGIN 
  SELECT concat(u.Surname, '  ' ,u.FirstName) as 'Full Name', ul.UserName,u.RoleID, ul.LoginTime, ul.LogoutTime
  FROM UserLogin ul
  JOIN Users u 
  ON ul.UserName = u.UserName;
END //

DELIMITER ;

/*=====================================================*/
/*Get user information and permissions assigned to a user*/
DELIMITER //
DROP PROCEDURE IF EXISTS getUserPermission //
CREATE PROCEDURE getUserPermission(IN in_Username varchar(30))
BEGIN
	  SELECT u.UserName, concat(u.Surname, ' ' ,u.FirstName) as 'Full Name', u.RoleID,p.PermissionID, pt.Description, u.UserStatusID 
	  FROM Users u
	  JOIN Permissions p on u.RoleID=p.RoleID
	  JOIN PermissionTypes pt on p.PermissionID=pt.PermissionID
	  WHERE UserName = in_Username;
END //

DELIMITER ;

/*=======================================================================*/
/*Get all AULevel2 in AULevel1*/
DELIMITER //
DROP PROCEDURE IF EXISTS getAULevel2 //
CREATE PROCEDURE getAULevel2 (IN in_AUL1ID VARCHAR(5)) 
BEGIN
	  SELECT * FROM AULevel2 
	  WHERE AULevel1ID=in_AUL1ID;
END //

DELIMITER ;

/*==================================================================================*/
/*Get information from AULevel3 that is unquie to a an AULevel2ID*/
DELIMITER //
DROP PROCEDURE IF EXISTS getAULevel3 //
CREATE PROCEDURE getAULevel3 (IN in_AUL1ID VARCHAR(5), IN in_AUL2ID VARCHAR(5)) 
BEGIN
  SELECT * FROM AULevel3 WHERE AULevel1ID=in_AUL1ID AND AULevel2ID= in_AUL2ID;
END //

DELIMITER ;

/*==================================================================================*/
/*Select all from AULevel3*/
DELIMITER //
DROP PROCEDURE IF EXISTS getAllAULevel3 //
CREATE PROCEDURE getAllAULevel3() 
BEGIN
  SELECT * FROM AULevel3; 
END //

DELIMITER ;

/*==================================================================================*/
/*Select all from AULevel2*/
DELIMITER //
DROP PROCEDURE IF EXISTS getAllAULevel2 //
CREATE PROCEDURE getAllAULevel2() 
BEGIN
  SELECT * FROM AULevel2; 
END //

DELIMITER ;
  
/*==================================================================================*/
/*Select all from AULevel1*/
DELIMITER //
DROP PROCEDURE IF EXISTS getAllAULevel1 //
CREATE PROCEDURE getAllAULevel1() 
BEGIN
  SELECT * FROM AULevel1; 
END //

DELIMITER ;

/*==================================================================================*/
/*Update existing address */
DELIMITER //
DROP PROCEDURE IF EXISTS updateAddress //
CREATE PROCEDURE updateAddress(IN in_AddressID INT(11),
				IN in_AddressTypeID VARCHAR(5),
				IN in_CountryCode CHAR(3),
				IN in_AULevel1ID VARCHAR(5),
				IN in_AULevel2ID VARCHAR(5),
				IN in_AULevel3ID VARCHAR(5),
				IN in_RespondentID INT(11),
				IN in_Addressline1 VARCHAR(255),
				IN in_Addressline2 VARCHAR(255),
				IN in_Username VARCHAR(30),
				IN in_permission VARCHAR(30))
BEGIN
	
	IF (checkLoginStatus(in_Username)) THEN
             IF (checkPermission(in_Username,in_permission)) THEN
				IF checkActiveUser(in_Username) THEN
	

				UPDATE Addresses
				SET AddressID = in_AddressID,
				    AddressTypeID = in_AddressTypeID,
				    CountryCode = in_CountryCode,
				    AULevel1ID = in_AULevel1ID,
				    AULevel2ID = in_AULevel2ID,
				    AULevel3ID = in_AULevel3ID,
				    RespondentID = in_RespondentID,
				    Addressline1 = in_Addressline1,
				    Addressline2 = in_Addressline2,
				    ModifiedBy = in_Username
				WHERE AddressID = in_AddressID ;
				
				
	                           ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              
END //

DELIMITER ;

/*=============================================================================================*/
/*Update existing Facility information*/
DELIMITER //
DROP PROCEDURE IF EXISTS updateFacility //
CREATE PROCEDURE updateFacility(IN in_FacilityID INT(11),
				IN in_FacilityTypeID CHAR(3),
				IN in_ContactID INT(11),
				IN in_FacilityStatusID CHAR(3),
				IN in_ServiceTypeID CHAR(3),
				IN in_Username VARCHAR(30),
				IN in_permission VARCHAR(30))
BEGIN
	
	IF (checkLoginStatus(in_Username)) THEN
             IF (checkPermission(in_Username,in_permission)) THEN
				IF checkActiveUser(in_Username) THEN
	

				UPDATE Facilities
				SET FacilityID = in_FacilityID,
				FacilityTypeID = in_FacilityTypeID,
				ContactID = in_ContactID,
				FacilityStatusID = in_FacilityStatusID,
				ServiceTypeID = in_ServiceTypeID,
				ModifiedBy = in_Username
				WHERE FacilityID = in_FacilityID ;
				
				
	                           ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              
END //

DELIMITER ;

/*=========================================================================================*/
/*Update existing Users information*/
DELIMITER //
DROP PROCEDURE IF EXISTS updateUsers //
CREATE PROCEDURE updateUsers(IN in_Username VARCHAR(30),
				IN in_Surname VARCHAR(32),
				IN in_FirstName VARCHAR(32),
				IN in_SourceID CHAR(10),
				IN in_RoleID VARCHAR(20),
				IN inUserName varchar(30),
				IN in_permission VARCHAR(30))
BEGIN
	
	IF (checkLoginStatus(inUserName)) THEN
             IF (checkPermission(inUserName,in_permission)) THEN
				IF checkActiveUser(inUserName) THEN
	

				UPDATE Users
				SET UserName = in_Username,
				Surname = in_Surname,
				FirstName = in_FirstName,
				SourceID = in_SourceID,
				RoleID = in_RoleID
				WHERE Username = in_Username;
				
				
	                           ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              
END //

DELIMITER ;			    

/*=========================================================================================*/
/*Update human respondent information*/
DELIMITER //
DROP PROCEDURE IF EXISTS updateHumanRespondents//
CREATE PROCEDURE updateHumanRespondents(IN in_HumanID INT(11),
				IN in_Surname VARCHAR(32),
				IN in_middleName VARCHAR(32),
				IN in_FirstName VARCHAR(32),
				IN in_DateOfBirth Date,
				IN in_Sex CHAR(1),
				IN in_maritalID char(5),
				IN inUserName VARCHAR(30),
				IN in_permission VARCHAR(30))
BEGIN
	
	IF (checkLoginStatus(inUserName)) THEN
             IF (checkPermission(inUserName,in_permission)) THEN
				IF checkActiveUser(inUserName) THEN
	

				UPDATE HumanRespondents
				SET HumanID = in_HumanID,
				Surname = in_Surname,
				MiddleName = in_middleName,
				FirstName = in_FirstName,
				DateOfBirth = in_DateOfBirth,
				Sex = in_Sex,
				MaritalID = in_maritalID,
				ModifiedBy = inUserName
				WHERE HumanID = in_HumanID;
				
				
	                           ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              
END //

DELIMITER ;

/*=========================================================================================*/
/*Update team respondent information*/
DELIMITER //
DROP PROCEDURE IF EXISTS updateTeamRespondents//
CREATE PROCEDURE updateTeamRespondents(IN in_RespondentID INT(11),
				IN in_TeamID VARCHAR(5),
				IN inUserName VARCHAR(30),
				IN in_permission VARCHAR(30))
BEGIN
	
	IF (checkLoginStatus(inUserName)) THEN
             IF (checkPermission(inUserName,in_permission)) THEN
				IF checkActiveUser(inUserName) THEN
	

				UPDATE TeamRespondents
				SET RespondentID = in_RespondentID,
				TeamID = in_TeamID,
				ModifiedBy = inUserName
				WHERE  RespondentID = in_RespondentID;
				
				
	                           ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              
END //

DELIMITER ;

/*==============================================================*/
/*Update user roles*/
DELIMITER //
DROP PROCEDURE IF EXISTS updateUserRole//
CREATE PROCEDURE updateUserRole(IN in_RoleID VARCHAR(20),
				IN in_Description VARCHAR(50),
				IN inUserName VARCHAR(30),
				IN in_permission VARCHAR(30))
BEGIN
	
	IF (checkLoginStatus(inUserName)) THEN
             IF (checkPermission(inUserName,in_permission)) THEN
				IF checkActiveUser(inUserName) THEN
	

				UPDATE UserRoles
				SET RoleID = in_RoleID,
				Description = in_Description
				WHERE  RoleID = in_RoleID;
				
				
	                           ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              
END //

DELIMITER ;

/*==============================================================*/
/*Update Questions*/
DELIMITER //
DROP PROCEDURE IF EXISTS updateQuestions//
CREATE PROCEDURE updateQuestions(IN in_QuestionID INT(5),
				IN in_IndicatorID CHAR(10),
				IN in_QuestionStatusID CHAR(3),
				IN in_Description varchar(255),
				IN in_instructions varchar(255),
				IN in_Hint varchar(255),
				IN in_TypeID CHAR(3),
				IN inUserName VARCHAR(30),
				IN in_permission VARCHAR(30))
BEGIN
	
	IF (checkLoginStatus(inUserName)) THEN
             IF (checkPermission(inUserName,in_permission)) THEN
				IF checkActiveUser(inUserName) THEN
	

				UPDATE Questions
				SET QuestionID = in_QuestionID,
				IndicatorID = in_IndicatorID,
				QuestionStatusID = in_QuestionStatusID,
				Description = in_Description,
				Instructions = in_Instructions,
				Hint = in_Hint,
				TypeID = in_TypeID,
				ModifiedBy = inUserName
				WHERE  QuestionID = in_QuestionID;
				
				
	                           ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              
END //

DELIMITER ;

/*==============================================================*/
/*Update Indicators*/
DELIMITER //
DROP PROCEDURE IF EXISTS updateIndicators //
CREATE PROCEDURE updateIndicators(IN in_IndicatorID char(10),
				IN in_Name varchar(20),
				IN in_IndicatorStatusID char(3),
				IN in_IndicatorClassID char(10),
				IN inUserName varchar(30),
				IN in_permission varchar(30))
BEGIN
	
	IF (checkLoginStatus(inUserName)) THEN
             IF (checkPermission(inUserName,in_permission)) THEN
				IF checkActiveUser(inUserName) THEN
	

				UPDATE Indicators
				SET IndicatorID = in_IndicatorID,
				Name = in_Name,
				IndicatorStatusID = in_IndicatorStatusID,
				IndicatorClassID = in_indicatorClassID,
				ModifiedBy = inUserName
				WHERE  IndicatorID = in_IndicatorID;
				
				
	                           ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              
END //

DELIMITER ;

/*=====================================*/
/*Update indicator class*/
DELIMITER //
DROP PROCEDURE IF EXISTS updateIndicatorClass//
CREATE PROCEDURE updateIndicatorClass(IN in_IndicatorClassID char(10),
				IN in_Description varchar(100),
				IN inUserName varchar(30),
				IN in_permission varchar(30))
BEGIN
	
	IF (checkLoginStatus(inUserName)) THEN
             IF (checkPermission(inUserName,in_permission)) THEN
				IF checkActiveUser(inUserName) THEN
	

				UPDATE IndicatorClasses
				SET IndicatorClassID = in_indicatorClassID,
				Description = in_Description
				WHERE  IndicatorClassID = in_IndicatorClassID;
				
				
	                           ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              
END //

DELIMITER ;

/*=====================================*/
/*Update Measure*/
DELIMITER //
DROP PROCEDURE IF EXISTS updateMeasures//
CREATE PROCEDURE updateMeasures(IN in_ScheduleID varchar(16),
				IN in_QuestionID int(11),
				IN in_IndicatorID varchar(16),
				IN in_DateOfMeasurement date,
				IN in_CollectedOn date,
				IN in_CollectedBy varchar(16),
				IN in_TeamID varchar(16),
				IN in_Score int(11),
				IN in_RespondentID int(11),
				IN inUserName varchar(30),
				IN in_permission varchar(30))
BEGIN
	
	IF (checkLoginStatus(inUserName)) THEN
             IF (checkPermission(inUserName,in_permission)) THEN
				IF checkActiveUser(inUserName) THEN
	

				UPDATE Measures
				SET ScheduleID = in_ScheduleID,
				QuestionID = in_QuestionID,
				IndicatorID = in_IndicatorID, 
				DateOfMeasurement = in_DateOfMeasurement,
				CollectedOn = in_CollectedOn,
				CollectedBy = in_CollectedBy,
				TeamID = in_TeamID,
				Score = in_Score,
				RespondentID = in_RespondentID,
				ModifiedBy = inUserName
				WHERE  ScheduleID = in_ScheduleID;
				
				
	                           ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              
END //

DELIMITER ;

/*===================================================================================================*/
/*Update Respondents*/
DELIMITER //
DROP PROCEDURE IF EXISTS updateRespondent //
CREATE PROCEDURE updateRespondent(IN in_RespondentID INT(11),
				  IN in_Description VARCHAR(20),
				  IN in_FacilityID INT(11),
				  IN in_HumanID INT(11),
				  IN in_Username VARCHAR(30),
				  IN in_Permission VARCHAR(30))
BEGIN

		IF (checkLoginStatus(in_Username)) THEN
                              IF (checkPermission(in_Username,in_permission)) THEN
				                   IF checkActiveUser(in_Username) THEN
				                   
				   
				  UPDATE Respondents
				  SET RespondentID = in_RespondentID,
				      Description = in_Description,
				      FacilityID = in_FacilityID,
				      HumanID = in_HumanID,
				      ModifiedBy = in_Username
				      WHERE RespondentID = in_RespondentID;
				      

	                           ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              
END //

DELIMITER ;

/*===================================================================================*/
/*Update teams*/
DELIMITER //
DROP PROCEDURE IF EXISTS updateTeam //
CREATE PROCEDURE updateTeam(IN in_TeamID VARCHAR(5),
			    IN in_Description VARCHAR(32),
			    IN in_Username varchar(30),
			    IN in_permission varchar(30))
BEGIN
        IF (checkLoginStatus(in_Username)) THEN
                   IF (checkPermission(in_Username,in_permission)) THEN
				    IF checkActiveUser(in_Username) THEN
								   
						UPDATE Teams
						SET TeamID = in_TeamID,
						    Description = in_Description
						WHERE TeamID = in_TeamID ;


	                           ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              
END //

DELIMITER ;	

/*====================================================*/
DELIMITER //
DROP PROCEDURE IF EXISTS updateScheduleActiveIndicator //
CREATE PROCEDURE  updateScheduleActiveIndicator(IN in_ScheduleID VARCHAR(16),
						IN in_QuestionID INT(11),
						IN in_IndicatorStatusID CHAR(3),
						IN in_IndicatorID CHAR(10),
						IN in_StartDate DATE,
						IN in_EndDate DATE,
						IN in_MinimumScoreValue INT(11),
						IN in_MaximumScoreValue INT(11),
						IN in_FrequencyID CHAR(3),
						IN in_MethodOfMeasureID VARCHAR(8),
						IN in_Username VARCHAR(30),
						IN in_permission VARCHAR(30))
BEGIN
     
	       IF (checkLoginStatus(in_Username)) THEN
			   IF (checkPermission(in_Username,in_permission)) THEN
					       IF checkActiveUser(in_Username) THEN
					       
					       
					       UPDATE ScheduleActiveIndicators
					       SET ScheduleID = in_ScheduleID,
					           QuestionID = in_QuestionID,
					           IndicatorStatusID = in_IndicatorStatusID,
					           IndicatorID = in_IndicatorID,
					           StartDate = in_StartDate,
					           EndDate = in_EndDate,
					           MinimumScoreValue = in_MinimumScoreValue,
					           MaximumScoreValue = in_MaximumScoreValue,
					           FrequencyID = in_FrequencyID,
					           MethodOfMeasureID = in_MethodOfMeasureID,
					           ModifiedBy = in_Username
					     WHERE ScheduleID = in_ScheduleID;
					           

	                           ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              
END //

DELIMITER ;		

/*=====================================================================================================*/
DELIMITER //
DROP PROCEDURE IF EXISTS updateFreaquencyOfMeasures //
CREATE PROCEDURE updateFreaquencyOfMeasures(IN in_FrequencyID CHAR(3),
					    IN in_Description VARCHAR(32),
					    IN in_EffectiveStartDate DATE,
					    IN in_EffectiveEndDate DATE,
					    IN in_Username VARCHAR(30),
					    IN in_permission VARCHAR(30))
BEGIN 
     IF (checkLoginStatus(in_Username)) THEN
                   IF (checkPermission(in_Username,in_permission)) THEN
				      IF checkActiveUser(in_Username) THEN
				      
				      UPDATE FrequencyOfMeasures
				      SET FrequencyID = in_FrequencyID,
				          Description = in_Description,
				          EffectiveStartDate = in_EffectiveStartDate,
				          EffectiveEndDate =  in_EffectiveEndDate
				    WHERE FrequencyID = in_FrequencyID;
				    
	                           ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              
END //

DELIMITER ;		

/*=================================================================================================*/
DELIMITER //
DROP PROCEDURE IF EXISTS updateFacilityContact //
CREATE PROCEDURE updateFacilityContact(IN in_ContactID VARCHAR(50),
				       IN in_ContactEmail VARCHAR(32),
				       IN in_PhoneNumber VARCHAR(32),
				       IN in_Surname VARCHAR(32),
				       IN in_FirstName VARCHAR(32),
				       IN in_MiddleName VARCHAR(32),
				       IN in_Username VARCHAR(30),
				       IN in_permission VARCHAR(30))
BEGIN 
     IF (checkLoginStatus(in_Username)) THEN
                   IF (checkPermission(in_Username,in_permission)) THEN
				      IF checkActiveUser(in_Username) THEN
	                              
				      
				          UPDATE FacilityContacts
				          SET ContactID = in_ContactID,
				              ContactEmail = in_ContactEmail,
				              PhoneNumber = in_PhoneNumber,
				              Surname = in_Surname,
				              FirstName =  in_FirstName,
				              MiddleName = in_MiddleName
				          WHERE ContactID = in_ContactID;
				          
  
	                           ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              
END //

DELIMITER ;

/*=================================================================================================*/
DELIMITER //
DROP PROCEDURE IF EXISTS updateTeamMember //
CREATE PROCEDURE updateTeamMember(IN in_TeamID VARCHAR(5),
				  IN in_Username VARCHAR(20),
				  IN in_TeamLead VARCHAR(20),
				  IN inUsername VARCHAR(30),
				  IN in_permission VARCHAR(30))
BEGIN 
     IF (checkLoginStatus(in_Username)) THEN
                   IF (checkPermission(in_Username,in_permission)) THEN
				  IF checkActiveUser(in_Username) THEN
							      UPDATE TeamMembers
							      SET TeamID = in_TeamID,
								  Username = in_Username,
								  TeamLead =  in_TeamLead,
								  ModifiedBy = inUsername
							      WHERE TeamID = in_TeamID;
                                      
                                   ELSE
				   SIGNAL SQLSTATE '45000'
				   SET MESSAGE_TEXT =  '-45000: Status: User  Not Active';
				   END IF;
				   
		  ELSE
		  SIGNAL SQLSTATE '45000'
		  SET MESSAGE_TEXT =  '-45000: Permission: Permission Denied';
                  END IF;
                  
    ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  '-45000: loginUser: User Not Logged In';
    END IF;              
END //

DELIMITER ;
