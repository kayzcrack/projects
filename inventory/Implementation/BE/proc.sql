delimiter //
drop procedure if exists getAllPermissionType //
create procedure getAllPermissionType()
begin
 select PermissionTypeID,PermissionName from PermissionType;
end //
delimiter ;

-- -----------------------------
delimiter //
drop procedure if exists getAllUserRole //
create procedure getAllUserRole()
begin
 select RoleID,RoleName,Description from UserRole;
end //
delimiter ;
-- -----------------------------
delimiter //
drop procedure if exists getAllCategory //
create procedure getAllCategory()
begin
   select CategoryID,CategoryName,Description from Category;
end //
delimiter ;

-- -----------------------------
delimiter //
drop procedure if exists addCategory //
create procedure addCategory(IN in_CategoryID char(8), IN in_CategoryName varchar(32), IN in_Description varchar(64))
begin
  insert into Category 
  values(in_CategoryID,in_CategoryName,in_Description);
end //
delimiter ;
-- ---------------------------
delimiter //
drop procedure if exists getAvailableStatus //
create procedure getAvailableStatus()
begin
  select AvailableStatusID,Description from AvailableStatus;
end //
delimiter ;
-- --------------------------
delimiter //
drop procedure if exists getFunctionalStatus //
create procedure getFunctionalStatus()
begin
 select FunctionalStatusID,Description from FunctionalStatus;
end //
delimiter ;
-- -------------------------
delimiter //
drop procedure if exists getAuthorizedStatus //
create procedure getAuthorizedStatus()
begin
 select AuthorizedStatusID, Description from AuthorizedStatus;
end //
delimiter ;

-- -------------------------
delimiter //
drop procedure if exists getRequestStatus //
create procedure getRequestStatus()
begin
 select   RequestStatusID,Description from RequestStatus;
end //
delimiter ;
-- -------------------------
delimiter //
drop procedure if exists getAllPermission //
create procedure getAllPermission()
begin
   select p.PermissionTypeID,pt.PermissionName,p.RoleID,u.RoleName from Permission p
   left join PermissionType pt on p.PermissionTypeID = pt.PermissionTypeID
   left join UserRole u on p.RoleID = u.RoleID;
end //
delimiter ;
-- --------------------------   
delimiter //
drop procedure if exists getRolePermission //
create procedure getRolePermission(IN in_RoleID char(8))
begin
   select p.PermissionTypeID,pt.PermissionName,p.RoleID,u.RoleName from Permission p
   left join PermissionType pt on p.PermissionTypeID = pt.PermissionTypeID
   left join UserRole u on p.RoleID = u.RoleID
   where p.RoleID = in_RoleID; 
end //
delimiter ;
-- --------------------------
-- test this
delimiter //
drop procedure if exists getAllStaff //
create procedure getAllStaff()
begin
 select s.StaffID,s.Surname,s.Firstname,s.Username,s.Email,s.DepartmentID,d.DepartmentName,s.Password,s.RoleID,u.RoleName
 from Staff s
 left join Department d on s.DepartmentID = d.DepartmentID
 left join UserRole u on s.RoleID = u.RoleID
 order by s.Surname ASC;
end //
delimiter ;
-- -------------------------
-- test this
delimiter //
drop procedure if exists getStaff //
create procedure getStaff(IN in_StaffID varchar(16))
begin
 select s.StaffID,s.Surname,s.Firstname,s.Username,s.DepartmentID,d.DepartmentName,s.Password,s.RoleID,u.RoleName
 from Staff s
 left join Department d on s.DepartmentID = d.DepartmentID
 left join UserRole u on s.RoleID = u.RoleID
 where StaffID = in_StaffID;
end //
delimiter ;
-- -------------------------
-- test this
 delimiter //
drop procedure if exists getDepartmentStaff //
create procedure getDepartmentStaff(IN in_DeptID char(5))
begin
 select s.StaffID,s.Surname,s.Firstname,s.Username,s.DepartmentID,d.DepartmentName,s.Password,s.RoleID,u.RoleName
 from Staff s
 left join Department d on s.DepartmentID = d.DepartmentID
 left join UserRole u on s.RoleID = u.RoleID
 where DepartmentID = in_DeptID;
end //
delimiter ;
-- -------------------------
-- test this
delimiter //
drop procedure if exists getAllRequest //
create procedure getAllRequest()
begin
	 select
			 r.RequestID,
			 r.StaffID,
			 concat(s.Surname, ' ',s.Firstname) As Staff,
			 s.DepartmentID,
			 d.DepartmentName,
			 r.ProductName,
			 r.RequestDate,
			 r.Model,
			 r.Purpose,
			 r.Quantity,
			 r.CategoryID,
			 c.CategoryName,
			 r.`Comment`,
			 r.ExpectedDateOfCollection
	 from Request r
	 left join Staff s on r.StaffID = s.StaffID
	 left join Department d on s.DepartmentID = d.DepartmentID
	 left join Category c on r.CategoryID = c.CategoryID;
end //
delimiter ;
-- ------------------------
 delimiter //
drop procedure if exists getRequest //
create procedure getRequest(IN in_RequestID int)
begin
	 select
			 r.RequestID,
			 r.StaffID,
			 s.Surname,
			 s.Firstname,
			 s.DepartmentID,
			 d.DepartmentName,
			 r.ProductName,
			 r.RequestDate,
			 r.Model,
			 r.Purpose,
			 r.Quantity,
			 r.CategoryID,
			 c.CategoryName,
			 r.`Comment`,
			 r.ExpectedDateOfCollection
	 from Request r
	 left join Staff s on r.StaffID = s.StaffID
	 left join Department d on s.DepartmentID = d.DepartmentID
	 left join Category c on r.CategoryID = c.CategoryID
	 where r.RequestID = in_RequestID;
end //
delimiter ;
-- --------------------------
delimiter //
drop procedure if exists getStaffRequest //
create procedure getStaffRequest(IN in_staffID varchar(16))
begin
	 select
			 r.RequestID,
			 r.StaffID,
			 s.Surname,
			 s.Firstname,
			 s.DepartmentID,
			 d.DepartmentName,
			 r.ProductName,
			 r.RequestDate,
			 r.Model,
			 r.Purpose,
			 r.Quantity,
			 r.CategoryID,
			 c.CategoryName,
			 r.`Comment`,
			 r.ExpectedDateOfCollection
	 from Request r
	 left join Staff s on r.StaffID = s.StaffID
	 left join Department d on s.DepartmentID = d.DepartmentID
	 left join Category c on r.CategoryID = c.CategoryID
	 where r.StaffID = in_StaffID;
end //
delimiter ;
-- --------------------------
delimiter //
drop procedure if exists getAllRequestResponse //
create procedure getAllRequestResponse()
begin
   select
	   rr.RequestID,
	   rr.StaffID,
	   s.Surname,
	   s.Firstname,
	   rr.StatusID,
	   rr.`Comment`,
	   rr.AvailableDate
   from RequestResponse rr
   left join Staff s on rr.StaffID = s.StaffID;
end //
delimiter ;
-- --------------------------   
delimiter //
drop procedure if exists getRequestResponse //
create procedure getRequestResponse(IN in_RequestID int)
begin
   select
	   rr.RequestID,
	   rr.StaffID,
	   s.Surname,
	   s.Firstname,
	   rr.StatusID,
	   rr.`Comment`,
	   rr.AvailableDate
   from RequestResponse rr
   left join Staff s on rr.StaffID = s.StaffID
   where rr.RequestID = in_RequestID;
end //
delimiter ;
-- ------------------------
delimiter //
drop procedure if exists getStaffRequestResponse //
create procedure getStaffRequestResponse(IN in_StaffID varchar(16))
begin
   select
	   r.RequestID,
	   r.StaffID,
	   concat(s.Surname, ' ' , s.Firstname) 'Request By',
	   r.ProductName,
	   r.RequestDate,
	   r.Model,
	   r.Purpose,
	   r.Quantity,
	   rr.StaffID,
	   concat(s.Surname, ' ' ,s.Firstname)'Response By',
	   rr.StatusID,
	   rs.Description,
	   rr.`Comment`,
	   rr.AvailableDate
   from Request r
   left join RequestResponse rr on r.RequestID = rr.RequestID
   left join Staff s on r.StaffID = s.StaffID
   left join Staff ss on rr.StaffID = ss.StaffID
   left join RequestStatus rs on rr.StatusID = rs.StatusID
   where r.StaffID = in_StaffID;	   
end //
delimiter ;
-- -----------------------
-- getAllStaffAuthorizedRequest(StaffID)
delimiter //
drop procedure if exists getAllStaffAuthorizedRequest //
create procedure getAllStaffAuthorizedRequest(IN in_StaffID varchar(16))
begin
	select ar.RequestID,
	       concat(s.Surname, ' ' ,s.Firstname) 'Request By',
	       concat(r.ProductName, ' ', r.Model, ' ', r.Purpose, ' ', r.Quantity),
	       ar.AuthorizedStatusID,
	       aus.Description,
	       concat(ass.Surname, ' ', ass.Firstname) 'Authorized/Declined By',
	       ar.`Comment`
	from AuthorizedRequest ar     
	left join Staff ass on ar.StaffID = ass.StaffID
	left join RequestResponse rr on rr.RequestID = ar.RequestID
	left join Request r on r.RequestID = rr.RequestID
	left join Staff s on r.StaffID = s.StaffID  
	where in_StaffID = r.StaffID;
end //
delimiter ;

-- -------------------------
       delimiter //
drop procedure if exists getStaffAuthorizedRequest //
create procedure getStaffAuthorizedRequest(IN in_StaffID varchar(16),IN in_RequestID int)
begin
	select ar.RequestID,
	       concat(s.Surname, ' ' ,s.Firstname) 'Request By',
	       concat(r.ProductName, ' ', r.Model, ' ', r.Purpose, ' ', r.Quantity),
	       ar.AuthorizedStatusID,
	       aus.Description,
	       concat(ass.Surname, ' ', ass.Firstname) 'Authorized/Declined By',
	       ar.`Comment`
	from AuthorizedRequest ar     
	left join Staff ass on ar.StaffID = ass.StaffID
	left join RequestResponse rr on rr.RequestID = ar.RequestID
	left join Request r on r.RequestID = rr.RequestID
	left join Staff s on r.StaffID = s.StaffID  
	where in_StaffID = r.StaffID and in_RequestID = r.RequestID;
end //
delimiter ;
-- -------------------------
-- staff(staff name) requested for(product name) authorized or declined by(staff name) comment 




-- getStaffAUthorizedRequestByStatus(AuthorizedStatusID)
--  

delimiter //
drop procedure if exists getStaffAUthorizedRequestByStatus //
create procedure getStaffAUthorizedRequestByStatus(IN in_StaffID varchar(16),IN in_AuthorizedStatusID char(5))
begin
	select ar.RequestID,
	       concat(s.Surname, ' ' ,s.Firstname) 'Request By',
	       concat(r.ProductName, ' ', r.Model, ' ', r.Purpose, ' ', r.Quantity),
	       ar.AuthorizedStatusID,
	       aus.Description,
	       concat(ass.Surname, ' ', ass.Firstname) 'Authorized/Declined By',
	       ar.`Comment`
	from AuthorizedRequest ar     
	left join Staff ass on ar.StaffID = ass.StaffID
	left join RequestResponse rr on rr.RequestID = ar.RequestID
	left join Request r on r.RequestID = rr.RequestID
	left join Staff s on r.StaffID = s.StaffID  
	where in_StaffID = r.StaffID and in_AuthorizedStatusID = ar.AuthorizedStatusID;
end //
delimiter ;
-- -----------------------------
delimiter //
drop procedure if exists getAllReturn //
create procedure getAllReturn()
begin
  select RequestID,`Comment`,ReturnDate from `Return`;
end //
delimiter ;
-- ----------------------------- 
delimiter //
drop procedure if exists getReturn //
create procedure getReturn(IN in_RequestID int)
begin
  select RequestID,`Comment`,ReturnDate from `Return`
  where RequestID = in_RequestID;
end //
delimiter ; 
-- -----------------------------
-- getProductByPurchasedDate
-- ------------------------------
delimiter //
drop procedure if exists getAllProduct //
create procedure getAllProduct()
begin
  select p.ProductCode as Code,p.CategoryID,c.CategoryName as Category,
         p.ProductName as Name,p.SerialNumber as Serial,b.Name as Brand,
         p.ModelID as Model,
         p.DateOfPurchased as Purchased,p.AvailableStatusID,ass.Description  as Available,
         p.FunctionalStatusID,fs.Description as Functional
  from Product p
  left join Category c on p.CategoryID =  c.CategoryID
  left join Brand b on p.BrandID = b.BrandID
  left join AvailableStatus ass on p.AvailableStatusID = ass.AvailableStatusID
  left join FunctionalStatus fs on p.FunctionalStatusID = fs.FunctionalStatusID;
end //
delimiter ;
-- ------------------------------ 
delimiter //
drop procedure if exists getProduct //
create procedure getProduct(IN in_ProductCode varchar(16))
begin
  select p.ProductCode,p.CategoryID,c.CategoryName,
         p.ProductName,p.SerialNumber,
         p,Model,p.Quantity,
         p.DateOfPurchase,p.AvailableStatus,ass.Description,
         p.FunctionalStatus,fs.Description
  from Product p
  left join Category c on p.CategoryID =  c.CategoryID
  left join AvailableStatus ass on p.AvailableStatusID = ass.AvailableStatusID
  left join FunctionalStatus fs on p.FunctionalStatusID = fs.FunctionalStatusID
  where p.ProductCode = in_ProductCode;
end //
delimiter ; 
-- ---------------------------
delimiter //
drop procedure if exists getProductByCategory //
create procedure getProductByCategory(IN in_CategoryID char(5))
begin
  select p.ProductCode,p.CategoryID,c.CategoryName,
         p.ProductName,p.SerialNumber,
         p,Model,p.Quantity,
         p.DateOfPurchase,p.AvailableStatus,ass.Description,
         p.FunctionalStatus,fs.Description
  from Product p
  left join Category c on p.CategoryID =  c.CategoryID
  left join AvailableStatus ass on p.AvailableStatusID = ass.AvailableStatusID
  left join FunctionalStatus fs on p.FunctionalStatusID = fs.FunctionalStatusID
  where p.CategoryID = in_CategoryID;
end //
delimiter ; 
-- ---------------------------
delimiter //
drop procedure if exists getFautyProduct //
create procedure getFautyProduct()
begin
  select p.ProductCode,p.CategoryID,c.CategoryName,
         p.ProductName,p.SerialNumber,
         p,Model,p.Quantity,
         p.DateOfPurchase,p.AvailableStatus,ass.Description,
         p.FunctionalStatus,fs.Description
  from Product p
  left join Category c on p.CategoryID =  c.CategoryID
  left join AvailableStatus ass on p.AvailableStatusID = ass.AvailableStatusID
  left join FunctionalStatus fs on p.FunctionalStatusID = fs.FunctionalStatusID
  where p.FunctionalStatus = "Faulty";
end //
delimiter ;
-- --------------------------
delimiter //
drop procedure if exists getFunctionalProduct //
create procedure getFunctionalProduct()
begin
  select p.ProductCode,p.CategoryID,c.CategoryName,
         p.ProductName,p.SerialNumber,
         p,Model,p.Quantity,
         p.DateOfPurchase,p.AvailableStatus,ass.Description,
         p.FunctionalStatus,fs.Description
  from Product p
  left join Category c on p.CategoryID =  c.CategoryID
  left join AvailableStatus ass on p.AvailableStatusID = ass.AvailableStatusID
  left join FunctionalStatus fs on p.FunctionalStatusID = fs.FunctionalStatusID
  where p.FunctionalStatus = "Func";
end //
delimiter ;
-- ---------------------------
delimiter //
drop procedure if exists getAvailableProduct //
create procedure getAvailableProduct()
begin
  select p.ProductCode,p.CategoryID,c.CategoryName,
         p.ProductName,p.SerialNumber,
         p,Model,p.Quantity,
         p.DateOfPurchase,p.AvailableStatus,ass.Description,
         p.FunctionalStatus,fs.Description
  from Product p
  left join Category c on p.CategoryID =  c.CategoryID
  left join AvailableStatus ass on p.AvailableStatusID = ass.AvailableStatusID
  left join FunctionalStatus fs on p.FunctionalStatusID = fs.FunctionalStatusID
  where p.AvailableStatus = "AVAIL";
end //
delimiter ;
-- --------------------------
delimiter //
drop procedure if exists getNotAvailableProduct //
create procedure getNotAvailableProduct()
begin
  select p.ProductCode,p.CategoryID,c.CategoryName,
         p.ProductName,p.SerialNumber,
         p,Model,p.Quantity,
         p.DateOfPurchase,p.AvailableStatus,ass.Description,
         p.FunctionalStatus,fs.Description
  from Product p
  left join Category c on p.CategoryID =  c.CategoryID
  left join AvailableStatus ass on p.AvailableStatusID = ass.AvailableStatusID
  left join FunctionalStatus fs on p.FunctionalStatusID = fs.FunctionalStatusID
  where p.AvailableStatus = "NAVAIL";
end //
delimiter ;
-- ---------------------
delimiter //
drop procedure if exists getDepartment //
create procedure getDepartment()
begin
 select DepartmentID,DepartmentName from Department;
end //
delimiter ;
-- --------------------- 
-- function authenticates user
DELIMITER //
DROP FUNCTION IF EXISTS authenticateUser //
CREATE FUNCTION authenticateUser(in_User VARCHAR(32), in_Password VARCHAR(255))
RETURNS BOOLEAN READS SQL DATA
DETERMINISTIC
BEGIN
    RETURN (SELECT COUNT(*) FROM `Staff`
	WHERE Username=in_User AND Password= in_Password);

END //
DELIMITER ;

-- =======================================
-- Logs in a user.
DELIMITER //
DROP PROCEDURE IF EXISTS loginUser //
CREATE PROCEDURE loginUser(In in_User VARCHAR(32), In in_Password VARCHAR(255))READS SQL DATA
BEGIN
			IF(authenticateUser(in_User,in_Password)) THEN
				BEGIN
					
					START TRANSACTION;
					set @id = (select StaffID from Staff where Username = in_User);
					INSERT INTO UserLogin(StaffID,LoginTime,LogoutTime)
					VALUES(@id,NOW(),'');
					COMMIT;
					SELECT s.StaffID,s.Surname, s.Firstname,s.RoleID,
					             l.LoginTime,
					             s.Username,
					             s.Password,
						    _xyz(in_User) lastLog
						    FROM `Staff` s LEFT JOIN UserLogin l ON l.StaffID=s.StaffID
						    WHERE s.Username=in_User AND l.loginTime=
						    (select max(LoginTime) from UserLogin where StaffID=@id);
				END;
			
				ELSE
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT =  '-45000: loginUser: User authen fail';
			END IF;

END //
DELIMITER ;
-- ---------------------------------------
delimiter //
drop procedure if exists checkLogin //
create procedure checkLogin(IN in_Username varchar(32))
begin
	select ul.StaffID as Username
	from UserLogin ul
	left join Staff s on ul.StaffID = s.StaffID
	where s.Username = in_Username;
end //
delimiter ;
-- ----------------------------------- 
DELIMITER //
DROP PROCEDURE IF EXISTS logoutUser //
CREATE PROCEDURE LogoutUser(IN in_user VARCHAR(16) )
BEGIN
    set @id = (select StaffID from Staff where Username = in_User);
    UPDATE  UserLogin
    SET LogoutTime = NOW()
    WHERE StaffID = @id  AND LogoutTime = '0000-00-00 00:00:00' LIMIT 1;

END //
DELIMITER ;
-- ----------------------------------
-- Updates a user password
DELIMITER //
DROP PROCEDURE IF EXISTS changePassword//
CREATE PROCEDURE changePassword(In in_User VARCHAR(15), In in_Password VARCHAR(255))
BEGIN
	set @id = (select StaffID from Staff where Username = in_User);
	UPDATE Staff SET `Password`=in_Password
	WHERE StaffID=@id;
	SELECT s.StaffID,s.Surname, s.Firstname,s.RoleID,
					             l.LoginTime,
					             s.Username,
					             s.Password,
						    _xyz(in_User) lastLog
						    FROM `Staff` s LEFT JOIN UserLogin l ON l.StaffID=s.StaffID
						    WHERE s.Username=in_User AND l.loginTime=
						    (select max(LoginTime) from UserLogin where StaffID=@id);	
END;//
DELIMITER ;
-- -------------------------------
delimiter //
drop procedure if exists deleteStaff //
create procedure deleteStaff(IN in_StaffID varchar(16))
begin
  set foreign_key_checks = 0;
  delete from Staff where StaffID = in_StaffID;
  set foreign_key_checks = 1;
end //
delimiter ;  
-- ------------------------------
delimiter //
drop procedure if exists getBrand //
create procedure getBrand()
begin
  select BrandID, Name from Brand;
end //
delimiter ;
-- ----------------------------
  delimiter //
drop procedure if exists getModel //
create procedure getModel()
begin
  select BrandID,ModelID,Name from Model;
end //
delimiter ;
-- -------------------------
delimiter //
drop procedure if exists deleteProduct //
create procedure deleteProduct(IN in_Code varchar(16))
begin
 set foreign_key_checks = 0;
 delete from Product where ProductCode = in_Code;
 set foreign_key_checks = 1;
end //
delimiter ;
-- ----------------------- 
delimiter //
drop procedure if exists deleteBrand //
create procedure deleteBrand(IN in_BrandID char(5))
begin
  set foreign_key_checks = 0;
  delete from Brand where BrandID = in_BrandID;
  set foreign_key_checks = 1;
end //
delimiter ;
-- ---------------------
delimiter //
drop procedure if exists deleteModel //
create procedure deleteModel(IN in_ModelID char(32))
begin
  set foreign_key_checks = 0;
  delete from Model where ModelID = in_ModelID;
  set foreign_key_checks = 1;
end //
delimiter ;
-- --------------------
delimiter //
drop procedure if exists getLoggedUsers //
create procedure getLoggedUsers()
begin
  select count(*) as count from UserLogin where LogoutTime = '0000-00-00 00:00:00';
end //
delimiter ;
-- ----------------------  
delimiter //
drop procedure if exists getAllPurpose //
create procedure getAllPurpose()
begin
  select Id, Name from Purpose;
end //
delimiter ;
-- --------------------  
