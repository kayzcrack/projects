-- cpcd functions
-- voti@quanteq.com
-- 19/03/14
-- ============================
DELIMITER //

DROP FUNCTION IF EXISTS `upc_checkdigit`//

CREATE FUNCTION `upc_checkdigit`(s VARCHAR(255)) RETURNS CHAR(1) CHARSET latin1
DETERMINISTIC
BEGIN
	DECLARE len INT;
	DECLARE odd INT DEFAULT 0;
	DECLARE even INT DEFAULT 0;
	DECLARE i INT DEFAULT 1;
	DECLARE SUM INT;
	SET len=CHAR_LENGTH(s);
	REPEAT
		IF i<=len THEN
			SET odd=odd+ASCII(SUBSTRING(s FROM i FOR 1))-48;
		END IF;
		SET i = i+2;
	UNTIL i>len END REPEAT;
	SET i=2;
	REPEAT
		IF i<=len THEN
			SET even=even+ASCII(SUBSTRING(s FROM i FOR 1))-48;
		END IF;
		SET i = i+2;
	UNTIL i>len END REPEAT;
	SET SUM=even+3*odd;
	SET i=SUM%10;
	IF i THEN
		SET i=10-i;
	END IF;
	
	RETURN i;
END //

DELIMITER ;

-- ==========================================

-- generates identification number for Video.
DELIMITER //

DROP FUNCTION IF EXISTS `makeSDIN` //
CREATE FUNCTION `makeSDIN`(in_VideoTitle VARCHAR(64)) RETURNS CHAR(15) CHARSET latin1
DETERMINISTIC
BEGIN
SET @prefix = 'VAFF/';
SET @ldin=(SELECT SDIN FROM SDINs WHERE DateUsed IS NULL LIMIT 1);
UPDATE SDINs SET DateUsed=CURRENT_DATE() WHERE SDIN =@ldin; 
RETURN (CONCAT(@prefix,@ldin,upc_checkdigit(in_VideoTitle)));
END //

DELIMITER ;

-- =========================================
-- TO GENERATES SDINS NUMBERS..

DELIMITER $$

DROP PROCEDURE IF EXISTS `generateSDINs`$$

CREATE PROCEDURE `generateSDINs`(inStart INT, inCount INT)
BEGIN
	DECLARE X INT;
	DECLARE MAX INT;
	SET MAX = inCount+inStart;
	SET X = inStart;
	WHILE X <= MAX DO 
		BEGIN
			SET @tmp:=LPAD(X,3,'0');
			INSERT IGNORE INTO SDINs(SDIN) VALUES (CONCAT(@tmp, upc_checkdigit(@tmp)));
			SET X:= X+1;
		END;
	END WHILE;
END$$

DELIMITER ;

-- ==================================================================
-- function authenticates user
DELIMITER //
DROP FUNCTION IF EXISTS authenticateUser //
CREATE FUNCTION authenticateUser(in_User VARCHAR(16), in_Password VARCHAR(255))
RETURNS BOOLEAN READS SQL DATA
DETERMINISTIC
BEGIN
    RETURN (SELECT COUNT(*) FROM `User`
	WHERE Username=in_User AND Password= PASSWORD(in_Password));

END //
DELIMITER ;

-- =======================================
-- function authenticates user
DELIMITER //
DROP FUNCTION IF EXISTS authenticateUser1 //
CREATE FUNCTION authenticateUser1(in_User VARCHAR(16))
RETURNS BOOLEAN READS SQL DATA
DETERMINISTIC
BEGIN
    RETURN (SELECT COUNT(*) FROM `UserLogin`
	WHERE User=in_User AND LogoutTime = '0000-00-00 00:00:00');

END //
DELIMITER ;

