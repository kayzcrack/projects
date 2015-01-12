
-- cpcd functions
-- voti@quanteq.com
-- 19/03/14
-- ======================================
-- proc generates identification numbers for commercial drivers.

DELIMITER $$

DROP PROCEDURE IF EXISTS `generateCDINs`$$

CREATE PROCEDURE `generateCDINs`(inStart INT, inCount INT)
BEGIN
	DECLARE X INT;
	DECLARE MAX INT;
	SET MAX = inCount+inStart;
	SET X = inStart;
	WHILE X <= MAX DO 
		BEGIN
			SET @tmp:=LPAD(X,3,'0');
			INSERT IGNORE INTO CDINs(CDIN) VALUES (CONCAT(@tmp, upc_checkdigit(@tmp)));
			SET X:= X+1;
		END;
	END WHILE;
END$$

DELIMITER ;
-- =======================================
-- proc generates identification numbers for sector instructor

DELIMITER $$

DROP PROCEDURE IF EXISTS `generateSIINs`$$

CREATE PROCEDURE `generateSIINs`(inStart INT, inCount INT)
BEGIN
	DECLARE X INT;
	DECLARE MAX INT;
	SET MAX = inCount+inStart;
	SET X = inStart;
	WHILE X <= MAX DO 
		BEGIN
			SET @tmp:=LPAD(X,3,'0');
			INSERT IGNORE INTO SIINs(SIIN) VALUES (CONCAT(@tmp, upc_checkdigit(@tmp)));
			SET X:= X+1;
		END;
	END WHILE;
END$$

DELIMITER ;

-- ======================================
