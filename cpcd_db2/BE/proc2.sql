-- cpcd project
-- voti@quanteq.com
-- 17/03/14

-- ========================
-- Returns all menu from the database.
Delimiter //
Drop Procedure If Exists getAllMenu //
Create Procedure getAllMenu()
Begin
 Select MenuID, Description From Menu;
End //
Delimiter ;

-- =========================
-- Returns a specific menu from the database. 
Delimiter //
Drop Procedure If Exists getMenu //
Create Procedure getMenu(In in_MenuID Varchar(16))
Begin
 Select MenuID, Description From Menu
 Where MenuID = in_MenuID;
End //
Delimiter ;

-- =========================
-- Returns Menu Link for a specific LinkID from the database.
Delimiter //
Drop Procedure If Exists getMenuLink //
Create Procedure getMenuLink(in_MenuID Varchar(16))
Begin
 Select A.LinkID,A.Description,A.MenuID,B.Description,A.url
 From MenuLink A
 Left Join Menu B On A.MenuID = B.MenuID
 Where A.MenuID = in_MenuID;
End //
Delimiter ;

-- ==========================
-- Returns all permission from the database.
Delimiter //
Drop Procedure If Exists getAllPermission //
Create Procedure getAllPermission()
Begin
 Select A.RoleID,B.Description,A.`Mode`,A.LinkID,C.Description
 From Permission A
 Left Join UserRole B On A.RoleID = B.RoleID
 Left Join MenuLink C On A.LinkID = A.LinkID;
End //
Delimiter ;

-- ==========================
-- Returns permission for a specific role from the database.
Delimiter //
Drop Procedure If Exists getPermission //
Create Procedure getPermission(In in_RoleID Varchar(5))
Begin 
 Select A.RoleID,C.Description,A.`Mode`,A.LinkID,B.Description,B.MenuID,D.Description,B.url
 From Permission A
 Left Join MenuLink B On A.LinkID = B.LinkID
 Left Join UserRole C On A.RoleID = C.RoleID
 Left Join Menu D On B.MenuID = D.MenuID
 Where A.RoleID = in_RoleID;
End //
Delimiter ;

-- ==========================
-- Returns all the roles from the database.
Delimiter //
Drop Procedure If Exists getAllRoles //
Create Procedure getAllRoles()
Begin
 Select RoleID,Name,Description From UserRole;
End //
Delimiter ;

-- ==========================
-- Returns  roles from the database.
Delimiter //
Drop Procedure If Exists getRole //
Create Procedure getRole(In in_RoleID Varchar(5))
Begin
 Select RoleID,Name,Description From UserRole
 Where RoleID = in_RoleID;
End //
Delimiter ;

-- ==========================
-- Returns all user from the database.
Delimiter //
Drop Procedure If Exists getAllUser //
Create Procedure getAllUser()
Begin
 Select User,Surname,Otherames,RoleID,Description,Password 
 From User A
 Left Join UserRole B On A.RoleID = B.RoleID;
End //
Delimiter ;

-- ========================
-- Returns User with a specific id from the database

DELIMITER //
DROP PROCEDURE IF EXISTS getUser //
CREATE PROCEDURE getUser
		      ( IN in_User VARCHAR(16))

BEGIN

      SELECT A.Surname,A.Othernames,A.RoleID,B.Description FROM User A
      Left Join UserRole B On A.RoleID = B.RoleID
      WHERE A.User = in_User;
      
END //

DELIMITER ;

-- ========================
-- returns all gender from the database
Delimiter //
Drop Procedure If Exists getGender //
Create Procedure getGender()
Begin
 Select Sex,Description From Gender;
End //
Delimiter ;
-- =========================
-- Returns details for a specific driver from the database.
Delimiter //
Drop Procedure If Exists getDriver //
Create Procedure getDriver(In in_DriverID Varchar(16))
Begin
 Select A.DriverID,A.Surname,A.Othernames,A.DateOfBirth,A.PhoneNumber,A.LicenseNumber,
        A.Email,A.DateOfLicenseFirstIssue,A.DateOfCurLicenseFirstIssue,A.DateOfExpiryOfCurLicense,
        A.Sex,A.CurLicenseClass,A.PlaceOfReg,B.Name
 From Driver A
 Left Join FRSCSectorCommand B On A.PlaceOfReg = B.SectorCode
 Where DriverID = in_DriverID;
End //
Delimiter ;

-- ==========================
-- Returns all the drivers information from the database

DELIMITER //
DROP PROCEDURE IF EXISTS getAllDriver //
CREATE PROCEDURE getAllDriver(IN in_PlaceOfReg VARCHAR(16))			
BEGIN
	SELECT DriverID,Surname,Othernames,DateOfBirth,PhoneNumber,LicenseNumber,Email,DateOfLicenseFirstIssue,
        DateOfExpiryOfCurLicense,
        Sex,CurLicenseClass   
	FROM Driver
	WHERE PlaceOfReg = in_PlaceOfReg;

END //
DELIMITER ;
-- ==========================
-- Returns all relationship types from the database

DELIMITER //
DROP PROCEDURE IF EXISTS getAllRelationship //
CREATE PROCEDURE getAllRelationship()
			  
BEGIN

	SELECT RelationID,Description FROM RelationshipType;
	
END //
DELIMITER ;

-- ==========================
-- Returns a driver's NOK from the database

DELIMITER //
DROP PROCEDURE IF EXISTS getDriverNOK //
CREATE PROCEDURE getDriverNOK
			    (IN in_DriverID VARCHAR(16))
			  
BEGIN
	SELECT n.NokID, n.Surname, n.Othernames, n.RelationID, r.Description, n.PhoneNumber 
	FROM NOK n Left JOIN RelationshipType r ON n.RelationID = r.RelationID
        Where DriverID = in_DriverID;

END //
DELIMITER ;

-- =========================
-- Returns a specific FRSCSectorCommand from the database.
Delimiter //
Drop Procedure If Exists getFRSCSectorCommand //
Create Procedure getFRSCSectorCommand(In in_SectorCode Varchar(16))
Begin
 Select SectorCode,Name,Officer,EmailAddress,AddressLine1,AddressLine2
 From FRSCSectorCommand
 Where SectorCode = in_SectorCode;
End //
Delimiter ;

-- =========================
-- Returns all FRSCSectorCommand from the database.
Delimiter //
Drop Procedure If Exists getAllFRSCSectorCommand //
Create Procedure getAllFRSCSectorCommand()
Begin
 Select SectorCode,Name,Officer,EmailAddress,AddressLine1,AddressLine2
 From FRSCSectorCommand;
End //
Delimiter ;

-- =========================
-- Returns all sector instructor from the database.
Delimiter //
Drop Procedure If Exists getAllSectorInstructor //
Create Procedure getAllSectorInstructor()
Begin
 Select InstructorID,SectorCode,Surname,Othernames
 From SectorInstructor;
End //
Delimiter ;

-- =========================
-- Returns a specific Sector instructor from the database

DELIMITER //
DROP PROCEDURE IF EXISTS getSectorInstructor //
CREATE PROCEDURE getSectorInstructor
				 (IN in_InstructorID VARCHAR(16))

BEGIN
    SELECT InstructorID,SectorCode,Surname,Othernames FROM SectorInstructor
    WHERE InstructorID = in_InstructorID;

END //
DELIMITER ;

-- =========================
-- Returns information for a specified  Module from the database
Delimiter //
Drop Procedure If Exists getModule //
Create Procedure getModule(In in_ModuleID Char(1))
Begin
 Select ModuleID,Description From Module
 Where ModuleID = in_ModuleID;
End //
Delimiter ;

-- =======================
-- Returns a specific module from the database

DELIMITER //
DROP PROCEDURE IF EXISTS getModuleSubType //
CREATE PROCEDURE getModuleSubType
			( IN in_ModuleID CHAR(1))

BEGIN
      SELECT ModuleID,Description,MaxTime,MaxScore FROM ModuleSubType
      WHERE ModuleID = in_ModuleIDID;

END //
DELIMITER ;

-- ==============================
-- returns training for a driver within the specified time.
DELIMITER //
DROP PROCEDURE IF EXISTS getTraining //
CREATE PROCEDURE getTraining ( IN in_StartDate DATETIME,IN in_EndDate DATETIME,IN in_DriverID VARCHAR(16))			  
BEGIN
 Set @Sdate = (select MIN(DateOfTraining) From Training Where DriverID = in_DriverID);
 set @Edate = '2020-00-00 00:00:00';
 
	 If in_StartDate = '0000-00-00 00:00:00' AND in_EndDate = '0000-00-00 00:00:00' Then
		Select  A.DriverID,
			B.Surname,
			B.Othernames,
			A.InstructorID,C.Surname,C.Othernames,A.SectorCode,D.Name,A.NoOfHours,
			A.Score,A.ModuleSubTypeID,E.Description,A.ModuleID,F.Description,A.DateOfTraining,A.DateOfCompletion
                From Training A
                Left Join Driver B On A.DriverID = B.DriverID
		Left Join SectorInstructor C On A.InstructorID = C.InstructorID AND A.SectorCode = C.SectorCode
		Left Join FRSCSectorCommand D On C.SectorCode =  D.SectorCode
		Left Join ModuleSubType E On A.ModuleID = E.ModuleID AND A.ModuleSubTypeID = E.ModuleSubTypeID
		Left Join Module F On E.ModuleID = F.ModuleID
		Where A.DateOfTraining Between @Sdate AND @Edate AND A.DriverID = in_DriverID;
 Else
 
	 If in_StartDate = '0000-00-00 00:00:00' AND in_EndDate <> '' Then
		Select  A.DriverID,
			B.Surname,
			B.Othernames,
			A.InstructorID,C.Surname,C.Othernames,A.SectorCode,D.Name,A.NoOfHours,
			A.Score,A.ModuleSubTypeID,E.Description,A.ModuleID,F.Description,A.DateOfTraining,A.DateOfCompletion
                From Training A
                Left Join Driver B On A.DriverID = B.DriverID
		Left Join SectorInstructor C On A.InstructorID = C.InstructorID AND A.SectorCode = C.SectorCode
		Left Join FRSCSectorCommand D On C.SectorCode =  D.SectorCode
		Left Join ModuleSubType E On A.ModuleID = E.ModuleID AND A.ModuleSubTypeID = E.ModuleSubTypeID
		Left Join Module F On E.ModuleID = F.ModuleID
		Where A.DateOfTraining Between @Sdate AND in_EndDate AND A.DriverID = in_DriverID;
Else

	 If in_StartDate <> '' AND in_EndDate = '0000-00-00 00:00:00' Then
		Select  A.DriverID,
			B.Surname,
			B.Othernames,
			A.InstructorID,C.Surname,C.Othernames,A.SectorCode,D.Name,A.NoOfHours,
			A.Score,A.ModuleSubTypeID,E.Description,A.ModuleID,F.Description,A.DateOfTraining,A.DateOfCompletion
                From Training A
                Left Join Driver B On A.DriverID = B.DriverID
		Left Join SectorInstructor C On A.InstructorID = C.InstructorID AND A.SectorCode = C.SectorCode
		Left Join FRSCSectorCommand D On C.SectorCode =  D.SectorCode
		Left Join ModuleSubType E On A.ModuleID = E.ModuleID AND A.ModuleSubTypeID = E.ModuleSubTypeID
		Left Join Module F On E.ModuleID = F.ModuleID
		Where A.DateOfTraining Between in_StartDate AND @Edate AND A.DriverID = in_DriverID;
Else

	 If in_StartDate <> '' AND in_EndDate <> '' Then
			Select  A.DriverID,
			B.Surname,
			B.Othernames,
			A.InstructorID,C.Surname,C.Othernames,A.SectorCode,D.Name,A.NoOfHours,
			A.Score,A.ModuleSubTypeID,E.Description,A.ModuleID,F.Description,A.DateOfTraining,A.DateOfCompletion
		        From Training A
		        Left Join Driver B On A.DriverID = B.DriverID
			Left Join SectorInstructor C On A.InstructorID = C.InstructorID AND A.SectorCode = C.SectorCode
			Left Join FRSCSectorCommand D On C.SectorCode =  D.SectorCode
			Left Join ModuleSubType E On A.ModuleID = E.ModuleID AND A.ModuleSubTypeID = E.ModuleSubTypeID
			Left Join Module F On E.ModuleID = F.ModuleID
			Where A.DateOfTraining Between in_StartDate AND in_EndDate AND A.DriverID = in_DriverID;
Else 


	                Select  A.DriverID,
			B.Surname,
			B.Othernames,
			A.InstructorID,C.Surname,C.Othernames,A.SectorCode,D.Name,A.NoOfHours,
			A.Score,A.ModuleSubTypeID,E.Description,A.ModuleID,F.Description,A.DateOfTraining,A.DateOfCompletion
		        From Training A
		        Left Join Driver B On A.DriverID = B.DriverID
			Left Join SectorInstructor C On A.InstructorID = C.InstructorID AND A.SectorCode = C.SectorCode
			Left Join FRSCSectorCommand D On C.SectorCode =  D.SectorCode
			Left Join ModuleSubType E On A.ModuleID = E.ModuleID AND A.ModuleSubTypeID = E.ModuleSubTypeID
			Left Join Module F On E.ModuleID = F.ModuleID
                        Where A.DriverID = in_DriverID;
	End If ;
	 	End IF;
	 		 End If;
	   			End If;
End //
Delimiter ;
-- =============================

