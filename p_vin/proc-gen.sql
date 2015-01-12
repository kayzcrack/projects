
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
DELIMITER $$

DROP PROCEDURE IF EXISTS `generateSTINs`$$

CREATE PROCEDURE `generateSTINs`(inStart INT, inCount INT)
BEGIN
	DECLARE X INT;
	DECLARE MAX INT;
	SET MAX = inCount+inStart;
	SET X = inStart;
	WHILE X <= MAX DO 
		BEGIN
			SET @tmp:=LPAD(X,3,'0');
			INSERT IGNORE INTO STINs(STIN) VALUES (CONCAT(@tmp, upc_checkdigit(@tmp)));
			SET X:= X+1;
		END;
	END WHILE;
END$$

DELIMITER ;

-- =================================================================