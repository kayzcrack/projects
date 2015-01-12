-- cpcd project
-- voti@quanteq.com
-- 17/03/14

-- =================================

-- Adds a new menu to the database.
Delimiter //
Drop procedure if Exists addMenu //
Create Procedure Addmenu(In in_MenuID Varchar(16), In in_Description Varchar(128))
Begin 
 insert into Menu(MenuID, Description) Values(in_MenuID, in_Description);
End //
Delimiter ;

-- ===================================
-- Adds menu link to the database.
Delimiter //
Drop Procedure If Exists addmenuLink //
Create Procedure AddMenuLink(In in_LinkID Varchar(5), In in_Description Varchar(255),In in_MenuID Varchar(16), In in_url Varchar(255))
Begin
 Insert into MenuLink(LinkID, Description, MenuID, url)
 Values(in_LinkID, in_Description, in_MenuID, in_url); 
End //
Delimiter ;

-- ===================================
-- Adds a new permission to the database.
Delimiter // 
Drop Procedure If Exists addPermission //
Create Procedure AddPermission(In in_RoleID Varchar(5), In in_Mode Varchar(16), In in_LinkID Varchar(5))
Begin
 Insert into Permission(RoleID, `Mode`,LinkID)
 Values(in_RoleID, in_Mode, in_LinkID);
End //
Delimiter ;

-- ===================================
-- Adds a new role to the database
Delimiter //
Drop Procedure If Exists addRole //
Create Procedure AddRole(In in_RoleID Varchar(5), In in_Name Varchar(128), In in_Description Varchar(32))
Begin
 Insert into UserRole(RoleID, Name, Description)
 Values (in_RoleID, in_Name, in_Description);
End// 
Delimiter ;
-- ==================================
-- Adds a new user to the database.
Delimiter // 
Drop Procedure If Exists addUser //
Create Procedure AddUser(In in_User Varchar(16),In in_Surname varchar(32),In in_Othernames Varchar(32),In in_RoleID Varchar(5),
                                                                    In in_SectorCode Varchar(16) ,In in_Password varchar(255))
Begin 
 Insert Into User
 Values(in_User, in_Surname, in_Othernames, in_RoleID,in_SectorCode, password(in_Password));
End //
Delimiter ;
-- ================================
-- Adds a new driver to the database
-- note generate DriverIDe
Delimiter // 
Drop Procedure If Exists addDriver //
Create Procedure AddDriver(
In in_Surname varchar(32),
In in_Othernames varchar(32),
In in_DateOfBirth DATE,
In in_PhoneNumber varchar(16),
In in_LicenseNumber varchar(64),
In in_Email varchar(32),
In in_DateOfLicenseFirstIssue Datetime,
In in_DateOfCurLicenseFirstIssue Datetime,
In in_DateOfExpiryOfCurLicense Datetime,
In in_Sex char(1),
In in_CurLicenseClass varchar(16),
In in_PlaceOfReg Varchar(16),
In in_DateOfCommencement Datetime)
Begin

Set @driverid = makeCDIN(in_Surname);
Insert Into Driver 
Values(@driverid,in_Surname,in_Othernames,in_DateOfBirth,in_PhoneNumber,in_LicenseNumber,in_Email,
        in_DateOfLicenseFirstIssue,in_DateOfCurLicenseFirstIssue,in_DateOfExpiryOfCurLicense,in_Sex,
            in_CurLicenseClass,in_PlaceOfReg,in_DateOfCommencement)
ON DUPLICATE KEY UPDATE  Surname=in_Surname,Othernames=in_Othernames,DateOfBirth=in_DateOfBirth,PhoneNumber=in_PhoneNumber,
                         LicenseNumber=in_LicenseNumber,Email=in_Email,DateOfLicenseFirstIssue=in_DateOfLicenseFirstIssue,
                         DateOfCurLicenseFirstIssue=in_DateOfCurLicenseFirstIssue,
                         DateOfExpiryOfCurLicense=in_DateOfExpiryOfCurLicense,Sex=in_Sex,
                         CurLicenseClass=in_CurLicenseClass,PlaceOfReg=in_PlaceOfReg,DateOfCommencement=in_DateOfCommencement;
End //
Delimiter ;


-- =====================================
-- Adds a new NOK to the database
Delimiter //
Drop Procedure If Exists addNOK //
Create Procedure AddNOK(In in_Surname varchar(32),In in_Othernames varchar(32),In in_DriverID varchar(16),
                                               In in_RelationID char(8),In in_PhoneNumber varchar(16))
Begin
 Insert Into NOK(Surname,Othernames,DriverID,RelationID,PhoneNumber)
 Values(in_Surname,in_Othernames,in_DriverID,in_RelationID,in_PhoneNumber)
 On Duplicate key Update Surname = in_Surname,Othernames=in_Othernames,DriverID=in_DriverID,
                         RelationID=in_RelationID,PhoneNumber=in_PhoneNumber;
End//
Delimiter ;

-- ======================================
-- Adds a new sector instructor to the database.
-- note generate InstructorID
Delimiter //
Drop Procedure If Exists addSectorInstructor //
Create Procedure AddSectorInstructor(In in_Surname varchar(32),In in_Othernames varchar(32), IN in_User VARCHAR(16))
Begin

 Set @sec = (select A.SectorCode from User A 
             left Join UserLogin B on A.User = B.User where B.User =in_User and B.LogoutTime = '0000-00-00 00:00:00');
 Set @instructorid = makeSIIN(in_Surname,@sec);

 Insert Into SectorInstructor(InstructorID,SectorCode,Surname,Othernames)
 Values(@instructorid,@sec,in_Surname,in_Othernames)
 On Duplicate Key Update Surname=in_Surname,Othernames=in_Othernames;
End //
Delimiter ;

-- ========================================
-- adds a new  module to the database
Delimiter //
Drop Procedure If Exists addModule //
Create Procedure AddModule(In in_ModuleID Char(1), In in_Description Varchar(64))
Begin
 Insert Into Module(ModuleID, Description)
 Values(in_ModuleID, in_Description);
End //
Delimiter ;
-- =======================================
-- Adds new modulesubtype to the database.
Delimiter //
Drop Procedure If Exists addModuleSubType //
Create Procedure AddModuleSubType(In in_ModuleID Char(1),In in_Description Varchar(64), In in_MaxTime decimal(2,2),In in_MaxScore decimal(5,2)) 
Begin
 Insert Into ModuleSubType(ModuleID,Description,MaxTime,MaxScore)
 Values(in_ModuleID, in_Description,in_MaxTime, in_MaxScore);
End //
Delimiter ;

-- =======================================
-- schedules a new training
Delimiter //
Drop Procedure If Exists addTraining //
Create Procedure AddTraining(In in_InstructorID Varchar(16),In in_SectorCode Varchar(16),In in_NoOfHours decimal(5,2),
In in_Score decimal(5,2), In in_ModuleSubTypeID INT,In in_ModuleID Char(1), In in_DriverID Varchar(16))
Begin
 Insert Into Training(InstructorID,SectorCode,NoOfHours,Score,ModuleSubTypeID,ModuleID,DriverID)
 Values(in_InstructorID,in_SectorCode,in_NoOfHours,in_Score,in_ModuleSubTypeID,in_ModuleID,in_DriverID);
End //
Delimiter ;

-- =======================================
-- Updates a user password
DELIMITER //
DROP PROCEDURE IF EXISTS changeUserPassword//
CREATE PROCEDURE changeUserPassword(In in_User VARCHAR(15), In in_Password VARCHAR(255))
BEGIN
	UPDATE `User` SET `password`=PASSWORD(in_Password)
	WHERE `User`=in_user ;
END;//
DELIMITER ;

-- ==============================
-- Logs in a user.
DELIMITER //
DROP PROCEDURE IF EXISTS loginUser //
CREATE PROCEDURE LoginUser(In in_User VARCHAR(16), In in_Password VARCHAR(255))READS SQL DATA
BEGIN
			IF(authenticateUser(in_User,in_Password)) THEN
				BEGIN
					DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN
					ROLLBACK;
					SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT =  '-45000: loginUser: User already logged in ';
					END;
					
					START TRANSACTION;
					INSERT INTO UserLogin(User,LoginTime,LogoutTime)
					VALUES(in_User,NOW(),'');
					COMMIT;
					SELECT u.Surname, u.Othernames,u.RoleID, l.LoginTime
						    FROM `User` u LEFT JOIN UserLogin l ON l.User=u.User
						    WHERE u.User=in_User AND l.loginTime=
						    (select max(LoginTime) from UserLogin where User=in_User);
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
DROP PROCEDURE IF EXISTS logoutUser //
CREATE PROCEDURE LogoutUser(IN in_user VARCHAR(16) )
BEGIN
    UPDATE  UserLogin
    SET LogoutTime = NOW()
    WHERE User = in_User  AND LogoutTime = '0000-00-00 00:00:00' LIMIT 1;

END //
DELIMITER ;
-- ====================



