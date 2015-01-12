-- VIDIOAFFAIRS PROCEDURES....
-- 15-07-14
-- ================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS addCategory ##
CREATE PROCEDURE addCategory(IN in_CategoryID char(8),
			    IN in_Name varchar(16),IN in_Description varchar(128))

	BEGIN
		INSERT INTO Category(CategoryID,Name,Description)
		VALUES(in_CategoryID,in_Name,in_Description);
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getCategory ##
CREATE PROCEDURE getCategory()
	BEGIN
		SELECT CategoryID,Name,Description FROM Category;
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS addSubcategory ##
CREATE PROCEDURE addSubcategory(IN in_SubCategoryID char(8),
				IN in_CategoryID char(8),IN in_Name varchar(16),IN in_Description varchar(128))

	BEGIN
		INSERT INTO SubCategory(SubCategoryID,CategoryID,Name,Description)
		VALUES(in_SubCategoryID,in_CategoryID,in_Name,in_Description);
	END ##
DELIMITER ;
-- ===================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getAllSubcategory ##
CREATE PROCEDURE getAllSubcategory()
	BEGIN
		SELECT SubCategoryID,CategoryID,Name,Description FROM Subcategory;
	END ##
DELIMITER ;
-- ====================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getSubcategory ##
CREATE PROCEDURE getSubcategory(IN in_CategoryID char(8))
	BEGIN
		SELECT SubCategoryID,CategoryID,Name,Description FROM Subcategory;
	END ##
DELIMITER ;
-- ==================================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS addAuthor ##
CREATE PROCEDURE addAuthor(IN in_Surname varchar(16),IN in_Firstname varchar(16),IN in_Description varchar(128))

	BEGIN
		INSERT INTO Author(Surname,Firstname,Description)
		VALUES(in_Surname,in_Firstname,in_Description);
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getAllAuthor ##
CREATE PROCEDURE getAllAuthor()
	BEGIN
		SELECT AuthorID,Surname,Firstname,Description FROM Author;
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getAuthor ##
CREATE PROCEDURE getAuthor(IN in_AuthorID varchar(16))
	BEGIN
		SELECT AuthorID,Surname,Firstname,Description FROM Author;
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS addVideoFormat ##
CREATE PROCEDURE addVideoFormat(IN in_FormatID char(3),IN in_Name varchar(8))
	BEGIN 
		INSERT INTO VideoFormat(FormatID,Name)
		VALUES(in_FormatID,in_Name);
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getFormat ##
CREATE PROCEDURE getFormat()
	BEGIN
		SELECT FormatID,Name FROM VideoFormat;
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS addUser ##
CREATE PROCEDURE addUser(IN in_Username varchar(16),IN in_Surname varchar(32),IN in_Firstname varchar(32),IN in_RoleID varchar(16),IN 				in_Password varchar(255))
	BEGIN 
		INSERT INTO User(Username,Surname,Firstname,RoleID,Password)
		VALUES(in_Username,in_Surname,in_Firstname,in_RoleID,password(in_Password));
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getAllUser ##
CREATE PROCEDURE getAllUser()
	BEGIN
		SELECT Username,Surname,Firstname,RoleID,Password FROM User;
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getUser ##
CREATE PROCEDURE getUser(IN in_Username varchar(16))
	BEGIN
		SELECT Username,Surname,Firstname,RoleID,Password FROM User;
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS addUserRole ##
CREATE PROCEDURE addUserRole(IN in_RoleID varchar(16), IN in_Name varchar(32), IN in_Description varchar(128))
	BEGIN 
		INSERT INTO UserRole(RoleID,Name,Description)
		VALUES(in_RoleID,in_Name,in_Description);
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getAllUserRole ##
CREATE PROCEDURE getAllUserRole()
	BEGIN
		SELECT RoleID,Name,Description FROM UserRole;
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getUserRole ##
CREATE PROCEDURE getUserRole(IN in_RoleID varchar(16))
	BEGIN
		SELECT RoleID,Name,Description FROM UserRole;
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS addPermission ##
CREATE PROCEDURE addPermission(IN in_PermissionID varchar(16), IN in_RoleID varchar(16), IN in_Description varchar(128))
	BEGIN 
		INSERT INTO Permission(PermissionID,RoleID,Description)
		VALUES(in_PermissionID,in_RoleID,in_Description);
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getPermission ##
CREATE PROCEDURE getPermission()
	BEGIN
		SELECT PermissionID,RoleID,Description FROM Permission;
	END ##
DELIMITER ;
-- ==================================================================

DELIMITER ##
DROP PROCEDURE IF EXISTS addVideo ##
CREATE PROCEDURE addVideo(IN in_VideoTitle varchar(64),IN in_AuthorID int,IN in_CategoryID char(5),IN in_Size varchar(8),IN in_Duration Time,IN in_FormatID char(3),IN in_SubCategoryID char(8),IN in_Url varchar(128))
BEGIN 
		SET @videoid = makeSDIN(in_VideoTitle);
		INSERT INTO Video(VideoID,VideoTitle,AuthorID,CategoryID,Size,Duration,FormatID,SubCategoryID,Url)
		VALUES(@videoid,in_VideoTitle,in_AuthorID,in_CategoryID,in_Size,in_Duration,in_FormatID,
                       in_SubCategoryID,in_Url);
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getAllVideos ##
CREATE PROCEDURE getAllVideos()
	BEGIN
		SELECT VideoID,VideoTitle,AuthorID,CategoryID,DateUploaded,Size,Duration,FormatID,SubCategoryID,Rating FROM Video;
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getVideoByTitle ##
CREATE PROCEDURE getVideoByTitle(IN in_VideoTitle varchar(16))
	BEGIN
		SELECT VideoID,VideoTitle,AuthorID,CategoryID,DateUploaded,Size,Duration,FormatID,SubCategoryID,Rating FROM Video;
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getVideoByAuthor ##
CREATE PROCEDURE getVideoByAuthor(IN in_AuthorID int)
	BEGIN
		SELECT VideoID,VideoTitle,AuthorID,CategoryID,DateUploaded,Size,Duration,FormatID,SubCategoryID,Rating FROM Video;
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getVideoByCategory ##
CREATE PROCEDURE getVideoByCategory(IN in_CategoryID char(5))
	BEGIN
		SELECT VideoID,VideoTitle,AuthorID,CategoryID,DateUploaded,Size,Duration,FormatID,SubCategoryID,Rating FROM Video;
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getVideoBySubcategory ##
CREATE PROCEDURE getVideoBySubcategory(IN in_SubCategoryID char(5))
	BEGIN
		SELECT VideoID,VideoTitle,AuthorID,CategoryID,DateUploaded,Size,Duration,FormatID,SubCategoryID,Rating FROM Video;
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getVideoByFormat ##
CREATE PROCEDURE getVideoByFormat(IN in_FormatID char(3))
	BEGIN
		SELECT VideoID,VideoTitle,AuthorID,CategoryID,DateUploaded,Size,Duration,FormatID,SubCategoryID,Rating FROM Video;
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS addTag ##
CREATE PROCEDURE addTag(IN in_TagID char(5),IN in_Value varchar(16))
	BEGIN 
		INSERT INTO Tag(TagID,Value)
		VALUES(in_TagID,in_Value);
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getTag ##
CREATE PROCEDURE getTag()
	BEGIN
		SELECT TagID,Value FROM Tag;
	END ##
DELIMITER ;
-- ==================================================================
 DELIMITER ##
 DROP PROCEDURE IF EXISTS addVideoTag ##
 CREATE PROCEDURE addVideoTag(IN in_VideoID varchar(16),IN in_TagID char(5))
	BEGIN 
		INSERT INTO VideoTag(VideoID,TagID)
		VALUES(in_VideoID,in_TagID);
	END ##
 DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getAllVideoTag ##
CREATE PROCEDURE getAllVideoTag()
	BEGIN
		SELECT vt.VideoID,v.VideoTitle,vt.TagID,t.Value
		FROM VideoTag vt
		JOIN Video v on vt.VideoID = v.VideoID
		join Tag t on vt.TagID = t.TagID;
	END ##
DELIMITER ;
-- ==================================================================
 DELIMITER ##
 DROP PROCEDURE IF EXISTS getVideoTag ##
 CREATE PROCEDURE getVideoTag(IN in_VideoID varchar(16))
	BEGIN
		SELECT vt.VideoID,v.VideoTitle,vt.TagID,t.Value
		FROM VideoTag vt
		JOIN Video v on vt.VideoID = v.VideoID
		join Tag t on vt.TagID = t.TagID;
	END ##
 DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS addVideoRating ##
CREATE PROCEDURE addVideoRating(IN in_VideoID varchar(16),IN in_Username varchar(16),IN in_Rank Double,IN in_Review 					varchar(128))
	BEGIN 
		INSERT INTO VideoRating(VideoID,Username,Rank,Review)
		VALUES(in_VideoID,in_Username,in_Rank,in_Review);
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getVideoRating ##
CREATE PROCEDURE getVideoRating(IN in_VideoID Varchar(16))
	BEGIN
		SELECT VideoID,Username,Rank,DateRated,Review FROM VideoRating;
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getAllVideoRating ##
CREATE PROCEDURE getAllVideoRating()
	BEGIN
		SELECT VideoID,Username,Rank,DateRated,Review FROM VideoRating;
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS addVideoViewCount ##
CREATE PROCEDURE addVideoViewCount(IN in_VideoID varchar(16),IN in_Username Varchar(16))
	BEGIN 
		INSERT INTO VideoViewCount(VideoID,Username)
		VALUES(in_VideoID,in_Username);
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getVideoViewCount ##
CREATE PROCEDURE getVideoViewCount(IN in_VideoID varchar(16)) 
	BEGIN
		SELECT vc.VideoID,v.VideoTitle as Title,concat(a.Surname, ' ' ,Firstname) as Author,count(vc.VideoID) as Count
		FROM VideoViewCount vc
		left join Video v on v.VideoID = vc.VideoID
		left join Author a on v.AuthorID = a.AuthorID
		Where vc.VideoID = in_VideoID;
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS getAllVideoViewCount ##
CREATE PROCEDURE getAllVideoViewCount()
	BEGIN
		SELECT VideoID ViewDateTime,Username FROM VideoViewCount ;
	END ##
DELIMITER ;
-- ==================================================================
DELIMITER ##
DROP PROCEDURE IF EXISTS addUserFavourite ##
create procedure addUserFavourite(IN in_VideoID varchar(16),IN in_Username varchar(16))
begin
    insert into UserFavourite values(in_VideoID,in_Username);
end ##
delimiter ;
-- ===============================================================
delimiter ##
drop procedure if exists getAllUserFavourite ##
create procedure getAllUserFavourite()
begin
 select uf.VideoID,v.VideoTitle,uf.Username, concat(u.Surname, ' ' ,u.Firstname) User
 from UserFavourite uf
 left join Video v on uf.VideoID = v.VideoID
 left join User u on uf.Username = u.Username;
end ##
delimiter ;
-- =============================================================
delimiter ##
drop procedure if exists getUserFavourite ##
create procedure getUserFavourite(IN in_Username varchar(16))
begin
 select uf.VideoID,v.VideoTitle,uf.Username, concat(u.Surname, ' ' ,u.Firstname) User
 from UserFavourite uf
 left join Video v on uf.VideoID = v.VideoID
 left join User u on uf.Username = u.Username
 where uf.Username = in_Username;
end ##
delimiter ;
-- ===========================================================
-- Updates a user password
DELIMITER //
DROP PROCEDURE IF EXISTS changeUserPassword//
CREATE PROCEDURE changeUserPassword(In in_User VARCHAR(16), In in_Password VARCHAR(255))
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
					   IF(authenticateUser1(in_User)) THEN

						SIGNAL SQLSTATE '45000'
						SET MESSAGE_TEXT =  '-45000: loginUser: User already logged in';
					   END IF;

				BEGIN
					
					START TRANSACTION;
					INSERT INTO UserLogin(User,LoginTime,LogoutTime)
					VALUES(in_User,NOW(),'');
					COMMIT;
					SELECT u.Surname, u.Firstname,u.RoleID, l.LoginTime
						    FROM `User` u LEFT JOIN UserLogin l ON l.User=u.Username
						    WHERE u.Username=in_User AND l.loginTime=
						    (select max(LoginTime) from UserLogin where User=in_User);
				END;
			
				ELSE
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT =  '-45000: loginUser: User authen fail';
			END IF;

END //
DELIMITER ;
-- ===========================
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
 
