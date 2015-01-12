-- Terminator ;
-- Function for student database
-- voti@quanteq.com
-- db2 -td\@ -xvf func-school.sql


-- CREATE OR REPLACE FUNCTION makeSDIN() RETURNS CHAR(15)
-- MODIFIES SQL DATA
-- LANGUAGE SQL
-- DETERMINISTIC
-- BEGIN
-- DECLARE @prefix anchor Student.Surname;
-- DECLARE @ldin anchor Student.Surname;
-- SET @prefix = 'SDIN/';
-- SET @ldin=(SELECT SDIN FROM SDINs WHERE DateUsed IS NULL LIMIT 1);
-- UPDATE SDINs SET DateUsed= CURRENT DATE WHERE SDIN =@ldin; 
-- RETURN (CONCAT(@prefix,@ldin));
-- END@
-- 
-- -- ===================================================
-- CREATE OR REPLACE FUNCTION makeSTIN() RETURNS CHAR(15)
-- MODIFIES SQL DATA
-- LANGUAGE SQL
-- DETERMINISTIC
-- BEGIN
-- DECLARE @prefix anchor Staff.Surname;
-- DECLARE @ldin anchor Staff.Surname;
-- SET @prefix = 'STIN/PEM/';
-- SET @ldin=(SELECT STIN FROM STINs WHERE DateUsed IS NULL LIMIT 1);
-- UPDATE STINs SET DateUsed=CURRENT DATE WHERE STIN =@ldin; 
-- RETURN (CONCAT(@prefix,@ldin));
-- END@
-- =================================================
CREATE OR REPLACE FUNCTION checkCourse(in_StudentID Varchar(16))
RETURNS ANCHOR STUDENT.STUDENTID READS SQL DATA
DETERMINISTIC
BEGIN
	DECLARE MAX INTEGER;
	DECLARE HIGH INTEGER;
	DECLARE TOO_HIGH INTEGER;
	SET HIGH = 5;
	
	SELECT COUNT(STUDENTID) INTO MAX FROM STUDENT
	WHERE STUDENTID = IN_STUDENTID;
	
	IF MAX > HIGH THEN
	SET TOO_HIGH = 0;
	END IF;
	
	IF MAX < HIGH THEN
	SET TOO_HIGH = 1;
	END IF;
	
	RETURN TOO_HIGH ;
END@	

-- ================================================
	