DELIMITER ##
DROP PROCEDURE IF EXISTS getStudent ##
CREATE PROCEDURE getStudent(IN in_Matno Varchar(16))
	BEGIN
	SELECT StudentID,SurName,FirstName,Othernames,Sex,DOB,FacultyID,DeptID,LevelID,Address,Country,State,LGA
	FROM Student
	Where StudentID = in_Matno;
	END ##
DELIMITER ;

-- =====================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getAllStudent ##
CREATE PROCEDURE getAllStudent()
	BEGIN
	SELECT StudentID,SurName,FirstName,FacultyID,DeptID,LevelID
	FROM Student;
	END ##
DELIMITER ;