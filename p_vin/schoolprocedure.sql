-- THE SCHOOL GET AND ADD PROCEDURES....
-- 22-05-14

-- @@@1
DELIMITER ##
drop procedure if exists getGender ##
CREATE PROCEDURE getGender()
	BEGIN
	SELECT Sex,Description FROM Gender;
	END ##
DELIMITER ;
-- @@@@2
DELIMITER ##
DROP PROCEDURE IF EXISTS getMenu ##

CREATE PROCEDURE getMenu()

BEGIN
	SELECT MenuID,MenuDescription FROM Menu;
END ##
DELIMITER ;
-- @@@@ 3
DELIMITER ##
DROP PROCEDURE IF EXISTS addMenu ##

CREATE PROCEDURE addMenu(IN In_MenuID varchar(16),IN In_MenuDescription varchar(128))

BEGIN
	INSERT INTO Menu(MenuID,MenuDescription)
	VALUES(In_MenuID,In_MenuDescription);
END ##
DELIMITER ;
-- @@@@@4
DELIMITER ##
DROP PROCEDURE IF EXISTS getMenuLink ##
CREATE PROCEDURE getMenuLink()
BEGIN 
	SELECT LinkID,Description,MenuID,Url FROM MenuLink;
END ##
DELIMITER ;
-- @@@@@ 5
DELIMITER ##
DROP PROCEDURE IF EXISTS addMenuLink ##
CREATE PROCEDURE addMenuLink(IN In_LinkID varchar(16),IN In_Description varchar(255),IN In_MenuID varchar(16),IN In_Url varchar(255))
BEGIN 
	INSERT INTO MenuLink(LinkID,Description,MenuID,Url)
	VALUES(In_LinkID,In_Description,In_MenuID,In_Url);
END ##
DELIMITER ;
-- @@@@@6
DELIMITER ##
DROP PROCEDURE IF EXISTS getPermission ##
CREATE PROCEDURE getPermission()

BEGIN
	SELECT RoleID,Mode,LinkID FROM Permission;
END ##
DELIMITER ;
-- @@@@7
DELIMITER ##
DROP PROCEDURE IF EXISTS addPermission ##
CREATE PROCEDURE addPermission(IN In_RoleID varchar(16),IN In_Mode varchar(16),IN In_LinkID varchar(16))

BEGIN
	INSERT INTO Permission(RoleID,Mode,LinkID)
	VALUES(In_RoleID,In_Mode,In_LinkID);
END ##
DELIMITER ;
-- @@@@@8
DELIMITER ##
DROP PROCEDURE IF EXISTS getUserRole ##
CREATE PROCEDURE getUserRole()
	BEGIN
	SELECT RoleID,Name,Description FROM UserRole;
	END ##
DELIMITER ;
-- @@@@@9
DELIMITER ##
DROP PROCEDURE IF EXISTS addUserRole ##
CREATE PROCEDURE addUserRole(IN In_RoleID varchar(5),IN In_Name varchar(128),IN In_Description varchar(32))
	BEGIN
	INSERT INTO UserRole(RoleID,Name,Description)
	VALUES(In_RoleID,In_Name,In_Description);
	END ##
DELIMITER ;
-- @@@@ 10
DELIMITER ##
DROP PROCEDURE IF EXISTS getUser ##
CREATE PROCEDURE getUser(IN In_User varchar(16), IN In_Password varchar(255))
	BEGIN
	SELECT User,Surname,Othernames,RoleID,Password
	FROM User
	WHERE User = In_User and Password = In_Password;
	END ##
DELIMITER ;
-- @@@@@ 11
DELIMITER ##
DROP PROCEDURE IF EXISTS addUser ##
CREATE PROCEDURE addUser(IN In_User varchar(16),IN In_Surname varchar(32),IN In_Othernames varchar(32),
	IN In_RoleID varchar(16),IN In_Password varchar(255))
	BEGIN
	INSERT INTO User(User,Surname,Othernames,RoleID,Password)
	VALUES(In_User,In_Surname,In_Othernames,In_RoleID,In_Password);
	END ##
DELIMITER ;
-- @@@@@12
DELIMITER ##
DROP PROCEDURE IF EXISTS getUserLogin ##
CREATE PROCEDURE getUserLogin()
	BEGIN
	SELECT User,LoginTime,RemoteHost,MachineID,LogOutTime FROM UserLogin;
	END ##
DELIMITER ;
-- @@@@@@13
DELIMITER ##
DROP PROCEDURE IF EXISTS addUserLogin ##
CREATE PROCEDURE addUserLogin(IN In_User varchar(16),IN In_LoginTime datetime,IN In_RemoteHost varchar(128),
	IN In_MachineID varchar(128),IN In_LogOutTime datetime)
	BEGIN
	INSERT INTO UserLogin(User,LoginTime,RemoteHost,MachineID,LogOutTime)
	VALUES(In_User,In_LoginTime,In_RemoteHost,In_MachineID,In_LogOutTime);
	END ##
DELIMITER ;
-- @@@@@14
DELIMITER ##
drop procedure if exists getSemester ##
CREATE PROCEDURE getSemester()
	BEGIN
	SELECT SemesterID,SemesterName,StartDate,EndDate FROM Semester;
	END ##
DELIMITER ;
	
-- @@@@@ 15
DELIMITER ##
DROP PROCEDURE IF EXISTS addSemester ##
CREATE PROCEDURE addSemester(IN In_SemesterID varchar(16),IN In_SemesterName varchar(32),IN In_StartDate DateTime,IN In_EndDate DateTime)
BEGIN 
	INSERT INTO Semester(SemesterID,SemesterName,StartDate,EndDate)
	VALUES(In_SemesterID,In_SemesterName,In_StartDate,In_EndDate);
END ##
DELIMITER ;

-- @@@@ 16
DELIMITER ##
drop procedure if exists getFaculty ##
CREATE PROCEDURE getFaculty()
	BEGIN
	SELECT FacultyID,FacultyName as Name,Description FROM Faculty;
	END ##
DELIMITER ;
-- @@@@@ 17
DELIMITER ##
DROP PROCEDURE IF EXISTS addFaculty ##
CREATE PROCEDURE addFaculty(IN In_FacultyID varchar(16),IN In_FacultyName varchar(128),IN In_Description varchar(128))
BEGIN 
	INSERT INTO Faculty(FacultyID,FacultyName,Description)
	VALUES(In_FacultyID,In_FacultyName,In_Description)
ON DUPLICATE KEY UPDATE
FacultyName = In_FacultyName, Description = In_Description;
END ##
DELIMITER ;
-- @@@@ 18
DELIMITER ##
drop procedure if exists getDepartment ##
CREATE PROCEDURE getDepartment()
	BEGIN
	SELECT DeptID as Code,DeptName as Name,concat(FacultyID, ' ' ,FacultyName) as Faculty,Description FROM Department;
	END ##
DELIMITER ;
-- =============================================
DELIMITER ;
-- @@@@ 20
DELIMITER ##
drop procedure if exists getStaff ##
CREATE PROCEDURE getStaff()
	BEGIN
	SELECT StaffID,SurName,FirstName,OtherNames,Sex,DOB,CourseID,LevelID,Position,Email,StaffImage FROM Staff;
	END ##
DELIMITER ;
-- @@@@@ 21
DELIMITER ##
DROP PROCEDURE IF EXISTS addStaff ##
CREATE PROCEDURE addStaff(IN In_StaffID varchar(16),IN In_SurName varchar(128),IN In_FirstName varchar(128),IN In_OtherNames varchar(128),IN In_Sex char(1),IN In_DOB date,In_CourseID varchar(16),IN In_LevelID varchar(16),IN In_Position varchar(32),IN In_Email varchar(32),IN In_StaffImage BLOB)
BEGIN 
	INSERT INTO Staff(StaffID,SurName,FirstName,OtherNames,Sex,DOB,CourseID,LevelID,Position,Email,StaffImage)
	VALUES(In_StaffID,In_SurName,In_FirstName,In_OtherNames,In_Sex,In_DOB,In_CourseID,In_LevelID,In_Position,In_Email,In_StaffImage);
END ##
DELIMITER ;
-- @@@@ 22
DELIMITER ##
drop procedure if exists getLevel ##
CREATE PROCEDURE getLevel()
	BEGIN
	SELECT LevelID,LevelName FROM Level;
	END ##
DELIMITER ;
-- @@@@@ 23
DELIMITER ##
DROP PROCEDURE IF EXISTS addLevel ##
CREATE PROCEDURE addLevel(IN In_LevelID varchar(16),IN In_LevelName varchar(16))
BEGIN 
	INSERT INTO Level(LevelID,LevelName)
	VALUES(In_LevelID,In_LevelName);
END ##
DELIMITER ;
-- @@@@ 24
DELIMITER ##
drop procedure if exists getStudent ##
CREATE PROCEDURE getStudent()
	BEGIN
	SELECT StudentID, SurName,FirstName,Othernames,Sex,DOB,FacultyID,LevelID,DeptID,Address,Country,State,LGA,Image FROM Student;
	END ##
DELIMITER ;
-- @@@@@ 25
DELIMITER ##
DROP PROCEDURE IF EXISTS addStudent ##
CREATE PROCEDURE addStudent(IN In_StudentID Varchar(16),IN In_SurName Varchar(128),IN In_FirstName Varchar(128),IN In_Othernames Varchar(128),IN In_Sex char(1),IN In_DOB date,IN In_FacultyID Varchar(16),IN In_DeptID Varchar(16),IN In_LevelID Varchar(16),IN In_Address Varchar(255),IN In_Country Varchar(32),IN In_State Varchar(32),IN In_LGA Varchar(32),IN In_Image BLOB)
BEGIN 
	INSERT INTO Student(StudentID,SurName,FirstName,Othernames,Sex,DOB,FacultyID,LevelID,DeptID,Address,Country,State,LGA,Image)
	VALUES(In_StudentID,In_SurName,In_FirstName,In_Othernames,In_Sex,In_DOB,In_FacultyID,In_LevelID,In_DeptID,In_Address,In_Country,In_State,In_LGA,In_Image);
END ##
DELIMITER ;
-- @@@@ 26
DELIMITER ##
drop procedure if exists getResult ##
CREATE PROCEDURE getResult()
	BEGIN
	SELECT ResultID,ResultDate,ResultDescription,StudentID,LevelID,SemesterID FROM Result;
	END ##
DELIMITER ;
-- @@@@@ 27
DELIMITER ##
DROP PROCEDURE IF EXISTS addResult ##
CREATE PROCEDURE addResult(IN In_ResultID Varchar(16),IN In_ResultDate DateTime,IN In_ResultDescription Varchar(255),IN In_StudentID Varchar(16),IN In_LevelID Varchar(16),IN In_SemesterID Varchar(16))
BEGIN 
	INSERT INTO Resullt(ResultID,ResultDate,ResultDescription,StudentID,LevelID,SemesterID)
	VALUES(In_ResultID,In_ResultDate,In_ResultDescription,In_StudentID,In_LevelID,In_SemesterID);
END ##
DELIMITER ;
-- @@@@ 28
DELIMITER ##
drop procedure if exists getAllCourse ##
CREATE PROCEDURE getAllCourse()
	BEGIN
	SELECT CourseID,CourseName,CourseHours,LevelID,StaffID,CourseDescription FROM Course;
	END ##
DELIMITER ;
-- @@@@@ 29
DELIMITER ##
DROP PROCEDURE IF EXISTS addCourse ##
CREATE PROCEDURE addCourse(IN In_CourseID varchar(16),IN In_CourseName varchar(128),IN In_CourseHours INT,IN In_LevelID Varchar(16),
IN In_SemesterID Varchar(16), IN in_StaffID varchar(16),IN In_CourseDescription varchar(128))
BEGIN 
	INSERT INTO Course(CourseID,CourseName,CourseHours,LevelID,SemesterID,StaffID,CourseDescription)
	VALUES(In_CourseID,In_CourseName,In_CourseHours,In_LevelID,In_SemesterID,in_StaffID,In_CourseDescription);
END ##
DELIMITER ;
-- @@@@ 30
DELIMITER ##
drop procedure if exists getTimeTable ##
CREATE PROCEDURE getTimeTable()
	BEGIN
	SELECT TimeTableID,TermDate,LevelID,CourseID,StaffID FROM TimeTable;
	END ##
DELIMITER ;
-- @@@@@ 31
DELIMITER ##
DROP PROCEDURE IF EXISTS addTimeTable ##
CREATE PROCEDURE addTimeTable(IN In_TimeTableID varchar(16),IN In_TermDate INT,IN In_LevelID varchar(16),IN In_CourseID varchar(16),IN In_StaffID varchar(16))
BEGIN 
	INSERT INTO TimeTable(TimeTableID,TermDate,LevelID,CourseID,StaffID)
	VALUES(In_TimeTableID,In_TermDate,In_LevelID,In_CourseID,In_StaffID);
END ##
DELIMITER ;
-- @@@@ 32
DELIMITER ##
drop procedure if exists getCourseStaff ##
CREATE PROCEDURE getCourseStaff()
	BEGIN
	SELECT CourseStaffID,StaffID,CourseID FROM CourseStaff;
	END ##
DELIMITER ;
-- @@@@@ 33
DELIMITER ##
DROP PROCEDURE IF EXISTS addCourseStaff ##
CREATE PROCEDURE addCourseStaff(IN In_CourseStaffID varchar(16),IN In_StaffID varchar(16),IN In_CourseID varchar(16))
BEGIN 
	INSERT INTO CourseStaff(CourseStaffID,StaffID,CourseID)
	VALUES(In_CourseStaffID,In_StaffID,In_CourseID);
END ##
DELIMITER ;

-- @@@@@34
DELIMITER ##
drop procedure if exists getJob ##
CREATE PROCEDURE getJob()
	BEGIN
	SELECT JobID,Name,Description FROM Job;
	END ##
DELIMITER ;

-- @@@@@35
DELIMITER ##
drop procedure if exists addJob ##
CREATE PROCEDURE addJob(IN in_JobID VARCHAR(32), IN in_Name Varchar(128), IN in_Desc Varchar(32))
	BEGIN
	INSERT INTO Job(JobID, Name, Description)
	VALUES(in_JobID, in_Name, in_Desc);
	END ##
DELIMITER ;
-- @@@@@36
