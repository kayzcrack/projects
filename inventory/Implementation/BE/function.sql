DELIMITER //
DROP FUNCTION IF EXISTS `makePassword` //
CREATE FUNCTION `makePassword`() RETURNS CHAR(15) CHARSET latin1
DETERMINISTIC
BEGIN
     return(select substring(md5(rand()),8));
END //
DELIMITER ;     

-- --------------------------
DELIMITER //
DROP FUNCTION IF EXISTS `makeUsername` //
CREATE FUNCTION `makeUsername`(in_firstname varchar(32),in_surname varchar(32)) RETURNS CHAR(15) CHARSET latin1
DETERMINISTIC
BEGIN
     set @uname = LCASE(concat(substring(in_firstname,1,1),substring(in_surname,1)));
     return @uname;
END //
DELIMITER ; 
-- --------------------------
DELIMITER //
DROP FUNCTION IF EXISTS `makeEmail` //
CREATE FUNCTION `makeEmail`(in_firstname varchar(32),in_surname varchar(32)) RETURNS CHAR(128) CHARSET latin1
DETERMINISTIC
BEGIN
     set @email = concat(makeUsername(in_firstname,in_surname),'@','quanteq','.','com');
     return @email;
END //
DELIMITER ;
-- -------------------------
delimiter //
drop function if exists _xyz //
create function _xyz(in_User varchar(32)) returns char(32)
deterministic
begin
	set @id = (select StaffID from Staff where Username = in_User);
	set @rel = (select max(LoginTime) from UserLogin
	where StaffID = @id and LogoutTime != '0000-00-00 00:00:00');
	return @rel;
end //
delimiter ;
-- -----------------------	
